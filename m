Received: from eggs.gnu.org ([2001:4830:134:3::10]:39552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDSyY-0000SV-E2
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDSyV-0005Fw-AS
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:57:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48770 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fDSyV-0005Fo-4B
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:57:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E9A64270963
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 10:57:32 +0000 (UTC)
Date: Tue, 1 May 2018 11:57:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180501105725.GC3105@work-vm>
References: <20180430185943.35714-1-dgilbert@redhat.com>
	<20180501100035.GJ5708@redhat.com>
	<20180501101127.GK5708@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180501101127.GK5708@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Migration+TLS: Fix crash due to double
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Tue, May 01, 2018 at 11:00:35AM +0100, Daniel P. Berrang=E9 wrote:
> > On Mon, Apr 30, 2018 at 07:59:43PM +0100, Dr. David Alan Gilbert (git=
) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >=20
> > > During a TLS connect we see:
> > >   migration_channel_connect calls
> > >   migration_tls_channel_connect
> > >   (calls after TLS setup)
> > >   migration_channel_connect
> > >=20
> > > My previous error handling fix made migration_channel_connect
> > > call migrate_fd_connect in all cases; unfortunately the above
> > > means it gets called twice and crashes doing double cleanup.
> > >=20
> > > Fixes: 688a3dcba98
> >=20
> > This fixes the crash, but we're still seeing error messages duplicate=
d
> >=20
> > (qemu) migrate_set_parameter tls-creds tls0
> > (qemu) migrate tcp:localhost:9000
> > qemu-system-x86_64: Certificate does not match the hostname localhost
> > qemu-system-x86_64: Certificate does not match the hostname localhost
> >=20
> > git bisect points to 688a3dcba98 as the cause of these double
> > errors still.

Can you give me the full sequence to trigger that; I did try yesterday
and have failed to get that error out of the TLS code.

> FYI the stack traces look like this..
>=20
> The first error message is printed in this context:
>=20
> #0  0x0000555555bb6c20 in error_report (fmt=3D0x555555d0d77e "%s") at u=
til/qemu-error.c:273
> #1  0x0000555555bb5fa5 in error_report_err (err=3D0x55555749cb00) at ut=
il/error.c:228
> #2  0x0000555555a6d1f8 in migrate_fd_cleanup (opaque=3Dopaque@entry=3D0=
x5555569925a0) at migration/migration.c:1106
> #3  0x0000555555a6e2aa in migrate_fd_connect (s=3Ds@entry=3D0x555556992=
5a0, error_in=3D0x55555768de80) at migration/migration.c:2387
> #4  0x0000555555a6f8e7 in migration_channel_connect (s=3Ds@entry=3D0x55=
55569925a0, ioc=3Dioc@entry=3D0x555557e1de10, hostname=3Dhostname@entry=3D=
0x0, error=3D<optimized out>) at migration/channel.c:83
> #5  0x0000555555a6f2d6 in migration_tls_outgoing_handshake (task=3D<opt=
imized out>, opaque=3D0x5555569925a0) at migration/tls.c:124
> #6  0x0000555555b6d2b2 in qio_task_complete (task=3Dtask@entry=3D0x5555=
576ae620) at io/task.c:142
> #7  0x0000555555b68c74 in qio_channel_tls_handshake_task (ioc=3Dioc@ent=
ry=3D0x555557e1de10, task=3Dtask@entry=3D0x5555576ae620) at io/channel-tl=
s.c:171
> #8  0x0000555555b6975a in qio_channel_tls_handshake (ioc=3Dioc@entry=3D=
0x555557e1de10, func=3Dfunc@entry=3D0x555555a6f250 <migration_tls_outgoin=
g_handshake>, opaque=3Dopaque@entry=3D0x5555569925a0, destroy=3Ddestroy@e=
ntry=3D0x0) at io/channel-tls.c:215
> #9  0x0000555555a6f6ac in migration_tls_channel_connect (s=3Ds@entry=3D=
0x5555569925a0, ioc=3Dioc@entry=3D0x555556a01000, hostname=3Dhostname@ent=
ry=3D0x555556bc0c30 "localhost", errp=3Derrp@entry=3D0x7fffffffd778) at m=
igration/tls.c:159
> #10 0x0000555555a6f967 in migration_channel_connect (s=3D0x5555569925a0=
, ioc=3Dioc@entry=3D0x555556a01000, hostname=3D0x555556bc0c30 "localhost"=
, error=3D<optimized out>) at migration/channel.c:73
> #11 0x0000555555a6e5f4 in socket_outgoing_migration (task=3D<optimized =
out>, opaque=3D0x555556cc7de0) at migration/socket.c:85
> #12 0x0000555555b6d2b2 in qio_task_complete (task=3Dtask@entry=3D0x5555=
576ce3b0) at io/task.c:142
> #13 0x0000555555b6d3a2 in gio_task_thread_result (opaque=3D0x5555578eff=
50) at io/task.c:88
> #14 0x00007ffff5da1577 in g_idle_dispatch () at /lib64/libglib-2.0.so.0
> #15 0x00007ffff5da4b77 in g_main_context_dispatch () at /lib64/libglib-=
2.0.so.0
> #16 0x0000555555baf677 in glib_pollfds_poll () at util/main-loop.c:214
> #17 0x0000555555baf677 in os_host_main_loop_wait (timeout=3D<optimized =
out>) at util/main-loop.c:261
> #18 0x0000555555baf677 in main_loop_wait (nonblocking=3D<optimized out>=
) at util/main-loop.c:515
> #19 0x00005555557b9157 in main_loop () at vl.c:1935
> #20 0x00005555557b9157 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at vl.c:4767

