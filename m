Received: from eggs.gnu.org ([209.51.188.92]:49358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1glhH8-0007Kz-B6
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1glhH7-0000s7-Fj
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:38:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1glhH1-0000mR-R3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:38:29 -0500
References: <20190120071337.55595-1-liq3ea@163.com>
	<20190120071337.55595-3-liq3ea@163.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2e1e9b39-ed96-452a-de4b-9b7337702a89@redhat.com>
Date: Mon, 21 Jan 2019 22:38:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190120071337.55595-3-liq3ea@163.com>
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
To: Li Qiang <liq3ea@163.com>, philmd@redhat.com, kraxel@redhat.com, thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

On 01/20/19 08:13, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/fw_cfg-test.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 1c5103fe1c..c28e6c3fb5 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -99,6 +99,15 @@ static void test_fw_cfg_boot_menu(void)
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), ==, boot_menu);
>  }
>  
> +static void test_fw_cfg_reboot_timeout(void)
> +{
> +    uint32_t reboot_timeout;
> +
> +    qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> +                     &reboot_timeout, sizeof(reboot_timeout));
> +    g_assert_cmpint(reboot_timeout, ==, 15);
> +}
> +

You don't check the return status of qfw_cfg_get_file(), before reading
"reboot_timeout". If the qfw_cfg_get_file() fails (returning 0), then
the comparison will refer to an indeterminate value. Also, it's
theoretically possible for qfw_cfg_get_file() to overwrite only part of
the "reboot_timeout" object.

So I think we need the function to transfer exactly (sizeof
reboot_timeout) bytes.

BTW, this reminds me, qfw_cfg_get_file() seems to return the number of
bytes that would be necessary for transferring the entire file. That
looks like a good idea, but it should be documented. Please add some
docs on top of qfw_cfg_get_file().

>  int main(int argc, char **argv)
>  {
>      QTestState *s;
> @@ -106,7 +115,8 @@ int main(int argc, char **argv)
>  
>      g_test_init(&argc, &argv, NULL);
>  
> -    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
> +    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 "
> +                   "-boot reboot-timeout=15");
>  
>      fw_cfg = pc_fw_cfg_init(s);
>  
> @@ -125,6 +135,7 @@ int main(int argc, char **argv)
>      qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
>      qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
>      qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
> +    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
>  
>      ret = g_test_run();
>  
> 

Looks OK otherwise.

Thanks
Laszlo
