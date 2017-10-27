Received: from eggs.gnu.org ([2001:4830:134:3::10]:35743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e83nA-0001Yx-8n
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e83n4-0006JV-6c
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:31:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43328
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e83n4-0006Ic-0Q
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:31:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RCPStw028291
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:31:06 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv44ga95c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:31:06 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 13:31:04 +0100
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 14:31:00 +0200
MIME-Version: 1.0
In-Reply-To: <c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <b40f75d4-2280-fc66-b92f-34717b51ed47@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jjherne@linux.vnet.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>



On 10/25/2017 08:13 PM, Jason J. Herne wrote:
> On 10/20/2017 10:54 AM, Christian Borntraeger wrote:
>> Starting a guest with
>> =C2=A0=C2=A0=C2=A0 <os>
>> =C2=A0=C2=A0=C2=A0=C2=A0 <type arch=3D's390x' machine=3D's390-ccw-virt=
io-2.9'>hvm</type>
>> =C2=A0=C2=A0 </os>
>> =C2=A0=C2=A0 <cpu mode=3D'host-model'/>
>>
>> on an IBM z14 results in
>>
>> "qemu-system-s390x: Some features requested in the CPU model are not
>> available in the configuration: gs"
>>
>> This is because guarded storage is fenced for compat machines that did=
 not have
>> guarded storage support, but libvirt expands the cpu model according t=
o the
>> latest available machine.
>>
>> While this prevents future migration abort (by not starting the guest =
at all),
>> not being able to start a "host-model" guest is very much unexpected.=C2=
=A0 As it
>> turns out, even if we would modify libvirt to not expand the cpu model=
 to
>> contain "gs" for compat machines, it cannot guarantee that a migration=
 will
>> succeed. For example if the kernel changes its features (or the user h=
as
>> nested=3D1 on one host but not on the other) the migration will fail
>> nevertheless.=C2=A0 So instead of fencing "gs" for machines <=3D 2.9 l=
ets allow it for
>> all machine types that support the CPU model. This will make "host-mod=
el"
>> runnable all the time, while relying on the CPU model to reject invali=
d
>> migration attempts.
> ...
>> -=C2=A0=C2=A0=C2=A0 if (gs_allowed()) {
>> +=C2=A0=C2=A0=C2=A0 if (cpu_model_allowed()) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_vm_enab=
le_cap(s, KVM_CAP_S390_GS, 0) =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cap_gs =3D 1;


@Jason

Hi Jason,

I don't have access to a z14 at the moment, and since you do, I would
like to try out something.

I will first describe my concern, and then the test scenario.

The last line above, cap_gs =3D 1, has the side effect of returning
true ever after.

int kvm_s390_get_gs(void)                                                =
      =20
{                                                                        =
      =20
    return cap_gs;                                                       =
      =20
} =20

Now considering
static bool gscb_needed(void *opaque)
{
    return kvm_s390_get_gs();
}

const VMStateDescription vmstate_gscb =3D {
    .name =3D "cpu/gscb",
    .version_id =3D 1,
    .minimum_version_id =3D 1,
    .needed =3D gscb_needed,
    .fields =3D (VMStateField[]) {
        VMSTATE_UINT64_ARRAY(env.gscb, S390CPU, 4),
        VMSTATE_END_OF_LIST()
        }
};

const VMStateDescription vmstate_s390_cpu =3D {
    .name =3D "cpu",
    .post_load =3D cpu_post_load,
    .pre_save =3D cpu_pre_save,
    .version_id =3D 4,
    .minimum_version_id =3D 3,
    .fields      =3D (VMStateField[]) {
        VMSTATE_UINT64_ARRAY(env.regs, S390CPU, 16),
        VMSTATE_UINT64(env.psw.mask, S390CPU),
        VMSTATE_UINT64(env.psw.addr, S390CPU),
        VMSTATE_UINT64(env.psa, S390CPU),
        VMSTATE_UINT32(env.todpr, S390CPU),
        VMSTATE_UINT64(env.pfault_token, S390CPU),
        VMSTATE_UINT64(env.pfault_compare, S390CPU),
        VMSTATE_UINT64(env.pfault_select, S390CPU),
        VMSTATE_UINT64(env.cputm, S390CPU),
        VMSTATE_UINT64(env.ckc, S390CPU),
        VMSTATE_UINT64(env.gbea, S390CPU),
        VMSTATE_UINT64(env.pp, S390CPU),
        VMSTATE_UINT32_ARRAY(env.aregs, S390CPU, 16),
        VMSTATE_UINT64_ARRAY(env.cregs, S390CPU, 16),
        VMSTATE_UINT8(env.cpu_state, S390CPU),
        VMSTATE_UINT8(env.sigp_order, S390CPU),
        VMSTATE_UINT32_V(irqstate_saved_size, S390CPU, 4),
        VMSTATE_VBUFFER_UINT32(irqstate, S390CPU, 4, NULL,
                               irqstate_saved_size),
        VMSTATE_END_OF_LIST()
    },
    .subsections =3D (const VMStateDescription*[]) {
        &vmstate_fpu,
        &vmstate_vregs,
        &vmstate_riccb,
        &vmstate_exval,
        &vmstate_gscb,
        NULL
    },
};

I would expect the vmstate_gscb subsection being sent, even if gs is disa=
bled
via cpu-model if kernel and possibly machine has gs support (and qemu
has cpu-models).

So the test scenario I want you to play trough is the following. Take
the latest-greatest qemu with this patch applied. Make sure gs works
(is provided to the guest) with a 2.9 machine version, and a fully
specified cpu-model. Now disable gs explicitly.

Try to migrate this to another machine having a 2.9 binary. I expect
the migration failing because, the subsection is going to be sent by
the latest-greatest binary, but is unknown to the 2.9 binary.

Notice this is despite the fact that gs is explicitly disabled.

Now that I think about it, maybe the 2.9 binary is going to reject
the explicit gs flag altogether, because it's unknown.

Isn't this a problem? I'm afraid like this the only migration-safe
variant is -base, but that would essentially make adding features
incrementally impossible.=20

But I hypothesize trying to migrate with z13 or even z13-base
would also trigger the unknown subsection problem.

Unfortunately I can't test this because my kernel never
makes kvm_vm_enable_cap(s, KVM_CAP_S390_GS, 0) return 0, because
I lack HW support in the host.

Regards,
Halil


>=20
> Ok, honestly, I dislike this idea because it means we are effectively l=
ying now. We will happily accept a +gs cpu model with a 2.9 compat machin=
e when the point of compat machines is to mimick the older version of Qem=
u which does not support GS.=C2=A0 Yes, model checking will prevent the w=
orst side effects, namely, exploding migrations.
>=20
> I'd far prefer a solution that makes host-model dependent on the machin=
e type. But I understand some of the backlash on that idea. Still, it see=
ms like the cleanest approach even if it will be more work.
>=20
> With all of that said, I know we want this fixed and your patch seems t=
o fix the problem. So if you need an R-b...
>=20
> Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>=20
> Can we have a new tag? :-D
> Reviewed-by-with-reservations: Jason J. Herne <jjherne@linux.vnet.ibm.c=
om>
>=20
