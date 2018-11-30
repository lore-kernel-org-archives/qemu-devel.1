Received: from eggs.gnu.org ([2001:4830:134:3::10]:47716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gShNK-0004PE-De
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gShNF-0005Fp-Rd
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:54:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gShNF-0005FP-II
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:54:21 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAUBs4UD117580
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 06:54:20 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p33vwjbjm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 06:54:20 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 30 Nov 2018 11:54:18 -0000
Reply-To: pmorel@linux.ibm.com
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-7-git-send-email-pmorel@linux.ibm.com>
	<555d039d-16ef-f279-fd48-f0d422f7905a@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 30 Nov 2018 12:54:11 +0100
MIME-Version: 1.0
In-Reply-To: <555d039d-16ef-f279-fd48-f0d422f7905a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <db7c028e-387b-246a-378e-f2e1ae99f924@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] s390x/vfio: ap: Implementing AP
 Queue Interrupt Control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, pasic@linux.ibm.com

On 29/11/2018 22:53, Tony Krowiak wrote:
> On 11/22/18 11:35 AM, Pierre Morel wrote:
>> We intercept the PQAP(AQIC) instruction and transform

...

>> +static int ap_pqap_aqic(CPUS390XState *env)
>> +{
>> +=C2=A0=C2=A0=C2=A0 uint64_t g_nib =3D env->regs[2];
>> +=C2=A0=C2=A0=C2=A0 uint8_t apid =3D ap_reg_get_apid(env->regs[0]);
>> +=C2=A0=C2=A0=C2=A0 uint8_t apqi =3D ap_reg_get_apqi(env->regs[0]);
>> +=C2=A0=C2=A0=C2=A0 uint32_t retval;
>> +=C2=A0=C2=A0=C2=A0 APDevice *ap =3D s390_get_ap();
>=20
> To be consistent with the naming convention in the rest of
> this file, can you name this variable 'apdev'?

OK

>=20
>> +=C2=A0=C2=A0=C2=A0 VFIODevice *vdev;
>> +=C2=A0=C2=A0=C2=A0 VFIOAPDevice *ap_vdev;
>=20
> To be consistent with the naming convention in the rest of
> this file, can you name this variable 'vapdev'?
>=20
>> +=C2=A0=C2=A0=C2=A0 APQueue *apq;
>> +
>> +=C2=A0=C2=A0=C2=A0 ap_vdev =3D DO_UPCAST(VFIOAPDevice, apdev, ap);
>=20
> Where is 'apdev' defined/initialized?

It is part of the VFIOAPDevice structure

>=20
>> +=C2=A0=C2=A0=C2=A0 vdev =3D &ap_vdev->vdev;
>> +=C2=A0=C2=A0=C2=A0 apq =3D &ap->card[apid].queue[apqi];
>> +=C2=A0=C2=A0=C2=A0 apq->isc =3D ap_reg_get_isc(env->regs[1]);
>> +=C2=A0=C2=A0=C2=A0 apq->apqn =3D (apid << 8) | apqi;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ap_reg_get_ir(env->regs[1])) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retval =3D ap_pqap_set_irq=
(vdev, apq, g_nib);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retval =3D ap_pqap_clear_i=
rq(vdev, apq);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 env->regs[1] =3D retval;
>> +=C2=A0=C2=A0=C2=A0 if (retval & AP_STATUS_RC_MASK) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 3;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +/*
>> + * ap_pqap
>> + * @env: environment pointing to registers
>> + * return value: Code Condition
>> + */
>> +int ap_pqap(CPUS390XState *env)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int cc =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (ap_reg_get_fc(env->regs[0])) {
>> +=C2=A0=C2=A0=C2=A0 case AQIC:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s390_has_feat(S390_FE=
AT_AP_QUEUE_INTERRUPT_CONTROL)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -PGM_OPERATION;
>=20
> Shouldn't this be PGM_SPECIFICATION?

Before the patch, when PQAP is not intercepted we sent PGM_OPERATION.
I think we should continue doing the same as before if the feature is=20
not activated.


>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

...snip...


>> +typedef struct APQueue {
>> +=C2=A0=C2=A0=C2=A0 AdapterRoutes routes;
>> +=C2=A0=C2=A0=C2=A0 IndAddr *nib;
>> +=C2=A0=C2=A0=C2=A0 uint16_t apqn;
>> +=C2=A0=C2=A0=C2=A0 uint8_t isc;
>> +} APQueue;
>> +
>> +typedef struct APCard {
>> +=C2=A0=C2=A0=C2=A0 APQueue queue[MAX_AP_DOMAIN];
>=20
> This seems to be an unnecessary allocation of memory, particularly
> if there is only a few queues. I understand this
> maps to the concept of a matrix and makes for quick retrieval of
> an APQueue, but I think it would be more efficient to use something
> like a GTree, or a GHashTable both of which would save you space and
> allow for fairly quick retrieval.


OK.
We can optimize this later.

...

>> +/* Register 1 as input hold the AQIC information */
>> +static inline uint32_t ap_reg_set_status(uint8_t status)
>=20
> This function does not set anything, but returns an APQSW.
> Maybe it should be named ap_reg_get_status_word or ap_reg_get_apqsw
> or ap_reg_get_status.

All these operations are "get" when retrieving informations from=20
registers and "set" when setting information inside registers.


>=20
...snip...
>> =C2=A0 }
>> +static int kvm_ap_pqap(S390CPU *cpu, uint16_t ipbh0)
>> +{
>> +=C2=A0=C2=A0=C2=A0 CPUS390XState *env =3D &cpu->env;
>> +=C2=A0=C2=A0=C2=A0 int r;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (env->psw.mask & PSW_MASK_PSTATE) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_s390_program_interrupt=
(cpu, PGM_PRIVILEGED);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (env->regs[0] & AP_AQIC_ZERO_BITS) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_s390_program_interrupt=
(cpu, PGM_SPECIFICATION);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> This check does not belong here; for example, if the PQAP(TAPQ)
> instruction is intercepted and the T bit (bit 40) is set, a
> specification exception would be erroneously recognized. This check
> should be done in the ap_pqap_aqic() function.

Right, I will move the test.


Regards,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
