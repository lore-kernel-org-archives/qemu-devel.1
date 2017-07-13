Received: from eggs.gnu.org ([2001:4830:134:3::10]:53826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVZBh-0000b1-Vs
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVZBe-0002mN-PI
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:09:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVZBe-0002l1-JJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:09:26 -0400
References: <201707131053572555365@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa3f5e1f-4c59-9745-cdb5-54ca6d40d330@redhat.com>
Date: Thu, 13 Jul 2017 10:09:21 +0200
MIME-Version: 1.0
In-Reply-To: <201707131053572555365@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogW1BBVENIXSB0YXJnZXQtaTM4?=
 =?utf-8?q?6=3Akvm=5Fget/put=5Fvcpu=5Fevents_don=27t_handlesipi=5Fvector?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peng.hao2@zte.com.cn
Cc: rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org, jan.kiszka@siemens.com

On 13/07/2017 04:53, peng.hao2@zte.com.cn wrote:
> > I think what you're seeing is a race like this:
> >=20
> >     VCPU 0                           VCPU 1
> >     [qemu] kvm_get_mp_state
> >       [kvm] kvm_apic_accept_events
> >                                     __apic_accept_irq
> >                                     set KVM_APIC_SIPI
> >     [qemu] kvm_get_vcpu_events
>
> I suspect that sipi_vector is lost when hotplug cpu in some time.
>=20
> VCPU0                               VCPU1 (hotplug)
> [kvm] apic_send_ipi
>   [kvm] __apic_accept_irq
>     [kvm] set vcpu1.sipi_vector     =20
>     [kvm] set KVM_APIC_SIPI
> [kvm] wakeup vcpu1 thread           [qemu] kvm_put_vcpu_events
>                                        [kvm] set vcpu1.sipi_vector=3D0
>                                        [kvm] kvm_apic_accept_events
>                                        [kvm] kvm_vcpu_deliver_sipi_vect=
or(sipi_vector=3D0)

So I suggest the following changes in QEMU:

- reorder kvm_get_vcpu_events, then kvm_get_mp_state, then the others.
This is just to be safe and ensure that a KVM_APIC_SIPI event is not lost=
.

- don't set KVM_VCPUEVENT_VALID_SIPI_VECTOR unless the mp_state is
KVM_MP_STATE_SIPI_RECEIVED (which will only happen for old kernels).

- call kvm_put_mp_state after kvm_put_vcpu_events, so that KVM_APIC_SIPI
is only set after the sipi_vector is in place.

Thanks,

Paolo
