Received: from eggs.gnu.org ([209.51.188.92]:53229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gwplc-000384-3P
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gwplb-0007NW-4b
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:56:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46951)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gwplZ-0007FE-67
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:56:03 -0500
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
	<CAFEAcA9_shDqjpqF-k9mvR1N6DY7HmXMPiOpkSFcnGpyC3W7tQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <12a1fc59-da10-174b-6544-3af075da8057@redhat.com>
Date: Thu, 21 Feb 2019 15:55:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9_shDqjpqF-k9mvR1N6DY7HmXMPiOpkSFcnGpyC3W7tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi,
On 2/21/19 3:26 PM, Peter Maydell wrote:
> On Thu, 21 Feb 2019 at 14:20, Auger Eric <eric.auger@redhat.com> wrote:
>> My qemu cmd line is:
>>
>> qemu-system-aarch64 -M virt,gic-version=3 -cpu host -smp 2 -m 4G
>> -display none --enable-kvm -serial tcp:localhost:4444,server -qmp
>> unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait -device
>> virtio-blk-pci,bus=pcie.0,scsi=off,drive=drv0,id=virtio-disk0,bootindex=1,werror=stop,rerror=stop
>> -drive
>> file=aarch64-vm0-rhel-alt-7.6.qcow2,format=qcow2,if=none,cache=writethrough,id=drv0
>> -device virtio-net-pci,bus=pcie.0,netdev=nic0,mac=6a:f5:10:b1:3d:d2
>> -netdev
>> tap,id=nic0,script=/home/augere/TEST/SCRIPTS/qemu-ifup,downscript=/home/augere/TEST/SCRIPTS/qemu-ifdown
>> -bios
>> /home/augere/UPSTREAM/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd
>> -net none -d guest_errors
> 
> Does the bug still occur if you get rid of all the network/disk related
> command line options here (hopefully it does, to reduce the size of
> the test case) ? Can you provide the QEMU_EFI.fd ?
I am using upstream EDK2 (https://github.com/tianocore/edk2) compiled in
debug mode

I can reproduce the bug with

qemu-system-aarch64 -M virt,gic-version=3 -cpu host -smp 4 -m 4G
-display none --enable-kvm -serial stdio \
-device
virtio-blk-pci,bus=pcie.0,scsi=off,drive=drv0,id=virtio-disk0,bootindex=1,werror=stop,rerror=stop
\
-drive
file=/home/augere/VM/IMAGES/aarch64-vm0-rhel-alt-7.6.qcow2,format=qcow2,if=none,cache=writethrough,id=drv0
\
-bios
/home/augere/UPSTREAM/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd
\
-net none -d guest_errors

also with virtio-blk-device

Thanks

Eric
> 
> thanks
> -- PMM
> 
