Received: from eggs.gnu.org ([2001:4830:134:3::10]:41171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eigM0-0007sK-EX
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eigLv-0005jY-CX
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:58:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eigLv-0005d3-7P
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:58:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A600728203
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 12:58:29 +0000 (UTC)
References: <20180205114938.15784-1-berrange@redhat.com>
	<20180205114938.15784-2-berrange@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <498c4706-b451-2b91-e47e-023fc5658eb1@redhat.com>
Date: Mon, 5 Feb 2018 13:58:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180205114938.15784-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] ui: avoid risk of 32-bit int overflow
 in VNC buffer check
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
> For very large framebuffers, it is theoretically possible for the resul=
t
> of 'vs->throttle_output_offset * VNC_THROTTLE_OUTPUT_LIMIT_SCALE' to
> exceed the size of a 32-bit int. For this to happen in practice, the
> video RAM would have to be set to a large enough value, which is not
> likely today. None the less we can be paranoid against future growth by
> using division instead of multiplication when checking the limits.
>=20
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  ui/vnc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 93731accb6..e14e524764 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1572,8 +1572,8 @@ void vnc_write(VncState *vs, const void *data, si=
ze_t len)
>       * handshake, or from the job thread's VncState clone
>       */
>      if (vs->throttle_output_offset !=3D 0 &&
> -        vs->output.offset > (vs->throttle_output_offset *
> -                             VNC_THROTTLE_OUTPUT_LIMIT_SCALE)) {
> +        (vs->output.offset / VNC_THROTTLE_OUTPUT_LIMIT_SCALE) >
> +        vs->throttle_output_offset) {
>          trace_vnc_client_output_limit(vs, vs->ioc, vs->output.offset,
>                                        vs->throttle_output_offset);
>          vnc_disconnect_start(vs);
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
