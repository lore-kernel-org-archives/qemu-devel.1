Received: from eggs.gnu.org ([2001:4830:134:3::10]:58342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ej7sh-0001Bf-7v
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ej7se-0005Fr-3Z
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:22:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55968
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ej7sd-0005FU-VL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:22:08 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16IM0KX097866
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 13:22:07 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fye20jrk8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 13:22:06 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Feb 2018 18:21:28 -0000
References: <20180206074622.157812-1-borntraeger@de.ibm.com>
	<4181f0ff-5a2d-bdaa-9e40-ae3cb6f4417c@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Feb 2018 19:21:23 +0100
MIME-Version: 1.0
In-Reply-To: <4181f0ff-5a2d-bdaa-9e40-ae3cb6f4417c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <d28909dd-b7fd-3f35-3bf6-94075e840aca@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/1] s390x/cpu: expose the guest crash
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>



On 02/06/2018 04:31 PM, Eric Blake wrote:
> On 02/06/2018 01:46 AM, Christian Borntraeger wrote:
>> This patch is the s390 implementation of guest crash information,
>> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
>> property") and the related commits. We will detect several crash
>> reasons, with the "disabled wait" being the most important one, since
>> this is used by all s390 guests as a "panic like" notification.
>>
>=20
>>
>> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>> =C2=A0 qapi/run-state.json=C2=A0=C2=A0 | 27 ++++++++++++++++++++++--
>> =C2=A0 target/s390x/cpu.c=C2=A0=C2=A0=C2=A0 | 57 +++++++++++++++++++++=
++++++++++++++++++++++++++++++
>> =C2=A0 target/s390x/cpu.h=C2=A0=C2=A0=C2=A0 | 11 ++++++++++
>> =C2=A0 target/s390x/helper.c |=C2=A0 5 ++++-
>> =C2=A0 target/s390x/kvm.c=C2=A0=C2=A0=C2=A0 | 15 +++++++-------
>> =C2=A0 vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
>> =C2=A0 6 files changed, 110 insertions(+), 11 deletions(-)
>>
>=20
>>
>> =C2=A0##
>> =C2=A0# @GuestPanicInformation:
>> =C2=A0#
>> =C2=A0# Information about a guest panic
>> =C2=A0#
>> +# @type: Crash type that defines the hypervisor specific information
>> +#
>> =C2=A0# Since: 2.9
>> =C2=A0##
>> =C2=A0{'union': 'GuestPanicInformation',
>> =C2=A0 'base': {'type': 'GuestPanicInformationType'},
>> =C2=A0 'discriminator': 'type',
>> - 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
>> + 'data': { 'hyper-v': 'GuestPanicInformationHyperV',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 's390': =
'GuestPanicInformationS390' } }
>> =C2=A0
>=20
> The qapi type has only integers (that the caller will presumably know h=
ow to decode if it cares) and a human readable string.=C2=A0 Meanwhile,...
>=20
>>
>> +/* Crash cases. */
>> +enum crash_reasons {
>=20
> Doesn't seem to match our usual coding conventions of CamelCase for nam=
es in the enum/struct/union namespace.

yes, needs fixing
>=20
>> +=C2=A0=C2=A0=C2=A0 CRASH_REASON_UNKNOWN,=C2=A0 /* default value of 0 =
on reset */
>> +=C2=A0=C2=A0=C2=A0 CRASH_REASON_PGM,
>> +=C2=A0=C2=A0=C2=A0 CRASH_REASON_EXT,
>> +=C2=A0=C2=A0=C2=A0 CRASH_REASON_WAITPSW,
>> +=C2=A0=C2=A0=C2=A0 CRASH_REASON_OPEREXC,
>=20
> ...you have an internal enum for decoding some of those integer values =
into specific human readable strings, but don't expose the enum over QAPI=
.=C2=A0 Are we sure that's the interface we want to go with?=C2=A0 As lon=
g as you are okay with that, then I can live with the interface change; I=
 just want to make sure that you are certain that the machine-based consu=
mer of the QMP command does not need to decode crash_reasons because you =
left it as an internal enum.

We might want to have temporary or intermediate crash reasons (e.g. emula=
tion failure or whatever),=20
so not requiring changes in both components might be less error prone. (t=
he way it is today)
But if there is a strong wish for an on-the-wire enum, we could do that a=
s well.
>=20
>> +
>> +static void s390_cpu_get_crash_info_qom(Object *obj, Visitor *v,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const char *name, void *opaque,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>=20
> Indentation is off.

I blame Conny who requested an s/s390x/s390/ change :-p
