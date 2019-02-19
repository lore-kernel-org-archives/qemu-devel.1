Received: from eggs.gnu.org ([209.51.188.92]:49491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw6TB-0008LW-GR
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw6TA-0003nL-M2
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:34:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw6TA-0003fK-DO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:34:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so8864398wrg.9
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 06:33:49 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-2-armbru@redhat.com>
	<095c8b8c-d33a-e972-d38f-b22b39d5c4b0@redhat.com>
	<87o977uc8t.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <667aa10b-c0f0-2d2a-201d-d4e5a2db085b@redhat.com>
Date: Tue, 19 Feb 2019 15:33:46 +0100
MIME-Version: 1.0
In-Reply-To: <87o977uc8t.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/10] pflash: Rename pflash_t to
 PFlashCFI01, PFlashCFI02
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, lersek@redhat.com, mreitz@redhat.com, qemu-ppc@nongnu.org, alex.bennee@linaro.org

On 2/19/19 2:41 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 2/18/19 1:56 PM, Markus Armbruster wrote:
>>> flash.h's incomplete struct pflash_t is completed both in
>>> pflash_cfi01.c and in pflash_cfi02.c.  The complete types are
>>> incompatible.  This can hide type errors, such as passing a pflash_t
>>> created with pflash_cfi02_register() to pflash_cfi01_get_memory().
>>>
>>> Furthermore, POSIX reserves typedef names ending with _t.

Worth adding in CODING_STYLE 'Naming' section :)

>>>
>>> Rename the two structs to PFlashCFI01 and PFlashCFI02.
>>
>> Why not ParallelFlashCFIxx?
> 
> Feels a bit long, and we abbreviate to pflash pretty consistently.  That
> said, I'm not particularly enamored with my choice of name :)
> 
>> Ideally ParallelFlashCFI would be an InterfaceInfo...
> 
> You mean TYPE_CFI_PFLASH0{1,2} should be children of an abstract parent?

I'd use "TYPE_PFLASH_CFI0[12]".

---

The "Common Flash memory Interface" as stated is definitively an
interface :)

QEMU models the 2 most famous industry implementations:

- vendor 0x01: Intel (and Sharp)
- vendor 0x02: AMD (and Fujistu)

---

My first refactor attempt was to have both implementations inheritate
from an abstract parent, but since the migration structures are
different, it looked easier to me to extract an InterfaceInfo.

>From here my idea was to add an NorFlash abstract parent where to share
the block devices and some of the reset:

            +-------------------+
            |                   |
            |    NOR Flash      |
            |                   |
            +-------------------+
              |    Parent     |
              |               |
              |               |
 +------------v---+       +---v------------+
 |                |       |                |
 |    PFlash01    |       |    PFlash02    |
 |                |       |                |
 +----------------+       +----------------+
     Child      |           |
                |           |
                | Implements|
            +---v-----------v---+
            |                   |
            |     CFI Flash     |
            |                   |
            +-------------------+

But since there is no consumer of the CFI InterfaceInfo, we can simply
go the way you suggested:

            +-------------------+
            |                   |
            |   CFI NOR Flash   |
            |                   |
            +-------------------+
              |    Parent     |
              |               |
 +------------v---+       +---v------------+
 |                |       |                |
 |    PFlash01    |       |    PFlash02    |
 |                |       |                |
 +----------------+       +----------------+
        Child                   Child
