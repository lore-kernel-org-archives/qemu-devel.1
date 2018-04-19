Received: from eggs.gnu.org ([2001:4830:134:3::10]:56912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f9Cbi-0007Go-Fr
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f9Cbe-0000ah-Oj
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:40:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f9Cbe-0000Zs-A3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:40:22 -0400
Date: Thu, 19 Apr 2018 17:40:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180419164003.GV10259@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <62d561d0-fe72-4971-1bf5-72adc4a979f2@amsat.org>
	<CAMxuvaz40mfpVRhy+GggTveNB+qvXG=sA+g=9w7RyjYAHktXDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvaz40mfpVRhy+GggTveNB+qvXG=sA+g=9w7RyjYAHktXDg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vnc: heap-use-after-free in vnc_client_io() after
 vnc_disconnect_finish()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Apr 19, 2018 at 06:37:12PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Apr 17, 2018 at 7:52 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org> wrote:
> > running commit ce8d4082054519f2eaac39958edde502860a7fc6:
> >
> > qemu-system-mips -M malta -m 512 \
> >   -kernel vmlinux-3.2.0-4-4kc-malta \
> >   -append 'root=3D/dev/sda1 console=3DttyS0' \
> >   -hda debian_wheezy_mips_standard.qcow2 \
> >   -redir tcp:5556::22 -serial stdio
> >
> > and connecting with "xtightvncviewer :0" I get when closing vnc:
>=20
> This is also true with other targets, ex:
> x86_64-softmmu/qemu-system-x86_64 -vnc :0
>=20
> Daniel, Gerd, are you looking at it? this looks like a 2.12 regression.

I've not had toime to look at it - would be useful if someone can bisect
it at least if its a regression since 2.11

>=20
> >
> > =3D=3D27686=3D=3DERROR: AddressSanitizer: heap-use-after-free on addr=
ess
> > 0x63100003c814 at pc 0x55eed918362a bp 0x7ffdf5c36c80 sp 0x7ffdf5c36c=
78
> > READ of size 4 at 0x63100003c814 thread T0
> >     #0 0x55eed9183629 in vnc_client_io /source/qemu/ui/vnc.c:1549
> >     #1 0x55eed94ae26c in qio_channel_fd_source_dispatch
> > /source/qemu/io/channel-watch.c:84
> >     #2 0x7f3e181860f4 in g_main_context_dispatch
> > (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4c0f4)
> >     #3 0x55eed95b9799 in glib_pollfds_poll /source/qemu/util/main-loo=
p.c:215
> >     #4 0x55eed95b9989 in os_host_main_loop_wait
> > /source/qemu/util/main-loop.c:263
> >     #5 0x55eed95b9b5f in main_loop_wait /source/qemu/util/main-loop.c=
:522
> >     #6 0x55eed898f7dd in main_loop /source/qemu/vl.c:1943
> >     #7 0x55eed89a1f0b in main /source/qemu/vl.c:4734
> >     #8 0x7f3dfe094a86 in __libc_start_main
> > (/lib/x86_64-linux-gnu/libc.so.6+0x21a86)
> >     #9 0x55eed8518db9 in _start
> > (/build/qemu/mips-softmmu/qemu-system-mips+0x14f3db9)
> >
> > 0x63100003c814 is located 20 bytes inside of 75744-byte region
> > [0x63100003c800,0x63100004efe0)
> > freed by thread T0 here:
> >     #0 0x7f3e18b878c8 in __interceptor_free
> > (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xd98c8)
> >     #1 0x55eed9181bb0 in vnc_disconnect_finish /source/qemu/ui/vnc.c:=
1278
> >     #2 0x55eed9183225 in vnc_client_read /source/qemu/ui/vnc.c:1511
> >     #3 0x55eed91835a9 in vnc_client_io /source/qemu/ui/vnc.c:1541
> >     #4 0x55eed94ae26c in qio_channel_fd_source_dispatch
> > /source/qemu/io/channel-watch.c:84
> >     #5 0x7f3e181860f4 in g_main_context_dispatch
> > (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4c0f4)
> >
> > previously allocated by thread T0 here:
> >     #0 0x7f3e18b87df8 in calloc
> > (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xd9df8)
> >     #1 0x7f3e1818b8b0 in g_malloc0
> > (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x518b0)
> >     #2 0x55eed9192aa0 in vnc_listen_io /source/qemu/ui/vnc.c:3186
> >     #3 0x55eed94b9fd7 in qio_net_listener_channel_func
> > /source/qemu/io/net-listener.c:57
> >     #4 0x55eed94ae26c in qio_channel_fd_source_dispatch
> > /source/qemu/io/channel-watch.c:84
> >     #5 0x7f3e181860f4 in g_main_context_dispatch
> > (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4c0f4)
> >
> > SUMMARY: AddressSanitizer: heap-use-after-free
> > /source/qemu/ui/vnc.c:1549 in vnc_client_io
> > Shadow bytes around the buggy address:
> >   0x0c627ffff8b0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> >   0x0c627ffff8c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> >   0x0c627ffff8d0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> >   0x0c627ffff8e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> >   0x0c627ffff8f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> > =3D>0x0c627ffff900: fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd fd fd
> >   0x0c627ffff910: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> >   0x0c627ffff920: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> >   0x0c627ffff930: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> >   0x0c627ffff940: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> >   0x0c627ffff950: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> >
> > Shadow byte legend (one shadow byte represents 8 application bytes):
> >   Heap left redzone:       fa
> >   Freed heap region:       fd
> > =3D=3D26606=3D=3DABORTING
> >

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
