Received: from eggs.gnu.org ([2001:4830:134:3::10]:54907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1V1s-0006eW-G9
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1V1r-0000op-Pk
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:43:36 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:44624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f1V1r-0000oe-IQ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:43:35 -0400
Received: by mail-wr0-x236.google.com with SMTP id u46so4948008wrc.11
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 03:43:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522270761-29646-3-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1522270761-29646-3-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Mar 2018 12:43:33 +0200
Message-ID: <CAJ+F1CKK+27LbyvT=AG=W6d6k-X00Y=gT166QtkHtyNd8W=-ZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] tpm: CRB: Reset Granted flag when
 relinquishing locality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Wed, Mar 28, 2018 at 10:59 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Reset the Granted flag when relinquishing a locality.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Makes sense. I tried to avoid looking at locality management so far,
but I guess a minimum is necessary. I suppose no locality will be
granted in this case after relinquish, until a new request. But the
spec says: "If two localities have requested use of the TPMwhen
the current locality relinquishes it, the locality with the highest
priority getsaccess to the TPM." Probably that doesn't make sense with
only loc 0, as you can't request, then relinquish, and expect it to be
granted immediately after.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/tpm/tpm_crb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index e728b55..ee6c87e 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -145,6 +145,8 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr a=
ddr,
>          case CRB_LOC_CTRL_RELINQUISH:
>              ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
>                               locAssigned, 0);
> +            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> +                             Granted, 0);
>              break;
>          case CRB_LOC_CTRL_REQUEST_ACCESS:
>              ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
