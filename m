Received: from eggs.gnu.org ([2001:4830:134:3::10]:55219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cRdN9-0003WK-JA
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cRdN4-0002KM-Jo
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:16:47 -0500
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:41472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cRdN4-0002KD-DQ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:16:42 -0500
Received: from player726.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 887A937C47
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 12:16:39 +0100 (CET)
Date: Thu, 12 Jan 2017 12:16:23 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170112121623.6b92a336@bahia.lan>
In-Reply-To: <CAC2QTZYnL--Uyab7mmnzUQjE6UFWJWqJq2kBdxBbtef2Mpp7Tg@mail.gmail.com>
References: <1483981368-9965-1-git-send-email-ashijeetacharya@gmail.com>
	<1483981368-9965-5-git-send-email-ashijeetacharya@gmail.com>
	<CAFEAcA_jcWo+mJ=3FLgx_R7QEvZ9NeTp-RhYZF4nczY-FViySg@mail.gmail.com>
	<CAC2QTZYnL--Uyab7mmnzUQjE6UFWJWqJq2kBdxBbtef2Mpp7Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/4] migration: Fail migration blocker
 for --only-migratble
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, "Aneesh
	Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 12 Jan 2017 16:15:28 +0530
Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:

> On Tuesday, 10 January 2017, Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On 9 January 2017 at 17:02, Ashijeet Acharya <ashijeetacharya@gmail.com
> > <javascript:;>> wrote:
> > > migrate_add_blocker should rightly fail if the '--only-migratable'
> > > option was specified and the device in use should not be able to
> > > perform the action which results in an unmigratable VM.
> > >
> > > Make migrate_add_blocker return -EACCES in this case.
> >
> > > diff --git a/block/qcow.c b/block/qcow.c
> > > index 11526a1..bdc6446 100644
> > > --- a/block/qcow.c
> > > +++ b/block/qcow.c
> > > @@ -254,7 +254,10 @@ static int qcow_open(BlockDriverState *bs, QDict
> > *options, int flags,
> > >                 bdrv_get_device_or_node_name(bs));
> > >      ret = migrate_add_blocker(s->migration_blocker, errp);
> > >      if (ret < 0) {
> > > -        error_free(s->migration_blocker);
> > > +        if (ret == -EACCES) {
> > > +            error_append_hint(errp, "Cannot use a node with qcow format
> > as "
> > > +                              "it does not support live migration");
> > > +        }
> > >          goto fail;
> > >      }
> > >
> >
> > The error handling for these call sites should look just like
> > that for any other function call that takes an Error**:
> >
> >     Error *local_err = NULL;
> >     [...]
> >     migrate_add_blocker(s->migration_blocker, &local_err);
> >     if (local_err) {
> >         error_propagate(errp, local_err);
> >         return; // or otherwise handle failure appropriately
> >     }
> 
> 
> One more reason Peter I found for returning an error value is that in cases
> like 9pfs where we do not set errp inside migrate_add_blocker() (as
> suggested by Greg) and other similar ones where we pass NULL for errp, we
> cannot rely on checking for
> "if (local_err)" as it will never be set and always be NULL.
> Thus we will never fail appropriately at the caller sites when we fail to
> add migration blocker.
> Sounds right?
> 

The need for 9pfs is just to return an error to the guest, which will end
up being the errno for the failed mount(). And we don't want to print out
any error message to avoid a stupid guest to fill the QEMU log in case it
would loop over mount().

The only reason I see for migration_add_blocker() to return an error
would be to differentiate between the --only-migratable and the migration
in progress cases... But honestly, I don't care that much and something
like the following would be perfectly ok:

    Error *local_err = NULL;
    [...]
    migrate_add_blocker(s->migration_blocker, &local_err);
    if (local_err) {
        error_free(local_err);
        err = -EBUSY
        goto out_nofid;
    }

> Ashijeet
> 
> >
> > migrate_add_blocker() should just internally construct
> > the error text and extra hint lines by looking at the
> > text it can fish out of the s->migration_blocker argument
> > and calling error_append_hint() itself.
> >
> > The patch is also a bit odd because the error_free() calls
> > were only added in patch 3/4, right? Generally adding
> > lines of code in one patch and deleting them in the next
> > is a bad idea.
> >
> > thanks
> > -- PMM
> >
