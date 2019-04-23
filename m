Received: from eggs.gnu.org ([209.51.188.92]:48443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hIyIW-0004PB-Ur
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hIyIV-0007Cd-Qe
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:29:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hIyIU-0007A5-W3
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:29:31 -0400
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
Date: Tue, 23 Apr 2019 18:29:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190420100056.116305-4-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, lvivier@redhat.com, pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

On 20/04/2019 12.00, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/fw_cfg-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index c22503619f..9f75dbb5f4 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -174,6 +174,24 @@ static void test_fw_cfg_boot_menu(void)
>      qtest_quit(s);
>  }
>  
> +static void test_fw_cfg_reboot_timeout(void)
> +{
> +    QFWCFG *fw_cfg;
> +    QTestState *s;
> +    uint32_t reboot_timeout = 0;
> +    size_t filesize;
> +
> +    s = qtest_init("-boot reboot-timeout=15");
> +    fw_cfg = pc_fw_cfg_init(s);
> +
> +    filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> +                     &reboot_timeout, sizeof(reboot_timeout));
> +    g_assert_cmpint(filesize, ==, sizeof(reboot_timeout));
> +    g_assert_cmpint(reboot_timeout, ==, 15);

Is this endianess-safe? Or do you need to byteswap reboot_timeout if the
host and guest endianess does not match?

 Thomas
