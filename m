Received: from eggs.gnu.org ([2001:4830:134:3::10]:52705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cY9F5-0006WL-Na
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cY9F1-0002cf-0B
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:31:23 -0500
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:35942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cY9F0-0002bV-PX
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:31:18 -0500
Received: by mail-vk0-x233.google.com with SMTP id t8so212696920vke.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 02:31:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170130064736.9236-1-ppandit@redhat.com>
References: <20170130064736.9236-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 10:30:57 +0000
Message-ID: <CAFEAcA9H8NTnHaQEUUbuC0VC4oSfPywWR3aTDzymRc+A84yfrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] sd: sdhci: check data length during
 dma_memory_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-stable <qemu-stable@nongnu.org>

On 30 January 2017 at 06:47, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While doing multi block SDMA transfer in routine
> 'sdhci_sdma_transfer_multi_blocks', the 's->fifo_buffer' starting
> index 'begin' and data length 's->data_count' could end up to be same.
> This could lead to an OOB access issue. Correct transfer data length
> to avoid it.
>
> Reported-by: Jiang Xin <jiangxin1@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/sd/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 01fbf22..5bd5ab6 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -536,7 +536,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>                  boundary_count -= block_size - begin;
>              }
>              dma_memory_read(&address_space_memory, s->sdmasysad,
> -                            &s->fifo_buffer[begin], s->data_count);
> +                            &s->fifo_buffer[begin], s->data_count - begin);
>              s->sdmasysad += s->data_count - begin;
>              if (s->data_count == block_size) {
>                  for (n = 0; n < block_size; n++) {

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org

thanks
-- PMM
