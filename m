Received: from eggs.gnu.org ([209.51.188.92]:49817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzQTF-0002qU-6t
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzQTE-0000mY-Db
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:31:49 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzQTD-0000m0-Bv
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:31:48 -0500
Received: by mail-oi1-x244.google.com with SMTP id s16so17295938oih.9
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:31:46 -0800 (PST)
MIME-Version: 1.0
References: <155137678223.44753.5438092367451176318.stgit@bahia.lan>
In-Reply-To: <155137678223.44753.5438092367451176318.stgit@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 18:31:34 +0000
Message-ID: <CAFEAcA94Y5jt8wr3Os7PWT_hA_OLRyL7FQqxdp5B_Lfg1Gy+_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 28 Feb 2019 at 17:59, Greg Kurz <groug@kaod.org> wrote:
>
> Build fails with gcc 9:
>
>   CC      ppc64-softmmu/hw/scsi/virtio-scsi.o
> hw/scsi/virtio-scsi.c: In function =E2=80=98virtio_scsi_do_tmf=E2=80=99:
> hw/scsi/virtio-scsi.c:265:39: error: taking address of packed member of =
=E2=80=98struct virtio_scsi_ctrl_tmf_req=E2=80=99 may result in an unaligne=
d pointer value [-Werror=3Daddress-of-packed-member]
>   265 |     virtio_tswap32s(VIRTIO_DEVICE(s), &req->req.tmf.subtype);
>       |                                       ^~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> All the fields in struct virtio_scsi_ctrl_tmf_req are naturally aligned,
> so we could in theory drop QEMU_PACKED. Unfortunately, the header file
> is imported from linux which already has the packed attribute. Trying to
> fix that in the update-linux-headers.sh script is likely to produce
> ugliness. Turn the call to virtio_tswap32s() into an assignment instead.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/scsi/virtio-scsi.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index ce99d288b035..839f1202567d 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -262,7 +262,13 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOS=
CSIReq *req)
>      /* Here VIRTIO_SCSI_S_OK means "FUNCTION COMPLETE".  */
>      req->resp.tmf.response =3D VIRTIO_SCSI_S_OK;
>
> -    virtio_tswap32s(VIRTIO_DEVICE(s), &req->req.tmf.subtype);
> +    /*
> +     * req->req.tmf has the QEMU_PACKED attribute. Don't use virtio_tswa=
p32s()
> +     * to avoid compiler errors.
> +     */
> +    req->req.tmf.subtype =3D
> +        virtio_tswap32(VIRTIO_DEVICE(s), req->req.tmf.subtype);
> +
>      switch (req->req.tmf.subtype) {
>      case VIRTIO_SCSI_T_TMF_ABORT_TASK:
>      case VIRTIO_SCSI_T_TMF_QUERY_TASK:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I haven't generally bothered to add comments about packed
structs when I've switched away from the *s versions of byteswap
functions, but it doesn't hurt.

We should consider just replacing the other dozen uses
of virtio_tswap*s() with the non-s versions and dropping the
s functions entirely...

thanks
-- PMM
