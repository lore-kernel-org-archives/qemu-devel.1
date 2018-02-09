Received: from eggs.gnu.org ([2001:4830:134:3::10]:54695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ek4Du-0000WW-6f
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ek4Dp-00010N-97
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:39:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41418
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ek4Dp-000105-37
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:39:53 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w198dFDv043427
	for <qemu-devel@nongnu.org>; Fri, 9 Feb 2018 03:39:52 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g16tq3n3q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 03:39:51 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 9 Feb 2018 08:39:50 -0000
References: <20180208095752.23960-1-borntraeger@de.ibm.com>
	<f889c2c4-aae1-a7c1-7024-db0ace96b36a@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 9 Feb 2018 09:39:46 +0100
MIME-Version: 1.0
In-Reply-To: <f889c2c4-aae1-a7c1-7024-db0ace96b36a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <1598c244-d2ae-e78d-c0c6-9a575290313b@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>



On 02/08/2018 03:20 PM, Eric Blake wrote:
> On 02/08/2018 03:57 AM, Christian Borntraeger wrote:
>> This patch is the s390 implementation of guest crash information,
>> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
>> property") and the related commits. We will detect several crash
>> reasons, with the "disabled wait" being the most important one, since
>> this is used by all s390 guests as a "panic like" notification.
>>
>=20
>> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>=20
>> +##
>> +# @GuestPanicInformationS390:
>> +#
>> +# S390 specific guest panic information (PSW)
>> +#
>> +# @core: core id of the CPU that crashed
>> +# @psw-mask: control fields of guest PSW
>> +# @psw-addr: guest instruction address
>> +# @reason: guest crash reason in human readable form
>> +#
>> +# Since: 2.12
>> +##
>> +{'struct': 'GuestPanicInformationS390',
>> + 'data': { 'core': 'uint32',
>=20
> Should core be optional,...
>=20
>=20
>> +static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
>> +{
>> +=C2=A0=C2=A0=C2=A0 GuestPanicInformation *panic_info;
>> +=C2=A0=C2=A0=C2=A0 S390CPU *cpu =3D S390_CPU(cs);
>> +
>> +=C2=A0=C2=A0=C2=A0 cpu_synchronize_state(cs);
>> +=C2=A0=C2=A0=C2=A0 panic_info =3D g_malloc0(sizeof(GuestPanicInformat=
ion));
>> +
>> +=C2=A0=C2=A0=C2=A0 panic_info->type =3D GUEST_PANIC_INFORMATION_TYPE_=
S390;
>> +#if !defined(CONFIG_USER_ONLY)
>> +=C2=A0=C2=A0=C2=A0 panic_info->u.s390.core =3D cpu->env.core_id;
>> +#endif
>=20
> ...given that it is only conditionally assigned?=C2=A0 If so, you'd als=
o need to set panic_info->u.s390.has_core when you have a core id to expo=
se.

So after some irc discussion with Daniel and Erik, I plan to add

#else
    panic_info->u.s390.core =3D 0;

for two reasons
- this interface is likely never used for linux-user
- linux-user does not know about CPU numbers, so using 0 is a good defaul=
t

an optional item seems like overkill interface-wise.
