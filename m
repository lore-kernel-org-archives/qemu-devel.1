Received: from eggs.gnu.org ([2001:4830:134:3::10]:56654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duIr9-0008Dy-05
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duIr6-00042T-BY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:46:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50034
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duIr6-00041r-3w
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:46:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JDiQ4D130298
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:46:27 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d313wd07g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:46:26 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 14:46:23 +0100
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-5-pasic@linux.vnet.ibm.com>
	<20170919055005.GE5274@bjsdjshi@linux.vnet.ibm.com>
	<20170919114859.3e2d895b.cohuck@redhat.com>
	<fbb3522e-4086-359a-fca7-05371b76dac7@linux.vnet.ibm.com>
	<20170919125717.1ae0cd38.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 15:46:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170919125717.1ae0cd38.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <0c6660b7-9d81-7ada-7388-cfdaf89e25f3@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] s390x/css: support ccw IDA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 19/09/2017 12:57, Cornelia Huck wrote:
> On Tue, 19 Sep 2017 12:36:33 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>=20
>> On 09/19/2017 11:48 AM, Cornelia Huck wrote:
>>> On Tue, 19 Sep 2017 13:50:05 +0800
>>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>>>   =20
>>>> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-13 13:50:29 +0200]=
:
>>>>  =20
>>>>> Let's add indirect data addressing support for our virtual channel
>>>>> subsystem. This implementation does no bother with any kind of
>>>>> prefetching. We simply step trough the IDAL on demand.
>>>>>
>>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>> ---
>>>>>   hw/s390x/css.c | 109 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++-
>>>>>   1 file changed, 108 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>>>> index 6b0cd8861b..e34b2af4eb 100644
>>>>> --- a/hw/s390x/css.c
>>>>> +++ b/hw/s390x/css.c
>>>>> @@ -819,6 +819,113 @@ incr:
>>>>>       return 0;
>>>>>   }
>>>>>
>>>>> +/* returns values between 1 and bsz, where bs is a power of 2 */
>>>>> +static inline uint16_t ida_continuous_left(hwaddr cda, uint64_t bs=
z)
>>>>> +{
>>>>> +    return bsz - (cda & (bsz - 1));
>>>>> +}
>>>>> +
>>>>> +static inline uint64_t ccw_ida_block_size(uint8_t flags)
>>>>> +{
>>>>> +    return 1ULL << (((flags ^ CDS_F_C64) & (CDS_F_C64 | CDS_F_I2K)=
) ? 11 : 12);
>>>> If CDS_F_C64 is set, (flags ^ CDS_F_C64) will be 0, so (1ULL << 11) =
will
>>>> be the result regardless the I2K flag? The logic seems wrong.
>>
>> No. If CDS_F_C64 is set then the outcome depends on the fact if
>> CDS_F_I2K is set or not.
>> (flags & CDS_F_IK) =3D> ((flags ^ CDS_F_C64) & CDS_F_IK)
>> "(flags ^ CDS_F_C64) will be 0" is wrong. flags ^ CDS_F_C64
>> just flips the CDS_F_C64.
>>
>> OTOH if the CDS_F_C64 was not set we have the corresponding
>> bit set in flags ^ CDS_F_C64 so then the  CDS_F_I2K bit does
>> not matter: we have 1ULL << 11.
>>
>> In my reading the logic is good.
>=20
> So I'll just leave it...
>=20
>>
>>>
>>> I've stared at that condition now for a bit, but all it managed was t=
o
>>> get me more confused... probably just need a break.
>>>   =20
>>>>
>>>> I2K is meaningful only when C64 is 1, otherwise it is ignored. The l=
ogic
>>>> here should be:
>>>> if ((flags & CDS_F_C64) && !(flags & CDS_F_I2K)) {
>>>>      return 1ULL << 12;
>>>> }
>>>>      return 1ULL << 11;
>>>
>>> But I do think your version is more readable... >>>
>>
>> I won't argue with this.

:)

