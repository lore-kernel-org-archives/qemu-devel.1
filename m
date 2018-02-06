Received: from eggs.gnu.org ([2001:4830:134:3::10]:45157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eiyqV-0000BI-SX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eiyqS-00007x-Mq
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:43:19 -0500
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:40567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eiyqS-00005M-Fp
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:43:16 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id D7F459C96E
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 09:43:14 +0100 (CET)
Date: Tue, 6 Feb 2018 09:43:10 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180206094310.2a9cdc5c@bahia.lan>
In-Reply-To: <9f1237f2-5194-1cc5-dbc4-b453ff3ee7c4@virtuozzo.com>
References: <151790197381.27004.13241184632371976036.stgit@bahia.lan>
	<9f1237f2-5194-1cc5-dbc4-b453ff3ee7c4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: incoming postcopy advise sanity
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Tue, 6 Feb 2018 10:49:47 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 06.02.2018 10:26, Greg Kurz wrote:
> > If postcopy-ram was set on the source but not on the destination,
> > migration doesn't occur, the destination prints an error and boots
> > the guest:
> >
> > qemu-system-ppc64: Expected vmdescription section, but got 0
> >
> > We end up with two running instances.
> >
> > This behaviour was introduced in 2.11 by commit 58110f0acb1a "migration:
> > split common postcopy out of ram postcopy" to prepare ground for the
> > upcoming dirty bitmap postcopy support. It adds a new case where the
> > source may send an empty postcopy advise because dirty bitmap doesn't
> > need to check page sizes like RAM postcopy does.
> >
> > If the source has enabled postcopy-ram, then it sends an advise with
> > the page size values. If the destination hasn't enabled postcopy-ram,
> > then loadvm_postcopy_handle_advise() leaves the page size values on
> > the stream and returns. This confuses qemu_loadvm_state() later on
> > and causes the destination to start execution.
> >
> > As discussed several times, postcopy-ram should be enabled both sides
> > to be functional. This patch changes the destination to perform some
> > extra checks on the advise length to ensure this is the case. Otherwise
> > an error is returned and migration is aborted.
> >
> > Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   migration/savevm.c |   18 +++++++++++++++---
> >   1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index b7908f62be3c..1c516fcbb8d7 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1376,7 +1376,8 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> >    * *might* happen - it might be skipped if precopy transferred everything
> >    * quickly.
> >    */
> > -static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
> > +static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> > +                                         uint16_t len)
> >   {
> >       PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
> >       uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
> > @@ -1387,8 +1388,19 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
> >           return -1;
> >       }
> >   
> > -    if (!migrate_postcopy_ram()) {
> > +    switch (len) {
> > +    case 0:
> > +        /* The source hasn't enabled postcopy-ram. Nothing to do. */  
> 
> should we error-out here if (migrate_postcopy_ram()) ?
> 

I was also thinking so at first, but if the source hasn't enabled postcopy-ram,
then RAM postcopy won't happen. Not sure why we should error out...

> >           return 0;
> > +    case 8 + 8:
> > +        if (!migrate_postcopy_ram()) {
> > +            error_report("RAM postcopy is disabled");
> > +            return -EINVAL;
> > +        }
> > +        break;
> > +    default:
> > +        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
> > +        return -EINVAL;
> >       }
> >   
> >       if (!postcopy_ram_supported_by_host(mis)) {
> > @@ -1807,7 +1819,7 @@ static int loadvm_process_command(QEMUFile *f)
> >           return loadvm_handle_cmd_packaged(mis);
> >   
> >       case MIG_CMD_POSTCOPY_ADVISE:
> > -        return loadvm_postcopy_handle_advise(mis);
> > +        return loadvm_postcopy_handle_advise(mis, len);
> >   
> >       case MIG_CMD_POSTCOPY_LISTEN:
> >           return loadvm_postcopy_handle_listen(mis);
> >  
> 
> 
