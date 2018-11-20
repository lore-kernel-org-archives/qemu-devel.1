Received: from eggs.gnu.org ([2001:4830:134:3::10]:36622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7zv-0006Pj-O2
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7zr-000825-Ob
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:31:31 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP7zq-0007sW-9T
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:31:27 -0500
Received: by mail-ot1-x342.google.com with SMTP id 81so2028190otj.2
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 07:31:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181115192446.17187-3-minyard@acm.org>
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-3-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 15:31:00 +0000
Message-ID: <CAFEAcA8uwxopJ0ujysD1PNeLBRZVuYECfwtkwZcvfEYN+eKZ-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 02/12] i2c: have I2C receive operation
 return uint8_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <cminyard@mvista.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 15 November 2018 at 19:24,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> It is never supposed to fail and cannot return an error, so just
> have it return the proper type.  Have it return 0xff on nothing
> available, since that's what would happen on a real bus.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

This is a nice cleanup. There are some followups at
callsites of i2c_recv():

hw/arm/stellaris.c:                s->mdr = i2c_recv(s->bus) & 0xff;
 -- mask not needed

hw/i2c/aspeed_i2c.c:    ret = i2c_recv(bus->bus);
hw/i2c/aspeed_i2c.c-    if (ret < 0) {
hw/i2c/aspeed_i2c.c-        qemu_log_mask(LOG_GUEST_ERROR, "%s: read
failed\n", __func__);
hw/i2c/aspeed_i2c.c-        ret = 0xff;
 -- error handling can be deleted

hw/i2c/exynos4210_i2c.c:    ret = i2c_recv(s->bus);
hw/i2c/exynos4210_i2c.c-    if (ret < 0 && (s->i2ccon & I2CCON_ACK_GEN)) {
hw/i2c/exynos4210_i2c.c-        s->i2cstat |= I2CSTAT_LAST_BIT;  /*
Data is not acknowledged */
 -- ditto

hw/i2c/imx_i2c.c:                ret = i2c_recv(s->bus);
hw/i2c/imx_i2c.c-
hw/i2c/imx_i2c.c-                if (ret >= 0) {
hw/i2c/imx_i2c.c-                    imx_i2c_raise_interrupt(s);
 -- condition now always-true

which should probably go in their own patch(es).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
