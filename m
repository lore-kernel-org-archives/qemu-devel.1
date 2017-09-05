Received: from eggs.gnu.org ([2001:4830:134:3::10]:54020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpMNC-0004pG-67
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpMN6-0001OW-US
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:31:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47506
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpMN6-0001OG-Oy
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:31:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85MSgZv131992
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 18:31:02 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ct32mmvk4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 18:31:02 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 23:31:01 +0100
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-5-pasic@linux.vnet.ibm.com>
	<20170831115535.1e4201d3.cohuck@redhat.com>
	<7540741b-d230-e7c4-50d3-036f31997c8b@linux.vnet.ibm.com>
	<20170905182546.00457332.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 00:30:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170905182546.00457332.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <fe102a7a-e998-8ebe-b94d-e653c4f66c39@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] s390x: refactor error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/05/2017 06:25 PM, Cornelia Huck wrote:
> On Tue, 5 Sep 2017 17:55:17 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>=20
>> On 08/31/2017 11:55 AM, Cornelia Huck wrote:
>>> On Wed, 30 Aug 2017 18:36:04 +0200
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>  =20
>>>> Simplify the error handling of the SSCH and RSCH handler avoiding
>>>> arbitrary and cryptic error codes being mapped to what a subchannel =
is
>>>> supposed to do.  Let the code detecting the condition tell how it's =
to be
>>>> handled in a less ambiguous way.  It's best to handle SSCH and RSCH =
in
>>>> one go as the emulation of the two shares a lot of code. =20
>>>
>>> So determining the return code at the point in time where we can
>>> instead of trying to map to return codes and back again makes quite a
>>> bit of sense, but I'll have to look at the rest of this. =20
>>
>>
>> Looging forward to.
>=20
> Once I manage to find some quiet time for thinking :(

I think it's the best if you ignore the rest until v2.

Since we agreed that cc 3 is not the way to go and that the basic
idea is sane, IMHO it does not make much sense to do a thorough
review of this any more.

Not diverting valuable maintainer resources from my indirect data=20
access patch set is also a point (IDA is something I have to deliver, whi=
le
this is just for fun).
=20
>=20
>>>> -    ret =3D s390_ccw_cmd_request(orb, s, sch->driver_data);
>>>> -    switch (ret) {
>>>> -    /* Currently we don't update control block and just return the =
cc code. */
>>>> -    case 0:
>>>> -        break;
>>>> -    case -EBUSY:
>>>> -        break;
>>>> -    case -ENODEV:
>>>> -        break;
>>>> -    case -EFAULT:
>>>> -         break;
>>>> -    case -EACCES:
>>>> -        /* Let's reflect an inaccessible host device by cc 3. */
>>>> -    default:
>>>> -        /* Let's make all other return codes map to cc 3.  */
>>>> -        ret =3D -ENODEV;
>>>> -    };
>>>> -
>>>> -    return ret;
>>>> +    s390_ccw_cmd_request(sch); =20
>>>
>>> As you change the handling anyway: Don't change this logic in prior
>>> patches? =20
>>
>> I preserve the logic as altered by the previous patches (at least,
>> that is the intention). This is the mapping around part which is going
>> away if we push the handling down.
>=20
> My point is that you touch the code path twice. But we disagreed on the
> original change anyway :)

Nod.

