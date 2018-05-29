Received: from eggs.gnu.org ([2001:4830:134:3::10]:57744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNXY3-000269-RE
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNXXz-0006Eg-Rz
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:51:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNXXz-0006E4-Mw
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:51:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C76864026787
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 05:51:50 +0000 (UTC)
Date: Tue, 29 May 2018 13:51:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180529055141.GA25245@xz-mi>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-5-peterx@redhat.com>
	<87sh6h77d0.fsf@dusky.pond.sub.org> <20180528070621.GE2584@xz-mi>
	<877ennn6z7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877ennn6z7.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] monitor: add lock to protect
 mon_fdsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, May 28, 2018 at 05:19:08PM +0200, Markus Armbruster wrote:

[...]

> >> 
> >> > + * Meanwhile it can also be used even at the end of main.  Let's keep
> >> > + * it initialized for the whole lifecycle of QEMU.
> >> > + */
> >> 
> >> Awkward question, since our main() is such a tangled mess, but here goes
> >> anyway...  The existing place to initialize monitor.c's globals is
> >> monitor_init_globals().  But that one runs too late, I guess:
> >> parse_add_fd() runs earlier, and calls monitor_fdset_add_fd().  Unclean
> >> even without this lock; no module should be used before its
> >> initialization function runs.  Sure we can't run monitor_init_globals()
> >> sufficiently early?
> >
> > Please see the comment for monitor_init_globals():
> >
> >     /*
> >      * Note: qtest_enabled() (which is used in monitor_qapi_event_init())
> >      * depends on configure_accelerator() above.
> >      */
> >     monitor_init_globals();
> >
> > So I guess it won't work to directly move it earlier.  The init
> > dependency of QEMU is really complicated.  I'll be fine now that we
> > mark totally independent init functions (like this one, which is a
> > mutex init only) as constructor, then we can save some time on
> > ordering issue.
> 
> Let me rephrase.  There's a preexisting issue: main() calls monitor.c
> functions before calling its initialization function
> monitor_init_globals().  This needs to be cleaned up.  Would you be
> willing to do it?
> 
> Possible solutions:
> 
> * Perhaps we can move monitor_init_globals() up and/or the code calling
>   into monitor.c early down sufficiently.
> 
> * Calculate event_clock_type on each use instead of ahead of time.  It's
>   qtest_enabled ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME, and neither
>   of its users needs to be fast.  Then move monitor_init_globals before
>   the code calling into monitor.c.

Indeed.  Obviously you thought a step further. :)

> 
> I'm not opposed to use of constructors for self-contained initialization
> (no calls to other modules).  But I don't like initialization spread
> over multiple functions.

Since this work will actually decide where I should init this new
fdset lock, so I'll try to do that altogether within the series.

Thanks for your suggestions!  It makes sense.

-- 
Peter Xu
