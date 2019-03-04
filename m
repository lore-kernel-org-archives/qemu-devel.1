Received: from eggs.gnu.org ([209.51.188.92]:41868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0m02-0001Lp-Pd
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0m01-0004IV-Nz
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:43:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0m01-0004HF-Gv
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:43:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id q187so4302370wme.5
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 03:43:13 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-7-armbru@redhat.com>
	<CAFEAcA_OLYno=YNS6bHOemwEp0gnc3fwRn8Rjvmo9v-i89xrMA@mail.gmail.com>
	<87d0nnsrx0.fsf@dusky.pond.sub.org>
	<c6d4c021-8d62-ada0-d152-b1d4f2b7aff2@redhat.com>
	<87ftsjptxk.fsf@dusky.pond.sub.org>
	<CANqRtoSOF8uvh-9-_CgsuhB_N18NhSiS=DPsY1+3+ff4NzgE+w@mail.gmail.com>
	<87mumbcd8k.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2c8f20d-17ad-b72b-28fb-c835d6b97c10@redhat.com>
Date: Mon, 4 Mar 2019 12:43:10 +0100
MIME-Version: 1.0
In-Reply-To: <87mumbcd8k.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Qemu-block <qemu-block@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 3/4/19 8:25 AM, Markus Armbruster wrote:
> Magnus Damm <magnus.damm@gmail.com> writes:
>> On Wed, Feb 20, 2019 at 2:31 AM Markus Armbruster <armbru@redhat.com> wrote:
>>> Perhaps Magnus, who maintains the machine, can pick a new value for us.
>>
>> According to the old board user document in Japanese (under NDA) what
>> is referred to as FROM (Area0) is connected via a 32-bit bus and CS0
>> to CN8. The docs mention s29pl127j60tfi130 but since I don't have the
>> board handy ATM I don't know how the chips are connected.
>>
>> Hope this helps,
> 
> If you want me to change our emulated flash memory's size, please give
> me a number.

datasheet "S29PL-J 002-00615 Rev. *E":
https://www.cypress.com/file/207091/download

The S29PL127J60TFI130 is a 128Mbit NOR pflash addressable in words of 16bit.

128Mbit = 16 MiB

At least it matches the "RTS7751R2D Handling Manual"!
https://elinux.org/RTS7751R2D_Handling_Manual#Kernel_start_from_FROM_extension_card_.28Kernel_space_XIP.29

PL127J:
- 4 Banks
  -> we don't model banks.
- sectors of 4Kw and 32Kw
  -> we don't model different sector size and only use the
     biggest available

sector_size = 32Kw = 64KiB // sector_len
(naive) sector_count = 256 // nb_blocs

ManufID:  0001h
DeviceID: 227Eh 2220h 2200h

I understand "connected via a 32-bit bus and CS0 to CN8" as the full
device wordsize is addressable, so this device

So in pflash_cfi02_register() format:

- name = "FROM (Area0)"
- size = 16 * MiB
- sector_len = 64 * KiB
- nb_blocs = 256
- nb_mappings = 1? /* Machine specific... */
- width = 2
- id0 = 0x0001
- id1 = 0x227e
- id2 = 0x2220
- id3 = 0x2200
- unlock_addr0 = 0x555,
- unlock_addr1 = 0x2aa
- be = 0 /* Arch specific... */

Which hopefully is very similar to what we currently use :)

Regards,

Phil.
