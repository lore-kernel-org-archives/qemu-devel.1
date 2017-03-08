Received: from eggs.gnu.org ([2001:4830:134:3::10]:48880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1clZqh-0000oo-L1
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1clZqd-0006cQ-K6
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:33:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1clZqd-0006c6-CG
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:33:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v28BT7dC068200
	for <qemu-devel@nongnu.org>; Wed, 8 Mar 2017 06:33:37 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 292h0jrgdd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 06:33:37 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 8 Mar 2017 11:33:33 -0000
References: <20170307025328.53409-1-haoqf@linux.vnet.ibm.com>
	<20170307025328.53409-2-haoqf@linux.vnet.ibm.com>
	<20170307092951.GA5871@noname.str.redhat.com>
	<80495689-674c-5dde-ae49-d80a2eb20372@linux.vnet.ibm.com>
	<20170307100525.GD5871@noname.str.redhat.com>
	<cbd5b0ac-4cae-6f5b-2583-a6e32eb65f38@linux.vnet.ibm.com>
	<a0013bf9-4e53-7a38-3249-b7267ae33307@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 8 Mar 2017 12:33:28 +0100
MIME-Version: 1.0
In-Reply-To: <a0013bf9-4e53-7a38-3249-b7267ae33307@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <6c0b3128-37e6-8607-abab-4f655cd91426@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] vmstate: draft fix for failed
 iotests case 68 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, liujbjl@linux.vnet.ibm.com, qemu-devel@nongnu.org, mreitz@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, dgilbert@redhat.com



