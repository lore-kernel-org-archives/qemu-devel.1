Received: from eggs.gnu.org ([208.118.235.92]:55383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gefy3-0005sk-4L
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 07:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gefxz-0006Pp-6G
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 07:49:51 -0500
Date: Wed, 2 Jan 2019 13:49:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190102041133.GM27457@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.9999.1901021336130.78010@zero.eik.bme.hu>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<2403f70ea0cda1ba4e6345eb89a5aa5f3fe6e264.1546394798.git.balaton@eik.bme.hu>
	<20190102041133.GM27457@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 2/8] sam460ex: Clean up SPD EEPROM creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Wed, 2 Jan 2019, David Gibson wrote:
> On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
>> +    /* IIC controllers and devices */
>>      dev = sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700, uic[0][2]);
>> -    i2c[0] = PPC4xx_I2C(dev);
>> -    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
>> -    smbus_eeprom_init(i2c[0]->bus, 8, smbus_eeprom_buf, smbus_eeprom_size);
>> -    g_free(smbus_eeprom_buf);
>> -    i2c_create_slave(i2c[0]->bus, "m41t80", 0x68);
>> +    i2c = PPC4xx_I2C(dev)->bus;
>> +    /* SPD EEPROM on RAM module */
>> +    spd_data = spd_data_generate(DDR2, ram_sizes[0]);
>> +    if (spd_data) {
>> +        spd_data[20] = 4; /* SO-DIMM module */
>> +        smbus_eeprom_init_one(i2c, 0x50, spd_data);
>
> Any specific reason this case is handled outside spd_data_generate()?

As explained in previous reply I tried to keep number of options to the 
function to minimum and not handle every board specific case in that 
function. This board has SO-DIMM instead of regular DIMM socket but most 
of the SPD data is the same so it's easy enough to patch it here to match 
what real hardware may have. Otherwise spd_data_generate should have a lot 
of options for all different possibilites different boards might have.

(Also this is an example that unexpected configs might still work:

$ qemu-system-ppc -M sam460ex -m 64 -serial stdio
qemu-system-ppc: warning: Memory size is too small for SDRAM type, adjusting type
[...]
DRAM:  64 MiB (ECC not enabled, 460 MHz, CL0)

This SoC has a DRAM controller which accepts both DDR and DDR2 and the 
firmware does not care either so it works even if this cannot happen on 
real hardware. The spd_data[20] is different for DDR2 and DDR/SDR but in 
the latter it's ~WE latency which does not matter either so it can be set 
unconditionally. If this was not working the board code could check 
spd_data[2] != DDR2 and then abort itself.)

Regards,
BALATON Zoltan
