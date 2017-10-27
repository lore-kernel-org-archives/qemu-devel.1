Received: from eggs.gnu.org ([2001:4830:134:3::10]:37955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e83yv-0003Gm-0I
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e83yr-0008RS-TY
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:43:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45404
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e83yr-0008Ik-NU
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:43:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RCaT7q040695
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:43:05 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv4g19wv8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:43:04 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 27 Oct 2017 13:43:02 +0100
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
	<b40f75d4-2280-fc66-b92f-34717b51ed47@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 27 Oct 2017 14:42:57 +0200
MIME-Version: 1.0
In-Reply-To: <b40f75d4-2280-fc66-b92f-34717b51ed47@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <b76b2832-8e14-43fe-ea9b-23e6bf330bf6@de.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, jjherne@linux.vnet.ibm.com, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>



On 10/27/2017 02:31 PM, Halil Pasic wrote:
>=20
>=20
> On 10/25/2017 08:13 PM, Jason J. Herne wrote:
>> On 10/20/2017 10:54 AM, Christian Borntraeger wrote:
>>> Starting a guest with
>>> =C2=A0=C2=A0=C2=A0 <os>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 <type arch=3D's390x' machine=3D's390-ccw-vir=
tio-2.9'>hvm</type>
>>> =C2=A0=C2=A0 </os>
>>> =C2=A0=C2=A0 <cpu mode=3D'host-model'/>
>>>
>>> on an IBM z14 results in
>>>
>>> "qemu-system-s390x: Some features requested in the CPU model are not
>>> available in the configuration: gs"
>>>
>>> This is because guarded storage is fenced for compat machines that di=
d not have
>>> guarded storage support, but libvirt expands the cpu model according =
to the
>>> latest available machine.
>>>
>>> While this prevents future migration abort (by not starting the guest=
 at all),
>>> not being able to start a "host-model" guest is very much unexpected.=
=C2=A0 As it
>>> turns out, even if we would modify libvirt to not expand the cpu mode=
l to
>>> contain "gs" for compat machines, it cannot guarantee that a migratio=
n will
>>> succeed. For example if the kernel changes its features (or the user =
has
>>> nested=3D1 on one host but not on the other) the migration will fail
>>> nevertheless.=C2=A0 So instead of fencing "gs" for machines <=3D 2.9 =
lets allow it for
>>> all machine types that support the CPU model. This will make "host-mo=
del"
>>> runnable all the time, while relying on the CPU model to reject inval=
id
>>> migration attempts.
>> ...
>>> -=C2=A0=C2=A0=C2=A0 if (gs_allowed()) {
>>> +=C2=A0=C2=A0=C2=A0 if (cpu_model_allowed()) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_vm_ena=
ble_cap(s, KVM_CAP_S390_GS, 0) =3D=3D 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 cap_gs =3D 1;
>=20
>=20
> @Jason
>=20
> Hi Jason,
>=20
> I don't have access to a z14 at the moment, and since you do, I would
> like to try out something.
>=20
> I will first describe my concern, and then the test scenario.
>=20
> The last line above, cap_gs =3D 1, has the side effect of returning
> true ever after.
>=20
> int kvm_s390_get_gs(void)                                              =
        =20
> {                                                                      =
        =20
>     return cap_gs;                                                     =
        =20
> } =20
>=20
> Now considering
> static bool gscb_needed(void *opaque)
> {
>     return kvm_s390_get_gs();
> }

Yes, we should also replace that with

 return s390_has_feat(S390_FEAT_GUARDED_STORAGE)

I can fixup my patch or provide a 2nd one.
