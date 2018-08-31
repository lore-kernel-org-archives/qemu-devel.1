Received: from eggs.gnu.org ([2001:4830:134:3::10]:36657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvm77-0007CQ-S7
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvm75-0001UX-0I
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:17:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1fvm74-0001TY-Ir
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:17:34 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-8-git-send-email-Liam.Merwick@oracle.com>
	<ba464589-10b3-d449-3077-74a5eee9ec61@redhat.com>
	<1e99f751-2cc6-7d66-dd57-cbc857a18a4a@oracle.com>
	<1ac8f2ee-6166-020f-38c6-b22f57e76d5b@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <d0b3dc77-eed4-013c-deb6-6dd020815370@oracle.com>
Date: Fri, 31 Aug 2018 17:19:22 +0100
MIME-Version: 1.0
In-Reply-To: <1ac8f2ee-6166-020f-38c6-b22f57e76d5b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/8] io: file descriptor not initialized in
 qio_channel_command_new_spawn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org



On 31/08/18 16:50, Eric Blake wrote:
> On 08/31/2018 10:36 AM, Liam Merwick wrote:
>> On 30/08/2018 17:18, Eric Blake wrote:
>>> On 08/30/2018 10:47 AM, Liam Merwick wrote:
>>>> Incorrect checking of flags could result in uninitialized
>>>> file descriptor being used.
>>>>
>
>>
>> Looking at it again, the very minor optimisation of converting the=20
>> 2nd 'if' to an 'else if' has the useful side-effect of appeasing the=20
>> static analysis tool.
>
> I never figured out what the tool precisely thought was wrong in the=20
> first place. Can you paste the output of the tool to see exactly what=20
> it analyzed as the potential flaw?=C2=A0 Perhaps the analyzer was tryin=
g to=20
> see what would happen if a caller submitting the fourth value (3 on=20
> systems where O_RDONLY is 0, 0 on systems where O_RDONLY is 1) and the=20
> code not behaving in that setup, even though we know that all callers=20
> only submit the three valid values and never the fourth invalid=20
> value?=C2=A0 Or maybe it's a weakness where we have made dependent=20
> assumptions but in independent branches, in such a way that we know it=20
> will never fail but the analyzer doesn't?
>

The specific error it reported was

Error: File Invalid
 =C2=A0=C2=A0 File Descriptor not Initialized [file-desc-not-init]:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The value <unknown> is not initialized as=
 a file descriptor.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at line 91 of io/channel-comm=
and.c in function=20
'qio_channel_command_new_spawn'.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resource=C2=A0 no=
t initialized when flags !=3D 0 at line 62
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 and flags !=3D 1 at line 65
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 and stdinnull is false at line 69
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 and stdoutnull is false at line 69.


I've been staring at the code and can see no reason why it isn't a false=20
positive (and I'll let the tool authors know)

Regards,
Liam

>>
>> --- a/io/channel-command.c
>> +++ b/io/channel-command.c
>> @@ -61,8 +61,7 @@ qio_channel_command_new_spawn(const char *const=20
>> argv[],
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags =3D=3D O_RDONLY) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stdinnull =3D t=
rue;
>> -=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (flags =3D=3D O_WRONLY) {
>> +=C2=A0=C2=A0=C2=A0 } else if (flags =3D=3D O_WRONLY) {
>
> But this sort of change is acceptable, especially if it does shut up=20
> the analyzer, and done with a commit message mentioning that it is not=20
> a semantic change but does make it easier to use the static checker to=20
> find real problems by getting rid of noise.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stdoutnull =3D =
true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Regards,
>> Liam
>>
>
