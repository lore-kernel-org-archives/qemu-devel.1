Received: from eggs.gnu.org ([2001:4830:134:3::10]:57632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1esuOq-0000DK-L2
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1esuOl-0002DU-Nx
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:59:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1esuOl-0002DM-Eu
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:59:43 -0500
References: <20180228180215.25470-1-wei@redhat.com>
	<20180228180215.25470-2-wei@redhat.com>
	<ca21f795-dae7-d6b5-44f1-ef8ba792ac04@redhat.com>
	<20180305110122.GD3131@work-vm>
	<20180305133654.7aokepvzcmxhzk4q@kamzik.brq.redhat.com>
	<20180305135244.GJ3131@work-vm>
From: Wei Huang <wei@redhat.com>
Message-ID: <868c6039-35fb-16cb-67bb-39cee11e8118@redhat.com>
Date: Mon, 5 Mar 2018 11:59:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180305135244.GJ3131@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V7 1/4] rules: Move cross compilation auto
 detection functions to rules.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, quintela@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org



On 03/05/2018 07:52 AM, Dr. David Alan Gilbert wrote:
> * Andrew Jones (drjones@redhat.com) wrote:
>> On Mon, Mar 05, 2018 at 11:01:23AM +0000, Dr. David Alan Gilbert wrote:
>>> * Laurent Vivier (lvivier@redhat.com) wrote:
>>>> On 28/02/2018 19:02, Wei Huang wrote:
>>>>> This patch moves the auto detection functions for cross compilation from
>>>>> roms/Makefile to rules.mak. So the functions can be shared among Makefiles
>>>>> in QEMU.
>>>>>
>>>>> Signed-off-by: Wei Huang <wei@redhat.com>
>>>>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>>>> ---
>>>>>  roms/Makefile | 24 +++++++-----------------
>>>>>  rules.mak     | 15 +++++++++++++++
>>>>>  2 files changed, 22 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/roms/Makefile b/roms/Makefile
>>>>> index b5e5a69e91..e972c65333 100644
>>>>> --- a/roms/Makefile
>>>>> +++ b/roms/Makefile
>>>>> @@ -21,23 +21,6 @@ pxe-rom-virtio   efi-rom-virtio   : DID := 1000
>>>>>  pxe-rom-vmxnet3  efi-rom-vmxnet3  : VID := 15ad
>>>>>  pxe-rom-vmxnet3  efi-rom-vmxnet3  : DID := 07b0
>>>>>  
>>>>> -#
>>>>> -# cross compiler auto detection
>>>>> -#
>>>>> -path := $(subst :, ,$(PATH))
>>>>> -system := $(shell uname -s | tr "A-Z" "a-z")
>>>>> -
>>>>> -# first find cross binutils in path
>>>>> -find-cross-ld = $(firstword $(wildcard $(patsubst %,%/$(1)-*$(system)*-ld,$(path))))
>>>>> -# then check we have cross gcc too
>>>>> -find-cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call find-cross-ld,$(1)))))
>>>>> -# finally strip off path + toolname so we get the prefix
>>>>> -find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
>>>>> -
>>>>> -powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
>>>>> -powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
>>>>> -x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
>>>>> -
>>>>>  # tag our seabios builds
>>>>>  SEABIOS_EXTRAVERSION="-prebuilt.qemu-project.org"
>>>>>  
>>>>> @@ -66,6 +49,13 @@ default:
>>>>>  	@echo "  skiboot        -- update skiboot.lid"
>>>>>  	@echo "  u-boot.e500    -- update u-boot.e500"
>>>>>  
>>>>> +SRC_PATH=..
>>>>> +include $(SRC_PATH)/rules.mak
>>>>> +
>>>>> +powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
>>>>> +powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
>>>>> +x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
>>>>> +
>>>>>  bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
>>>>>  	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
>>>>>  	cp seabios/builds/seabios-256k/bios.bin ../pc-bios/bios-256k.bin
>>>>> diff --git a/rules.mak b/rules.mak
>>>>> index 6e943335f3..ef8adee3f8 100644
>>>>> --- a/rules.mak
>>>>> +++ b/rules.mak
>>>>> @@ -62,6 +62,21 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
>>>>>                    $(foreach o,$(filter %.mo,$1),$($o-objs)) \
>>>>>                    $(filter-out %.o %.mo,$1))
>>>>>  
>>>>> +# Cross compilation auto detection. Use find-cross-prefix to detect the
>>>>> +# target archtecture's prefix, and then append it to the build tool or pass
>>>>> +# it to CROSS_COMPILE directly. Here is one example:
>>>>> +#      x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
>>>>> +#      $(x86_64_cross_prefix)gcc -c test.c -o test.o
>>>>> +#      make -C testdir CROSS_COMPILE=$(x86_64_cross_prefix)
>>>>> +cross-search-path := $(subst :, ,$(PATH))
>>>>> +cross-host-system := $(shell uname -s | tr "A-Z" "a-z")
>>>>> +
>>>>> +find-cross-ld = $(firstword $(wildcard $(patsubst \
>>>>> +                    %,%/$(1)-*$(cross-host-system)*-ld,$(cross-search-path))))
>>>>> +find-cross-gcc = $(firstword $(wildcard \
>>>>> +                    $(patsubst %ld,%gcc,$(call find-cross-ld,$(1)))))
>>>>> +find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
>>>>> +
>>>>>  %.o: %.c
>>>>>  	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
>>>>>  	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
>>>>>
>>>>
>>>> With this patch, "make slof" fails:
>>>>
>>>>   git submodule init roms/SLOF
>>>>   git submodule update roms/SLOF
>>>>   cd roms
>>>>   make slof
>>>> ...
>>>> make[4]: Entering directory
>>>> '/home/lvivier/Projects/qemu-upstream/roms/SLOF/lib/libnvram'
>>>> 	[CC]	Makefile.dep
>>>> powerpc64-linux-gnu-ar: nvram.o: No such file or directory
>>>> make[4]: *** [Makefile:31: ../libnvram.a] Error 1
>>>>
>>>> Perhaps rules.mak defines values inherited by SLOF makefiles that are
>>>> incompatible?
>>>
>>> OK, can we go back a step here; and split this series; it's trying to do
>>> two entirely different things:
>>>
>>>    a) Add an aarch64 migration test
>>>    b) Refactor some of the build stuff
>>>
>>> I'd like to see (a) posted separately, doing things approximately the same way that
>>> the x86 ROM is doing it. 
>>
>> IMO, the makefile is the right approach.
> 
> It may be; however, for what benefit?  How many iterations have we gone
> through here for something that (in the x86 case) was shipped as a hex
> blob and never regenerated.  IMHO even the script is overkill, comments
> in the .s file would be enough given just how often this stuff gets
> changed.  Simplicity seems a better aim.
> 
>> I wouldn't like to see AArch64
>> added with a script and then converted, along with x86, to a makefile at
>> some later time (probably never).
>>
>> We can drop the build refactoring, at the expense of adding redundant
>> cross-compile support, but still introduce a makefile. Likely nobody will
>> ever get around to the refactoring needed to remove that redundancy, but
>> oh well...
>>
>> I think we try to fix the SLOF build issue first, though.
> 
> OK.

SLO build actually is OK if we don't move the cross-compile stuff to the
generic rules.mak.

So this cross-compile approach has lots of objection (unclean, broken
rom build etc.). A complete solution will make this patchset bloated,
which is diverted away from original purpose of migration-test.

Dave & Drew: will the following be acceptable?

1. Still use Makefile for .s->.h compilation
2. In Makefile, we don't support cross-compilation. This avoids
duplicating the cross-compile detection code at all. Whoever really
wants to re-generate .h file must be avid programmers. They can either
find a native machine or fix Makefile themselves.
3. The cross-compile re-factoring will become a separate patchset. In
that patchset, both ROM and migration-test Makefiles will be changed to
support cross compilation.

Thoughts?

> 
> Dave
> 
>> Thanks,
>> drew
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
