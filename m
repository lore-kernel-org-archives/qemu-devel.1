Received: from eggs.gnu.org ([2001:4830:134:3::10]:33215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRSUN-0007nv-Jb
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRSUM-0002Bc-SG
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:44:03 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:34224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eRSUM-0002Aw-M0
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:44:02 -0500
Received: by mail-ot0-x22d.google.com with SMTP id n18so9016458otd.1
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 16:44:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1513729519.git.alistair.francis@xilinx.com>
References: <cover.1513729519.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Dec 2017 00:43:41 +0000
Message-ID: <CAFEAcA-dvs-E83ZCEk6VAyyQkpghX9oF-d-D62vOKs7kfjPzaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/5] Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alistair Francis <alistair23@gmail.com>

On 20 December 2017 at 00:27, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> There are numorous QEMU machines that only have a single or a handful of
> valid CPU options. To simplyfy the management of specificying which CPU
> is/isn't valid let's create a property that can be set in the machine
> init. We can then check to see if the user supplied CPU is in that list
> or not.
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
> The valid types are: cortex-m3-arm-cpu, cortex-m4-arm-cpu

Thanks for this; we really should be more strict about
forbidding "won't work" combinations than we have
been in the past.

In the last of these cases, I think that when we
list the invalid CPU type and the valid types
we should use the same names we want the user to
use on the command line, without the "-arm-cpu"
suffixes.

thanks
-- PMM
