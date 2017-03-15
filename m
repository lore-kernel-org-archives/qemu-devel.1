Received: from eggs.gnu.org ([2001:4830:134:3::10]:43544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cnxdp-0005Pm-Rp
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cnxdm-0006BR-MC
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:22:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cnxdm-0006An-Bd
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:22:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2F1Dp4g086117
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 21:22:11 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 296ng0qjtq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 21:22:10 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 14 Mar 2017 21:22:09 -0400
References: <20170310044402.38880-1-haoqf@linux.vnet.ibm.com>
	<20170310044402.38880-2-haoqf@linux.vnet.ibm.com>
	<20170314141356.GK2445@work-vm>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Wed, 15 Mar 2017 09:21:57 +0800
MIME-Version: 1.0
In-Reply-To: <20170314141356.GK2445@work-vm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <cdc32993-366f-5fe4-43ac-4da21f10377f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] vmstate: fix failed iotests case 68
 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, quintela@redhat.com



=E5=9C=A8 2017/3/14 22:13, Dr. David Alan Gilbert =E5=86=99=E9=81=93:
> * QingFeng Hao (haoqf@linux.vnet.ibm.com) wrote:
>> This problem affects s390x only if we are running without KVM.
>> Basically, S390CPU.irqstate is unused if we do not use KVM,
>> and thus no buffer is allocated.
>> This causes size=3D0, first_elem=3DNULL and n_elems=3D1 in
>> vmstate_load_state and vmstate_save_state. And the assert fails.
>> With this fix we can go back to the old behavior and support
>> VMS_VBUFFER with size 0 and nullptr.
>>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Thanks, and fixes problem with vmxnet3 migration.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Thank you, Dave!
>
> Dave
>
>> ---
>>   migration/vmstate.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index 78b3cd4..7b4a607 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -109,7 +109,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateD=
escription *vmsd,
>>               vmstate_handle_alloc(first_elem, field, opaque);
>>               if (field->flags & VMS_POINTER) {
>>                   first_elem =3D *(void **)first_elem;
>> -                assert(first_elem  || !n_elems);
>> +                assert(first_elem || !n_elems || !size);
>>               }
>>               for (i =3D 0; i < n_elems; i++) {
>>                   void *curr_elem =3D first_elem + size * i;
>> @@ -117,7 +117,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateD=
escription *vmsd,
>>                   if (field->flags & VMS_ARRAY_OF_POINTER) {
>>                       curr_elem =3D *(void **)curr_elem;
>>                   }
>> -                if (!curr_elem) {
>> +                if (!curr_elem && size) {
>>                       /* if null pointer check placeholder and do not =
follow */
>>                       assert(field->flags & VMS_ARRAY_OF_POINTER);
>>                       ret =3D vmstate_info_nullptr.get(f, curr_elem, s=
ize, NULL);
>> @@ -325,7 +325,7 @@ void vmstate_save_state(QEMUFile *f, const VMState=
Description *vmsd,
>>               trace_vmstate_save_state_loop(vmsd->name, field->name, n=
_elems);
>>               if (field->flags & VMS_POINTER) {
>>                   first_elem =3D *(void **)first_elem;
>> -                assert(first_elem  || !n_elems);
>> +                assert(first_elem || !n_elems || !size);
>>               }
>>               for (i =3D 0; i < n_elems; i++) {
>>                   void *curr_elem =3D first_elem + size * i;
>> @@ -336,7 +336,7 @@ void vmstate_save_state(QEMUFile *f, const VMState=
Description *vmsd,
>>                       assert(curr_elem);
>>                       curr_elem =3D *(void **)curr_elem;
>>                   }
>> -                if (!curr_elem) {
>> +                if (!curr_elem && size) {
>>                       /* if null pointer write placeholder and do not =
follow */
>>                       assert(field->flags & VMS_ARRAY_OF_POINTER);
>>                       vmstate_info_nullptr.put(f, curr_elem, size, NUL=
L, NULL);
>> --=20
>> 1.8.3.1
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

--=20
Regards
QingFeng Hao
