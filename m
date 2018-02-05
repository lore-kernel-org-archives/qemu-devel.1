Received: from eggs.gnu.org ([2001:4830:134:3::10]:43780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eigW6-0006BQ-RC
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eigW3-0002ND-Lv
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:09:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eigW3-0002Mn-FZ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:08:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4D5A81DE4
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 13:08:58 +0000 (UTC)
References: <20180205114938.15784-1-berrange@redhat.com>
	<20180205114938.15784-5-berrange@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <41549b25-fbc9-dbcd-0af8-53b7d70cbc24@redhat.com>
Date: Mon, 5 Feb 2018 14:08:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180205114938.15784-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] ui: extend VNC trottling tracing to
 SASL codepaths
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

On 02/05/18 12:49, Daniel P. Berrang=C3=A9 wrote:
> In previous commit:
>=20
>   commit 6aa22a29187e1908f5db738d27c64a9efc8d0bfa
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Mon Dec 18 19:12:27 2017 +0000
>=20
>     ui: add trace events related to VNC client throttling
>=20
> trace points related to unthrottling client I/O were missed from the
> SASL codepaths.
>=20
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  ui/vnc-auth-sasl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
> index 8ebd0d3d00..3751a777a4 100644
> --- a/ui/vnc-auth-sasl.c
> +++ b/ui/vnc-auth-sasl.c
> @@ -79,12 +79,23 @@ size_t vnc_client_write_sasl(VncState *vs)
> =20
>      vs->sasl.encodedOffset +=3D ret;
>      if (vs->sasl.encodedOffset =3D=3D vs->sasl.encodedLength) {
> +        bool throttled =3D vs->force_update_offset !=3D 0;
> +        size_t offset;
>          if (vs->sasl.encodedRawLength >=3D vs->force_update_offset) {
>              vs->force_update_offset =3D 0;
>          } else {
>              vs->force_update_offset -=3D vs->sasl.encodedRawLength;
>          }
> +        if (throttled && vs->force_update_offset =3D=3D 0) {
> +            trace_vnc_client_unthrottle_forced(vs, vs->ioc);
> +        }
> +        offset =3D vs->output.offset;
>          buffer_advance(&vs->output, vs->sasl.encodedRawLength);
> +        if (offset >=3D vs->throttle_output_offset &&
> +            vs->output.offset < vs->throttle_output_offset) {
> +            trace_vnc_client_unthrottle_incremental(vs, vs->ioc,
> +                                                    vs->output.offset)=
;
> +        }
>          vs->sasl.encoded =3D NULL;
>          vs->sasl.encodedOffset =3D vs->sasl.encodedLength =3D 0;
>      }
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thank you!
Laszlo
