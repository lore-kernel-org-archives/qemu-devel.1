Received: from eggs.gnu.org ([209.51.188.92]:37473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hG50X-0003pQ-1f
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hG50W-0003x3-2h
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hG50V-0003v4-Qb
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:03:00 -0400
From: Bandan Das <bsd@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<20190415154503.6758-2-berrange@redhat.com>
Date: Mon, 15 Apr 2019 13:02:52 -0400
In-Reply-To: <20190415154503.6758-2-berrange@redhat.com> ("Daniel
	P. \=\?utf-8\?Q\?Berrang\=C3\=A9\=22's\?\= message of "Mon,
	15 Apr 2019 16:45:01 +0100")
Message-ID: <jpgbm17p5fn.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] usb-mtp: fix string length for
 filename when writing metadata
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The ObjectInfo 'length' field provides the length of the
> wide character string filename. This is then converted to
> a multi-byte character string. This may have a different
> byte count to the wide character string. We should use the
> C string length of the multi-byte string instead.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index ebf210fbf8..838cd74da6 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1714,7 +1714,7 @@ static void usb_mtp_write_metadata(MTPState *s, uin=
t64_t dlen)
>          return;
>      }
>=20=20
> -    o =3D usb_mtp_object_lookup_name(p, filename, dataset->length);
> +    o =3D usb_mtp_object_lookup_name(p, filename, -1);

Nit: Might as well just remove the "-1" argument and unconditionally use
strlen in usb_mtp_object_lookup_name

Bandan

>      if (o !=3D NULL) {
>          next_handle =3D o->handle;
>      }
