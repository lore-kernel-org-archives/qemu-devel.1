Received: from eggs.gnu.org ([2001:4830:134:3::10]:59328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvlgY-0008Cw-88
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvlgU-0005mJ-UR
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:50:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42162 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvlgU-0005lb-Pv
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:50:06 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-8-git-send-email-Liam.Merwick@oracle.com>
	<ba464589-10b3-d449-3077-74a5eee9ec61@redhat.com>
	<1e99f751-2cc6-7d66-dd57-cbc857a18a4a@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ac8f2ee-6166-020f-38c6-b22f57e76d5b@redhat.com>
Date: Fri, 31 Aug 2018 10:50:05 -0500
MIME-Version: 1.0
In-Reply-To: <1e99f751-2cc6-7d66-dd57-cbc857a18a4a@oracle.com>
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

On 08/31/2018 10:36 AM, Liam Merwick wrote:
> On 30/08/2018 17:18, Eric Blake wrote:
>> On 08/30/2018 10:47 AM, Liam Merwick wrote:
>>> Incorrect checking of flags could result in uninitialized
>>> file descriptor being used.
>>>

>=20
> Looking at it again, the very minor optimisation of converting the 2nd=20
> 'if' to an 'else if' has the useful side-effect of appeasing the static=
=20
> analysis tool.

I never figured out what the tool precisely thought was wrong in the=20
first place. Can you paste the output of the tool to see exactly what it=20
analyzed as the potential flaw?  Perhaps the analyzer was trying to see=20
what would happen if a caller submitting the fourth value (3 on systems=20
where O_RDONLY is 0, 0 on systems where O_RDONLY is 1) and the code not=20
behaving in that setup, even though we know that all callers only submit=20
the three valid values and never the fourth invalid value?  Or maybe=20
it's a weakness where we have made dependent assumptions but in=20
independent branches, in such a way that we know it will never fail but=20
the analyzer doesn't?

>=20
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -61,8 +61,7 @@ qio_channel_command_new_spawn(const char *const argv[=
],
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (flags =3D=3D O_RDONLY) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stdinnull =3D true;
> -=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 if (flags =3D=3D O_WRONLY) {
> +=C2=A0=C2=A0=C2=A0 } else if (flags =3D=3D O_WRONLY) {

But this sort of change is acceptable, especially if it does shut up the=20
analyzer, and done with a commit message mentioning that it is not a=20
semantic change but does make it easier to use the static checker to=20
find real problems by getting rid of noise.

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stdoutnull =3D true;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Regards,
> Liam
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
