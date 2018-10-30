Received: from eggs.gnu.org ([2001:4830:134:3::10]:33751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHPKm-0002Ef-SB
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHPKk-0002JG-Qw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:25:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gHPKj-0002Hf-LJ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:25:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id n5-v6so11480941wrw.12
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 01:25:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20181030062842.9792-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb59b1b6-f273-4df5-4b05-60e6d54e80ac@redhat.com>
Date: Tue, 30 Oct 2018 09:25:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181030062842.9792-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] lsi53c895a: check message length value
 is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Ameya More <ameya.more@oracle.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 30/10/2018 07:28, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While writing a message in 'lsi_do_msgin', message length value
> in 'msg_len' could be invalid. Add check to avoid OOB access issue.
> 
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

with one change below:

> ---
>  hw/scsi/lsi53c895a.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> Update v2: modify assert()
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06273.html
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index d1e6534311..dc39f4c3ee 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -861,10 +861,11 @@ static void lsi_do_status(LSIState *s)
>  
>  static void lsi_do_msgin(LSIState *s)
>  {
> -    int len;
> +    uint8_t len;
>      trace_lsi_do_msgin(s->dbc, s->msg_len);
>      s->sfbr = s->msg[0];
>      len = s->msg_len;
> +    assert(len > 0 && len <= LSI_MAX_MSGIN_LEN);
>      if (len > s->dbc)
>          len = s->dbc;
>      pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
> @@ -1705,8 +1706,10 @@ static uint8_t lsi_reg_readb(LSIState *s, int offset)
>          break;
>      case 0x58: /* SBDL */
>          /* Some drivers peek at the data bus during the MSG IN phase.  */
> -        if ((s->sstat1 & PHASE_MASK) == PHASE_MI)
> +        if ((s->sstat1 & PHASE_MASK) == PHASE_MI) {
> +            assert(s->msg_len >= 0);

should be > 0 as well.

Paolo

>              return s->msg[0];
> +        }
>          ret = 0;
>          break;
>      case 0x59: /* SBDL high */
> @@ -2103,11 +2106,23 @@ static int lsi_pre_save(void *opaque)
>      return 0;
>  }
>  
> +static int lsi_post_load(void *opaque, int version_id)
> +{
> +    LSIState *s = opaque;
> +
> +    if (s->msg_len < 0 || s->msg_len > LSI_MAX_MSGIN_LEN) {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_lsi_scsi = {
>      .name = "lsiscsi",
>      .version_id = 0,
>      .minimum_version_id = 0,
>      .pre_save = lsi_pre_save,
> +    .post_load = lsi_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_PCI_DEVICE(parent_obj, LSIState),
>  
> 
