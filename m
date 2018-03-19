Received: from eggs.gnu.org ([2001:4830:134:3::10]:34857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey0ad-0000oG-S5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey0ac-0002Pa-O7
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:37:03 -0400
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-3-mreitz@redhat.com>
	<c8a20a6d-039f-544a-3b58-098f6be19ecf@redhat.com>
	<afd63f12-6b1c-1981-ac3a-52d108725e2d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24d6fa65-3570-4eff-fce4-23a5b0a5a2f8@redhat.com>
Date: Mon, 19 Mar 2018 14:36:55 -0500
MIME-Version: 1.0
In-Reply-To: <afd63f12-6b1c-1981-ac3a-52d108725e2d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/7] qapi: Add qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

On 02/26/2018 05:58 AM, Max Reitz wrote:
> On 2018-02-24 21:57, Eric Blake wrote:
>> On 02/24/2018 09:40 AM, Max Reitz wrote:
>>> This is a dynamic casting macro that, given a QObject type, returns a=
n
>>> object as that type or NULL if the object is of a different type (or
>>> NULL itself).
>>>

>>> +#define qobject_to(obj, type) \
>>> +=C2=A0=C2=A0=C2=A0 container_of(qobject_check_type(obj, glue(QTYPE_C=
AST_TO_, type))
>>> ?: \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QOBJECT((type *)NULL)=
, \
>>
>> I guess the third (second?) branch of the ternary is written this way,
>> rather than the simpler 'NULL', to ensure that 'type' is still somethi=
ng
>> that can have the QOBJECT() macro applied to it?=C2=A0 Should be okay.
>=20
> It's written this way because of the container_of() around it.  We want
> the whole expression to return NULL then, and without the QOBJECT()
> around it, it would only return NULL if offsetof(type, base) =3D=3D 0 (=
which
> it is not necessarily).
>=20
> OTOH, container_of(&((type *)NULL)->base, type, base) is by definition =
NULL.
>=20
> (QOBJECT(x) is &(x)->base)

Well, clang's ubsan griped:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05143.html

Practically, all of our qtypes have 'base' at offset 0, which means=20
(QObject*)addr and (QString*)addr are the same address, even when addr=20
is NULL.  But neither QOBJECT() nor container_of() are currently fit to=20
run on a NULL pointer, since the 'base' member need not be at offset 0,=20
at which point, we'd be converting away from the NULL pointer on the=20
&(x)->base conversion, and then back to the NULL pointer on the=20
container_of() conversion.  So at the end of the day, we get the right=20
results, but we relied on undefined behavior in the interim.

So here's what I'm squashing in, if you like it (and remembering that I=20
already swapped argument order to be qobject_to(type, obj) in my pending=20
pull requests):

diff --git i/include/qapi/qmp/qobject.h w/include/qapi/qmp/qobject.h
index ea9702270e7..e6ce9347ab8 100644
--- i/include/qapi/qmp/qobject.h
+++ w/include/qapi/qmp/qobject.h
@@ -62,9 +62,8 @@ QEMU_BUILD_BUG_MSG(QTYPE__MAX !=3D 7,
                     "The QTYPE_CAST_TO_* list needs to be extended");

  #define qobject_to(type, obj) \
-    container_of(qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)) ?: =
\
-                     QOBJECT((type *)NULL), \
-                 type, base)
+    ({ QObject *_tmp =3D qobject_check_type(obj, glue(QTYPE_CAST_TO_,=20
type)); \
+        _tmp ? container_of(_tmp, type, base) : (type *)NULL; })

  /* Initialize an object to default values */
  static inline void qobject_init(QObject *obj, QType type)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
