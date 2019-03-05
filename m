Received: from eggs.gnu.org ([209.51.188.92]:35623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1DlL-0002EE-H3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1DlK-00016O-BK
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:55 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1DlK-00011h-3u
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:54 -0500
Received: by mail-wr1-f43.google.com with SMTP id w2so10350808wrt.11
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:21:53 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-7-armbru@redhat.com>
	<CAFEAcA_OLYno=YNS6bHOemwEp0gnc3fwRn8Rjvmo9v-i89xrMA@mail.gmail.com>
	<87d0nnsrx0.fsf@dusky.pond.sub.org>
	<c6d4c021-8d62-ada0-d152-b1d4f2b7aff2@redhat.com>
	<87ftsjptxk.fsf@dusky.pond.sub.org>
	<CANqRtoSOF8uvh-9-_CgsuhB_N18NhSiS=DPsY1+3+ff4NzgE+w@mail.gmail.com>
	<87mumbcd8k.fsf@dusky.pond.sub.org>
	<f2c8f20d-17ad-b72b-28fb-c835d6b97c10@redhat.com>
	<87k1he1wnz.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e8b000bc-d457-7c5a-b7d2-4e3ff63d0c73@redhat.com>
Date: Tue, 5 Mar 2019 18:21:50 +0100
MIME-Version: 1.0
In-Reply-To: <87k1he1wnz.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/10] r2d: Flash memory creation is
 confused about size, mark FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

On 3/4/19 4:33 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>> On 3/4/19 8:25 AM, Markus Armbruster wrote:
>>> Magnus Damm <magnus.damm@gmail.com> writes:
>>>> On Wed, Feb 20, 2019 at 2:31 AM Markus Armbruster <armbru@redhat.com> wrote:
>>>>> Perhaps Magnus, who maintains the machine, can pick a new value for us.
>>>>
>>>> According to the old board user document in Japanese (under NDA) what
>>>> is referred to as FROM (Area0) is connected via a 32-bit bus and CS0
>>>> to CN8. The docs mention s29pl127j60tfi130 but since I don't have the
>>>> board handy ATM I don't know how the chips are connected.
>>>>
>>>> Hope this helps,
>>>
>>> If you want me to change our emulated flash memory's size, please give
>>> me a number.
>>
>> datasheet "S29PL-J 002-00615 Rev. *E":
>> https://www.cypress.com/file/207091/download
>>
>> The S29PL127J60TFI130 is a 128Mbit NOR pflash addressable in words of 16bit.
>>
>> 128Mbit = 16 MiB
>>
>> At least it matches the "RTS7751R2D Handling Manual"!
>> https://elinux.org/RTS7751R2D_Handling_Manual#Kernel_start_from_FROM_extension_card_.28Kernel_space_XIP.29
>>
>> PL127J:
>> - 4 Banks
>>   -> we don't model banks.
>> - sectors of 4Kw and 32Kw
>>   -> we don't model different sector size and only use the
>>      biggest available
>>
>> sector_size = 32Kw = 64KiB // sector_len
>> (naive) sector_count = 256 // nb_blocs
>>
>> ManufID:  0001h
>> DeviceID: 227Eh 2220h 2200h
>>
>> I understand "connected via a 32-bit bus and CS0 to CN8" as the full
>> device wordsize is addressable, so this device
>>
>> So in pflash_cfi02_register() format:
>>
>> - name = "FROM (Area0)"
>> - size = 16 * MiB
>> - sector_len = 64 * KiB
>> - nb_blocs = 256
>> - nb_mappings = 1? /* Machine specific... */
>> - width = 2
>> - id0 = 0x0001
>> - id1 = 0x227e
>> - id2 = 0x2220
>> - id3 = 0x2200
>> - unlock_addr0 = 0x555,
>> - unlock_addr1 = 0x2aa
>> - be = 0 /* Arch specific... */
>>
>> Which hopefully is very similar to what we currently use :)
> 
> 'fraid not:

I was trying to be sarcastic :/

> 
>     $ qemu-system-sh4 -M r2d -display none -S -monitor stdio
>     QEMU 3.1.50 monitor - type 'help' for more information
>     (qemu) info qtree
>     [...]
>       dev: cfi.pflash02, id ""
>         drive = ""
>         num-blocks = 512 (0x200)        <--- instead of 256
>         sector-length = 16384 (0x4000)  <--- instead of 65536
>         width = 4 (0x4)                 <--- instead of 2
>         mappings = 1 (0x1)
>         big-endian = 0 (0x0)
>         id0 = 0 (0x0)                   <--- instead of 0x0001
>         id1 = 0 (0x0)                   <--- instead of 0x227e
>         id2 = 0 (0x0)                   <--- instead of 0x2220
>         id3 = 0 (0x0)                   <--- instead of 0x2200
>         unlock-addr0 = 1365 (0x555)
>         unlock-addr1 = 682 (0x2aa)
>         name = "r2d.flash"              <--- instead of "FROM (Area0)"
>         mmio 0000000000000000/0000000000800000
> 
> Not shown: size is num-blocks * sector-length = 512 * 16384 = 8MiB
> instead of 16MiB.
> 
> Which properties would you like me to change, and how?

The simpler change for correctness is to fix the FLASH_SIZE:

-#define FLASH_SIZE 0x02000000
+#define FLASH_SIZE (16 * MiB)

+   /*
+    * According to the old board user document in Japanese (under NDA) what
+    * is referred to as FROM (Area0) is connected via a 32-bit bus and CS0
+    * to CN8. The docs mention a Cypress S29PL127J60TFI130 chipsset.
+    * Per the 'S29PL-J 002-00615 Rev. *E' datasheet, it is a 128Mbit NOR
+    * parallel flash addressable in words of 16bit.
+    */
    pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE,
                          dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                         16 * KiB, FLASH_SIZE >> 16,
+                         16 * KiB, FLASH_SIZE >> 14 /* will get removed
later */,
                          1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
                          0x555, 0x2aa, 0);

                          1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
                          0x555, 0x2aa, 0);

Now fixing the sector size:

    pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE,
                          dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                         16 * KiB, FLASH_SIZE >> 16,
-                         1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
+                         64 * KiB, FLASH_SIZE >> 16 /* will get removed
later */,
+                         1, 4, 0x0001, 0x227e, 0x2220, 0x2200
                          0x555, 0x2aa, 0);

But I'd recommend changing/fixing the sector size during the next dev
cycle, so we have more time for testing.

Regards,

Phil.
