Received: from eggs.gnu.org ([2001:4830:134:3::10]:39635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cTXeT-0005NV-Iu
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cTXeQ-0006NT-CJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:34:33 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cTXeQ-0006NJ-13
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:34:30 -0500
Received: by mail-lf0-x243.google.com with SMTP id x1so11901860lff.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 09:34:29 -0800 (PST)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-10-git-send-email-clg@kaod.org>
	<304c10df-271d-5ae2-1d1f-5bf215b805c4@gmail.com>
	<1d865c7c-837e-aa9b-b29b-6395fd083e91@kaod.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <996e7e22-7eea-846d-5785-aec2c865b32b@gmail.com>
Date: Tue, 17 Jan 2017 18:34:26 +0100
MIME-Version: 1.0
In-Reply-To: <1d865c7c-837e-aa9b-b29b-6395fd083e91@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/11] aspeed/smc: extend tests for
 Command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org



W dniu 17.01.2017 o 09:34, Cédric Le Goater pisze:
> On 01/16/2017 06:51 PM, mar.krzeminski wrote:
>>
>> W dniu 09.01.2017 o 17:24, Cédric Le Goater pisze:
>>> The Aspeed SMC controllers have a mode (Command mode) in which
>>> accesses to the flash content are no different than doing MMIOs. The
>>> controller generates all the necessary commands to load (or store)
>>> data in memory.
>>>
>>> So add a couple of tests doing direct reads and writes on the AHB bus.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>> ---
>>>    tests/m25p80-test.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 102 insertions(+)
>>>
>>>    Changes since v1:
>>>
>>>    - added preliminary configuration of the controller and the flash
>>>      before starting the test.
>>>    - added a flash reset
>>>
>>> diff --git a/tests/m25p80-test.c b/tests/m25p80-test.c
>>> index 8dd550deb95e..244aa33dd941 100644
>>> --- a/tests/m25p80-test.c
>>> +++ b/tests/m25p80-test.c
>>> @@ -36,6 +36,9 @@
>>>    #define   CRTL_EXTENDED0       0  /* 32 bit addressing for SPI */
>>>    #define R_CTRL0             0x10
>>>    #define   CTRL_CE_STOP_ACTIVE  (1 << 2)
>>> +#define   CTRL_READMODE        0x0
>>> +#define   CTRL_FREADMODE       0x1
>>> +#define   CTRL_WRITEMODE       0x2
>>>    #define   CTRL_USERMODE        0x3
>>>      #define ASPEED_FMC_BASE    0x1E620000
>>> @@ -86,6 +89,22 @@ static void spi_conf_remove(uint32_t value)
>>>        writel(ASPEED_FMC_BASE + R_CONF, conf);
>>>    }
>>>    +static void spi_ce_ctrl(uint32_t value)
>>> +{
>>> +    uint32_t conf = readl(ASPEED_FMC_BASE + R_CE_CTRL);
>>> +
>>> +    conf |= value;
>>> +    writel(ASPEED_FMC_BASE + R_CE_CTRL, conf);
>>> +}
>>> +
>>> +static void spi_ctrl_setmode(uint8_t mode, uint8_t cmd)
>>> +{
>>> +    uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
>>> +    ctrl &= ~(CTRL_USERMODE | 0xff << 16);
>>> +    ctrl |= mode | (cmd << 16);
>>> +    writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
>>> +}
>>> +
>>>    static void spi_ctrl_start_user(void)
>>>    {
>>>        uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
>>> @@ -152,6 +171,18 @@ static void read_page(uint32_t addr, uint32_t *page)
>>>        spi_ctrl_stop_user();
>>>    }
>>>    +static void read_page_mem(uint32_t addr, uint32_t *page)
>>> +{
>>> +    int i;
>>> +
>>> +    /* move out USER mode to use direct reads from the AHB bus */
>>> +    spi_ctrl_setmode(CTRL_READMODE, READ);
>>> +
>>> +    for (i = 0; i < PAGE_SIZE / 4; i++) {
>>> +        page[i] = make_be32(readl(ASPEED_FLASH_BASE + addr + i * 4));
>> Wouldn't be better to make i < PAGE_SIZE and get rid of multiplications?
> Hmm, we need the addresses to be 32bits aligned. Am I missing something ?
Yes, sorry I missed page[i] in the loop.
>
>> Please check other similar loops in the code.
>>> +    }
>>> +}
>>> +
>>>    static void test_erase_sector(void)
>>>    {
>>>        uint32_t some_page_addr = 0x600 * PAGE_SIZE;
>>> @@ -248,6 +279,75 @@ static void test_write_page(void)
>>>        flash_reset();
>>>    }
>>>    +static void test_read_page_mem(void)
>>> +{
>> This function repeats write_page tests.
> It is true that this test depends on the previous test
> 'test_write_page()'. The test checks the flash contents
> using the command mode.
>
> Resetting the flash contents to an initial state did not
> seem necessary but I should probably comment on the test
> case  dependencies though.
>
>> Maybe would be better to have one function, do read - epected 0xFF,
>> write then read - the same data and read other sector in one function?
> OK. I think I understand. So I should provide some toolbox
> with highlevel functions for each test to use in order to
> clarify what is being done.
>
> I will try that in a followup patch.
This is just suggestion, one function that do read/write is clearer than 
two that do
some part twice.
>
>>> +    uint32_t my_page_addr = 0x14000 * PAGE_SIZE; /* beyond 16MB */
>>> +    uint32_t some_page_addr = 0x15000 * PAGE_SIZE;
>>> +    uint32_t page[PAGE_SIZE / 4];
>>> +    int i;
>>> +
>>> +    /* Enable 4BYTE mode for controller. This is should be strapped by
>>> +     * HW for CE0 anyhow.
>>> +     */
>>> +    spi_ce_ctrl(1 << CRTL_EXTENDED0);
>>> +
>>> +    /* Enable 4BYTE mode for flash. */
>>> +    spi_conf(CONF_ENABLE_W0);
>>> +    spi_ctrl_start_user();
>>> +    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
>>> +    spi_ctrl_stop_user();
>>> +    spi_conf_remove(CONF_ENABLE_W0);
>>> +
>>> +    /* Check what was written */
>>> +    read_page_mem(my_page_addr, page);
>>> +    for (i = 0; i < PAGE_SIZE / 4; i++) {
>>> +        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
>>> +    }
>>> +
>>> +    /* Check some other page. It should be full of 0xff */
>>> +    read_page_mem(some_page_addr, page);
>>> +    for (i = 0; i < PAGE_SIZE / 4; i++) {
>>> +        g_assert_cmphex(page[i], ==, 0xffffffff);
>>> +    }
>>> +
>>> +    flash_reset();
>>> +}
>>> +
>>> +static void test_write_page_mem(void)
>>> +{
>>> +    uint32_t my_page_addr = 0x15000 * PAGE_SIZE;
>>> +    uint32_t page[PAGE_SIZE / 4];
>>> +    int i;
>>> +
>>> +    /* Enable 4BYTE mode for controller. This is should be strapped by
>>> +     * HW for CE0 anyhow.
>>> +     */
>>> +    spi_ce_ctrl(1 << CRTL_EXTENDED0);
>>> +
>>> +    /* Enable 4BYTE mode for flash. */
>>> +    spi_conf(CONF_ENABLE_W0);
>>> +    spi_ctrl_start_user();
>>> +    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
>>> +    writeb(ASPEED_FLASH_BASE, WREN);
>> This is a bit tricky, in real HW you need to set WREN
>> before issue PROGRAM command on most of the devices.
>> If there is no cache in emulated in SMC controller
>> (if any in HW), WREN should be issued before every write.
> ah yes. So to be more precise, WREN should be moved in the
> loop below.
Yes.

Thanks,
Marcin
> Thanks,
>
> C.
>
>> Thanks,
>> Marcin
>>> +    spi_ctrl_stop_user();
>>> +
>>> +    /* move out USER mode to use direct writes to the AHB bus */
>>> +    spi_ctrl_setmode(CTRL_WRITEMODE, PP);
>>> +
>>> +    for (i = 0; i < PAGE_SIZE / 4; i++) {
>>> +        writel(ASPEED_FLASH_BASE + my_page_addr + i * 4,
>>> +               make_be32(my_page_addr + i * 4));
>>> +    }
>>> +
>>> +    /* Check what was written */
>>> +    read_page_mem(my_page_addr, page);
>>> +    for (i = 0; i < PAGE_SIZE / 4; i++) {
>>> +        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
>>> +    }
>>> +
>>> +    flash_reset();
>>> +}
>>> +
>>>    static char tmp_path[] = "/tmp/qtest.m25p80.XXXXXX";
>>>      int main(int argc, char **argv)
>>> @@ -273,6 +373,8 @@ int main(int argc, char **argv)
>>>        qtest_add_func("/m25p80/erase_sector", test_erase_sector);
>>>        qtest_add_func("/m25p80/erase_all",  test_erase_all);
>>>        qtest_add_func("/m25p80/write_page", test_write_page);
>>> +    qtest_add_func("/m25p80/read_page_mem", test_read_page_mem);
>>> +    qtest_add_func("/m25p80/write_page_mem", test_write_page_mem);
>>>          ret = g_test_run();
>>>    
>