>=20
> ...and we could change that in a patch on top to avoid future confusion.
>=20
>>
>>>>  =20
>>>>> +}
>>>>> +
>>>>> +static inline int ida_read_next_idaw(CcwDataStream *cds)
>>>>> +{
>>>>> +    union {uint64_t fmt2; uint32_t fmt1; } idaw;
>>>>                                             ^
>>>> Nit.
>>>>  =20
>>
>> Maybe checkpatch wanted it this way. My memories are blurry.
>=20
>=20
> I'd just leave it like that, tbh.
>=20
>>
>>>>> +    bool is_fmt2 =3D cds->flags & CDS_F_C64;
>>>>> +    int ret;
>>>>> +    hwaddr idaw_addr;
>>>>> +
>>>>> +    if (is_fmt2) {
>>>>> +        idaw_addr =3D cds->cda_orig + sizeof(idaw.fmt2) * cds->at_=
idaw;
>>>>> +        if (idaw_addr & 0x07) {
>>>>> +            return -EINVAL; /* channel program check */
>>>>> +        }
>>>>> +        ret =3D address_space_rw(&address_space_memory, idaw_addr,
>>>>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &i=
daw.fmt2,
>>>>> +                               sizeof(idaw.fmt2), false);
>>>>> +        cds->cda =3D be64_to_cpu(idaw.fmt2);
>>>>> +    } else {
>>>>> +        idaw_addr =3D cds->cda_orig + sizeof(idaw.fmt1) * cds->at_=
idaw;
>>>>> +        if (idaw_addr & 0x03) {
>>>> ?:
>>>> (idaw_addr & 0x80000003)
>>>
>>> Yes.
>>>   =20
>>
>> I will double check this. Does not seem unreasonable but
>> double-checking is better.
>=20
> Please let me know. I think the architecture says that the bit must be
> zero, and that we may (...) generate a channel program check.
>=20

Right (0x80000003) !=3D0 implies program check .
It is what is done , except for the bit 0 that was forgotten.

>>
>>>>  =20
>>>>> +            return -EINVAL; /* channel program check */
>>>>> +
>>>>> +        }
>>>>> +        ret =3D address_space_rw(&address_space_memory, idaw_addr,
>>>>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &i=
daw.fmt1,
>>>>> +                               sizeof(idaw.fmt1), false);
>>>>> +        cds->cda =3D be64_to_cpu(idaw.fmt1);
>>>>> +    }
>>>>> +    ++(cds->at_idaw);
>>>>> +    if (ret !=3D MEMTX_OK) {
>>>>> +        /* assume inaccessible address */
>>>>> +        return -EINVAL; /* channel program check */
>>>>> +
>>>>> +    }
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int =
len,
>>>>> +                              CcwDataStreamOp op)
>>>>> +{
>>>>> +    uint64_t bsz =3D ccw_ida_block_size(cds->flags);
>>>>> +    int ret =3D 0;
>>>>> +    uint16_t cont_left, iter_len;
>>>>> +
>>>>> +    ret =3D cds_check_len(cds, len);
>>>>> +    if (ret <=3D 0) {
>>>>> +        return ret;
>>>>> +    }
>>>>> +    if (!cds->at_idaw) {
>>>>> +        /* read first idaw */
>>>>> +        ret =3D ida_read_next_idaw(cds);
>>>>> +        if (ret) {
>>>>> +            goto err;
>>>>> +        }
>>>>> +        cont_left =3D ida_continuous_left(cds->cda, bsz);
>>>>> +    } else {
>>>>> +        cont_left =3D ida_continuous_left(cds->cda, bsz);
>>>>> +        if (cont_left =3D=3D bsz) {
>>>>> +            ret =3D ida_read_next_idaw(cds);
>>>>> +            if (ret) {
>>>>> +                goto err;
>>>>> +            }
>>>>> +            if (cds->cda & (bsz - 1)) {
>>>> Could move this check into ida_read_next_idaw?
>>>
>>> I'd like to avoid further code movement...
>>>   =20
>>
>> The first idaw is special. I don't think moving is possible.
>=20
> So, the code is correct and I'll just leave it like that.

hum.
It seems to me that the handling of the first IDAW is indeed a little=20
bit different.
It is accessed directly from the CCW->CDA and generated dedicated status=20
but I do not see the handling.

The channel status must be made pending with primary, secondary and=20
alert status.

I do not find this code, may be it is somewhere before, I searched but=20
did not find it.
Also, I do not find in the documentation that we have a program check=20
for this case.

>=20
>>
>>>>  =20
>>>>> +                ret =3D -EINVAL; /* channel program check */
>>>>> +                goto err;
>>>>> +            }
>>>>> +        }
>>>>> +    }
>>>>> +    do {
>>>>> +        iter_len =3D MIN(len, cont_left);
>>>>> +        if (op !=3D CDS_OP_A) {
>>>>> +            ret =3D address_space_rw(&address_space_memory, cds->c=
da,
>>>>> +                                   MEMTXATTRS_UNSPECIFIED, buff, i=
ter_len, op);
>>>> Ahh, now I recall that explictly defining CDS_OP_R to 0 and CDS_OP_W=
 to
>>>> 1 in 'struct CcwDataStreamOp' do have a meaning. Does it make sense =
to
>>>> make it more obvious by adding some comment there?
>>>
>>> Would you have a good text for that?
>>>   =20
>>
>> I'm fine with clarifications.
>=20
> Let's do it as a patch on top.
>=20
>>
>>>>  =20
>>>>> +            if (ret !=3D MEMTX_OK) {
>>>>> +                /* assume inaccessible address */
>>>>> +                ret =3D -EINVAL; /* channel program check */
>>>>> +                goto err;
>>>>> +            }
>>>>> +        }
>>>>> +        cds->at_byte +=3D iter_len;
>>>>> +        cds->cda +=3D iter_len;
>>>>> +        len -=3D iter_len;
>>>>> +        if (!len) {
>>>>> +            break;
>>>>> +        }
>>>>> +        ret =3D ida_read_next_idaw(cds);
>>>>> +        if (ret) {
>>>>> +            goto err;
>>>>> +        }
>>>>> +        cont_left =3D bsz;
>>>>> +    } while (true);
>>>>> +    return ret;
>>>>> +err:
>>>>> +    cds->flags |=3D CDS_F_STREAM_BROKEN;
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>>   void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB co=
nst *orb)
>>>>>   {
>>>>>       /*
>>>>> @@ -835,7 +942,7 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 =
const *ccw, ORB const *orb)
>>>>>       if (!(cds->flags & CDS_F_IDA)) {
>>>>>           cds->op_handler =3D ccw_dstream_rw_noflags;
>>>>>       } else {
>>>>> -        assert(false);
>>>>> +        cds->op_handler =3D ccw_dstream_rw_ida;
>>>>>       }
>>>>>   }
>>>>>
>>>>> --=20
>>>>> 2.13.5
>>>>>     =20
>>>>
>>>> Generally, the logic looks fine to me.
>>>>  =20
>>>
>>> It did pass Halil's test; but that can only test fmt-2 + 4k blocks, a=
s
>>> this is what the kernel infrastructure provides.
>>
>> Nod.
>>
>>>
>>> Halil, do you have some more comments?
>>>   =20
>>
>> Just a question. Do I have to respin?
>=20
> I don't think so. If you could confirm the check for format-1, I'll
> just fixup that one and get the queued patches out of the door.

generally LGTM but in my opinion the check for format-1 and the handling=20
of the error status for the first IDA for format 1 and 2 must be cleared.


>=20
> We can do more changes on top; it's not like I don't have more patches
> waiting...
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
