Received: from eggs.gnu.org ([2001:4830:134:3::10]:40333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLuLu-0005s5-Ne
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLuLr-0008Ep-Eh
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:16:22 -0500
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-2-david@redhat.com>
	<20171204180349.379dd02e.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <10941b30-4fa9-37e6-7d25-f3423282f5b0@redhat.com>
Date: Mon, 4 Dec 2017 18:16:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171204180349.379dd02e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 1/5] s390x/kvm: factor out
 build_channel_report_mcic() into cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 04.12.2017 18:03, Cornelia Huck wrote:
> On Mon,  4 Dec 2017 13:55:01 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> We'll need it later on in two places. Refactor it to just indicate the
>> valid bit. While at it, introduce a define for the used CR14 bit (we'l=
l
>=20
> s/valid bit/validity bits/

In the PoP they are defined as "validity" (e.g. 11-15)

Vector-register validity (VR)
External-damage-code validity (EC)
Floating-point-register validity (FP)
General-register validity (GR)
Control-register validity (CR)

So I am not sure if using a slightly different terminology here helps.

>=20
>> also need later on).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/cpu.h | 20 ++++++++++++++++++++
>>  target/s390x/kvm.c | 25 ++-----------------------
>>  2 files changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 9cfbbbac04..4d3e7920f5 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -351,6 +351,9 @@ extern const struct VMStateDescription vmstate_s39=
0_cpu;
>>  #define CR0_CPU_TIMER_SC        0x0000000000000400ULL
>>  #define CR0_SERVICE_SC          0x0000000000000200ULL
>> =20
>> +/* Control register 14 bits */
>> +#define CR14_CHANNEL_REPORT_SC  0x0000000010000000ULL
>> +
>>  /* MMU */
>>  #define MMU_PRIMARY_IDX         0
>>  #define MMU_SECONDARY_IDX       1
>> @@ -674,6 +677,23 @@ struct sysib_322 {
>>  #define MCIC_VB_CT 0x0000000000020000ULL
>>  #define MCIC_VB_CC 0x0000000000010000ULL
>> =20
>> +static inline uint64_t s390_build_validity_mcic(void)
>> +{
>> +    uint64_t mcic;
>> +
>> +    /* indicate all valid bits (no damage) */
>=20
> s/valid/validity/

dito

>=20
>> +    mcic =3D MCIC_VB_WP | MCIC_VB_MS | MCIC_VB_PM | MCIC_VB_IA | MCIC=
_VB_FP |
>> +           MCIC_VB_GR | MCIC_VB_CR | MCIC_VB_ST | MCIC_VB_AR | MCIC_V=
B_PR |
>> +           MCIC_VB_FC | MCIC_VB_CT | MCIC_VB_CC;
>> +    if (s390_has_feat(S390_FEAT_VECTOR)) {
>> +        mcic |=3D MCIC_VB_VR;
>> +    }
>> +    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
>> +        mcic |=3D MCIC_VB_GS;
>> +    }
>> +    return mcic;
>> +}
>> +
>=20
> Not sure why this should go into cpu.h - isn't there a better header
> for it?

internal.h maybe, but we also have the MCIC_* defines in cpu.h (esp.
direct above this function :) ). So I guess this is best kept here.
Opinions?

>=20
>> =20
>>  /* cpu.c */
>>  int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 97c45d5537..9b8b59f2a2 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -1852,33 +1852,12 @@ void kvm_s390_io_interrupt(uint16_t subchannel=
_id,
>>      kvm_s390_floating_interrupt(&irq);
>>  }
>> =20
>> -static uint64_t build_channel_report_mcic(void)
>> -{
>> -    uint64_t mcic;
>> -
>> -    /* subclass: indicate channel report pending */
>> -    mcic =3D MCIC_SC_CP |
>> -    /* subclass modifiers: none */
>> -    /* storage errors: none */
>=20
> I find these additional comments quite useful - can they be preserved
> in any way?

With the new abstraction ("validity" only) / function name most of them
don't make sense anymore (esp. to be handled by the caller) in the
context of this function. All other bits would be special for other
machine check types we want to inject.

>=20
>> -    /* validity bits: no damage */
>> -        MCIC_VB_WP | MCIC_VB_MS | MCIC_VB_PM | MCIC_VB_IA | MCIC_VB_F=
P |
>> -        MCIC_VB_GR | MCIC_VB_CR | MCIC_VB_ST | MCIC_VB_AR | MCIC_VB_P=
R |
>> -        MCIC_VB_FC | MCIC_VB_CT | MCIC_VB_CC;
>> -    if (s390_has_feat(S390_FEAT_VECTOR)) {
>> -        mcic |=3D MCIC_VB_VR;
>> -    }
>> -    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
>> -        mcic |=3D MCIC_VB_GS;
>> -    }
>> -    return mcic;
>> -}



--=20

Thanks,

David / dhildenb
