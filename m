Received: from eggs.gnu.org ([2001:4830:134:3::10]:47328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gJvaM-0007GF-TB
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gJvaJ-0001zd-MW
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:15:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58422 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gJvaJ-0001rQ-8W
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:15:35 -0500
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-10-fli@suse.com> <877ehrvdfb.fsf@trasno.org>
From: Fei Li <fli@suse.com>
Message-ID: <2cb52a32-4801-2f89-1e76-a0c157f9eba7@suse.com>
Date: Tue, 6 Nov 2018 15:15:22 +0800
MIME-Version: 1.0
In-Reply-To: <877ehrvdfb.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v7 9/9] qemu_thread_create: propagate
 the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: peterx@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com



On 11/05/2018 09:53 PM, Juan Quintela wrote:
> Fei Li <fli@suse.com> wrote:
>> Make qemu_thread_create() return a Boolean to indicate if it succeeds
>> rather than failing with an error. And add an Error parameter to hold
>> the error message and let the callers handle it.
> Nice work, thanks.
>
>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   cpus.c                      | 45 ++++++++++++++++++++++++-----------=
--
>>   dump.c                      |  6 +++--
>>   hw/misc/edu.c               |  6 +++--
>>   hw/ppc/spapr_hcall.c        | 10 +++++++--
>>   hw/rdma/rdma_backend.c      |  4 +++-
>>   hw/usb/ccid-card-emulated.c | 15 +++++++++----
>>   include/qemu/thread.h       |  4 ++--
>>   io/task.c                   |  3 ++-
>>   iothread.c                  | 16 +++++++++-----
>>   migration/migration.c       | 54 +++++++++++++++++++++++++++++------=
----------
>>   migration/postcopy-ram.c    | 14 ++++++++++--
>>   migration/ram.c             | 41 +++++++++++++++++++++++++---------
>>   migration/savevm.c          | 11 ++++++---
>>   tests/atomic_add-bench.c    |  3 ++-
>>   tests/iothread.c            |  2 +-
>>   tests/qht-bench.c           |  3 ++-
>>   tests/rcutorture.c          |  3 ++-
>>   tests/test-aio.c            |  2 +-
>>   tests/test-rcu-list.c       |  3 ++-
>>   ui/vnc-jobs.c               | 17 +++++++++-----
>>   ui/vnc-jobs.h               |  2 +-
>>   ui/vnc.c                    |  4 +++-
>>   util/compatfd.c             | 12 ++++++++--
>>   util/oslib-posix.c          | 17 ++++++++++----
>>   util/qemu-thread-posix.c    | 24 +++++++++++++-------
>>   util/qemu-thread-win32.c    | 16 ++++++++++----
>>   util/rcu.c                  |  3 ++-
>>   util/thread-pool.c          |  4 +++-
>>   28 files changed, 243 insertions(+), 101 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index ed71618e1f..0510f90e06 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1949,15 +1949,20 @@ static void qemu_tcg_init_vcpu(CPUState *cpu, =
Error **errp)
>>               snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG=
",
>>                    cpu->cpu_index);
>>  =20
>> -            qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu=
_thread_fn,
>> -                               cpu, QEMU_THREAD_JOINABLE);
>> +            if (!qemu_thread_create(cpu->thread, thread_name,
>> +                                    qemu_tcg_cpu_thread_fn, cpu,
>> +                                    QEMU_THREAD_JOINABLE, errp)) {
> I think that in this cases where you are not handling the error, you
> should use an exit() here.  We can't continue.
Not sure whether I understand correctly, but we can not use exit() here=20
as there
exists more than one caller and different caller has its own handling way=
.
Instead we pass the errp to further callers to let them handle. Take the
qemu_xxx_init_vcpu() for example, there are two callers:
- the main thread to create vcpu while starting the guest[1]:
 =C2=A0 pc_cpus_init() {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_new_cpu(, &error_fatal);
 =C2=A0 }
- using hmp to hot-plug one cpu:
 =C2=A0 hmp_cpu_add() {
 =C2=A0 =C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qmp_cpu_add(, &err) {
 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 pc_hot_add_cpu(cpuid, &loc=
al_err) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pc_new_cpu(, &local_err);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0 }

For the first case, if there's an error, qemu will exit when=20
error_handle_fatal(&error_fatal, )
is called by error_propagate().
For the second case, hmp_handle_error() will handle the error.
> I am not saying that you need to fix all the places that call
> qmeu_thread_create() to handle the error gracefully, but in the places
> where you don't do, you should just exit.
>
> I.e. this patch should be split in something that does:
>
> -   qemu_thread_create(...., errp);
> +   if (!qemu_thread_create(..., errp))  {
> +      error_report_err(errp);
> +      exit(1);
> +   }
>
> So, we can fix any caller independtly from here.
> Otherwise, we are ignoring an important error.
>
> What do you think?
>
> Later, Juan.
BTW, for those fatal errors only has one caller, e.g.=20
qio_task_run_in_thread(),
I just pass &error_abort to qemu_thread_create(). :)

Have a nice day, thanks
Fei


[1]
(gdb) bt
#0=C2=A0 0x000055555584b333 in qemu_init_vcpu (cpu=3D0x555556927db0,=20
errp=3D0x7fffffffda40)
 =C2=A0=C2=A0=C2=A0 at /build/gitcode/qemu-build/cpus.c:2071
