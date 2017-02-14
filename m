Received: from eggs.gnu.org ([2001:4830:134:3::10]:57269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdavo-00088a-Bj
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdavl-0007Hv-7o
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:06:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdavl-0007HM-21
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:05:57 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A97DE7FB6D
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 11:05:56 +0000 (UTC)
Date: Tue, 14 Feb 2017 11:05:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170214110551.GD2463@work-vm>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-16-git-send-email-quintela@redhat.com>
	<20170203113611.GG3208@work-vm> <87k28u3u6c.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k28u3u6c.fsf@emacs.mitica>
Subject: Re: [Qemu-devel] [PATCH 15/17] migration: Test new fd infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> We just send the address through the alternate channels and test that it
> >> is ok.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  migration/ram.c | 36 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 36 insertions(+)
> >> 
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index 4e530ea..95af694 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -432,8 +432,22 @@ static void *multifd_send_thread(void *opaque)
> >>      qemu_mutex_lock(&params->mutex);
> >>      while (!params->quit){
> >>          if (params->pages.num) {
> >> +            int i;
> >> +            int num;
> >> +
> >> +            num = params->pages.num;
> >>              params->pages.num = 0;
> >>              qemu_mutex_unlock(&params->mutex);
> >> +
> >> +            for(i=0; i < num; i++) {
> >> +                if (qio_channel_write(params->c,
> >> +                                      (const char *)&params->pages.address[i],
> >> +                                      sizeof(uint8_t *), &error_abort)
> >> +                    != sizeof(uint8_t*)) {
> >> +                    /* Shuoudn't ever happen */
> >> +                    exit(-1);
> >> +                }
> >
> > Nope, need to find a way to cleanly find the migration; that
> > might actually be tricky from one of these threads?
> 
> It is tricky, but the error handling is wrong in the callers of this
> already.  Will try to improve it on next series, but the problem is
> already there.

Well we should never kill the source because of a failed migration;
especially just due to a fairly boring IO error.
You could just exit the thread and return a marker value that gets
delivered to the pthread_join.
There is qemu_file_set_error() that you could call - although you'd
have to figure out thread safety.
(Which might be as simple as cmpxchg the error values and only
change the error value if it was previously 0).

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
