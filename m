Received: from eggs.gnu.org ([2001:4830:134:3::10]:36440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1d46Pk-00009D-V8
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1d46Pk-0002zU-54
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:58:29 -0400
References: <1493314727-6951-1-git-send-email-wei@redhat.com>
	<CAFEAcA-KKvhspYza=8TNNuFtqzco=ChhtS6Aa5hnn8=Cb036-Q@mail.gmail.com>
	<4dbaaea9-7576-9acf-5327-b22db6f00ed2@redhat.com>
	<CAFEAcA8K9DENSPqJD2Okqjqyi7T8RhSBmhCa3ztooJK5xdcZVg@mail.gmail.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <8b782ee5-3545-3cb5-3b09-209fcffee7e4@redhat.com>
Date: Fri, 28 Apr 2017 08:58:20 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8K9DENSPqJD2Okqjqyi7T8RhSBmhCa3ztooJK5xdcZVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix compilation dependency issues of
 CONFIG_ARM_V7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>



On 04/28/2017 07:09 AM, Peter Maydell wrote:
> On 28 April 2017 at 01:10, Wei Huang <wei@redhat.com> wrote:
>> In our downstream code, we try to minimize the number of supported
>> devices to reduce the maintenance effort. ARM v7M is not in the
>> supported list.
>>
>> For most unsupported devices, we can remove them by configuring
>> default-configs file, except for CONFIG_ARM_V7M=y. This is because the
>> ARMv7m code in target/arm/helper.c intertwines with NVIC code. As a
>> result we have to keep NVIC and SysTick in order to compile helper.c,
>> which is not desirable.
>>
>> This patchset tries to address the problem by making NVIC and SysTick
>> removable.
> 
> I think that's the wrong way to do it. If you want to not compile
> in ARMv7M support then you need more ifdeffery in the target/arm
> code to disable the v7M code and CPUs entirely. NVIC and systick

We do disable most CPUs, which means only a limited number of CPUs
(host, cortex-a15, cortex-53/57) are left.

Using #ifdef is indeed a cleaner solution. However I can't use "#ifdef
CONFIG_ARM_V7M" & co inside target/arm/cpu.c file because CONFIG_xxx
aren't available as preprocessor directives. From what I saw the
CONFIG_xxx options can only control compiling source file. One solution
is to extract out all v7M code into separate files and use
CONFIG_ARM_V7M to direct compilation. A bit messy though. Any other
suggestions?

> are required core parts of v7M CPUs and so if they are not
> present then QEMU will claim to support the v7M cores but not
> in fact correctly do so.



> 
> thanks
> -- PMM
> 
