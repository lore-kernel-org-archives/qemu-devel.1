Received: from eggs.gnu.org ([2001:4830:134:3::10]:36707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cTBDZ-0001h7-Pn
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cTBDW-0002wH-En
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:37:17 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cTBDW-0002vx-7A
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:37:14 -0500
Received: by mail-lf0-x241.google.com with SMTP id x1so8197131lff.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:37:14 -0800 (PST)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-9-git-send-email-clg@kaod.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <7df52dde-e4b2-23de-47e7-2e97d5eab4e4@gmail.com>
Date: Mon, 16 Jan 2017 18:37:11 +0100
MIME-Version: 1.0
In-Reply-To: <1483979087-32663-9-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/11] aspeed/smc: reset flash after
 each test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcin Krzeminski <marcin.krzeminski@nokia.com>



W dniu 09.01.2017 o 17:24, Cédric Le Goater pisze:
> Let's make sure when each test is run that the flash object is in an
> initial state and did not keep configuration from the previous tests.
Is there any particukar reason why you do that (bug/side 
effect/whatever) or you
just want to be sure what the flash state is?

Thanks,
Marcin
>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   tests/m25p80-test.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/tests/m25p80-test.c b/tests/m25p80-test.c
> index cb7ec81f1a6d..8dd550deb95e 100644
> --- a/tests/m25p80-test.c
> +++ b/tests/m25p80-test.c
> @@ -50,6 +50,8 @@ enum {
>       READ = 0x03,
>       PP = 0x02,
>       WREN = 0x6,
> +    RESET_ENABLE = 0x66,
> +    RESET_MEMORY = 0x99,
>       EN_4BYTE_ADDR = 0xB7,
>       ERASE_SECTOR = 0xd8,
>   };
> @@ -76,6 +78,14 @@ static void spi_conf(uint32_t value)
>       writel(ASPEED_FMC_BASE + R_CONF, conf);
>   }
>   
> +static void spi_conf_remove(uint32_t value)
> +{
> +    uint32_t conf = readl(ASPEED_FMC_BASE + R_CONF);
> +
> +    conf &= ~value;
> +    writel(ASPEED_FMC_BASE + R_CONF, conf);
> +}
> +
>   static void spi_ctrl_start_user(void)
>   {
>       uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
> @@ -95,6 +105,18 @@ static void spi_ctrl_stop_user(void)
>       writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
>   }
>   
> +static void flash_reset(void)
> +{
> +    spi_conf(CONF_ENABLE_W0);
> +
> +    spi_ctrl_start_user();
> +    writeb(ASPEED_FLASH_BASE, RESET_ENABLE);
> +    writeb(ASPEED_FLASH_BASE, RESET_MEMORY);
> +    spi_ctrl_stop_user();
> +
> +    spi_conf_remove(CONF_ENABLE_W0);
> +}
> +
>   static void test_read_jedec(void)
>   {
>       uint32_t jedec = 0x0;
> @@ -108,6 +130,8 @@ static void test_read_jedec(void)
>       jedec |= readb(ASPEED_FLASH_BASE);
>       spi_ctrl_stop_user();
>   
> +    flash_reset();
> +
>       g_assert_cmphex(jedec, ==, FLASH_JEDEC);
>   }
>   
> @@ -155,6 +179,8 @@ static void test_erase_sector(void)
>       for (i = 0; i < PAGE_SIZE / 4; i++) {
>           g_assert_cmphex(page[i], ==, 0xffffffff);
>       }
> +
> +    flash_reset();
>   }
>   
>   static void test_erase_all(void)
> @@ -182,6 +208,8 @@ static void test_erase_all(void)
>       for (i = 0; i < PAGE_SIZE / 4; i++) {
>           g_assert_cmphex(page[i], ==, 0xffffffff);
>       }
> +
> +    flash_reset();
>   }
>   
>   static void test_write_page(void)
> @@ -195,6 +223,7 @@ static void test_write_page(void)
>   
>       spi_ctrl_start_user();
>       writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
> +    writeb(ASPEED_FLASH_BASE, WREN);
>       writeb(ASPEED_FLASH_BASE, PP);
>       writel(ASPEED_FLASH_BASE, make_be32(my_page_addr));
>   
> @@ -215,6 +244,8 @@ static void test_write_page(void)
>       for (i = 0; i < PAGE_SIZE / 4; i++) {
>           g_assert_cmphex(page[i], ==, 0xffffffff);
>       }
> +
> +    flash_reset();
>   }
>   
>   static char tmp_path[] = "/tmp/qtest.m25p80.XXXXXX";
