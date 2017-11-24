Received: from eggs.gnu.org ([2001:4830:134:3::10]:40974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8t0-00035E-QH
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8sv-0000PY-TH
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:58:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eI8sv-0000OZ-NY
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:58:53 -0500
Date: Fri, 24 Nov 2017 15:58:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171124075841.GE10471@xz-mi>
References: <20171116130610.23582-1-peterx@redhat.com>
	<20171116130610.23582-16-peterx@redhat.com>
	<20171123112315.GB2462@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171123112315.GB2462@work-vm>
Subject: Re: [Qemu-devel] [RFC v4 15/27] monitor: let
 monitor_{suspend|resume} thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com

On Thu, Nov 23, 2017 at 11:23:16AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Monitor code now can be run in more than one thread.  Let the suspend
> > and resume code be thread safe.
> > 
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/monitor.c b/monitor.c
> > index ec03f1b232..30f9cd80de 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4003,7 +4003,7 @@ int monitor_suspend(Monitor *mon)
> >  {
> >      if (!mon->rs)
> >          return -ENOTTY;
> > -    mon->suspend_cnt++;
> > +    atomic_inc(&mon->suspend_cnt);
> >      return 0;
> >  }
> >  
> > @@ -4011,8 +4011,9 @@ void monitor_resume(Monitor *mon)
> >  {
> >      if (!mon->rs)
> >          return;
> > -    if (--mon->suspend_cnt == 0)
> > +    if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
> >          readline_show_prompt(mon->rs);
> > +    }
> >  }
> >  
> >  static QObject *get_qmp_greeting(void)
> 
> Do you also need to do an atomic_read() in monitor_can_read?
> (I guess the code in monitor_event is ok because it's only the mux
> path, but still it's probably better to use all atomic ops on
> the suspend_cnt variable to be consistent).

Agreed.

-- 
Peter Xu
