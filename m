Received: from eggs.gnu.org ([2001:4830:134:3::10]:44388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecbnb-0007g8-Q8
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecbnW-0002L0-SK
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:53:59 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:42071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecbnW-0002Kl-MO
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:53:54 -0500
Received: by mail-qt0-x244.google.com with SMTP id c2so6228430qtn.9
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:53:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-4-f4bug@amsat.org>
	<20180119181827.GM15832@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b76e275a-ef7e-f73e-0c8a-e165c707703a@amsat.org>
Date: Fri, 19 Jan 2018 15:53:49 -0300
MIME-Version: 1.0
In-Reply-To: <20180119181827.GM15832@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/11] hw/i2c: convert I2CSlaveClass::init
 -> realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 01/19/2018 03:18 PM, Eduardo Habkost wrote:
> On Tue, Jan 16, 2018 at 10:15:47AM -0300, Philippe Mathieu-Daudé wrote:
> [...]
>> -static int i2c_slave_qdev_init(DeviceState *dev)
>> +static void i2c_slave_realize(DeviceState *dev, Error **errp)
>>  {
>>      I2CSlave *s = I2C_SLAVE(dev);
>>      I2CSlaveClass *sc = I2C_SLAVE_GET_CLASS(s);
>>  
>> -    if (sc->init) {
>> -        return sc->init(s);
>> +    if (sc->realize) {
>> +        return sc->realize(s, errp);
>>      }
> 
> Do you think i2c_slave_realize() will perform additional actions
> in the future?  If not, why not let subclasses set
> DeviceClass::realize directly?

Good idea, also with SMBusDeviceClass::realize.

>> -
>> -    return 0;
>>  }
>>  
>>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
>> @@ -301,7 +299,7 @@ DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
>>  static void i2c_slave_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *k = DEVICE_CLASS(klass);
>> -    k->init = i2c_slave_qdev_init;
>> +    k->realize = i2c_slave_realize;
>>      set_bit(DEVICE_CATEGORY_MISC, k->categories);
>>      k->bus_type = TYPE_I2C_BUS;
>>      k->props = i2c_props;
> [...]
> 