>=20
>>>> -int do_subchannel_work_passthrough(SubchDev *sch)
>>>> +void do_subchannel_work_passthrough(SubchDev *sch)
>>>>  {
>>>> -    int ret;
>>>>      SCSW *s =3D &sch->curr_status.scsw;
>>>>=20
>>>>      if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
>>>>          /* TODO: Clear handling */
>>>>          sch_handle_clear_func(sch);
>>>> -        ret =3D 0;
>>>>      } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
>>>>          /* TODO: Halt handling */
>>>>          sch_handle_halt_func(sch);
>>>> -        ret =3D 0;
>>>>      } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
>>>> -        ret =3D sch_handle_start_func_passthrough(sch);
>>>> +        sch_handle_start_func_passthrough(sch);
>>>>      } else {
>>>>          /* Cannot happen. */
>>>> -        return -ENODEV;
>>>> +        sch->iret.cc =3D 3; =20
>>>
>>> ftcl =3D=3D 0 should have been rejected already by the function handl=
ers
>>> here as well, shouldn't it? =20
>>
>> Which function handlers. Basically the instruction handlers set fctl
>> and call do_subchannel_work to get the indicated work done.
>=20
> Or set. My point is that we can't get here with fctl =3D=3D 0. So an as=
sert
> sounds better to me.
>=20
Yeah, I agree assert is the way to go here.

>=20
>>>> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
>>>> index 5c5fe6b202..d093181a9e 100644
>>>> --- a/include/hw/s390x/css.h
>>>> +++ b/include/hw/s390x/css.h
>>>> @@ -94,13 +94,31 @@ struct SubchDev {
>>>>      /* transport-provided data: */
>>>>      int (*ccw_cb) (SubchDev *, CCW1);
>>>>      void (*disable_cb)(SubchDev *);
>>>> -    int (*do_subchannel_work) (SubchDev *);
>>>> +    void (*do_subchannel_work) (SubchDev *);
>>>>      SenseId id;
>>>>      void *driver_data;
>>>> +    /* io instructions conclude according to iret */
>>>> +    struct {
>>>> +        /*
>>>> +         * General semantic of cc codes of IO instructions is (brie=
f):
>>>> +         * 0 -- produced expected result
>>>> +         * 1 -- produced alternate result
>>>> +         * 2 -- ineffective, because busy with previously initiated=
 function
>>>> +         * 3 -- ineffective, not operational =20
>>>
>>> I'm not sure you can summarize this that way in all cases.
>>>
>>> Also, what does "ineffective" mean? If I get a cc 1 for, say, ssch, I
>>> don't expect something either as the subchannel was already status
>>> pending. =20
>>
>> You are right cc 1 would have been better off with
>>  'produced alternate result or status pending'
>>
>> I've tried to make this shorter (from PoP 14-2):
>> """
>> Condition Code 0: Instruction execution produced
>> the expected or most probable result. (See =E2=80=9CDeferred
>> Condition Code (CC)=E2=80=9D on page 9 for a description of
>> conditions that can be encountered subsequent to
>> the presentation of condition code 0 that result in a
>> nonzero deferred condition code.)
>> Condition Code 1: Instruction execution produced
>> the alternate or second-most-probable result, or sta-
>> tus conditions were present that may or may not have
>> prevented the expected result.
>> Condition Code 2: Instruction execution was inef-
>> fective because the designated subchannel or chan-
>> nel-subsystem facility was busy with a previously
>> initiated function.
>> Condition Code 3: Instruction execution was inef-
>> fective because the designated element was not
>> operational or because some condition precluded ini-
>> tiation of the normal function.
>> """
>>
>> Well ineffective means not-effective ;).
>=20
> Yes :)
>=20
> I think the summary in the PoP is already a bit on the over-generalized
> side, and condensing it further makes it rather ineffective ;) at
> explaining what happens. Frankly, I'd just drop this and rely on
> interested parties referring to the PoP.
>=20

That's what I did in the first place, but then Janosch complained.
I will meditate on this (having some sort of explanation is helpful
and I think cc 0 2 and 3 are actually quite OK).

>>
>>>  =20
>>>> +         */
>>>> +        uint32_t cc:4;
>>>> +        bool pgm_chk:1; =20
>>>
>>> This looks weird?> =20
>>
>> What do you mean? Any suggestions how to do it better?
>=20
> Taking one bit from a bool looks odd. I'd either use a bool normally or
> take one bit from an uint8_t.
>=20

I have to think about this.

>> =20
>>>> +        uint32_t irq_code;
>>>> +    } iret;
>>>>  };
>>>> =20
>>>>  extern const VMStateDescription vmstate_subch_dev; =20
>=20
>> But I guess, I was afraid of somebody blaming me for this
>> comment (such TODOs in production code are a bit strange -- what
>> does it mean: we did not bother to figure it out?).
>=20
> For one, the TODO is preexisting... and we really should remember to
> figure out if there's something better rather than just drop the
> comment.
>=20
> (And I sure hope nobody is using vfio-ccw in production yet...)
>
Since blame says the TODO has been around since 2017-05-17
let me have a critical look at it.

At a first glance I would say addressing exception for SSCH
is not what we want: the only possibility I see for address
exception for SSCH is due to the ORB address. But if that's
the case we will never reach the code in question. So I suppose
we can do better.

Adding Ren. @Ren: Do you agree with my analysis. If you do,
I could come up with a proposal what to do -- after some reading.

Regards,
Halil
