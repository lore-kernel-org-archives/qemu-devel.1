Received: from eggs.gnu.org ([2001:4830:134:3::10]:40842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVFKX-00062o-VR
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVFKJ-0000OS-ND
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:01:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVFKJ-0000N7-Fp
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:01:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 584EC40201BE
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 12:01:34 +0000 (UTC)
Date: Tue, 19 Jun 2018 13:01:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180619120126.GQ20929@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180618161729.334-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/26] chardev: avoid crash if no
 associated address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Mon, Jun 18, 2018 at 06:17:04PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> A socket chardev may not have associated address (when adding client
> fd manually for example). But on disconnect, updating socket filename
> expects an address and may lead to this crash:
>=20
>   Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation faul=
t.
>   0x0000555555d8c70c in SocketAddress_to_str (prefix=3D0x555556043062 "=
disconnected:", addr=3D0x0, is_listen=3Dfalse, is_telnet=3Dfalse) at /hom=
e/elmarco/src/qq/chardev/char-socket.c:388
>   388	    switch (addr->type) {
>   (gdb) bt
>   #0  0x0000555555d8c70c in SocketAddress_to_str (prefix=3D0x5555560430=
62 "disconnected:", addr=3D0x0, is_listen=3Dfalse, is_telnet=3Dfalse) at =
/home/elmarco/src/qq/chardev/char-socket.c:388
>   #1  0x0000555555d8c8aa in update_disconnected_filename (s=3D0x555556b=
1ed00) at /home/elmarco/src/qq/chardev/char-socket.c:419
>   #2  0x0000555555d8c959 in tcp_chr_disconnect (chr=3D0x555556b1ed00) a=
t /home/elmarco/src/qq/chardev/char-socket.c:438
>   #3  0x0000555555d8cba1 in tcp_chr_hup (channel=3D0x555556b75690, cond=
=3DG_IO_HUP, opaque=3D0x555556b1ed00) at /home/elmarco/src/qq/chardev/cha=
r-socket.c:482
>   #4  0x0000555555da596e in qio_channel_fd_source_dispatch (source=3D0x=
555556bb68b0, callback=3D0x555555d8cb58 <tcp_chr_hup>, user_data=3D0x5555=
56b1ed00) at /home/elmarco/src/qq/io/channel-watch.c:84
>=20
> Replace filename with a generic "disconnected:socket" in this case.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
