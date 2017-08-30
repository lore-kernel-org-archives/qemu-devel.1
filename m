Received: from eggs.gnu.org ([2001:4830:134:3::10]:34761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn6Vb-0000zQ-HL
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn6Va-0003j2-Am
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:10:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503985539-7205-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<c61ae7e6-a117-a9c1-6a73-73beaede08a8@amsat.org>
	<e70b2b00-e471-7d9b-c754-6245b723ea94@linux.vnet.ibm.com>
	<59193a65-f1d1-4383-b776-053dce6e9746@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8947138e-fbe5-5e86-f42e-b79c2d6fb33a@amsat.org>
Date: Wed, 30 Aug 2017 14:10:18 -0300
MIME-Version: 1.0
In-Reply-To: <59193a65-f1d1-4383-b776-053dce6e9746@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] vl: exit if maxcpus is negative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seeteena <s1seetee@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, famz@redhat.com, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

Hi Seeteena,

>>> On 08/29/2017 02:45 AM, Seeteena Thoufeek wrote:
>>>> ---Steps to Reproduce---
>>>>
>>>> When passed a negative number to 'maxcpus' parameter, Qemu aborts
>>>> with a core dump.
>>>>
>>>> Run the following command with maxcpus argument as negative number
>>>>
>>>> ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine
>>>> pseries,accel=kvm,kvm-type=HV -m size=200g -device virtio-blk-pci,
>>>> drive=rootdisk -drive file=/home/images/pegas-1.0-ppc64le.qcow2,
>>>> if=none,cache=none,id=rootdisk,format=qcow2 -monitor telnet
>>>> :127.0.0.1:1234,server,nowait -net nic,model=virtio -net
>>>> user -redir tcp:2000::22 -device nec-usb-xhci -smp 8,cores=1,
>>>> threads=1,maxcpus=-12

Using 'extern unsigned int max_cpus;' I get:

qemu-system-ppc64: Number of SMP CPUs requested (-12) exceeds max CPUs 
supported by machine 'pseries-2.10' (1024)

Which looks weird but sane :)

>>>>
>>>> (process:12149): GLib-ERROR **: gmem.c:130: failed to allocate
>>>>   18446744073709550568 bytes
>>>>
>>>> Trace/breakpoint trap
>>>>
>>>> Reported-by: R.Nageswara Sastry <rnsastry@linux.vnet.ibm.com>
>>>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
>>>> ---
>>>> v1 -> v2:
>>>>    - Fix the error check in vl.c to make it generic.
>>>> v2 -> v3:
>>>>    - Fix coding style pointed out by patchew.
>>>>    - Fix check for "<= 0" instead of just "< 0".
>>>> v3 -> v4:
>>>>    - Fix subject line.
>>>>    - Removed space before ":" from vl.c:1248
>>>>    - Removed Reviewed-by: flag.
>>>> ---
>>>>   vl.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/vl.c b/vl.c
>>>> index 8e247cc..2d9e73d 100644
>>>> --- a/vl.c
>>>> +++ b/vl.c
>>>> @@ -1244,7 +1244,10 @@ static void smp_parse(QemuOpts *opts)
>>>>           }
>>>>             max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
>>>> -
>>>> +        if (max_cpus <= 0) {
>>>> +            error_report("Invalid max_cpus: %d", max_cpus);
>>>
>>> I disagree with this patch, I think the correct fix is to declare 
>>> max_cpus as unsigned.
>>> Looking at the codebase I can't find any signed use of it.
>>    if I declare max_cpus as unsigned, the error check is no more valid 
>> as the value max_cpus fetches is of unsigned type and hence we cannot 
>> do this below check.
>>                                                     if (max_cpus <= 0) {
>> error_report("Invalid max_cpus: %d", max_cpus);
>>
>> When I remove the error check with max_cpus defined as unsigned, the 
>> code behaves as follows when negetive value is passed for maxcpus
>>    ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine 
>> pseries,accel=kvm,kvm-type=HV -m size=20g -device 
>> virtio-blk-pci,drive=rootdisk -drive 
>> file=/var/lib/libvirt/images/avocado-fvt-wrapper/data/avocado-vt/images/ubuntu-17.10-ppc64le.qcow2,if=none,cache=none,id=rootdisk,format=qcow2 
>> -monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=virtio 
>> -net user -device nec-usb-xhci -smp 8,cores=1,threads=1,maxcpus=-12
>>
>>
>> SLOF 
>> **********************************************************************
>> QEMU Starting
>>  Build Date = Jan  4 2017 05:15:48
>>  FW Version = buildd@ release 20161019
>>  Press "s" to enter Open Firmware.
>>
> 
> Adding .. between we have max_cpus declared as extern int max_cpus; in 
> sysemu.h file.
>>>
>>>> +            exit(1);
>>>> +        }
>>>>           if (max_cpus < cpus) {
>>>>               error_report("maxcpus must be equal to or greater than 
>>>> smp");
>>>>               exit(1);
>>>>
>>>
>>> Regards,
>>>
>>> Phil.
>>>
>>
> 
