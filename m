Received: from eggs.gnu.org ([2001:4830:134:3::10]:50943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDRzd-0005u0-6s
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDRza-00083g-0n
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:26:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDRzZ-00082D-Op
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:26:53 -0400
Date: Fri, 19 Oct 2018 11:26:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019102647.GH13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181019101346.3316-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181019101346.3316-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] websock: fix handshake leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, jusual@mail.ru

On Fri, Oct 19, 2018 at 02:13:46PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Thanks Valgrind:
>=20
> =3D=3D955=3D=3D 217 bytes in 1 blocks are definitely lost in loss recor=
d 275 of 321
> =3D=3D955=3D=3D    at 0x483A965: realloc (vg_replace_malloc.c:785)
> =3D=3D955=3D=3D    by 0x50B6839: __vasprintf_chk (in /usr/lib64/libc-2.=
28.so)
> =3D=3D955=3D=3D    by 0x49AA05C: g_vasprintf (in /usr/lib64/libglib-2.0=
.so.0.5800.1)
> =3D=3D955=3D=3D    by 0x4983440: g_strdup_vprintf (in /usr/lib64/libgli=
b-2.0.so.0.5800.1)
> =3D=3D955=3D=3D    by 0x126048: qio_channel_websock_handshake_send_res =
(channel-websock.c:162)
> =3D=3D955=3D=3D    by 0x1266E6: qio_channel_websock_handshake_send_res_=
ok (channel-websock.c:362)
> =3D=3D955=3D=3D    by 0x126D3E: qio_channel_websock_handshake_process (=
channel-websock.c:468)
> =3D=3D955=3D=3D    by 0x126EF2: qio_channel_websock_handshake_read (cha=
nnel-websock.c:511)
> =3D=3D955=3D=3D    by 0x12715B: qio_channel_websock_handshake_io (chann=
el-websock.c:571)
> =3D=3D955=3D=3D    by 0x125027: qio_channel_fd_source_dispatch (channel=
-watch.c:84)
> =3D=3D955=3D=3D    by 0x496326C: g_main_context_dispatch (in /usr/lib64=
/libglib-2.0.so.0.5800.1)
> =3D=3D955=3D=3D    by 0x169EC3: glib_pollfds_poll (main-loop.c:215)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  io/channel-websock.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index e6608b969d..dc43dc6bb9 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -163,6 +163,7 @@ qio_channel_websock_handshake_send_res(QIOChannelWe=
bsock *ioc,
>      responselen =3D strlen(response);
>      buffer_reserve(&ioc->encoutput, responselen);
>      buffer_append(&ioc->encoutput, response, responselen);
> +    g_free(response);
>      va_end(vargs);
>  }

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
