Received: from eggs.gnu.org ([209.51.188.92]:35818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDnSh-0000CO-5E
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDnSg-0006t9-7L
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:54:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDnSf-0006ra-Qm
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:54:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEFC6307D98F
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 09:54:36 +0000 (UTC)
References: <20190318171521.8524-1-pbonzini@redhat.com>
	<20190318171521.8524-7-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f028cf6d-9be3-a248-e484-08216177b4cb@redhat.com>
Date: Tue, 9 Apr 2019 11:54:34 +0200
MIME-Version: 1.0
In-Reply-To: <20190318171521.8524-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/13] imx25-pdk: create ds1338 for qtest
 inside the test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 18/03/2019 18.15, Paolo Bonzini wrote:
> There is no need to have a test device created by the board.
> Instead, create it in the qtest so that we will be able to run
> it on other boards too.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/arm/imx25_pdk.c  | 9 ---------
>  tests/ds1338-test.c | 2 +-
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
> index 9f3ee14739..65e1768663 100644
> --- a/hw/arm/imx25_pdk.c
> +++ b/hw/arm/imx25_pdk.c
> @@ -132,15 +132,6 @@ static void imx25_pdk_init(MachineState *machine)
>       */
>      if (!qtest_enabled()) {
>          arm_load_kernel(&s->soc.cpu, &imx25_pdk_binfo);
> -    } else {
> -        /*
> -         * This I2C device doesn't exist on the real board.
> -         * We add it here (only on qtest usage) to be able to do a bit
> -         * of simple qtest. See "make check" for details.
> -         */
> -        i2c_create_slave((I2CBus *)qdev_get_child_bus(DEVICE(&s->soc.i2c[0]),
> -                                                      "i2c-bus.0"),
> -                         "ds1338", 0x68);
>      }
>  }
>  
> diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
> index 88f829f241..bd72a159cb 100644
> --- a/tests/ds1338-test.c
> +++ b/tests/ds1338-test.c
> @@ -54,7 +54,7 @@ int main(int argc, char **argv)
>  
>      g_test_init(&argc, &argv, NULL);
>  
> -    s = qtest_start("-display none -machine imx25-pdk");
> +    s = qtest_start("-display none -machine imx25-pdk -device ds1338,address=0x68");
>      i2c = imx_i2c_create(s, IMX25_I2C_0_BASE);
>      addr = DS1338_ADDR;

Reviewed-by: Thomas Huth <thuth@redhat.com>
