Received: from eggs.gnu.org ([2001:4830:134:3::10]:40262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLrkp-0000rU-5U
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLrko-0006Sd-99
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:02:11 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLrko-0006SI-1a
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:02:10 -0400
Received: by mail-oi0-x241.google.com with SMTP id l1-v6so1739167oii.1
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 08:02:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <99505ab5-d5fe-11ba-7f85-ea24c6f39ae2@redhat.com>
References: <1527070950-208350-1-git-send-email-imammedo@redhat.com>
	<99505ab5-d5fe-11ba-7f85-ea24c6f39ae2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 16:01:48 +0100
Message-ID: <CAFEAcA-Gmzd1SaG1SferBy8tJcBHXOAHztuJPbjR6O317o3zuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] arm: fix qemu crash on startup with -bios
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>

On 23 May 2018 at 13:09, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Igor,
>
> On 05/23/2018 12:22 PM, Igor Mammedov wrote:
>> When QEMU is started with following CLI
>>  -machine virt,gic-version=3,accel=kvm -cpu host -bios AAVMF_CODE.fd
>> it crashes with abort at
>>  accel/kvm/kvm-all.c:2164:
>>  KVM_SET_DEVICE_ATTR failed: Group 6 attr 0x000000000000c665: Invalid argument
>>
>> Which is caused by implicit dependecy of kvm_arm_gicv3_reset() on
> dependency
>> arm_gicv3_icc_reset() where the later is called by CPU reset
>> reset callback.
>>
>> However commit:
>>  3b77f6c arm/boot: split load_dtb() from arm_load_kernel()
>> broke CPU reset callback registration in case
>>
>>   arm_load_kernel()
>>       ...
>>       if (!info->kernel_filename || info->firmware_loaded)
>>
>> branch is taken, i.e. it's sufficient to provide a firmware
>> or do not provide kernel on CLI to skip cpu reset callback
>> registration, where before offending commit the callback
>> has been registered unconditionally.
>>
>> Fix it by registering the callback right at the begging of
> beginning
>> arm_load_kernel() unconditionally instead of doing it at the end.
>>
>> NOTE:
>>  we probably should eleminate that dependency anyways as well as
> eliminate, anyway?
>>  separate arch CPU reset parts from arm_load_kernel() into CPU
>>  itself, but that refactoring that I probably would have to do
>>  anyways later for CPU hotplug to work.
> may deserve some rewording.
>>
>> Reported-by: Auger Eric <eric.auger@redhat.com>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>
> Thank you for the quick fix. It fixes the reported issue.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks; applied to target-arm.next with the commit message
typos fixed.

-- PMM
