Received: from eggs.gnu.org ([2001:4830:134:3::10]:53880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eHbct-00045M-65
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eHbcq-0007ka-CI
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:28:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eHbcq-0007jy-3Y
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:28:04 -0500
Date: Wed, 22 Nov 2017 18:28:00 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171122202800.GU3037@localhost.localdomain>
References: <20171122180908.31389-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122180908.31389-1-rkrcmar@redhat.com>
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
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Nov 22, 2017 at 07:09:08PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
> QEMU saves only 8 bits of APIC LDR, which means that it does not suppor=
t
> x2APIC.  The correct way of fixing this would be to save and restore th=
e
> full 32 bit register, but because x2APIC LDR is a function of x2APIC ID=
,
> we can also compute it and keep the migration format untouched.
>=20
> KVM always expected the LDR format to follow the xAPIC/x2APIC standard,
> but pre 4.1 KVMs used non-standard x2APIC ID in case the OS changed
> xAPIC ID before switching to x2APIC, which means that QEMU has to use
> the kvm_x2apic_api feature to derive the x2APIC ID.
>=20
> This bug has also been addressed on the KVM side with patch 5849d75a5c9=
b
> ("KVM: lapic: Fixup LDR on load in x2apic").

Is this sufficient to fix the bug on hosts that lack KVM commit
5849d75a5c9b, or we need both the KVM and QEMU patches?

>=20
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reported-by: Yiqian Wei <yiwei@redhat.com>
> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> ---
>  I haven't tested that it actually fixes the bug,
>  https://bugzilla.redhat.com/show_bug.cgi?id=3D1502591.
> =20
>  hw/i386/kvm/apic.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
> index 1df6d26816f9..89df165a04bf 100644
> --- a/hw/i386/kvm/apic.c
> +++ b/hw/i386/kvm/apic.c
> @@ -30,6 +30,13 @@ static inline uint32_t kvm_apic_get_reg(struct kvm_l=
apic_state *kapic,
>      return *((uint32_t *)(kapic->regs + (reg_id << 4)));
>  }
> =20
> +static inline uint32_t kvm_apic_calc_x2apic_ldr(APICCommonState *s)
> +{
> +    uint32_t id =3D kvm_has_x2apic_api() ? s->initial_apic_id : s->id;
> +
> +    return ((id >> 4) << 16) | (1 << (id & 0xf));
> +}
> +
>  static void kvm_put_apic_state(APICCommonState *s, struct kvm_lapic_st=
ate *kapic)
>  {
>      int i;
> @@ -41,7 +48,11 @@ static void kvm_put_apic_state(APICCommonState *s, s=
truct kvm_lapic_state *kapic
>          kvm_apic_set_reg(kapic, 0x2, s->id << 24);
>      }
>      kvm_apic_set_reg(kapic, 0x8, s->tpr);
> -    kvm_apic_set_reg(kapic, 0xd, s->log_dest << 24);
> +    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
> +        kvm_apic_set_reg(kapic, 0xd, kvm_apic_calc_x2apic_ldr(s));
> +    } else {
> +        kvm_apic_set_reg(kapic, 0xd, s->log_dest << 24);
> +    }
>      kvm_apic_set_reg(kapic, 0xe, s->dest_mode << 28 | 0x0fffffff);
>      kvm_apic_set_reg(kapic, 0xf, s->spurious_vec);
>      for (i =3D 0; i < 8; i++) {
> @@ -71,7 +82,11 @@ void kvm_get_apic_state(DeviceState *dev, struct kvm=
_lapic_state *kapic)
>      }
>      s->tpr =3D kvm_apic_get_reg(kapic, 0x8);
>      s->arb_id =3D kvm_apic_get_reg(kapic, 0x9);
> -    s->log_dest =3D kvm_apic_get_reg(kapic, 0xd) >> 24;
> +    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
> +        assert(kvm_apic_get_reg(kapic, 0xd) =3D=3D kvm_apic_calc_x2api=
c_ldr(s));

I assume this assert() won't trigger if the host just lacks the
kernel patch, will it?

What if we're going to migrate to a QEMU version that doesn't
have this patch applied?  Do we want to send the same log_dest
value as old QEMU versions, just in case?  (Those 8 bits QEMU
currently sets at LDR[31:24] seem completely useless, but maybe
it won't hurt to keep them?)


> +    } else {
> +        s->log_dest =3D kvm_apic_get_reg(kapic, 0xd) >> 24;
> +    }
>      s->dest_mode =3D kvm_apic_get_reg(kapic, 0xe) >> 28;
>      s->spurious_vec =3D kvm_apic_get_reg(kapic, 0xf);
>      for (i =3D 0; i < 8; i++) {
> --=20
> 2.14.2
>=20

--=20
Eduardo
