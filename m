Received: from eggs.gnu.org ([2001:4830:134:3::10]:49400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNnPZ-0007yT-SX
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNnPY-0005RJ-Q5
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:43:41 -0400
References: <20170621134744.8047-1-mreitz@redhat.com>
	<20170621134744.8047-2-mreitz@redhat.com>
	<87d19xwbpj.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4afa1020-22a7-c07e-3f73-36746644c77a@redhat.com>
Date: Wed, 21 Jun 2017 23:43:29 +0200
MIME-Version: 1.0
In-Reply-To: <87d19xwbpj.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BMRphC5cij7T96T3L9LdjODVdKi3I2HAj"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qapi/qnull: Add own header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BMRphC5cij7T96T3L9LdjODVdKi3I2HAj
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <4afa1020-22a7-c07e-3f73-36746644c77a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qapi/qnull: Add own header
References: <20170621134744.8047-1-mreitz@redhat.com>
 <20170621134744.8047-2-mreitz@redhat.com> <87d19xwbpj.fsf@dusky.pond.sub.org>
In-Reply-To: <87d19xwbpj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-21 18:24, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/qapi/qmp/qnull.h   | 26 ++++++++++++++++++++++++++
>>  include/qapi/qmp/qobject.h |  8 --------
>>  include/qapi/qmp/types.h   |  1 +
>>  qobject/qnull.c            |  1 +
>>  target/i386/cpu.c          |  6 +-----
>>  tests/check-qnull.c        |  2 +-
>>  6 files changed, 30 insertions(+), 14 deletions(-)
>>  create mode 100644 include/qapi/qmp/qnull.h
>>
>> diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
>> new file mode 100644
>> index 0000000..69555ac
>> --- /dev/null
>> +++ b/include/qapi/qmp/qnull.h
>> @@ -0,0 +1,26 @@
>> +/*
>> + * QNull Module
>> + *
>> + * Copyright (C) 2009, 2017 Red Hat Inc.
>> + *
>> + * Authors:
>> + *  Luiz Capitulino <lcapitulino@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU LGPL, version 2.1=
 or later.
>> + * See the COPYING.LIB file in the top-level directory.
>=20
> Copy the boilerplate from qnull.c instead, factual correctness.

Sorry, will do.

>> + */
>> +
>> +#ifndef QNULL_H
>> +#define QNULL_H
>> +
>> +#include "qapi/qmp/qobject.h"
>> +
>> +extern QObject qnull_;
>> +
>> +static inline QObject *qnull(void)
>> +{
>> +    qobject_incref(&qnull_);
>> +    return &qnull_;
>> +}
>> +
>> +#endif /* QNULL_H */
>=20
> Meh, another tiny header.  Are our compiles too fast?

For me, testing takes longer, so from my POV they're fast enough. ;-)

You can always merge all the QObject types into a single header; but as
the code is organized now, I think QNull should have its own header.

>> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
>> index b8ddbca..ef1d1a9 100644
>> --- a/include/qapi/qmp/qobject.h
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -93,12 +93,4 @@ static inline QType qobject_type(const QObject *obj=
)
>>      return obj->type;
>>  }
>> =20
>> -extern QObject qnull_;
>> -
>> -static inline QObject *qnull(void)
>> -{
>> -    qobject_incref(&qnull_);
>> -    return &qnull_;
>> -}
>> -
>>  #endif /* QOBJECT_H */
>> diff --git a/include/qapi/qmp/types.h b/include/qapi/qmp/types.h
>> index 27cfbd8..4c87182 100644
>> --- a/include/qapi/qmp/types.h
>> +++ b/include/qapi/qmp/types.h
>> @@ -20,5 +20,6 @@
>>  #include "qapi/qmp/qstring.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qapi/qmp/qlist.h"
>> +#include "qapi/qmp/qnull.h"
>> =20
>>  #endif /* QAPI_QMP_TYPES_H */
>> diff --git a/qobject/qnull.c b/qobject/qnull.c
>> index c124d05..b3cc85e 100644
>> --- a/qobject/qnull.c
>> +++ b/qobject/qnull.c
>> @@ -13,6 +13,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu-common.h"
>>  #include "qapi/qmp/qobject.h"
>=20
> Let's drop this include, like you do in check-qnull.c below.

I don't even know why I've dropped it there, must have been an accident.
But, well, I don't mind having more happy little accidents.

>> +#include "qapi/qmp/qnull.h"
>> =20
>>  QObject qnull_ =3D {
>>      .type =3D QTYPE_QNULL,
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index b2b1d20..f118a54 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -29,11 +29,7 @@
>>  #include "qemu/option.h"
>>  #include "qemu/config-file.h"
>>  #include "qapi/qmp/qerror.h"
>> -#include "qapi/qmp/qstring.h"
>> -#include "qapi/qmp/qdict.h"
>> -#include "qapi/qmp/qbool.h"
>> -#include "qapi/qmp/qint.h"
>> -#include "qapi/qmp/qfloat.h"
>> +#include "qapi/qmp/types.h"
>=20
> qapi/qmp/types.h is a lazy way to increase compile times by including
> more than you need.  One day I'll kill it.  Until then, I tolerate it i=
n
> .c, but not in .h.

First, I think the compiler has enough work to do on i386/cpu.c as it
is, so it won't matter much here.

Secondly, I'll gladly take a qapi/qmp/primitive-types.h; but I don't see
the point of including six different headers and keeping track of which
primitives type you plan to use.

So if you want to merge them all into one, go for out, sounds very
reasonable to me.

>> =20
>>  #include "qapi-types.h"
>>  #include "qapi-visit.h"
>> diff --git a/tests/check-qnull.c b/tests/check-qnull.c
>> index 8dd1c96..4a67b9a 100644
>> --- a/tests/check-qnull.c
>> +++ b/tests/check-qnull.c
>> @@ -8,7 +8,7 @@
>>   */
>>  #include "qemu/osdep.h"
>> =20
>> -#include "qapi/qmp/qobject.h"
>> +#include "qapi/qmp/qnull.h"
>>  #include "qemu-common.h"
>>  #include "qapi/qobject-input-visitor.h"
>>  #include "qapi/qobject-output-visitor.h"
>=20
> With the boilerplate corrected and the superfluous include in qnull.c
> deleted
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Will do, thanks!

Max


--BMRphC5cij7T96T3L9LdjODVdKi3I2HAj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZSuiBEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQOKZ
B/9Yu8o70p0QDZgcQV2Jjmtz7k5ahoFBbQgihSb/gnMYPMvy+oE77yqPrZnNt2lu
IDo9KrdXw497tvlt3nEEadxodb9gje4Ql0luRIVle7RebdXJIm8Sb2l29VUUcnLi
IJRKqiA7/V8L0QecKZHmQJE56Qzp2+HjaHCSa1X9SNAwdThUD1mci+ONBMFgSYAP
bWRn4ZAEb37hONzppf44q+IBw3I/CPfsPYo+fCUbNcWGQokyR7ZHZQLPZrMI2ADz
nimLa4jrPhK0t4IqBZjWLD19q0yOztEzXmSkL3Y4bWZ9ouG+s0eQYclmPlwF5llL
RktN5DBbVbApx2SRBpIcNY75
=STsO
-----END PGP SIGNATURE-----

--BMRphC5cij7T96T3L9LdjODVdKi3I2HAj--
