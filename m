Received: from eggs.gnu.org ([2001:4830:134:3::10]:53001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fIZm3-000898-Bw
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fIZlu-0004fV-UP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:13:51 -0400
References: <20180513090613.27960-1-sw@weilnetz.de>
	<cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
	<CAFEAcA9kcKb28uQJOnqCAC4Gf9b7Hnu0wJbG1nHQLF4U1T9sKA@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <99693ba4-c282-a10b-e811-697617f7ee06@weilnetz.de>
Date: Tue, 15 May 2018 15:13:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9kcKb28uQJOnqCAC4Gf9b7Hnu0wJbG1nHQLF4U1T9sKA@mail.gmail.com>
Content-Language: en-GB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] disas/libvixl: Fix VIXL_FALLTHROUGH macro
 for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developer <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Am 15.05.2018 um 14:13 schrieb Peter Maydell:
> On 13 May 2018 at 10:57, Stefan Weil <sw@weilnetz.de> wrote:
>> Even with the above patch, disas/libvixl raises a compiler warning for a
>> fall through case. The patch below fixes that warning, but I am not sure
>> whether a fall through is correct there.
>>
>> Stefan
>>
>>
>> diff --git a/disas/libvixl/vixl/a64/disasm-a64.cc
>> b/disas/libvixl/vixl/a64/disasm-a64.cc
>> index 7a58a5c087..5481d94209 100644
>> --- a/disas/libvixl/vixl/a64/disasm-a64.cc
>> +++ b/disas/libvixl/vixl/a64/disasm-a64.cc
>> @@ -2986,6 +2986,7 @@ int Disassembler::SubstituteImmediateField(const
>> Instruction* instr,
>>            return 3;
>>          }
>>        }
>> +      VIXL_FALLTHROUGH(); // ???
>>      }
>>      case 'C': {  // ICondB - Immediate Conditional Branch.
>>        int64_t offset = instr->ImmCondBranch() << 2;
> This is fixed in upstream vixl, in fact:
>
> https://git.linaro.org/arm/vixl.git/commit/?id=de326f850f736c3a337fda52845ed3d2e620cc02
>
> thanks
> -- PMM


That fix will work for the moment, but is not sufficient for the future
because it only supports gcc 7.x, but not gcc 8.x or later:

+#elif __GNUC__ == 7

How do we proceed with the code in QEMU? Do you have a plan to update
the vixl code? As vixl is obviously no longer maintained on GitHub, I am
not sure whom I could contact.

And what about my other question / suggestion:

"I suggest to add and use a similar macro QEMU_FALLTHROUGH() for the
rest of the code and can provide a patch if that's fine for everyone."

gcc gives lots of fallthrough warnings, and many code locations don't contain a comment stating that the fall through is fine.

Thanks
Stefan
