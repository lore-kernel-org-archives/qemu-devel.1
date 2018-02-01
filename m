Received: from eggs.gnu.org ([2001:4830:134:3::10]:48460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ehHgT-00047V-U4
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 11:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ehHgN-0000Ao-AD
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 11:25:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ehHgN-00009k-3g
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 11:25:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C71D9C047B7C
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 16:25:49 +0000 (UTC)
References: <20180201155841.27509-1-berrange@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2a023a3d-ebc3-cc59-04dd-974740037252@redhat.com>
Date: Thu, 1 Feb 2018 17:25:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180201155841.27509-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] ui: correctly advance output buffer
 when writing SASL data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 02/01/18 16:58, Daniel P. Berrang=C3=A9 wrote:
> In this previous commit:
>=20
>   commit 8f61f1c5a6bc06438a1172efa80bc7606594fa07
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Mon Dec 18 19:12:20 2017 +0000
>=20
>     ui: track how much decoded data we consumed when doing SASL encodin=
g
>=20
> I attempted to fix a flaw with tracking how much data had actually been
> processed when encoding with SASL. With that flaw, the VNC server could
> mistakenly discard queued data that had not been sent.
>=20
> The fix was not quite right though, because it merely decremented the
> vs->output.offset value. This is effectively to discarding data from th=
e
> end of the pending output buffer. We actually need to discard data from
> the start of the pending output buffer. We also want to free memory tha=
t
> is no longer required. The correct way to handle this is to use the
> buffer_advance() helper method instead of directly manipulating the
> offset value.
>=20
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  ui/vnc-auth-sasl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
> index 74a5f513f2..fbccca8c8a 100644
> --- a/ui/vnc-auth-sasl.c
> +++ b/ui/vnc-auth-sasl.c
> @@ -84,7 +84,7 @@ size_t vnc_client_write_sasl(VncState *vs)
>          } else {
>              vs->force_update_offset -=3D vs->sasl.encodedRawLength;
>          }
> -        vs->output.offset -=3D vs->sasl.encodedRawLength;
> +        buffer_advance(&vs->output, vs->sasl.encodedRawLength);
>          vs->sasl.encoded =3D NULL;
>          vs->sasl.encodedOffset =3D vs->sasl.encodedLength =3D 0;
>      }
>=20

With the typo pointed out by Eric fixed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thank you!
Laszlo