#1=C2=A0 0x0000555555969861 in x86_cpu_realizefn (dev=3D0x555556927db0,=20
errp=3D0x7fffffffda40)
 =C2=A0=C2=A0=C2=A0 at /build/gitcode/qemu-build/target/i386/cpu.c:5115
#2=C2=A0 0x0000555555a9fed6 in device_set_realized (obj=3D0x555556927db0,=
=20
value=3Dtrue, errp=3D0x7fffffffdc18) at hw/core/qdev.c:826
#3=C2=A0 0x0000555555ce91b1 in property_set_bool (obj=3D0x555556927db0, v=
=3D
 =C2=A0=C2=A0=C2=A0 0x55555693f380, name=3D0x555555f4f1a0 "realized",=20
opaque=3D0x5555569046c0, errp=3D0x7fffffffdc18) at qom/object.c:1991
#4=C2=A0 0x0000555555ce707d in object_property_set (obj=3D0x555556927db0,=
 v=3D
 =C2=A0=C2=A0=C2=A0 0x55555693f380, name=3D0x555555f4f1a0 "realized", err=
p=3D0x7fffffffdc18)
 =C2=A0=C2=A0=C2=A0 at qom/object.c:1183
#5=C2=A0 0x0000555555cea893 in object_property_set_qobject=20
(obj=3D0x555556927db0, value=3D0x5555569439b0, name=3D0x555555f4f1a0=20
"realized", errp=3D0x7fffffffdc18) at qom/qom-qobject.c:27
#6=C2=A0 0x0000555555ce7416 in object_property_set_bool (obj=3D0x55555692=
7db0,=20
value=3Dtrue, name=3D0x555555f4f1a0 "realized", errp=3D0x7fffffffdc18) at=
=20
qom/object.c:1249
#7=C2=A0 0x000055555592bb45 in pc_new_cpu (typename=3D0x555555f4fbcc=20
"qemu64-x86_64-cpu", apic_id=3D0, errp=3D0x5555567f3b60 <error_fatal>) at=
=20
/build/gitcode/qemu-build/hw/i386/pc.c:1112
#8=C2=A0 0x000055555592bdbf in pc_cpus_init (pcms=3D0x5555568ee1f0)
 =C2=A0=C2=A0=C2=A0 at /build/gitcode/qemu-build/hw/i386/pc.c:1160
#9=C2=A0 0x0000555555930b28 in pc_init1 (machine=3D0x5555568ee1f0,=20
host_type=3D0x555555f5056c "i440FX-pcihost", pci_type=3D0x555555f50565 "i=
440FX")
 =C2=A0=C2=A0=C2=A0 at /build/gitcode/qemu-build/hw/i386/pc_piix.c:153
#10 0x0000555555931946 in pc_init_v3_0 (machine=3D0x5555568ee1f0)
 =C2=A0=C2=A0=C2=A0 at /build/gitcode/qemu-build/hw/i386/pc_piix.c:438
#11 0x0000555555aaa036 in machine_run_board_init (machine=3D0x5555568ee1f=
0)
 =C2=A0=C2=A0=C2=A0 at hw/core/machine.c:834
#12 0x0000555555a03593 in main (argc=3D30, argv=3D0x7fffffffe148,=20
envp=3D0x7fffffffe240)
 =C2=A0=C2=A0=C2=A0 at vl.c:4503
