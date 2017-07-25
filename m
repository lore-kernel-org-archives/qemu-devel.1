Received: from eggs.gnu.org ([2001:4830:134:3::10]:49633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZsOQ-0003mm-AX
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZsON-0007sI-66
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:28:26 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZsON-0007s4-1x
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:28:23 -0400
Received: by mail-qk0-x242.google.com with SMTP id q66so11809808qki.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 22:28:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
	<86339fc5-002a-5f20-272b-b0c76006e63f@amsat.org>
	<CAFEAcA-z997nAPX256-H0Byr5USOupW9+gdqSAUZk-94vsv=xA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <38c3b7a5-c74a-dfa4-915d-315c79234602@amsat.org>
Date: Tue, 25 Jul 2017 02:28:18 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-z997nAPX256-H0Byr5USOupW9+gdqSAUZk-94vsv=xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/11] Make memory_region_init_ram() and
 friends handle migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 07/23/2017 04:58 PM, Peter Maydell wrote:
> On 22 July 2017 at 05:47, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> I'm seeing memleaks using the malta machine, they come from the
>> smbus_eeprom_init() in hw/i2c/smbus_eeprom.c which does:
>>
>>      uint8_t *eeprom_buf = g_malloc0(8 * 256); /* XXX: make this persistent
>> */
> 
> (This isn't actually a leak because the eeprom device
> can't be hotplugged/unplugged, so once created it will
> live for the life of the simulation.)
> 
>> Question for 2.11: is this device a candidate to use one of the function you
>> enumerated? My guess is memory_region_init_rom_device()
> 
> A quick look at that device suggests that it's doing some
> pretty weird stuff which probably should be being
> cleaned up to use a memory region to handle the backing
> store for the EEPROM (although there are other ways to do it;
> since there's only 2K of data there it could also be
> handled by a byte-array in the device migrated via
> VMState).
> 
> Do you know what the intention is of the code which
> passes the device an offset into the eeprom_buf buffer
> rather than just passing the start of the buffer ?
> 
>> Question for 2.10: does that mean than the malta machine is not migratable?
> 
> Depends whether the guest is actually writing to the EEPROM :-)
> The smbus_eeprom device doesn't have any support for migration
> at all -- it is neither migrating the data, nor the internal
> state (the offset). But if the guest doesn't ever write to
> the EEPROM and it doesn't happen to be relying on the offset
> having a particular value at the point of migration, you
> won't notice.
> 
> In particular, the pc_piix and pc_q35 machines both create
> one of these devices, so this is an issue for the pc
> machine migration too... (and any fix we make to
> smbus_eeprom needs to handle migration compat as a result)

Thank for your clear explanation, it seems quite some work to fix this 
device (due to the migration part I'm not common yet) so I'll just add 
this in my TODO list for 2.13 and will probably come back to you about 
that in a far future.

Regards,

Phil.
