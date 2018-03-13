Received: from eggs.gnu.org ([2001:4830:134:3::10]:36073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evt74-0002Qi-Ht
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evt71-00080I-D4
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:13:46 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evt71-0007zw-5a
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:13:43 -0400
Received: by mail-wr0-x241.google.com with SMTP id v65so2570991wrc.11
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 16:13:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4c7b83ad-8306-5c52-22e9-044a9f926a56@amsat.org>
Date: Wed, 14 Mar 2018 00:13:40 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1517532021.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/6] Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, alistair23@gmail.com, Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com

On 02/02/2018 01:42 AM, Alistair Francis wrote:
> 
> There are numorous QEMU machines that only have a single or a handful of
> valid CPU options. To simplyfy the management of specificying which CPU
> is/isn't valid let's create a property that can be set in the machine
> init. We can then check to see if the user supplied CPU is in that list
> or not.

Sadly this series missed the 2.12 train.

> 
> I have added the valid_cpu_types for some ARM machines only at the
> moment.
> 
> Here is what specifying the CPUs looks like now:
> 
> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m3" -S
> QEMU 2.10.50 monitor - type 'help' for more information
> (qemu) info cpus
> * CPU #0: thread_id=24175
> (qemu) q
> 
> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m4" -S
> QEMU 2.10.50 monitor - type 'help' for more information
> (qemu) q
> 
> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m5" -S
> qemu-system-aarch64: unable to find CPU model 'cortex-m5'
> 
> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-a9" -S
> qemu-system-aarch64: Invalid CPU type: cortex-a9-arm-cpu
> The valid models are: cortex-m3, cortex-m4
> 
> V5:
>  - Use cpu_model instead of cpu_type
> V4:
>  - Rebase
>  - Remove spaces
> V3:
>  - Make the varialbes static
> V2:
>  - Rebase
>  - Reorder patches
>  - Add a Raspberry Pi 2 CPU fix
> V1:
>  - Small fixes to prepare a series instead of RFC
>  - Add commit messages for the commits
>  - Expand the machine support to ARM machines
> RFC v2:
>  - Rebase on Igor's work
>  - Use more QEMUisms inside the code
>  - List the supported machines in a NULL terminated array
> 
> 
> 
> Alistair Francis (6):
>   machine: Convert the valid cpu types to use cpu_model
>   netduino2: Specify the valid CPUs
>   bcm2836: Use the Cortex-A7 instead of Cortex-A15
>   raspi: Specify the valid CPUs
>   xlnx-zcu102: Specify the valid CPUs
>   xilinx_zynq: Specify the valid CPUs
> 
>  hw/arm/bcm2836.c     |  2 +-
>  hw/arm/netduino2.c   | 10 +++++++++-
>  hw/arm/raspi.c       |  7 +++++++
>  hw/arm/xilinx_zynq.c |  6 ++++++
>  hw/arm/xlnx-zcu102.c | 17 +++++++++++++++++
>  hw/core/machine.c    | 11 +++++------
>  6 files changed, 45 insertions(+), 8 deletions(-)
> 
