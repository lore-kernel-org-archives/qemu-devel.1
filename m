Received: from eggs.gnu.org ([2001:4830:134:3::10]:46617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eRSoC-0000oe-9r
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 20:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eRSoB-0006Ij-8v
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 20:04:32 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eRSoA-0006HU-U4
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 20:04:31 -0500
Received: by mail-wr0-x236.google.com with SMTP id l19so8536566wrc.2
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 17:04:30 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAKmqyKPHHQcQ3HYs4r7f4uUDfdMqSq=-mUJn6becXw8WXNAwNQ@mail.gmail.com>
References: <cover.1513729519.git.alistair.francis@xilinx.com>
	<CAFEAcA-dvs-E83ZCEk6VAyyQkpghX9oF-d-D62vOKs7kfjPzaw@mail.gmail.com>
	<CAKmqyKPHHQcQ3HYs4r7f4uUDfdMqSq=-mUJn6becXw8WXNAwNQ@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 19 Dec 2017 17:03:59 -0800
Message-ID: <CAKmqyKMKL_BGSbaetubaPv8gkmF9XFFdDwkXAPsUZdV1qkOyqA@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Tue, Dec 19, 2017 at 4:55 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Tue, Dec 19, 2017 at 4:43 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 20 December 2017 at 00:27, Alistair Francis
>> <alistair.francis@xilinx.com> wrote:
>>> There are numorous QEMU machines that only have a single or a handful of
>>> valid CPU options. To simplyfy the management of specificying which CPU
>>> is/isn't valid let's create a property that can be set in the machine
>>> init. We can then check to see if the user supplied CPU is in that list
>>> or not.
>>>
>>> I have added the valid_cpu_types for some ARM machines only at the
>>> moment.
>>>
>>> Here is what specifying the CPUs looks like now:
>>>
>>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m3" -S
>>> QEMU 2.10.50 monitor - type 'help' for more information
>>> (qemu) info cpus
>>> * CPU #0: thread_id=24175
>>> (qemu) q
>>>
>>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m4" -S
>>> QEMU 2.10.50 monitor - type 'help' for more information
>>> (qemu) q
>>>
>>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m5" -S
>>> qemu-system-aarch64: unable to find CPU model 'cortex-m5'
>>>
>>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-a9" -S
>>> qemu-system-aarch64: Invalid CPU type: cortex-a9-arm-cpu
>>> The valid types are: cortex-m3-arm-cpu, cortex-m4-arm-cpu
>>
>> Thanks for this; we really should be more strict about
>> forbidding "won't work" combinations than we have
>> been in the past.
>>
>> In the last of these cases, I think that when we
>> list the invalid CPU type and the valid types
>> we should use the same names we want the user to
>> use on the command line, without the "-arm-cpu"
>> suffixes.
>
> Hmm... That is a good point, it is confusing that they don't line up.
>
> The problem is that we are just doing a simple
> object_class_dynamic_cast() in hw/core/machine.c which I think
> (untested) requires us to have the full name in the valid cpu array.

Yeah, so I tested this diff on top of this series:

diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 111a1d0aba..702e5e8fcf 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -42,8 +42,8 @@ static void netduino2_init(MachineState *machine)
 }

 static const char *netduino_valid_cpus[] = {
-                                            ARM_CPU_TYPE_NAME("cortex-m3"),
-                                            ARM_CPU_TYPE_NAME("cortex-m4"),
+                                            "cortex-m3",
+                                            "cortex-m4",
                                             NULL
                                            };

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c857f3f934..4b817ccc58 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -761,8 +761,8 @@ void machine_run_board_init(MachineState *machine)
     /* If the machine supports the valid_cpu_types check and the user
      * specified a CPU with -cpu check here that the user CPU is supported.
      */
-    if (machine_class->valid_cpu_types && machine->cpu_type) {
-        ObjectClass *class = object_class_by_name(machine->cpu_type);
+    if (machine_class->valid_cpu_types && machine->cpu_model) {
+        ObjectClass *class = object_class_by_name(machine->cpu_model);
         int i;

         for (i = 0; machine_class->valid_cpu_types[i]; i++) {
@@ -777,7 +777,7 @@ void machine_run_board_init(MachineState *machine)

         if (!machine_class->valid_cpu_types[i]) {
             /* The user specified CPU is not valid */
-            error_report("Invalid CPU type: %s", machine->cpu_type);
+            error_report("Invalid CPU type: %s", machine->cpu_model);
             error_printf("The valid types are: %s",
                          machine_class->valid_cpu_types[0]);
             for (i = 1; machine_class->valid_cpu_types[i]; i++) {

and I get this:

$ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel
./u-boot.elf -nographic -cpu "cortex-m4" -S
qemu-system-aarch64: Invalid CPU type: cortex-m4
The valid types are: cortex-m3, cortex-m4

So we loose the object_class_dynamic_cast() ability.

I think an earlier version of my previous series adding the support to
machine.c did string comparison, but it was decided to utilise objects
instead. One option is to make the array 2 wide and have the second
string be user friendly?

Alistair

>
> Alistair
>
>>
>> thanks
>> -- PMM
