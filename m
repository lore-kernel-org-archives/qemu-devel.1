Received: from eggs.gnu.org ([2001:4830:134:3::10]:40602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBqH-0008IT-1O
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBqD-0006Sr-Rh
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:00:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHBqC-0006RT-Aj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:00:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so9203682wmw.2
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:00:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20181026194314.18663-1-ppandit@redhat.com>
	<CAFEAcA8auV_NMER=nfrMnHOQ8oSSAupCt8ap2W+XJ4ypsR5uDA@mail.gmail.com>
	<1b9136bd-47b8-4a39-59c1-5831498a2578@redhat.com>
Message-ID: <2dd73225-1e25-423e-5284-8f6fc60d47e3@redhat.com>
Date: Mon, 29 Oct 2018 18:58:22 +0100
MIME-Version: 1.0
In-Reply-To: <1b9136bd-47b8-4a39-59c1-5831498a2578@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] lsi53c895a: check message length value
 is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>
Cc: Ameya More <ameya.more@oracle.com>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>

On 29/10/2018 18:56, Paolo Bonzini wrote:
> On 26/10/2018 22:55, Peter Maydell wrote:
>>> +    assert(len <= LSI_MAX_MSGIN_LEN);
>>>      pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
>>>      /* Linux drivers rely on the last byte being in the SIDL.  */
>>>      s->sidl = s->msg[len - 1];
>> Is it possible to get here with len == 0 ?
> 
> No, all calls to
> 
>     lsi_set_phase(s, PHASE_MI);
> 
> are followed or preceded by lsi_add_msg_byte.  But an assertion is good
> to add.  What do you think of squashing this on top:
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 3a40e62853..72d85c42dd 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -865,9 +865,9 @@ static void lsi_do_msgin(LSIState *s)
>      trace_lsi_do_msgin(s->dbc, s->msg_len);
>      s->sfbr = s->msg[0];
>      len = s->msg_len;
> +    assert(len >= 0 && len <= LSI_MAX_MSGIN_LEN);

Ahem, len > 0.  Is there a CVE number?

Paolo

>      if (len > s->dbc)
>          len = s->dbc;
> -    assert(len <= LSI_MAX_MSGIN_LEN);
>      pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
>      /* Linux drivers rely on the last byte being in the SIDL.  */
>      s->sidl = s->msg[len - 1];
> @@ -1706,8 +1706,10 @@
>          break;
>      case 0x58: /* SBDL */
>          /* Some drivers peek at the data bus during the MSG IN phase.  */
> -        if ((s->sstat1 & PHASE_MASK) == PHASE_MI)
> +        if ((s->sstat1 & PHASE_MASK) == PHASE_MI) {
> +            assert(s->msg_len >= 0);
>              return s->msg[0];
> +        }
>          ret = 0;
>          break;
>      case 0x59: /* SBDL high */
> 
> 
> Paolo
> 
