Received: from eggs.gnu.org ([2001:4830:134:3::10]:38473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRHNK-0006Dt-I5
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRHNG-0003cA-15
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:52:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eRHNF-0003bT-OX
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:51:57 -0500
References: <20171218184428.15074-1-danielhb@linux.vnet.ibm.com>
	<20171218184428.15074-2-danielhb@linux.vnet.ibm.com>
	<87efnr81qs.fsf@dusky.pond.sub.org>
	<a4277edc-37f6-8673-1883-b30f793d9d43@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <caa98406-154a-a599-6556-5b6ef13d4d25@redhat.com>
Date: Tue, 19 Dec 2017 06:51:54 -0600
MIME-Version: 1.0
In-Reply-To: <a4277edc-37f6-8673-1883-b30f793d9d43@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qmp: marking qmp_cpu as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

On 12/19/2017 06:19 AM, Daniel Henrique Barboza wrote:

>> Let's compare behavior:
>>
>> 0. Status quo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 do nothing and succeed
>> 1. Your patch=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 fail with GenericError
>> 2. Your patch less error_setg()=C2=A0=C2=A0=C2=A0=C2=A0 do nothing and=
 succeed
>> 3. Immediate removal=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail with CommandNotFound
>>
>> Does the difference between 1. and 3. matter at all?=C2=A0 Or is it ju=
st
>> deprecation cargo cult?
>=20
> Good point. If both the deprecation message and the removal will
> result in error for the user ....
>=20
>>
>> Here's my take on it.=C2=A0 I'd prefer 3. Immediate removal.=C2=A0 I'd=
 also be
>> fine with 2. Your patch less error_setg(), followed by removal after t=
he
>> customary deprecation period.=C2=A0 1. plus later removal just doesn't=
 make
>> sense to me, but it's really no big deal, so if you guys want it...
>=20
> It all goes down to whether we consider qmp_cpu, a QMP command that doe=
s
> nothing since its creation and apparently no one ever used it, a=20
> feature. If it's a
> feature, then I vote for (2) and removal after 2 releases following the=
=20
> regular
> deprecation policy.
>=20
> If we consider that applying the policy to qmp_cpu is more trouble than=
=20
> it's worth,
> I'll gladly resend this patch removing it entirely and rewording the=20
> qemu-doc.texi
> entry to mention that it was removed because it did nothing and it was =
of
> no use for anyone.
>=20

My vote: (3).  No one was using qmp_cpu for anything, while deprecation=20
exists to allow a user a chance to fix their workflow to adjust from one=20
thing that works (but badly) to its replacement that also works (and=20
will be supported long term).  Since our replacement is nothing, we are=20
admitting that no one was relying on the command, and I don't see the=20
point in a deprecation delay. Just nuke it!

qemu-doc.texi doesn't even need to mention the command; the commit=20
message is enough to document our reasons for complete removal.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
