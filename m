Received: from eggs.gnu.org ([2001:4830:134:3::10]:40275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gBMrQ-0000w2-7B
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gBMrM-00059Y-3y
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:33:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gBMrL-000588-Rz
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:33:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 913D781F09
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 16:33:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-15-armbru@redhat.com>
	<20181012163554.6e54d717@redhat.com>
Date: Sat, 13 Oct 2018 18:33:44 +0200
In-Reply-To: <20181012163554.6e54d717@redhat.com> (Igor Mammedov's message of
	"Fri, 12 Oct 2018 16:35:54 +0200")
Message-ID: <87ftx9x0uv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/31] numa: Fix QMP command set-numa-node
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

Igor Mammedov <imammedo@redhat.com> writes:

> On Mon,  8 Oct 2018 19:31:08 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Calling error_report() in a function that takes an Error ** argument
>> is suspicious.  parse_numa_node() does that, and then exit()s.  It
>> also passes &error_fatal to machine_set_cpu_numa_node().  Both wrong.
>> Attempting to configure numa when the machine doesn't support it kills
>> the VM:
>> 
>>     $ qemu-system-x86_64 -nodefaults -S -display none -M none -preconfig -qmp stdio
>>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 3}, "package": "v3.0.0-837-gc5e4e49258"}, "capabilities": []}}
>>     {"execute": "qmp_capabilities"}
>>     {"return": {}}
>>     {"execute": "set-numa-node", "arguments": {"type": "node"}}
>>     NUMA is not supported by this machine-type
>>     $ echo $?
>>     1
>> 
>> Messed up when commit 64c2a8f6d3f and 7c88e65d9e9 (v2.10.0) added
>> incorrect error handling right next to correct examples.  Latent bug
>> until commit f3be67812c2 (v3.0.0) made it accessible via QMP.  Fairly
>> harmless in practice, because it's limited to RUN_STATE_PRECONFIG.
>> The fix is obvious: replace error_report(); exit() by error_setg();
>> return.
>> 
>> This affects parse_numa_node()'s other caller
>> numa_complete_configuration(): since it ignores errors, the "NUMA is
>> not supported by this machine-type" is now ignored, too.  But that
>> error is as unexpected there as any other.  Change it to abort on
>> error instead.
>> 
>> Fixes: f3be67812c226162f86ce92634bd913714445420
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> 
>> fixup! numa: Fix QMP command set-numa-node error handling
>> ---
>>  numa.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>> 
>> diff --git a/numa.c b/numa.c
>> index 81542d4ebb..1d7c49ad43 100644
>> --- a/numa.c
>> +++ b/numa.c
>> @@ -60,6 +60,7 @@ NodeInfo numa_info[MAX_NODES];
>>  static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>>                              Error **errp)
>>  {
>> +    Error *err = NULL;
>>      uint16_t nodenr;
>>      uint16List *cpus = NULL;
>>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>> @@ -82,8 +83,8 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>>      }
>>  
>>      if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) {
>> -        error_report("NUMA is not supported by this machine-type");
>> -        exit(1);
>> +        error_setg(errp, "NUMA is not supported by this machine-type");
>> +        return;
>>      }
>>      for (cpus = node->cpus; cpus; cpus = cpus->next) {
>>          CpuInstanceProperties props;
>> @@ -97,7 +98,11 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>>          props = mc->cpu_index_to_instance_props(ms, cpus->value);
>>          props.node_id = nodenr;
>>          props.has_node_id = true;
>> -        machine_set_cpu_numa_node(ms, &props, &error_fatal);
>> +        machine_set_cpu_numa_node(ms, &props, &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>>      }
>>  
>>      if (node->has_mem && node->has_memdev) {
>> @@ -367,7 +372,7 @@ void numa_complete_configuration(MachineState *ms)
>>      if (ms->ram_slots > 0 && nb_numa_nodes == 0 &&
>>          mc->auto_enable_numa_with_memhp) {
>>              NumaNodeOptions node = { };
>> -            parse_numa_node(ms, &node, NULL);
>> +            parse_numa_node(ms, &node, &error_abort);
> it won't affect machines with numa support /i.e. no change/,
> but if machine that doesn't support numa, gets here it fine for it to die.

Uh, that could be undesirable.  Quick test:

    $ qemu-system-x86_64 -nodefaults -S -M none -numa node
    qemu-system-x86_64: -numa node: NUMA is not supported by this machine-type
    [Exit 1 ]

Stack backtrace:

    #0  0x00007fffec860b10 in _exit () at /lib64/libc.so.6
    #1  0x00007fffec7d36ea in __run_exit_handlers () at /lib64/libc.so.6
    #2  0x00007fffec7d371c in  () at /lib64/libc.so.6
    #3  0x0000555555e3cfb9 in error_handle_fatal (errp=0x55555685d8e0 <error_fatal>, err=0x555556a5cbc0) at /work/armbru/qemu/util/error.c:42
    #4  0x0000555555e3db6b in error_propagate (dst_errp=0x55555685d8e0 <error_fatal>, local_err=0x555556a5cbc0) at /work/armbru/qemu/util/error.c:288
    #5  0x000055555587e4f2 in parse_numa (opaque=0x55555693fc00, opts=0x55555692ee60, errp=0x55555685d8e0 <error_fatal>) at /work/armbru/qemu/numa.c:242
    #6  0x0000555555e4c8d1 in qemu_opts_foreach (list=0x555556647140 <qemu_numa_opts>, func=0x55555587e3cf <parse_numa>, opaque=0x55555693fc00, errp=0x55555685d8e0 <error_fatal>) at /work/armbru/qemu/util/qemu-option.c:1151
    #7  0x000055555587ed91 in parse_numa_opts (ms=0x55555693fc00)
        at /work/armbru/qemu/numa.c:447
    #8  0x0000555555a0c648 in main (argc=7, argv=0x7fffffffdf88, envp=0x7fffffffdfc8) at /work/armbru/qemu/vl.c:4454

That's before numa_complete_configuration() gets called via
machine_run_board_init().

Can you give me a hint how to "get here fine"?

>>      }
>>  
>>      assert(max_numa_nodeid <= MAX_NODES);
>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