On 03/08/2017 08:05 AM, QingFeng Hao wrote:
>=20
>=20
> =E5=9C=A8 2017/3/7 18:19, Halil Pasic =E5=86=99=E9=81=93:
>>
>> On 03/07/2017 11:05 AM, Kevin Wolf wrote:
>>> Am 07.03.2017 um 10:54 hat Halil Pasic geschrieben:
>>>>
>>>> On 03/07/2017 10:29 AM, Kevin Wolf wrote:
>>>>> Am 07.03.2017 um 03:53 hat QingFeng Hao geschrieben:
>>>>>> I am not very clear about the logic in vmstate.c, but from its con=
text in
>>>>>> vmstate_save_state, it seems size should not be 0, otherwise the f=
ollowed
>>>>>> for loop will keep working on the same element. So I just add a si=
mple
>>>>>> check to pass that case, not sure if it's right but it can pass io=
test
>>>>>> case 68 and 91 now.
>>>>>>
>>>>>> The iotest's failed output is:
>>>>>> 068 1s ... - output mismatch (see 068.out.bad)
>>>>>> --- /home/haoqf/KVMonz/gitcheck/work/qemu-master/tree/qemu/tests/q=
emu-iotests/068.out   2017-03-06 05:52:24.817328899 +0100
>>>>>> +++ 068.out.bad 2017-03-07 03:28:44.426714519 +0100
>>>>>> @@ -3,9 +3,13 @@
>>>>>>   =3D=3D=3D Saving and reloading a VM state to/from a qcow2 image =
=3D=3D=3D
>>>>>>
>>>>>>   Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072
>>>>>> +qemu-system-s390x: migration/vmstate.c:336: vmstate_save_state: A=
ssertion `first_elem || !n_elems' failed.
>>>>>> +./common.config: line 109: 52497 Aborted                 ( if [ -=
n "${QEMU_NEED_PID}" ]; then
>>>>>> +    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
>>>>>> +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
>>>>>>
>>>>>>
>>>>>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>   migration/vmstate.c | 8 ++++++++
>>>>>>   1 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>>>>>> index 78b3cd4..ff28dde 100644
>>>>>> --- a/migration/vmstate.c
>>>>>> +++ b/migration/vmstate.c
>>>>>> @@ -106,6 +106,10 @@ int vmstate_load_state(QEMUFile *f, const VMS=
tateDescription *vmsd,
>>>>>>               int i, n_elems =3D vmstate_n_elems(opaque, field);
>>>>>>               int size =3D vmstate_size(opaque, field);
>>>>>>   +            if (size =3D=3D 0) {
>>>>>> +                field++;
>>>>>> +                continue;
>>>>>> +            }
>>>>>>               vmstate_handle_alloc(first_elem, field, opaque);
>>>>>>               if (field->flags & VMS_POINTER) {
>>>>>>                   first_elem =3D *(void **)first_elem;
>>>>>> @@ -322,6 +326,10 @@ void vmstate_save_state(QEMUFile *f, const VM=
StateDescription *vmsd,
>>>>>>               int64_t old_offset, written_bytes;
>>>>>>               QJSON *vmdesc_loop =3D vmdesc;
>>>>>>   +            if (size =3D=3D 0) {
>>>>>> +                field++;
>>>>>> +                continue;
>>>>>> +            }
>>>>>>               trace_vmstate_save_state_loop(vmsd->name, field->nam=
e, n_elems);
>>>>>>               if (field->flags & VMS_POINTER) {
>>>>>>                   first_elem =3D *(void **)first_elem;
>>>>> This is really a live migration fix, so I'm adding Juan and Dave to=
 CC.
>>>> You are right, this is migration stuff and has very little to do wit=
h
>>>> qemu-block.
>>>>> I suspect the real question is why a field with size 0 was even sto=
red
>>>>> in the vmstate to begin with.
>>>>>
>>>> I have looked onto the issue. It affects s390x only if we
>>>> are running without KVM. Basically, S390CPU.irqstate is unused
>>>> if we do not use KVM, and thus no buffer is allocated.
>>>>
>>>> IMHO this is a missing field and the cleaner way to handle such
>>>> missing fields is exist. However this used to work, and I recommende=
d
>>>> QuiFeng Hao to discuss the problem upstream.
>>>>
>>>> By the way, I think, if we want to go back to the old behavior
>>>> and support VMS_VBUFFER with size 0 and nullptr, a much
>>>> cleaner way to do the fix is to change the assert to:
>>>>
>>>> assert(first_elem  || !n_elems || !size)
>>>>
>>>> Obviously the other clean way to fix is to implement exists.
>>> If you're right that this specific vmstate was valid in earlier
>>> versions, then I think it's clear that we need to make it work again.
>>> Otherwise we're breaking migration from old versions.
>> Not really. We would not break migration because nothing was written t=
o
>> the stream for VMS_VBUFFER of size 0 except the vmdesc which is at the=
 end,
>> 'debug only', and does not affect migration compatibility.
>>
>> IMHO it is an API question. I would have said, there is no data, there=
fore
>> there is no field if it's from scratch. But with prior history, I agre=
e
>> with Dave, we should restore old behavior -- which was changed uninten=
tionally
>> because I made a wrong assumption.
> Halil,
> Unfortunately, another assert failed after I change the code as below i=
n
> vmstate_save_state and vmstate_load_state:
> assert(first_elem  || !n_elems || !size);
>=20
> The error is:
> +qemu-system-s390x: migration/vmstate.c:341: vmstate_save_state: Assert=
ion `field->flags & VMS_ARRAY_OF_POINTER' failed.
> It's the code as below:
>  if (!curr_elem) {

Sorry, I failed to mention this yesterday. You should also do

-                 if (!curr_elem) {
+                 if (!curr_elem && size) {




>                     /* if null pointer write placeholder and do not fol=
low      */
>                   assert(field->flags & VMS_ARRAY_OF_POINTER);
> After debug, I found that the assert failure was still of irqstate and =
its field flags is 0x102(VMS_VBUFFER | VMS_POINTER),
> while VMS_ARRAY_OF_POINTER is 0x040. The flags's value matches Dave's f=
ormer assumption
> on machine.c although machine.c wasn't compiled, which also confuses me.
>=20
> Then I commented out that assert(field->flags & VMS_ARRAY_OF_POINTER) a=
nd the case 68 & 91
> can both work!

Yeah but that would break migration compatibility for write by=20
writing a nullptr-marker character into the stream.

>=20
> The question is: can we do that change and what the second assert of fi=
eld's flags is used for?

The assert is there to guard against unintended use of this nullptr-marke=
r
mechanism.

I have tested so this should work. By the way a vmstate test covering thi=
s
corner-case would be a good idea too (IMHO). Would you like to write one?

Regards,
Halil

> Thanks!
>> Regards,
>> Halil
>=20
