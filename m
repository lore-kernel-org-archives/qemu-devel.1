Received: from eggs.gnu.org ([2001:4830:134:3::10]:60760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eyId9-0001eB-Bp
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eyId8-00080i-Hd
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:52:51 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eyId8-0007yT-9Q
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:52:50 -0400
Received: by mail-wr0-x241.google.com with SMTP id h2so1981698wre.12
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 07:52:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521476505-30584-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521476505-30584-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 20 Mar 2018 15:52:47 +0100
Message-ID: <CAJ+F1CK2uEhbQ6UaPY5JTiXxRD==OyqBXTBzQpzrh-ud1NcaDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tpm: Set tpmRegValidSts flag to '1' in
 device reset
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

Hi

On Mon, Mar 19, 2018 at 5:21 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Fix the initialization of the tpmRegValidSts flag and set it to '1'
> during device reset without expecting a write to another register.
> This seems to also be the default behavior of real hardware.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_crb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index d8917cb..114b66e 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -145,8 +145,6 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr a=
ddr,
>                               beenSeized, 0);
>              ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
>                               locAssigned, 1);
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> -                             tpmRegValidSts, 1);
>              break;
>          }
>          break;
> @@ -210,6 +208,8 @@ static void tpm_crb_reset(void *dev)
>
>      tpm_backend_reset(s->tpmbe);
>
> +    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> +                     tpmRegValidSts, 1);
>      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>                       InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
>      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,

Hmm, the specification says they default to 0. Except tpmEstablished
to 1, which we should probably manipulate somehow ("The TPM clears
this bit to 0 upon receipt of _TPM_Hash_End The TPM sets this bit to a
1 when the TPM_LOC_CTRL_x.resetEstablishment field is set to 1.").
Help welcome!

Shouldn't it also set locAssigned to 1 in this case ?

I am not very familiar with the locality support, since I didn't
implement it for CRB. You may have more clues what is expected here.

--=20
Marc-Andr=C3=A9 Lureau
