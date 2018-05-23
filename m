Received: from eggs.gnu.org ([2001:4830:134:3::10]:41833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fLURi-00078m-5E
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fLURd-0004co-CL
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:08:54 -0400
References: <20180522191743.12872-1-pbonzini@redhat.com>
	<336d4fa2-623c-1cb6-829d-71cf7039431e@redhat.com>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <f2d5a6ca-6342-0e59-0003-7a6ec3a7275d@gmail.com>
Date: Wed, 23 May 2018 07:08:05 -0700
MIME-Version: 1.0
In-Reply-To: <336d4fa2-623c-1cb6-829d-71cf7039431e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc: move at24c to its own
 CONFIG_ symbol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

On 05/22/2018 10:30 PM, Thomas Huth wrote:
> On 22.05.2018 21:17, Paolo Bonzini wrote:
>> AT24c EEPROM is currently gated by CONFIG_I2C, and as such it is
>> being included in all emulators that use I2C, even if they do not
>> really need it.  Separate it and, since it was added for the e500
>> machines, add it to qemu-system-ppc and qemu-system-ppc64.
>> ---
>>  default-configs/ppc-softmmu.mak | 1 +
>>  hw/nvram/Makefile.objs          | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
>> index 4d7be45ac5..c57e568121 100644
>> --- a/default-configs/ppc-softmmu.mak
>> +++ b/default-configs/ppc-softmmu.mak
>> @@ -26,6 +26,7 @@ CONFIG_USB_EHCI_SYSBUS=y
>>  CONFIG_SM501=y
>>  CONFIG_IDE_SII3112=y
>>  CONFIG_I2C=y
>> +CONFIG_AT24C=y
>>  
>>  # For Macs
>>  CONFIG_MAC=y
>> diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
>> index a912d25391..b318e53a43 100644
>> --- a/hw/nvram/Makefile.objs
>> +++ b/hw/nvram/Makefile.objs
>> @@ -1,6 +1,6 @@
>>  common-obj-$(CONFIG_DS1225Y) += ds1225y.o
>>  common-obj-y += eeprom93xx.o
>> -common-obj-$(CONFIG_I2C) += eeprom_at24c.o
>> +common-obj-$(CONFIG_AT24C) += eeprom_at24c.o
>>  common-obj-y += fw_cfg.o
>>  common-obj-y += chrp_nvram.o
>>  common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
> 
> Since this is a device that can only be added by the user (no board is
> using it automatically, as far as I can see),

The board which prompted me to add this device is still out there and
I'm still intent on pursuing getting it into QEMU.  It's clearly going
to be some time before this can happen as there are RTC and e500
patches that would need to get in first, and my time to spend on this
has been non-existent in recent months.

https://github.com/mdavidsaver/qemu/commits/vme

> it could be useful for
> other machines, too, I guess? Anyway, it's a good idea to have a
> separate config switch available for it, and we can add it to other
> machines again later if somebody feels that it is necessary, so (once
> you add your SoB):
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
