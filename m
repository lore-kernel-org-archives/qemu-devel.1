Received: from eggs.gnu.org ([2001:4830:134:3::10]:33003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1eHc5Z-0003dF-D8
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1eHc5V-0007PK-RL
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:57:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1eHc5V-0007OW-KW
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:57:41 -0500
Date: Wed, 22 Nov 2017 21:57:37 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20171122205736.GA21184@flask>
References: <20171122180908.31389-1-rkrcmar@redhat.com>
	<adada925-d23d-af1c-8965-f18904f5184d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adada925-d23d-af1c-8965-f18904f5184d@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] kvm: apic: save and restore x2APIC LDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

2017-11-22 20:26+0100, Paolo Bonzini:
> On 22/11/2017 19:09, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> > QEMU saves only 8 bits of APIC LDR, which means that it does not supp=
ort
> > x2APIC.  The correct way of fixing this would be to save and restore =
the
> > full 32 bit register, but because x2APIC LDR is a function of x2APIC =
ID,
> > we can also compute it and keep the migration format untouched.
> >=20
> > KVM always expected the LDR format to follow the xAPIC/x2APIC standar=
d,
> > but pre 4.1 KVMs used non-standard x2APIC ID in case the OS changed
> > xAPIC ID before switching to x2APIC, which means that QEMU has to use
> > the kvm_x2apic_api feature to derive the x2APIC ID.
> >=20
> > This bug has also been addressed on the KVM side with patch 5849d75a5=
c9b
> > ("KVM: lapic: Fixup LDR on load in x2apic").
>=20
> > +    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
> > +        kvm_apic_set_reg(kapic, 0xd, kvm_apic_calc_x2apic_ldr(s));
>=20
> Is this correct if the kernel doesn't support the new-style x2APIC API?

Should be: QEMU will use the APIC_ID register in that case, which
contains the x2APIC ID that KVM used to compute the LDR from.

(old-style APIC_ID just cannot store more than 8 bits and isn't tied to
 vcpu_id.)

> In the end, it seems simpler to just fix it in the kernel.

We already have the workaround in KVM, so dropping this one doesn't make
that much of a difference.  I perceive it as solely QEMU bug, though. :)
