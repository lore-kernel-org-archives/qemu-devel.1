Received: from eggs.gnu.org ([2001:4830:134:3::10]:40960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1eC1cu-0008Ag-CG
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1eC1co-00051Y-9U
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:01:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39458
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1eC1co-0004yn-4F
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:00:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7Axd6H019359
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 06:00:50 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e3b2ast6r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 06:00:49 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 7 Nov 2017 06:00:49 -0500
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
	<a6b1668e-b646-186b-8036-193100f15d54@redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue, 7 Nov 2017 19:00:33 +0800
MIME-Version: 1.0
In-Reply-To: <a6b1668e-b646-186b-8036-193100f15d54@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7c5f5d15-2275-7493-d311-73c21e1e1924@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>



=E5=9C=A8 2017/9/19 21:04, Eric Blake =E5=86=99=E9=81=93:
> On 09/19/2017 02:43 AM, Christian Borntraeger wrote:
>> From: Jing Liu <liujbjl@linux.vnet.ibm.com>
>>
>> This patch is the s390 implementation of guest crash information, simi=
lar
>> to commit d187e08dc4 ("i386/cpu: add crash-information QOM property") =
and
>> the related commits. We will detect several crash reasons, with the
>> "disabled wait" being the most important one, since this is used by al=
l
>> s390 guests as a "panic like" notification.
>>
>> Demonstrate the these ways with examples as follows.
>>
>> Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> [minor fixes due to upstream feedback]
>> ---
>> V1->V2:
>> 	- rename kvm-s390 to s390 in all places
>> 	- add "loop" to the crash reasons where appropriate
>> 	- use "-" instead of "_" for qapi
>>
>>   qapi/run-state.json | 19 ++++++++++++++++--
>>   target/s390x/cpu.c  | 57 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   target/s390x/cpu.h  |  6 ++++++
>>   target/s390x/kvm.c  | 29 +++++++++++++++++++++------
>>   vl.c                |  6 ++++++
>>   5 files changed, 109 insertions(+), 8 deletions(-)
>>
>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>> index d36ff49..4567510 100644
>> --- a/qapi/run-state.json
>> +
>> +##
>> +# @GuestPanicInformationS390:
>> +#
>> +# S390 specific guest panic information (PSW)
>> +#
>> +# Since: 2.11
>> +##
>> +{'struct': 'GuestPanicInformationS390',
>> + 'data': { 'psw-mask': 'uint64',
>> +           'psw-addr': 'uint64',
>> +           'reason': 'str' } }
> Missing documentation of the three fields; in particular, whether
I didn't get your point, do you mean we need to add comments
for the three fields? But I don't see the comments for Hyper-V either.
Thanks
> 'reason' is for human consumption only (presumably the case) rather tha=
n
> for machine parsing.
yes, the 'reason' is for human understanding and also investigation but=20
psw-*
could be used to parse later.
>
>> +    cpu_synchronize_state(cs);
>> +    panic_info =3D g_malloc0(sizeof(GuestPanicInformation));
>> +
>> +    panic_info->type =3D GUEST_PANIC_INFORMATION_TYPE_S390;
>> +    panic_info->u.s390.psw_mask =3D cpu->env.psw.mask;
>> +    panic_info->u.s390.psw_addr =3D cpu->env.psw.addr;
>> +
>> +    switch (cs->exception_index) {
>> +    case EXCP_CRASH_PGM:
>> +        panic_info->u.s390.reason =3D g_strdup("program interrupt loo=
p");
>> +        break;
>> +    case EXCP_CRASH_EXT:
>> +        panic_info->u.s390.reason =3D g_strdup("external interrupt lo=
op");
>> +        break;
>> +    case EXCP_CRASH_WAITPSW:
>> +        panic_info->u.s390.reason =3D g_strdup("disabled wait");
>> +        break;
>> +    case EXCP_CRASH_OPEREXC:
>> +        panic_info->u.s390.reason =3D g_strdup("operation exception l=
oop");
>> +        break;
>> +    default:
>> +        panic_info->u.s390.reason =3D g_strdup("unknown crash reason"=
);
>> +        break;
> Is it worth a QAPI enum type to expose the reason as one of a finite se=
t
> of known strings, or is that information not needed beyond the
> human-only string that you are setting here?
Actually we had considered to use enum type for 'reason' instead of str,=20
the awkwardness
is that then qemu_system_guest_panicked has to parse the 'reason' before=20
it prints it, but
qemu_system_guest_panicked is a common function and we don't want to do=20
more arch
related handling there.
Thanks!
>

--=20
Regards
QingFeng Hao
