Received: from eggs.gnu.org ([2001:4830:134:3::10]:43446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e32r0-0007a4-Ho
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e32qw-0001XA-0Q
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:30:30 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:45430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1e32qv-0001Wy-Ck
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:30:25 -0400
Received: by mail-wm0-x242.google.com with SMTP id q124so22575722wmb.0
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:30:25 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171013105438.41daaad8@nial.brq.redhat.com>
References: <cover.1507852977.git.alistair.francis@xilinx.com>
	<20171013105438.41daaad8@nial.brq.redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 13 Oct 2017 09:29:53 -0700
Message-ID: <CAKmqyKMX0B30sepnNv=0_7yg8arkbtiai_p6RVx5g_tYu28MBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>

On Fri, Oct 13, 2017 at 1:54 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Thu, 12 Oct 2017 17:07:23 -0700
> Alistair Francis <alistair.francis@xilinx.com> wrote:
>
>> There are numorous QEMU machines that only have a single or a handful of
>> valid CPU options. To simplyfy the management of specificying which CPU
>> is/isn't valid let's create a property that can be set in the machine
>> init. We can then check to see if the user supplied CPU is in that list
>> or not.
>>
>> I have added the valid_cpu_types for some ARM machines only at the
>> moment.
> do you plan to complete work for other boards as well
> so that new interface would replace current opencoded
> checks across the tree?

Ideally yes, it's just a matter of finding time to dig through the
other architectures.

Thanks,
Alistair

>
>
>> Here is what specifying the CPUs looks like now:
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m3" -S
>> QEMU 2.10.50 monitor - type 'help' for more information
>> (qemu) info cpus
>> * CPU #0: thread_id=24175
>> (qemu) q
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m4" -S
>> QEMU 2.10.50 monitor - type 'help' for more information
>> (qemu) q
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m5" -S
>> qemu-system-aarch64: unable to find CPU model 'cortex-m5'
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-a9" -S
>> qemu-system-aarch64: Invalid CPU type: cortex-a9-arm-cpu
>> The valid types are: cortex-m3-arm-cpu, cortex-m4-arm-cpu
>>
>> V2:
>>  - Rebase
>>  - Reorder patches
>>  - Add a Raspberry Pi 2 CPU fix
>> V1:
>>  - Small fixes to prepare a series instead of RFC
>>  - Add commit messages for the commits
>>  - Expand the machine support to ARM machines
>> RFC v2:
>>  - Rebase on Igor's work
>>  - Use more QEMUisms inside the code
>>  - List the supported machines in a NULL terminated array
>>
>> Alistair Francis (5):
>>   netduino2: Specify the valid CPUs
>>   bcm2836: Use the Cortex-A7 instead of Cortex-A15
>>   raspi: Specify the valid CPUs
>>   xlnx-zcu102: Specify the valid CPUs
>>   xilinx_zynq: : Specify the valid CPUs
>>
>>  hw/arm/bcm2836.c     |  2 +-
>>  hw/arm/netduino2.c   | 10 +++++++++-
>>  hw/arm/raspi.c       |  7 +++++++
>>  hw/arm/xilinx_zynq.c |  6 ++++++
>>  hw/arm/xlnx-zcu102.c | 17 +++++++++++++++++
>>  5 files changed, 40 insertions(+), 2 deletions(-)
>>
>
