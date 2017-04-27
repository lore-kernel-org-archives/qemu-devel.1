Received: from eggs.gnu.org ([2001:4830:134:3::10]:44138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1d3dOJ-0006ST-Nu
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1d3dOI-0002o0-Tp
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:59:03 -0400
References: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
	<CACJhumcMAtJgnRVctCLE5XJ0eo0vpQ35zjjB8twMTkbVphfB8g@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <fe5d76da-6fe5-65b2-af35-7673601ff1b8@redhat.com>
Date: Thu, 27 Apr 2017 08:58:51 +0200
MIME-Version: 1.0
In-Reply-To: <CACJhumcMAtJgnRVctCLE5XJ0eo0vpQ35zjjB8twMTkbVphfB8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v5 0/4] vITS save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prakash B <bjsprakash.linux@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, drjones@redhat.com, Vijay Kilari <vijay.kilari@gmail.com>, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, qemu-arm@nongnu.org, Vijaya.Kumar@cavium.com, Christoffer Dall <christoffer.dall@linaro.org>, eric.auger.pro@gmail.com

Hi Brahmajyosyula,

On 26/04/2017 13:18, Prakash B wrote:
> Verified on Cavium ThunderX platform
> Continousily migrated Guest more than 500 times b/w different  hosts.
> Please feel free to add  Tested-by: Prakash, Brahmajyosyula
> <Brahmajyosyula.Prakash@cavium.com>


Many thanks for your testing efforts!

Best Regards

Eric
> 
> On Fri, Apr 14, 2017 at 6:16 PM, Eric Auger <eric.auger@redhat.com> wrote:
>> This series allows ITS save/restore and migration use cases.
>> It relies on not upstreamed kernel series [1].
>>
>> ITS tables are flushed into guest RAM on VM stop while registers
>> are save on pre_save() callback. Tables and registers are restored
>> on ITS post_load().
>>
>> Redistributor pending tables also are flushed on VM stop, independently
>> on ITS tables.
>>
>> That work was tested on Cavium ThunderX using virsh save/restore and
>> virt-manager live migration.
>>
>> Best Regards
>>
>> Eric
>>
>> Host Kernel dependencies:
>> - [1] [PATCH v5 00/22] vITS save/restore
>>
>> History:
>> v4 -> v5:
>> - adapt to the new user API
>> - new patch "hw/intc/arm_gicv3_kvm: Implement pending table save"
>>   as the pending table save now is handled on GICV3 side.
>>
>> v3 -> v4:
>> - oversight in v3, missed a last minute correction related to
>>   reg useless declaration in kvm_arm_its_pre_save
>>
>> v2 -> v3:
>> - GITS_IIDR is now saved and restored to check ABI revision.
>> - get/put functions renamed into pre_save/post_load
>> - unmigratable = false removed
>> - changed the migration blocker message
>> - remove the extract64 round s->ctlr
>> - reword some comments
>>
>> v1 -> v2:
>> - rebase on 2.9 soft release code
>> - handle case where migrate_add_blocker fails
>> - add comments along with ITS and GICv3 migration priorities
>>
>>
>> Eric Auger (4):
>>   linux-headers: Update for vITS save/restore
>>   hw/intc/arm_gicv3_its: Implement state save/restore
>>   hw/intc/arm_gicv3_kvm: Implement pending table save
>>   hw/intc/arm_gicv3_its: Allow save/restore
>>
>>  hw/intc/arm_gicv3_common.c             |   1 +
>>  hw/intc/arm_gicv3_its_common.c         |  11 ++-
>>  hw/intc/arm_gicv3_its_kvm.c            | 120 +++++++++++++++++++++++++++++----
>>  hw/intc/arm_gicv3_kvm.c                |  25 +++++++
>>  include/hw/intc/arm_gicv3_its_common.h |   8 +++
>>  include/migration/vmstate.h            |   2 +
>>  linux-headers/asm-arm/kvm.h            |   6 +-
>>  linux-headers/asm-arm64/kvm.h          |   6 +-
>>  8 files changed, 164 insertions(+), 15 deletions(-)
>>
>> --
>> 2.5.5
>>
>>
> 