Right, that's certainly the one I'm expecting; my rule here is that
any connect path that might call migrate_fd_connect, *always* calls
migrate_fd_connect and in the error case gives it the error to report.
My original reason to do this was to make sure we clean up any
'cancelling's that are in flight - cancel+a broken connect could lead
to it getting stuck in cancelling.

> The second error message is printed in this context:
>=20
> #0  0x0000555555bb6c20 in error_report (fmt=3Dfmt@entry=3D0x555555d0d77=
e "%s") at util/qemu-error.c:273
> #1  0x0000555555904035 in hmp_migrate_status_cb (opaque=3D0x555556bc0ba=
0) at hmp.c:1909
> #2  0x0000555555baefac in timerlist_run_timers (timer_list=3D0x555556a0=
d760) at util/qemu-timer.c:536
> #3  0x0000555555baf1b7 in qemu_clock_run_timers (type=3DQEMU_CLOCK_REAL=
TIME) at util/qemu-timer.c:547
> #4  0x0000555555baf1b7 in qemu_clock_run_all_timers () at util/qemu-tim=
er.c:662
> #5  0x0000555555baf69a in main_loop_wait (nonblocking=3D<optimized out>=
) at util/main-loop.c:521
> #6  0x00005555557b9157 in main_loop () at vl.c:1935
> #7  0x00005555557b9157 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at vl.c:4767
>=20
>=20
> The second stack trace is the error reporting context that I added orig=
inally
> in
>=20
>   commit d59ce6f34434bf47a9b26138c908650bf9a24be1
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Wed Apr 27 11:05:00 2016 +0100
>=20
>     migration: add reporting of errors for outgoing migration
>=20
>=20
> So the first stack trace is the new duplicate.
>
> Which error reporting context is "better" though, I don't know ?


OK, I see why I didn't see this - I almost always use migrate -d  and
that timer only happens without the -d.


> My patch was based on the view that, although alot of code uses error_r=
eport,
> long term all migration would eventually need to be able to filter an
> 'Error *errp' back up the stack, so that we can pass it back to QMP / H=
MP via
> 'info migrate' / query-migrate. So I decided to leave the error_report_=
err
> call to the hmp.c code, as long term that's the only place that would n=
eed
> to print to the console.

I wanted it to land in the /var/log/libvirt/qemu/whatever so we could
see what happened.

Dave

>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
