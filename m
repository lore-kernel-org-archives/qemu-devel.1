Received: from eggs.gnu.org ([2001:4830:134:3::10]:54594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fFoTO-0005C8-N2
	for qemu-devel@nongnu.org; Mon, 07 May 2018 18:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fFoTK-0002fR-I1
	for qemu-devel@nongnu.org; Mon, 07 May 2018 18:19:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fFoTK-0002eh-8q
	for qemu-devel@nongnu.org; Mon, 07 May 2018 18:19:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w47MDphv039586
	for <qemu-devel@nongnu.org>; Mon, 7 May 2018 18:19:04 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2htw74w0je-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 18:19:04 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Mon, 7 May 2018 16:19:03 -0600
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<20180507033214.19219-2-zyimin@linux.ibm.com>
	<e4041508-c6ba-5e83-8bd8-50a4bd996009@redhat.com>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Tue, 8 May 2018 06:18:57 +0800
MIME-Version: 1.0
In-Reply-To: <e4041508-c6ba-5e83-8bd8-50a4bd996009@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9cdd19eb-f870-037e-64dc-fc7e9dc71cc3@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] sandbox: avoid to compile options if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: otubo@redhat.com, borntraeger@de.ibm.com, fiuczy@linux.ibm.com, jtomko@redhat.com, jferlan@redhat.com



=E5=9C=A8 2018/5/8 =E4=B8=8A=E5=8D=882:04, Eric Blake =E5=86=99=E9=81=93:
> On 05/06/2018 10:32 PM, Yi Min Zhao wrote:
>
> In the subject line: s/avoid to compile/avoid compiling/
>
>> If CONFIG_SECCOMP is undefined, the option 'elevatorprivileges' remain=
s
>
> s/elevator/elevate/
>
>> complied. This would make libvirt set the corresponding capability and
>
> s/complied/compiled/
Thanks for your correction.
>
>> then trigger the guest startup fails. So let's wrap the options with
>> CONFIG_SECCOMP.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> ---
>> =C2=A0 vl.c | 2 ++
>> =C2=A0 1 file changed, 2 insertions(+)
>>
>> diff --git a/vl.c b/vl.c
>> index fce1fd12d8..cb07b19c02 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -268,6 +268,7 @@ static QemuOptsList qemu_sandbox_opts =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .name =3D "enable",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .type =3D QEMU_OPT_BOOL,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +#ifdef CONFIG_SECCOMP
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .name =3D "obsolete",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .type =3D QEMU_OPT_STRING,
>> @@ -284,6 +285,7 @@ static QemuOptsList qemu_sandbox_opts =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .name =3D "resourcecontrol",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .type =3D QEMU_OPT_STRING,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +#endif
>
> The commit message mentions only 'elevateprivileges' (once the typo is=20
> fixed), but you are also crippling 'obsolete', 'spawn', and=20
> 'resourcecontrol'.=C2=A0 Perhaps the commit message should call that ou=
t=20
> better?=C2=A0 Or, since libvirt is looking at just 'elevateprivileges',=
 per=20
> this line in libvirt's qemu_capabilities.c:
>
> src/qemu/qemu_capabilities.c:=C2=A0=C2=A0=C2=A0 { "sandbox", "elevatepr=
ivileges",=20
> QEMU_CAPS_SECCOMP_BLACKLIST },
>
> is it sufficient to just mask out that one option?
>
The problem is caused by 'elevateprivileges' ostensibly from Libvirt=20
point of view. But in Qemu, CONFIG_SECCOMP controls other options except=20
'enable' in parse_sandbox(). So if SECCOMP is not configured, we don't=20
need other options instead of only elevateprivileges.
