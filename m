Received: from eggs.gnu.org ([209.51.188.92]:56903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDtPG-0006eE-W6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDtPF-0007YO-Kr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:15:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDtPF-0007WX-BH
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:15:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so21708556wrp.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:15:29 -0700 (PDT)
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<6cf20899-f643-950b-37b9-dcc47df0d72e@redhat.com>
	<5C484463-F00B-4EC0-9272-DC23CEE8F376@oberlin.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0437475a-10ff-b8e0-3914-536a78f99b6e@redhat.com>
Date: Tue, 9 Apr 2019 18:15:26 +0200
MIME-Version: 1.0
In-Reply-To: <5C484463-F00B-4EC0-9272-DC23CEE8F376@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/10] block/pflash_cfi02: Implement
 missing AMD pflash functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 4/9/19 5:55 PM, Stephen Checkoway wrote:
> Hi Phil,
> 
>> On Apr 9, 2019, at 06:34, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Hi Stephen,
>>
>> [Cc'ing Markus and Laszlo, we have similar interest in pflash01 testing]
>>
>> On 4/8/19 10:55 PM, Stephen Checkoway wrote:
>>> The goal of this patch series implement the following AMD command-set parallel
>>> flash functionality:
>>> - flash interleaving;
>>> - nonuniform sector sizes;
>>> - erase suspend/resume commands; and
>>> - multi-sector erase.
>>
>> I am very glad you addressed these long overdue issues and very pleased
>> by your patches :)
>> I'll thoroughly review it during next week (this won't get merge for the
>> current 4.0 cycle anyway).
> 
> Great!
> 
>> I started a similar cleanup (mostly pflash01 focused) and converted
>> DPRINTF to trace events, added few constants. I'll see if I can rebase
>> your work on top of mine. So far only your patch 2 (refactor) would be
>> modified, simplified as the "pull out all of the code to modify the
>> status into simple helper functions" part (which else I'd ask you to
>> move in a separate patch).
>>
>> We should think of more intereleaved tests, I'll prepare a table of
>> current QEMU models using this device and how is their intereleave
>> mapping. Hopefully it would be enough to simply add the existing
>> machines to your current musicpal qtest.
>>
>> Also I'd like to see some Top/Bottom block configuration qtests, your
>> patch #5 doesn't seem tested.
> 
> I included four tests <https://patchew.org/QEMU/cover.1554774454.git.stephen.checkoway@oberlin.edu/bbe417c354dfa908d5e1bc8f8ad7121ec9451682.1554774454.git.stephen.checkoway@oberlin.edu/>.
> 
> Patchew makes it hard to link to particular lines. Here's the same patch on Github <https://github.com/qemu/qemu/commit/a851d21347121a91ba9a39c133a8fbee6e84e557#diff-d2ed797ca8898de80768bdfb390781dfR498>.
> 
> Are those sufficient or would you like more tests?

Ah you don't mention the tests in the patch description, that's why I
missed them :) Sometimes I prefer to keep the test addition in a
separate patch, it eases rebases, however in your series it seems fine.

Since you did changes in the CFI table, I think we should add a tests
verifying the table is correctly generated for all you FlashConfig entries.

>>> During refactoring and implementation, I discovered several bugs that are
>>> fixed here as well:
>>> - flash commands use only 11-bits of the address in most cases, but the
>>>  current code uses all of them [1];
>>> - entering CFI mode from autoselect mode and then exiting CFI mode should
>>>  return the chip to autoselect mode, but the current code returns to read
>>>  array mode; and
>>> - reset command should be ignored during sector/chip erase, but the current
>>>  code performs the reset.
>>>
>>> The first patch in the series adds a test for the existing behavior. Tests for
>>> additional behavior/bug fixes are added in the relevant patch.
>>>
>>> 1. I found firmware in the wild that relies on the 11-bit address behavior,
>>>   probably due to a bug in the firmware itself.
>>
>> Is it a musicpal firmware? Are you able to compare with real hardware?
> 
> No, it's not musicpal. I'm not even sure what musicpal is, it was just the most convenient choice for testing.  The real hardware is an embedded system using an old AMD processor (Am486) with three different AMD command set flash chips. The unlock addresses the firmware uses don't actually match the part sheets (in most cases). It took quite a while to realize that the flash hardware only uses 11 bits of address. (It's clearly spelled out in the various part sheets, but I guess I missed it on the first 15 or so readings.)

I suppose you can not share the firmware binary. Can you share these
unlock addresses? Maybe once I reviewed carefully your series I might
ask you the (pflash) trace event output.

>> I vaguely remember some issue regarding address bus width when trying to
>> implement the TopBlock small sectors, but I wasn't using the musicpal.
>> I'll see if I can find my old notes and test with your series.
> 
> The one boot chip I'm using is the AM29F080B-90SI with top boot blocks. It has an 8-bit address bus.
