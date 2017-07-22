Received: from eggs.gnu.org ([2001:4830:134:3::10]:33405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYmKV-0007hi-1X
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYmKR-000063-WA
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:47:51 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYmKR-00005k-QU
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:47:47 -0400
Received: by mail-qt0-x243.google.com with SMTP id o3so4158217qto.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 21:47:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <86339fc5-002a-5f20-272b-b0c76006e63f@amsat.org>
Date: Sat, 22 Jul 2017 01:47:43 -0300
MIME-Version: 1.0
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Peter,

On 07/07/2017 11:42 AM, Peter Maydell wrote:
> This patchset changes the memory region functions
>   - memory_region_init_ram()
>   - memory_region_init_rom()
>   - memory_region_init_rom_device()
> to all automatically register the backing memory they allocate
> for migration using vmstate_register_ram(). Renamed functions
>   - memory_region_init_ram_nomigrate()
>   - memory_region_init_rom_nomigrate()
>   - memory_region_init_rom_device_nomigrate()
> are provided which only do the MR init, for the oddball
> cases which want to manage migration of the backing memory
> themselves (and to avoid behavioural changes for callers
> which weren't managing correctly migration themselves...)
[...]

I'm seeing memleaks using the malta machine, they come from the 
smbus_eeprom_init() in hw/i2c/smbus_eeprom.c which does:

     uint8_t *eeprom_buf = g_malloc0(8 * 256); /* XXX: make this 
persistent */

Question for 2.11: is this device a candidate to use one of the function 
you enumerated? My guess is memory_region_init_rom_device()

Question for 2.10: does that mean than the malta machine is not migratable?

Thanks!

Phil.
