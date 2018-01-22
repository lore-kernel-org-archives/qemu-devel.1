Received: from eggs.gnu.org ([2001:4830:134:3::10]:41585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1edfdp-00015X-V7
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1edfdm-0004Ub-PR
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:12:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1edfdm-0004Rl-Fq
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:12:14 -0500
References: <1516611841-5526-1-git-send-email-anton.nefedov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <eee99098-7056-ef29-3b47-e59f04e91dda@redhat.com>
Date: Mon, 22 Jan 2018 12:12:11 -0500
MIME-Version: 1.0
In-Reply-To: <1516611841-5526-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] ide-test: test trim requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org



On 01/22/2018 04:04 AM, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  tests/ide-test.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index aa9de06..be427e4 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -52,6 +52,7 @@
>  enum {
>      reg_data        = 0x0,
>      reg_feature     = 0x1,
> +    reg_error       = 0x1,
>      reg_nsectors    = 0x2,
>      reg_lba_low     = 0x3,
>      reg_lba_middle  = 0x4,
> @@ -69,6 +70,11 @@ enum {
>      ERR     = 0x01,
>  };
>  
> +/* Error field */
> +enum {
> +    ABRT    = 0x04,
> +};
> +
>  enum {
>      DEV     = 0x10,
>      LBA     = 0x40,
> @@ -81,6 +87,7 @@ enum {
>  };
>  
>  enum {
> +    CMD_DSM         = 0x06,
>      CMD_READ_DMA    = 0xc8,
>      CMD_WRITE_DMA   = 0xca,
>      CMD_FLUSH_CACHE = 0xe7,
> @@ -179,6 +186,12 @@ typedef struct PrdtEntry {
>  #define assert_bit_set(data, mask) g_assert_cmphex((data) & (mask), ==, (mask))
>  #define assert_bit_clear(data, mask) g_assert_cmphex((data) & (mask), ==, 0)
>  
> +static uint64_t trim_range_le(uint64_t sector, uint16_t count)
> +{
> +    /* 2-byte range, 6-byte LBA */
> +    return cpu_to_le64(((uint64_t)count << 48) + sector);
> +}
> +
>  static int send_dma_request(int cmd, uint64_t sector, int nb_sectors,
>                              PrdtEntry *prdt, int prdt_entries,
>                              void(*post_exec)(QPCIDevice *dev, QPCIBar ide_bar,
> @@ -204,6 +217,7 @@ static int send_dma_request(int cmd, uint64_t sector, int nb_sectors,
>           * the SCSI command being sent in the packet, too. */
>          from_dev = true;
>          break;
> +    case CMD_DSM:
>      case CMD_WRITE_DMA:
>          from_dev = false;
>          break;
> @@ -234,6 +248,10 @@ static int send_dma_request(int cmd, uint64_t sector, int nb_sectors,
>          /* Enables ATAPI DMA; otherwise PIO is attempted */
>          qpci_io_writeb(dev, ide_bar, reg_feature, 0x01);
>      } else {
> +        if (cmd == CMD_DSM) {
> +            /* trim bit */
> +            qpci_io_writeb(dev, ide_bar, reg_feature, 0x01);
> +        }
>          qpci_io_writeb(dev, ide_bar, reg_nsectors, nb_sectors);
>          qpci_io_writeb(dev, ide_bar, reg_lba_low,    sector & 0xff);
>          qpci_io_writeb(dev, ide_bar, reg_lba_middle, (sector >> 8) & 0xff);
> @@ -344,6 +362,58 @@ static void test_bmdma_simple_rw(void)
>      g_free(cmpbuf);
>  }
>  
> +static void test_bmdma_trim(void)
> +{
> +    QPCIDevice *dev;
> +    QPCIBar bmdma_bar, ide_bar;
> +    uint8_t status;
> +    const uint64_t trim_range[] = { trim_range_le(0, 2),
> +                                    trim_range_le(6, 8),
> +                                    trim_range_le(10, 1),
> +                                  };
> +    const uint64_t bad_range = trim_range_le(TEST_IMAGE_SIZE / 512 - 1, 2);
> +    size_t len = 512;
> +    uint8_t *buf;
> +    uintptr_t guest_buf = guest_alloc(guest_malloc, len);
> +
> +    PrdtEntry prdt[] = {
> +        {
> +            .addr = cpu_to_le32(guest_buf),
> +            .size = cpu_to_le32(len | PRDT_EOT),
> +        },
> +    };
> +
> +    dev = get_pci_device(&bmdma_bar, &ide_bar);
> +
> +    buf = g_malloc(len);
> +
> +    /* Normal request */
> +    *((uint64_t *)buf) = trim_range[0];
> +    *((uint64_t *)buf + 1) = trim_range[1];
> +
> +    memwrite(guest_buf, buf, 2 * sizeof(uint64_t));
> +
> +    status = send_dma_request(CMD_DSM, 0, 1, prdt,
> +                              ARRAY_SIZE(prdt), NULL);
> +    g_assert_cmphex(status, ==, BM_STS_INTR);
> +    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
> +
> +    /* Request contains invalid range */
> +    *((uint64_t *)buf) = trim_range[2];
> +    *((uint64_t *)buf + 1) = bad_range;
> +
> +    memwrite(guest_buf, buf, 2 * sizeof(uint64_t));
> +
> +    status = send_dma_request(CMD_DSM, 0, 1, prdt,
> +                              ARRAY_SIZE(prdt), NULL);
> +    g_assert_cmphex(status, ==, BM_STS_INTR);
> +    assert_bit_set(qpci_io_readb(dev, ide_bar, reg_status), ERR);
> +    assert_bit_set(qpci_io_readb(dev, ide_bar, reg_error), ABRT);
> +
> +    free_pci_device(dev);
> +    g_free(buf);
> +}
> +
>  static void test_bmdma_short_prdt(void)
>  {
>      QPCIDevice *dev;
> @@ -963,6 +1033,7 @@ int main(int argc, char **argv)
>  
>      qtest_add_func("/ide/bmdma/setup", test_bmdma_setup);
>      qtest_add_func("/ide/bmdma/simple_rw", test_bmdma_simple_rw);
> +    qtest_add_func("/ide/bmdma/trim", test_bmdma_trim);
>      qtest_add_func("/ide/bmdma/short_prdt", test_bmdma_short_prdt);
>      qtest_add_func("/ide/bmdma/one_sector_short_prdt",
>                     test_bmdma_one_sector_short_prdt);
> 

Reviewed-by: John Snow <jsnow@redhat.com>

Thanks, applied to my IDE tree:

https://github.com/jnsnow/qemu/commits/ide
https://github.com/jnsnow/qemu.git

--js
