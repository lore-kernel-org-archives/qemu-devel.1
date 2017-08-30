Received: from eggs.gnu.org ([2001:4830:134:3::10]:56397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1dmy2T-0006UY-Fs
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1dmy2Q-0001Az-98
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:07:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1dmy2P-0001Al-Ve
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:07:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7U87YjB071423
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 04:07:48 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cnqu36guk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 04:07:48 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 02:07:47 -0600
References: <1503985539-7205-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<c61ae7e6-a117-a9c1-6a73-73beaede08a8@amsat.org>
From: seeteena <s1seetee@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 13:37:38 +0530
MIME-Version: 1.0
In-Reply-To: <c61ae7e6-a117-a9c1-6a73-73beaede08a8@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <e70b2b00-e471-7d9b-c754-6245b723ea94@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] vl: exit if maxcpus is negative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, famz@redhat.com, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>



On 08/29/2017 07:15 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Seeteena,
>
> On 08/29/2017 02:45 AM, Seeteena Thoufeek wrote:
>> ---Steps to Reproduce---
>>
>> When passed a negative number to 'maxcpus' parameter, Qemu aborts
>> with a core dump.
>>
>> Run the following command with maxcpus argument as negative number
>>
>> ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine
>> pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D200g -device virtio-blk-pc=
i,
>> drive=3Drootdisk -drive file=3D/home/images/pegas-1.0-ppc64le.qcow2,
>> if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3Dqcow2 -monitor telnet
>> :127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net
>> user -redir tcp:2000::22 -device nec-usb-xhci -smp 8,cores=3D1,
>> threads=3D1,maxcpus=3D-12
>>
>> (process:12149): GLib-ERROR **: gmem.c:130: failed to allocate
>> =C2=A0 18446744073709550568 bytes
>>
>> Trace/breakpoint trap
>>
>> Reported-by: R.Nageswara Sastry <rnsastry@linux.vnet.ibm.com>
>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
>> ---
>> v1 -> v2:
>> =C2=A0=C2=A0 - Fix the error check in vl.c to make it generic.
>> v2 -> v3:
>> =C2=A0=C2=A0 - Fix coding style pointed out by patchew.
>> =C2=A0=C2=A0 - Fix check for "<=3D 0" instead of just "< 0".
>> v3 -> v4:
>> =C2=A0=C2=A0 - Fix subject line.
>> =C2=A0=C2=A0 - Removed space before ":" from vl.c:1248
>> =C2=A0=C2=A0 - Removed Reviewed-by: flag.
>> ---
>> =C2=A0 vl.c | 5 ++++-
>> =C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/vl.c b/vl.c
>> index 8e247cc..2d9e73d 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -1244,7 +1244,10 @@ static void smp_parse(QemuOpts *opts)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_cpus=
 =3D qemu_opt_get_number(opts, "maxcpus", cpus);
>> -
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_cpus <=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_report("Invalid max_cpus: %d", max_cpus);
>
> I disagree with this patch, I think the correct fix is to declare=20
> max_cpus as unsigned.
> Looking at the codebase I can't find any signed use of it.
 =C2=A0=C2=A0 if I declare max_cpus as unsigned, the error check is no mo=
re valid=20
as the value max_cpus fetches is of unsigned type and hence we cannot do=20
this below check.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (max_cpus <=3D 0) {
error_report("Invalid max_cpus: %d", max_cpus);

When I remove the error check with max_cpus defined as unsigned, the=20
code behaves as follows when negetive value is passed for maxcpus
 =C2=A0=C2=A0 ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -mach=
ine=20
pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D20g -device=20
virtio-blk-pci,drive=3Drootdisk -drive=20
file=3D/var/lib/libvirt/images/avocado-fvt-wrapper/data/avocado-vt/images=
/ubuntu-17.10-ppc64le.qcow2,if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3D=
qcow2=20
-monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net=
=20
user -device nec-usb-xhci -smp 8,cores=3D1,threads=3D1,maxcpus=3D-12


SLOF ********************************************************************=
**
QEMU Starting
 =C2=A0Build Date =3D Jan=C2=A0 4 2017 05:15:48
 =C2=A0FW Version =3D buildd@ release 20161019
 =C2=A0Press "s" to enter Open Firmware.

>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ex=
it(1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_cpus < =
cpus) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report("maxcpus must be equal to or greater than=20
>> smp");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 exit(1);
>>
>
> Regards,
>
> Phil.
>
