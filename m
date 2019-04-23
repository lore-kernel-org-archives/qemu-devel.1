Received: from eggs.gnu.org ([209.51.188.92]:44262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIwMe-0006cJ-1x
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIwBA-00074x-Ci
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hIwB8-00073K-W7
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:13:47 -0400
Date: Tue, 23 Apr 2019 15:13:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190423141332.GN6022@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190211182442.8542-1-berrange@redhat.com>
	<46b6b751-4e3f-1b11-9ac7-d0d73cca2227@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46b6b751-4e3f-1b11-9ac7-d0d73cca2227@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/16] chardev: refactoring & many
 bugfixes related tcp_chr_wait_connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Apr 22, 2019 at 09:51:17AM -0500, Eric Blake wrote:
> On 2/11/19 12:24 PM, Daniel P. Berrang=C3=A9 wrote:
> > This is a followup to
> >=20
> >   v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03344.=
html
> >   v2: http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg0594=
7.html
> >=20
> > This series comes out of a discussion between myself & Yongji Xie in:
> >=20
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01881.html
> >=20
> > I eventually understood that the problem faced was that
> > tcp_chr_wait_connected was racing with the background connection atte=
mpt
> > previously started, causing two connections to be established. This
> > broke because some vhost user servers only allow a single connection.
> >=20
> > After messing around with the code alot the final solution was in fac=
t
> > very easy. We simply have to delay the first background connection
> > attempt until the main loop is running. It will then automatically
> > turn into a no-op if tcp_chr_wait_connected has been run. This is
> > dealt with in the last patch in this series
> >=20
> > I believe this should solve the problem Yongji Xie faced, and thus no=
t
> > require us to add support for "nowait" option with client sockets at
> > all. The reconnect=3D1 option effectively already implements nowait
> > semantics, and now plays nicely with tcp_chr_wait_connected.
> >=20
> > In investigating this I found various other bugs that needed fixing a=
nd
> > identified some useful refactoring to simplify / clarify the code, he=
nce
> > this very long series.
>=20
> Even with this series applied, I'm still seeing sporadic failures of
> iotest 169. Max posted a hack patch a while back that tries to work
> around the race:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05907.html
>=20
> which he originally diagnosed in iotest 147:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05579.html
>=20
> but as it was a hack, he has not pursued it further, and so the symptom=
s
> are still there, although not completely reproducible:
>=20
> 169 10s ... - output mismatch (see 169.out.bad)
> --- /home/eblake/qemu/tests/qemu-iotests/169.out	2018-11-16
> 15:48:12.018526748 -0600
> +++ /home/eblake/qemu/tests/qemu-iotests/169.out.bad	2019-04-22
> 09:38:45.481517132 -0500
> @@ -1,3 +1,5 @@
> +WARNING:qemu:qemu received signal 11:
> /home/eblake/qemu/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x=
86_64
> -chardev
> socket,id=3Dmon,path=3D/home/eblake/qemu/tests/qemu-iotests/scratch/tmp=
4clmPF/qemua-26803-monitor.sock
> -mon chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest
> unix:path=3D/home/eblake/qemu/tests/qemu-iotests/scratch/qemua-26803-qt=
est.sock
> -machine accel=3Dqtest -nodefaults -machine accel=3Dqtest -drive
> if=3Dvirtio,id=3Ddrive0,file=3D/home/eblake/qemu/tests/qemu-iotests/scr=
atch/disk_a,format=3Dqcow2,cache=3Dwriteback
>=20
> Any chance you can take a look as to what a non-hack fix should be?

Oh, it looks like we dropped the ball here. We have a fix already but
it doesn't appear to have been merged for 4.0 :-(

  https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06174.html

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
