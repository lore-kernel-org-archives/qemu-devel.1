Received: from eggs.gnu.org ([2001:4830:134:3::10]:40908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJLw4-0001pk-G2
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJLvz-0004h8-Jy
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:34:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJLvz-0004gt-Dy
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:34:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170609133337.31183-1-marcandre.lureau@redhat.com>
	<650896fb-d42b-3ce7-8660-4c1275a5e360@redhat.com>
Date: Fri, 09 Jun 2017 17:34:42 +0200
In-Reply-To: <650896fb-d42b-3ce7-8660-4c1275a5e360@redhat.com> (Eric Blake's
	message of "Fri, 9 Jun 2017 09:58:37 -0500")
Message-ID: <87wp8lb2el.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: check-qom-proplist: fix leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 06/09/2017 08:33 AM, Marc-Andr=C3=A9 Lureau wrote:
>> user_creatable_add_opts() returns a reference (the other reference is
>> for the root parent/child link).
>>=20
>> Leak introduced in commit a1af255f065cc.
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  tests/check-qom-proplist.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
>> index 8e432e9ab6..a3cd7ab29f 100644
>> --- a/tests/check-qom-proplist.c
>> +++ b/tests/check-qom-proplist.c
>> @@ -428,6 +428,8 @@ static void test_dummy_createcmdl(void)
>>      g_assert(err =3D=3D NULL);
>>      error_free(err);
>>=20=20
>> +    object_unref(OBJECT(dobj));
>
> This should be spelled QDECREF(dobj);

Caution, this is object_unref(), not qobject_decref().

We suck at naming.

> (Hmm - maybe scripts/coccinelle/qobject.cocci should be taught this
> cleanup pattern...)
