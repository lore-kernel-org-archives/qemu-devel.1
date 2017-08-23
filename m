Received: from eggs.gnu.org ([2001:4830:134:3::10]:44160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bauerman@linux.vnet.ibm.com>) id 1dkerM-0006hG-J2
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 19:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bauerman@linux.vnet.ibm.com>) id 1dkerI-0007Rb-Fa
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 19:14:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bauerman@linux.vnet.ibm.com>)
	id 1dkerI-0007QX-6e
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 19:14:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7NNDu1v116137
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 19:14:46 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2chgynxtk0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 19:14:46 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bauerman@linux.vnet.ibm.com>;
	Wed, 23 Aug 2017 17:14:45 -0600
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170822020258.GX12356@umbus.fritz.box>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
In-reply-to: <20170822020258.GX12356@umbus.fritz.box>
Date: Wed, 23 Aug 2017 20:14:32 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87y3q9q3l3.fsf@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Ram Pai <linuxram@us.ibm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>


Hello David,

Thank you for your input.

David Gibson <david@gibson.dropbear.id.au> writes:

> On Mon, Aug 21, 2017 at 05:00:36PM -0300, Thiago Jung Bauermann wrote:
>> LoPAPR says:
>>=20
>>     =E2=80=9Cibm,processor-storage-keys=E2=80=9D
>>=20
>>     property name indicating the number of virtual storage keys suppor=
ted
>>     by the processor described by this node.
>>=20
>>     prop-encoded-array: Consists of two cells encoded as with encode-i=
nt.
>>     The first cell represents the number of virtual storage keys suppo=
rted
>>     for data accesses while the second cell represents the number of
>>     virtual storage keys supported for instruction accesses. The cell =
value
>>     of zero indicates that no storage keys are supported for the acces=
s
>>     type.
>>=20
>> pHyp provides the property above but there's a bug in P8 firmware wher=
e the
>> second cell is zero even though POWER8 supports instruction access key=
s.
>> This bug will be fixed for P9.
>>=20
>> Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 machi=
ne.
>>=20
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>
> Regardless of anything else, this clearly won't go in until 2.11 opens.

Ok, not a problem.

>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -605,6 +605,80 @@ static void spapr_populate_cpu_dt(CPUState *cs, v=
oid *fdt, int offset,
>>                            pcc->radix_page_info->count *
>>                            sizeof(radix_AP_encodings[0]))));
>>      }
>> +
>> +    if (spapr->storage_keys) {
>> +        uint32_t val[2];
>> +
>> +        val[0] =3D cpu_to_be32(spapr->storage_keys);
>> +        val[1] =3D spapr->insn_keys ? val[0] : 0;
>> +
>> +        _FDT(fdt_setprop(fdt, offset, "ibm,processor-storage-keys",
>> +                         val, sizeof(val)));
>> +    }
>> +}
>> +
>> +#define SYSFS_PROT_KEYS_PATH "/sys/kernel/mm/protection_keys/"
>> +#define SYSFS_USABLE_STORAGE_KEYS SYSFS_PROT_KEYS_PATH "usable_keys"
>> +#define SYSFS_DISABLE_EXEC_KEYS SYSFS_PROT_KEYS_PATH "disable_execute=
_supported"
>> +
>> +static void setup_storage_keys(CPUPPCState *env, sPAPRMachineState *s=
papr)
>> +{
>> +    if (!(env->mmu_model & POWERPC_MMU_AMR))
>> +        return;
>> +
>> +    if (kvm_enabled()) {
>> +        char buf[sizeof("false\n")];
>> +        uint32_t keys;
>> +        FILE *fd;
>
> For starters, reasonably complex kvm-only code like this should go
> into target/ppc/kvm.c.

Ok, will move the code there.

> But, there's a more fundamental problem.  Automatically adjusting
> guest visible parameters based on the host's capabilities is really
> problematic: if you migrate to a host with different capabilities
> what's usable suddenly changes, but the guest can't know.
>
> The usual way to deal with this is instead to have explicit machine
> parameters to control the value, and check if those are possible on
> the host.  It's then up to the user and/or management layer to set the
> parameters suitable to allow migration between all machines that they
> care about.

Good point, I hadn't thought of it. I will add the machine parameter
then and send a v2. Can the default value of the parameter be what is
supported by the host?=20

--=20
Thiago Jung Bauermann
IBM Linux Technology Center
