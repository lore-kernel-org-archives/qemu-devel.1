Received: from eggs.gnu.org ([2001:4830:134:3::10]:33576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dvAZ7-0004uT-Py
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dvAZ6-0000Ba-DG
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:07:29 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dvAZ6-000093-4F
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:07:28 -0400
Received: by mail-wm0-x241.google.com with SMTP id f4so6409388wmh.4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:07:26 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170909201657.GF7570@localhost.localdomain>
References: <cover.1504656490.git.alistair.francis@xilinx.com>
	<b2bfe1ee20bd9764572015df0d167d3015036ef0.1504656490.git.alistair.francis@xilinx.com>
	<20170909201657.GF7570@localhost.localdomain>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 21 Sep 2017 16:06:54 -0700
Message-ID: <CAKmqyKPJVLROtA7uT7YC9P8DVwNcTWURophsZ5id+bJ_oexwGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 1/2] machine: Add a valid_cpu_types
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>

On Sat, Sep 9, 2017 at 1:16 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Sep 05, 2017 at 05:12:01PM -0700, Alistair Francis wrote:
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  hw/core/machine.c   | 27 +++++++++++++++++++++++++++
>>  include/hw/boards.h |  1 +
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 41b53a17ad..de0f127d27 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -758,6 +758,33 @@ void machine_run_board_init(MachineState *machine)
>>          machine_numa_finish_init(machine);
>>      }
>>      machine_class->init(machine);
>> +
>> +    if (machine_class->valid_cpu_types && machine->cpu_model) {
>> +        const char *temp;
>> +        int i, len = machine_class->valid_cpu_types->len;
>
> I suggest doing this after Igor's series that replaces the
> cpu_model field (full -cpu string) with cpu_type (only the CPU
> type name).
>
>> +
>> +        for (i = 0; i < len; i++) {
>> +            temp = g_array_index(machine_class->valid_cpu_types, char *, i);
>> +            if (!strcmp(machine->cpu_model, temp)) {
>> +                /* The user specificed CPU is in the valid field, we are
>> +                 * good to go.
>> +                 */
>> +                g_array_free(machine_class->valid_cpu_types, true);
>> +                return;
>
> I suggest checking for:
>   object_class_dynamic_cast(object_class_get_name(machine->cpu_type), type)
> instead.  This way machines could just enumerate a common parent
> type to all supported CPU models.
>
>> +            }
>> +        }
>> +        /* The user specified CPU must not be a valid CPU, print a sane error */
>> +        temp = g_array_index(machine_class->valid_cpu_types, char *, 0);
>> +        error_report("Invalid CPU: %s", machine->cpu_model);
>> +        error_printf("The valid options are: %s", temp);
>> +        for (i = 1; i < len; i++) {
>> +            temp = g_array_index(machine_class->valid_cpu_types, char *, i);
>> +            error_printf(", %s", temp);
>> +        }
>> +        error_printf("\n");
>
> Now we have a completely new method to list the valid CPU types
> in addition to arch_query_cpu_definitions() and list_cpus()
> (which are already a bit messy and need to share more code).
>
> I think this should share code with "-cpu
> help"/query-cpu-definitions instead.  This means
> arch_query_cpu_definitions() will need a MachineClass* argument,
> if the user wants only the CPU types supported by a specific
> machine type, but I think it would be an interesting improvement
> to query-cpu-definitions.

I don't see the improvement here. arch_query_cpu_definitions() is just
a pretty simple list of that arch's CPUs. I don't really see how it
helps in this case. We don't re-use much code at all.

Ideally I would like to see less arch dependent code in QEMU, and
relying on arch_query_cpu_definitions() is moving in the opposite
direction. It looks like arch_query_cpu_definitions() isn't supported
by every architecture as well. I only see ARM, x86, PPC and S390x
support.

I have addressed all the other comments so I'm going to send an RFCv2
out later today. The code looks a lot nicer now. I'm happy to keep
discussing this though, just want to keep the ball rolling.

Thanks,
Alistair

>
>> +        g_array_free(machine_class->valid_cpu_types, true);
>> +        exit(1);
>> +    }
>>  }
>>
>>  static void machine_class_finalize(ObjectClass *klass, void *data)
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 3363dd19fd..78678f84a9 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -172,6 +172,7 @@ struct MachineClass {
>>      int minimum_page_bits;
>>      bool has_hotpluggable_cpus;
>>      int numa_mem_align_shift;
>> +    GArray *valid_cpu_types;
>
> The list of CPU types for a machine are very likely to be
> statically defined at build time.  Any specific reason to not
> make it a simple char** pointer?
>
>>      void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
>>                                   int nb_nodes, ram_addr_t size);
>>
>> --
>> 2.11.0
>>
>
> --
> Eduardo
