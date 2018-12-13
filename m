Received: from eggs.gnu.org ([2001:4830:134:3::10]:49555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXUBF-0008FG-6A
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXUBE-0006kN-CR
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:49:45 -0500
References: <20181213162727.17438-1-lvivier@redhat.com>
	<20181213162727.17438-2-lvivier@redhat.com>
	<827ac081-587f-d365-b682-3a65271a0a4a@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f0d5df55-e612-a7ac-35db-b32a82157252@redhat.com>
Date: Thu, 13 Dec 2018 17:49:35 +0100
MIME-Version: 1.0
In-Reply-To: <827ac081-587f-d365-b682-3a65271a0a4a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block/ssh: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On 13/12/2018 17:34, Eric Blake wrote:
> On 12/13/18 10:27 AM, Laurent Vivier wrote:
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>
>> Notes:
>> =C2=A0=C2=A0=C2=A0=C2=A0 v2: use %zu with size_t
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 change an uint64_t to=
 int64_t to match % PRIi64
>=20
> Why PRIi64?=C2=A0 It's identical to PRId64, but the sources show a stro=
ng
> preference for %d over %i:
>=20
> $ git grep PRIi[0-9] | wc
> =C2=A0=C2=A0=C2=A0=C2=A0 25=C2=A0=C2=A0=C2=A0=C2=A0 172=C2=A0=C2=A0=C2=A0=
 1885
> $ git grep PRId[0-9] | wc
> =C2=A0=C2=A0=C2=A0 415=C2=A0=C2=A0=C2=A0 3991=C2=A0=C2=A0 40345
>=20
> $ git grep '%i' | wc
> =C2=A0=C2=A0=C2=A0 231=C2=A0=C2=A0=C2=A0 1664=C2=A0=C2=A0 18269
> $ git grep '%d' | wc
> =C2=A0=C2=A0 5492=C2=A0=C2=A0 46211=C2=A0 498225
>=20

Yes, you're right but I have only moved the existing format string[1] to
trace-event:

diff --git a/block/ssh.c b/block/ssh.c
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1003,7 +991,7 @@ static void ssh_seek(BDRVSSHState *s, int64_t
offset, int flags)
     bool force =3D (flags & SSH_SEEK_FORCE) !=3D 0;

     if (force || op_read !=3D s->offset_op_read || offset !=3D s->offset=
) {
-        DPRINTF("seeking to offset=3D%" PRIi64, offset);
+        trace_ssh_seek(offset);

diff --git a/block/trace-events b/block/trace-events
--- a/block/trace-events
+++ b/block/trace-events
...
+ssh_seek(int64_t offset) "seeking to offset=3D%" PRIi64

Thanks,
Laurent
[1] in fact, I have a coccinelle script to do that automatically.
