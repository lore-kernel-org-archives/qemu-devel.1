Received: from eggs.gnu.org ([2001:4830:134:3::10]:44526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvmXw-0003Ix-Bf
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvmXr-0001Xy-IZ
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:45:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55300 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvmXp-0001Wt-It
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:45:13 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-8-git-send-email-Liam.Merwick@oracle.com>
	<ba464589-10b3-d449-3077-74a5eee9ec61@redhat.com>
	<1e99f751-2cc6-7d66-dd57-cbc857a18a4a@oracle.com>
	<1ac8f2ee-6166-020f-38c6-b22f57e76d5b@redhat.com>
	<d0b3dc77-eed4-013c-deb6-6dd020815370@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63e64181-a596-f440-3f46-5c09014627ee@redhat.com>
Date: Fri, 31 Aug 2018 11:45:10 -0500
MIME-Version: 1.0
In-Reply-To: <d0b3dc77-eed4-013c-deb6-6dd020815370@oracle.com>
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
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org

On 08/31/2018 11:19 AM, Liam Merwick wrote:

>>> Looking at it again, the very minor optimisation of converting the=20
>>> 2nd 'if' to an 'else if' has the useful side-effect of appeasing the=20
>>> static analysis tool.
>>
>> I never figured out what the tool precisely thought was wrong in the=20
>> first place. Can you paste the output of the tool to see exactly what=20
>> it analyzed as the potential flaw?

Thanks.

>>=C2=A0 Perhaps the analyzer was trying to=20
>> see what would happen if a caller submitting the fourth value (3 on=20
>> systems where O_RDONLY is 0, 0 on systems where O_RDONLY is 1) and the=
=20
>> code not behaving in that setup, even though we know that all callers=20
>> only submit the three valid values and never the fourth invalid=20
>> value?=C2=A0 Or maybe it's a weakness where we have made dependent=20
>> assumptions but in independent branches, in such a way that we know it=
=20
>> will never fail but the analyzer doesn't?
>>
>=20
> The specific error it reported was
>=20
> Error: File Invalid
>  =C2=A0=C2=A0 File Descriptor not Initialized [file-desc-not-init]:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The value <unknown> is not initialized =
as a file descriptor.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at line 91 of io/channel-co=
mmand.c in function=20
> 'qio_channel_command_new_spawn'.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resource=C2=A0 =
not initialized when flags !=3D 0 at line 62

flags is not O_RDONLY,

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 and flags !=3D 1 at line 65

flags is not O_WRONLY,

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 and stdinnull is false at line 69
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 and stdoutnull is false at line 69.

so yes, both stdinnull and stdoutnull will be false at this point.=20
Based on our earlier masking, that means flags is either O_RDWR (2) or=20
bogus (3).  The analyzer is then complaining about:

         dup2(stdinnull ? devnull : stdinfd[0], STDIN_FILENO);

So either it is complaining about devnull being uninitialized (which it=20
is when flags is O_RDWR - but in that situation, we know stdinnull is=20
false which also implies that the left half of ?: is unreachable and=20
therefore shouldn't matter) or it is complaining about stdinfd[0] being=20
uninitialized (but we can't reach here without having gone through the=20
earlier (!stdinnull && pipe(stdinfd)), and again, given that stdinnull=20
is false, that is initialized).  The fact that it lists '<unknown>'=20
rather than the actual (sub-)expression that it claims is uninitialized=20
doesn't help.  So yeah, I'm seriously confused as to why this false=20
positive is being reported, or why the change from 'if/if' to 'if/else=20
if' shuts it up.

>=20
>=20
> I've been staring at the code and can see no reason why it isn't a fals=
e=20
> positive (and I'll let the tool authors know)

Thanks for the followup.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
