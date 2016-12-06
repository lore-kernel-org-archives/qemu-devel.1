Received: from eggs.gnu.org ([2001:4830:134:3::10]:36275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1cEDhC-0001nY-3h
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1cEDhB-0006OK-0F
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:14:02 -0500
References: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
	<20161206094841.2wi34yfapalf6fth@kamzik.brq.redhat.com>
From: Andre Przywara <andre.przywara@arm.com>
Message-ID: <e7850784-09d3-c4eb-17c6-02765fecddf2@arm.com>
Date: Tue, 6 Dec 2016 11:14:41 +0000
MIME-Version: 1.0
In-Reply-To: <20161206094841.2wi34yfapalf6fth@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [kvm-unit-tests RFC 00/15] arm/arm64: add ITS
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, marc.zyngier@arm.com, christoffer.dall@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org

Hi,

On 06/12/16 09:48, Andrew Jones wrote:
> On Mon, Dec 05, 2016 at 10:46:31PM +0100, Eric Auger wrote:
>> This series proposes a framework to test the virtual ITS.
>> This is based on Drew's v7 series [1]. The last patch tests
>> several ITS commands (collection/device mapping, interrupt
>> translation service entry creation and LPI trigger through INT
>> command). At this point we don't use any external PCIe device
>> to write into the GITS_TRANSLATER register.
>>
>> The bulk of the code derives from the ITS driver code so all
>> the credit is due to Marc.
>>
>> Many other ITS commands could be tested. Also existing MMIO
>> accesses could be enhanced into standalone tests. Current focus
>> was to make it functional.
>>
>> The code deserves more cleanup with respect to cacheability
>> attributes in general.
>>
>> Tested on Cavium ThunderX [2].
>>
>> Best Regards
>>
>> Eric
>>
>> [1] [kvm-unit-tests PATCH v7 00/11] arm/arm64: add gic framework
>>
>> [2] sample command line:
>>
>> $QEMU -machine virt,accel=kvm -cpu host \
>>  -device virtio-serial-device \
>>  -device virtconsole,chardev=ctd -chardev testdev,id=ctd \
>>  -display none -serial stdio \
>>  -kernel arm/gic.flat \
>>  -smp 8 -machine gic-version=3 -append 'its'
>>
>> Eric Auger (15):
>>   libcflat: Add other size defines
>>   arm/arm64: gicv3: Add some re-distributor defines
>>   arm/arm64: ITS skeleton
>>   arm/arm64: ITS: BASER parsing and setup
>>   arm/arm64: GICv3: add cpu count
>>   arm/arm64: ITS: Set the LPI config and pending tables
>>   arm/arm64: ITS: Init the command queue
>>   arm/arm64: ITS: enable LPIs at re-distributor level
>>   arm/arm64: ITS: Parse the typer register
>>   arm/arm64: ITS: its_enable_defaults
>>   arm/arm64: ITS: create device
>>   arm/arm64: ITS: create collection
>>   arm/arm64: ITS: commands
>>   arm/arm64: gic: Generalize ipi_enable()
>>   arm/arm64: ITS test
>>
>>  arm/Makefile.common        |   1 +
>>  arm/gic.c                  | 101 +++++++++++-
>>  lib/arm/asm/gic-v3-its.h   | 238 +++++++++++++++++++++++++++
>>  lib/arm/asm/gic-v3.h       |  84 ++++++++++
>>  lib/arm/asm/gic.h          |   1 +
>>  lib/arm/gic-v3-its-cmd.c   | 399 +++++++++++++++++++++++++++++++++++++++++++++
>>  lib/arm/gic-v3-its.c       | 305 ++++++++++++++++++++++++++++++++++
>>  lib/arm/gic-v3.c           |   2 +
>>  lib/arm/gic.c              |  30 +++-
>>  lib/arm64/asm/gic-v3-its.h |   1 +
>>  lib/libcflat.h             |   3 +
>>  11 files changed, 1154 insertions(+), 11 deletions(-)
>>  create mode 100644 lib/arm/asm/gic-v3-its.h
>>  create mode 100644 lib/arm/gic-v3-its-cmd.c
>>  create mode 100644 lib/arm/gic-v3-its.c
>>  create mode 100644 lib/arm64/asm/gic-v3-its.h
>>
>> -- 
>> 2.5.5
>>
>>
> 
> Thanks for this Eric! I'm glad to see we're getting more GIC test
> coverage written, even before v8 of the gic series is posted :-)
> v8 will be rebased on some sysreg stuff Wei is doing for the PMU
> series,

Are you planning on a v8 post any time soon?

> that's why it's held up. I'll need to set plenty of time
> aside to learn enough in order to review all the 'ITS:' patches
> in this series.

Are you sure you want to really taint yourself with this stuff? You
wouldn't be the first who risks his mental health by understanding the
ITS ;-)

That being said, I will take a look, I am in ITS land anyway for Xen ...

Cheers,
Andre.


> Apologies if I can't get to it right away.
> 
> Thanks again,
> drew
> 
