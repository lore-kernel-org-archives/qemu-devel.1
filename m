Received: from eggs.gnu.org ([2001:4830:134:3::10]:49614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dGKN2-0005qV-F5
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dGKMz-0000Dm-9H
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:18:12 -0400
References: <20170531192836.7187-1-jsnow@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <88293908-ce2e-32e3-8094-f9288f9c6c17@redhat.com>
Date: Thu, 1 Jun 2017 09:18:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170531192836.7187-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] ide-test: check return of
 fwrite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-trivial@nongnu.org
Cc: thuth@redhat.com, qemu-devel@nongnu.org

On 31/05/2017 21:28, John Snow wrote:
> To quiet patchew, add an assert for fwrite's return value.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  tests/ide-test.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index 139ebc0..bfd79dd 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -796,11 +796,13 @@ static void cdrom_pio_impl(int nblocks)
>      int i, j;
>      uint8_t data;
>      uint16_t limit;
> +    size_t ret;
>  
>      /* Prepopulate the CDROM with an interesting pattern */
>      generate_pattern(pattern, patt_len, ATAPI_BLOCK_SIZE);
>      fh = fopen(tmp_path, "w+");
> -    fwrite(pattern, ATAPI_BLOCK_SIZE, patt_blocks, fh);
> +    ret = fwrite(pattern, ATAPI_BLOCK_SIZE, patt_blocks, fh);
> +    g_assert_cmpint(ret, ==, patt_blocks);
>      fclose(fh);
>  
>      ide_test_start("-drive if=none,file=%s,media=cdrom,format=raw,id=sr0,index=0 "
> @@ -880,6 +882,7 @@ static void test_cdrom_pio_large(void)
>  static void test_cdrom_dma(void)
>  {
>      static const size_t len = ATAPI_BLOCK_SIZE;
> +    size_t ret;
>      char *pattern = g_malloc(ATAPI_BLOCK_SIZE * 16);
>      char *rx = g_malloc0(len);
>      uintptr_t guest_buf;
> @@ -896,7 +899,8 @@ static void test_cdrom_dma(void)
>  
>      generate_pattern(pattern, ATAPI_BLOCK_SIZE * 16, ATAPI_BLOCK_SIZE);
>      fh = fopen(tmp_path, "w+");
> -    fwrite(pattern, ATAPI_BLOCK_SIZE, 16, fh);
> +    ret = fwrite(pattern, ATAPI_BLOCK_SIZE, 16, fh);
> +    g_assert_cmpint(ret, ==, 16);
>      fclose(fh);
>  
>      send_dma_request(CMD_PACKET, 0, 1, prdt, 1, send_scsi_cdb_read10);
> 
