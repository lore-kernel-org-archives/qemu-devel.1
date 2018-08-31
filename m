Received: from eggs.gnu.org ([2001:4830:134:3::10]:56873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvlcT-00067J-J2
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvlRL-0006j3-5G
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:34:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1fvlRK-0006in-SF
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:34:27 -0400
From: Liam Merwick <liam.merwick@oracle.com>
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-8-git-send-email-Liam.Merwick@oracle.com>
	<ba464589-10b3-d449-3077-74a5eee9ec61@redhat.com>
Message-ID: <1e99f751-2cc6-7d66-dd57-cbc857a18a4a@oracle.com>
Date: Fri, 31 Aug 2018 16:36:14 +0100
MIME-Version: 1.0
In-Reply-To: <ba464589-10b3-d449-3077-74a5eee9ec61@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
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

On 30/08/2018 17:18, Eric Blake wrote:
> On 08/30/2018 10:47 AM, Liam Merwick wrote:
>> Incorrect checking of flags could result in uninitialized
>> file descriptor being used.
>>
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
>> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
>> ---
>> =C2=A0 io/channel-command.c | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/io/channel-command.c b/io/channel-command.c
>> index 3e7eb17eff54..38deb687da21 100644
>> --- a/io/channel-command.c
>> +++ b/io/channel-command.c
>> @@ -59,10 +59,10 @@ qio_channel_command_new_spawn(const char *const=20
>> argv[],
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags =3D flags & O_ACCMODE;
>> -=C2=A0=C2=A0=C2=A0 if (flags =3D=3D O_RDONLY) {
>> +=C2=A0=C2=A0=C2=A0 if ((flags & O_RDONLY) =3D=3D O_RDONLY) {
>=20
> NACK.=C2=A0 O_RDONLY and O_WRONLY are subsets of O_ACCMODE, which we al=
ready=20
> masked out above.
>=20
> On some systems, we have:
> O_RDONLY =3D=3D 0
> O_WRONLY =3D=3D 1
> O_RDWR =3D=3D 2
>=20
> On other systems, we have:
> O_RDONLY =3D=3D 1
> O_WRONLY =3D=3D 2
> O_RDWR =3D=3D 3
>=20
> Either way, if the user passed in O_RDWR, (flags & O_RDONLY) =3D=3D O_R=
DONLY=20
> returns true, which is wrong.
>=20
> O_ACCMODE was historically 0x3, although now that POSIX has O_EXEC and=20
> O_SEARCH (which can be the same bit pattern), some systems now make=20
> O_ACCMODE occupy 3 bits instead of 2.
>=20

Thanks for catching that and for the explanation.

Looking at it again, the very minor optimisation of converting the 2nd=20
'if' to an 'else if' has the useful side-effect of appeasing the static=20
analysis tool.

--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -61,8 +61,7 @@ qio_channel_command_new_spawn(const char *const argv[],

      if (flags =3D=3D O_RDONLY) {
          stdinnull =3D true;
-    }
-    if (flags =3D=3D O_WRONLY) {
+    } else if (flags =3D=3D O_WRONLY) {
          stdoutnull =3D true;
      }

Regards,
Liam
