Received: from eggs.gnu.org ([209.51.188.92]:33867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDnPE-0007Z2-73
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDnPC-0004gM-8m
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDnPA-0004ev-CQ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:51:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C3B5330258
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 09:50:58 +0000 (UTC)
References: <20190318171521.8524-1-pbonzini@redhat.com>
	<20190318171521.8524-6-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2a7a057a-33c1-8022-8c43-662e1ddeb3cf@redhat.com>
Date: Tue, 9 Apr 2019 11:50:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190318171521.8524-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/13] pca9552-test: do not rely on state
 across tests
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
> receive_autoinc is relying on the LED state that is set by
> send_and_receive.  Stop doing that, because qgraph resets the
> machine between tests.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/pca9552-test.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/pca9552-test.c b/tests/pca9552-test.c
> index 06359b7435..89b4445e29 100644
> --- a/tests/pca9552-test.c
> +++ b/tests/pca9552-test.c
> @@ -18,11 +18,20 @@
>  
>  static I2CAdapter *i2c;
>  
> +static void pca9552_init(I2CAdapter *i2c)
> +{
> +    /* Switch on LEDs 0 and 12 */
> +    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0, 0x54);
> +    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3, 0x54);
> +}
> +
>  static void receive_autoinc(void)
>  {
>      uint8_t resp;
>      uint8_t reg = PCA9552_LS0 | PCA9552_AUTOINC;
>  
> +    pca9552_init(i2cdev);
> +
>      i2c_send(i2c, PCA9552_TEST_ADDR, &reg, 1);
>  
>      /* PCA9552_LS0 */
> @@ -52,16 +61,14 @@ static void send_and_receive(void)
>      value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
>      g_assert_cmphex(value, ==, 0x0);
>  
> -    /* Switch on LED 0 */
> -    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0, 0x54);
> +    pca9552_init(i2cdev);
> +
>      value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
>      g_assert_cmphex(value, ==, 0x54);
>  
>      value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
>      g_assert_cmphex(value, ==, 0x01);
>  
> -    /* Switch on LED 12 */
> -    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3, 0x54);
>      value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3);
>      g_assert_cmphex(value, ==, 0x54);

Reviewed-by: Thomas Huth <thuth@redhat.com>
