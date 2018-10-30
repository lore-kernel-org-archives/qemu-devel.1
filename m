Received: from eggs.gnu.org ([2001:4830:134:3::10]:58127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHHaq-0001w7-UY
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 20:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHHai-0002Ia-Lg
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 20:09:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHHag-0002Gn-Gh
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 20:09:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so10596212wrw.8
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 17:08:58 -0700 (PDT)
References: <20181028124004.30494-1-liq3ea@163.com>
	<20181028124004.30494-3-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3a1b60e0-fe90-4da7-210e-4519f220bb9f@redhat.com>
Date: Tue, 30 Oct 2018 01:08:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181028124004.30494-3-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: fw_cfg: add reboot_timeout test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com
Cc: qemu-devel@nongnu.org

On 28/10/18 13:40, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   tests/fw_cfg-test.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 1c5103fe1c..37765f15f8 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -99,6 +99,15 @@ static void test_fw_cfg_boot_menu(void)
>       g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), ==, boot_menu);
>   }
>   
> +static void test_fw_cfg_reboot_timeout(void)
> +{
> +    uint32_t reboot_timeout;
> +
> +    qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> +                     &reboot_timeout, sizeof(reboot_timeout));
> +    g_assert_cmpint(reboot_timeout, <=, 65535);
> +}
> +
>   int main(int argc, char **argv)
>   {
>       QTestState *s;
> @@ -106,7 +115,8 @@ int main(int argc, char **argv)
>   
>       g_test_init(&argc, &argv, NULL);
>   
> -    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
> +    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8"
> +                   " -boot reboot-timeout=4294967295");

I'd rather change this test to use qtest_add_data_func() ...:

         qtest_add_data_func("fw_cfg/reboot_timeout", "-boot 
reboot-timeout=4294967295 ", test_fw_cfg_reboot_timeout);

... to avoid adding this command line option to all the tests, because 
all tests are now failing:

$ make check-qtest-i386
[...]
ERROR:qemu/tests/fw_cfg-test.c:33:test_fw_cfg_signature: assertion 
failed (buf == "QEMU"): ("\377\377\377\377" == "QEMU")
ERROR:qemu/tests/fw_cfg-test.c:40:test_fw_cfg_id: assertion failed: ((id 
== 1) || (id == 3))
ERROR:qemu/tests/fw_cfg-test.c:52:test_fw_cfg_uuid: assertion failed: 
(memcmp(buf, uuid, sizeof(buf)) == 0)
ERROR:qemu/tests/fw_cfg-test.c:57:test_fw_cfg_ram_size: assertion failed 
(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE) == ram_size): (-1 == 134217728)
ERROR:qemu/tests/fw_cfg-test.c:62:test_fw_cfg_nographic: assertion 
failed (qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC) == 0): (65535 == 0)
ERROR:qemu/tests/fw_cfg-test.c:67:test_fw_cfg_nb_cpus: assertion failed 
(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS) == nb_cpus): (65535 == 1)
ERROR:qemu/tests/fw_cfg-test.c:72:test_fw_cfg_max_cpus: assertion failed 
(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS) == max_cpus): (65535 == 1)
ERROR:qemu/tests/fw_cfg-test.c:80:test_fw_cfg_numa: assertion failed 
(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA) == nb_nodes): (-1 == 0)
ERROR:qemu/tests/fw_cfg-test.c:99:test_fw_cfg_boot_menu: assertion 
failed (qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU) == boot_menu): (65535 
== 0)


(did you test your patch?)

>   
>       fw_cfg = pc_fw_cfg_init(s);
>   
> @@ -125,6 +135,7 @@ int main(int argc, char **argv)
>       qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
>       qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
>       qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
> +    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
>   
>       ret = g_test_run();
>   
> 
