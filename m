Received: from eggs.gnu.org ([209.51.188.92]:57329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHE9o-0004m5-Az
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHE9n-0003i6-Bd
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:01:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hHE9n-0003hZ-5K
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:01:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so4558204wra.12
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:01:19 -0700 (PDT)
References: <20190319023030.947-1-liq3ea@163.com>
	<20190319023030.947-3-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <979370c0-99ec-aff1-7cf5-350caa6ac773@redhat.com>
Date: Thu, 18 Apr 2019 23:01:16 +0200
MIME-Version: 1.0
In-Reply-To: <20190319023030.947-3-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
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
To: Li Qiang <liq3ea@163.com>, thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, lersek@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

Hi Li,

On 3/19/19 3:30 AM, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/fw_cfg-test.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 1c5103fe1c..551b51e38f 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -99,6 +99,17 @@ static void test_fw_cfg_boot_menu(void)
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), ==, boot_menu);
>  }
>  
> +static void test_fw_cfg_reboot_timeout(void)
> +{
> +    uint32_t reboot_timeout = 0;
> +    size_t filesize;
> +
> +    filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> +                     &reboot_timeout, sizeof(reboot_timeout));
> +    g_assert_cmpint(filesize, ==, sizeof(reboot_timeout));
> +    g_assert_cmpint(reboot_timeout, ==, 15);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      QTestState *s;
> @@ -106,7 +117,8 @@ int main(int argc, char **argv)
>  
>      g_test_init(&argc, &argv, NULL);
>  
> -    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
> +    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 "
> +                   "-boot reboot-timeout=15");

This modify all tests. I'd rather add a specific test with this option.
Doing so, we can easily modify the timeout and add the <0 and >0xffff cases.

Can you think of a 'splash-time' test (for commit 6912bb0b3d3b1)?

Regards,

Phil.

>  
>      fw_cfg = pc_fw_cfg_init(s);
>  
> @@ -125,6 +137,7 @@ int main(int argc, char **argv)
>      qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
>      qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
>      qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
> +    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
>  
>      ret = g_test_run();
>  
> 
