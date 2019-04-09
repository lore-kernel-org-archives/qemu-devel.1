Received: from eggs.gnu.org ([209.51.188.92]:60170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDnHO-0004W3-LS
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDnHN-0000zy-Cd
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:42:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDnHN-0000zZ-2S
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:42:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E62B610C6F
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 09:42:55 +0000 (UTC)
References: <20190318171521.8524-1-pbonzini@redhat.com>
	<20190318171521.8524-4-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6792361a-9a55-c97e-51e4-888ec87aeb7b@redhat.com>
Date: Tue, 9 Apr 2019 11:42:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190318171521.8524-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/13] libqos: move common i2c code to
 libqos
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
> The functions to read/write 8-bit or 16-bit registers are the same
> in tmp105 and pca9552 tests, and in fact they are a special case of
> "read block"/"write block" functionality; read block in turn is used
> in ds1338-test.
>=20
> Move everything inside libqos-test, removing the duplication.  Account
> for the small differences by adding to tmp105-test.c the "read register
> after writing" behavior that is specific to it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/ds1338-test.c  |  8 +----
>  tests/libqos/i2c.c   | 47 ++++++++++++++++++++++++++
>  tests/libqos/i2c.h   | 11 ++++++
>  tests/pca9552-test.c | 37 +++++---------------
>  tests/tmp105-test.c  | 80 ++++++++++++--------------------------------
>  5 files changed, 88 insertions(+), 95 deletions(-)
>=20
> diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
> index 742dad9113..88f829f241 100644
> --- a/tests/ds1338-test.c
> +++ b/tests/ds1338-test.c
> @@ -35,17 +35,11 @@ static inline uint8_t bcd2bin(uint8_t x)
> =20
>  static void send_and_receive(void)
>  {
> -    uint8_t cmd[1];
>      uint8_t resp[7];
>      time_t now =3D time(NULL);
>      struct tm *tm_ptr =3D gmtime(&now);
> =20
> -    /* reset the index in the RTC memory */
> -    cmd[0] =3D 0;
> -    i2c_send(i2c, addr, cmd, 1);
> -
> -    /* retrieve the date */
> -    i2c_recv(i2c, addr, resp, 7);
> +    i2c_read_block(i2c, addr, 0, resp, sizeof(resp));
> =20
>      /* check retrieved time againt local time */
>      g_assert_cmpuint(bcd2bin(resp[4]), =3D=3D , tm_ptr->tm_mday);
> diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
> index 23bc2a3eb2..daf9a96617 100644
> --- a/tests/libqos/i2c.c
> +++ b/tests/libqos/i2c.c
> @@ -21,3 +21,50 @@ void i2c_recv(I2CAdapter *i2c, uint8_t addr,
>  {
>      i2c->recv(i2c, addr, buf, len);
>  }
> +
> +void i2c_read_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> +                       uint8_t *buf, uint16_t len)
> +{
> +    i2c_send(i2c, addr, &reg, 1);
> +    i2c_recv(i2c, addr, buf, len);
> +}
> +
> +void i2c_write_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> +                     const uint8_t *buf, uint16_t len)
> +{
> +    uint8_t *cmd =3D g_malloc(len + 1);
> +    cmd[0] =3D reg;
> +    memcpy(&cmd[1], buf, len);
> +    i2c_send(i2c, addr, cmd, len + 1);
> +    g_free(cmd);
> +}

So the i2c_write_block function only uses i2c_send() ...

> +uint8_t i2c_get8(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
> +{
> +    uint8_t resp[1];
> +    i2c_read_block(i2c, addr, reg, resp, sizeof(resp));
> +    return resp[0];
> +}
> +
> +uint16_t i2c_get16(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
> +{
> +    uint8_t resp[2];
> +    i2c_read_block(i2c, addr, reg, resp, sizeof(resp));
> +    return (resp[0] << 8) | resp[1];
> +}
> +
> +void i2c_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> +              uint8_t value)
> +{
> +    i2c_write_block(i2c, addr, reg, &value, 1);
> +}
> +
> +void i2c_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> +               uint16_t value)
> +{
> +    uint8_t data[2];
> +
> +    data[0] =3D value >> 8;
> +    data[1] =3D value & 255;
> +    i2c_write_block(i2c, addr, reg, data, sizeof(data));
> +}

... i.e. the i2c_set8/16() functions also only use i2c_send()...

> -static void tmp105_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> -                        uint8_t value)
> -{
> -    uint8_t cmd[2];
> -    uint8_t resp[1];
> -
> -    cmd[0] =3D reg;
> -    cmd[1] =3D value;
> -    i2c_send(i2c, addr, cmd, 2);
> -    i2c_recv(i2c, addr, resp, 1);
> -    g_assert_cmphex(resp[0], =3D=3D, cmd[1]);
> -}
> -
> -static void tmp105_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> -                         uint16_t value)
> -{
> -    uint8_t cmd[3];
> -    uint8_t resp[2];
> -
> -    cmd[0] =3D reg;
> -    cmd[1] =3D value >> 8;
> -    cmd[2] =3D value & 255;
> -    i2c_send(i2c, addr, cmd, 3);
> -    i2c_recv(i2c, addr, resp, 2);
> -    g_assert_cmphex(resp[0], =3D=3D, cmd[1]);
> -    g_assert_cmphex(resp[1], =3D=3D, cmd[2]);
> -}

... but the old set8/16 functions also used i2c_recv() and
g_assert_cmphex() ... shouldn't this be added to the new functions, too?

 Thomas
