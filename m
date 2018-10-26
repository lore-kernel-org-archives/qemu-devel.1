Received: from eggs.gnu.org ([2001:4830:134:3::10]:52187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG98f-00079u-3Y
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 16:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG98e-000393-03
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 16:55:25 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gG98d-000380-5f
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 16:55:23 -0400
Received: by mail-ot1-x344.google.com with SMTP id o14so2327598oth.4
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 13:55:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181026194314.18663-1-ppandit@redhat.com>
References: <20181026194314.18663-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Oct 2018 21:55:01 +0100
Message-ID: <CAFEAcA8auV_NMER=nfrMnHOQ8oSSAupCt8ap2W+XJ4ypsR5uDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Ameya More <ameya.more@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>

On 26 October 2018 at 20:43, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While writing a message in 'lsi_do_msgin', message length value
> in 'msg_len' could be invalid. Add check to avoid OOB access issue.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/scsi/lsi53c895a.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> Update v1: add .post_load routine and an assert() call
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05730.html
>
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index d1e6534311..3a40e62853 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -861,12 +861,13 @@ static void lsi_do_status(LSIState *s)
>
>  static void lsi_do_msgin(LSIState *s)
>  {
> -    int len;
> +    uint8_t len;
>      trace_lsi_do_msgin(s->dbc, s->msg_len);
>      s->sfbr = s->msg[0];
>      len = s->msg_len;
>      if (len > s->dbc)
>          len = s->dbc;
> +    assert(len <= LSI_MAX_MSGIN_LEN);
>      pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
>      /* Linux drivers rely on the last byte being in the SIDL.  */
>      s->sidl = s->msg[len - 1];

Is it possible to get here with len == 0 ?

thanks
-- PMM
