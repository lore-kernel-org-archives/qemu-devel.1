Received: from eggs.gnu.org ([2001:4830:134:3::10]:55114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dB1mR-0007BC-K9
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dB1mN-0006wt-LD
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dB1mN-0006wC-CZ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:26:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A92213A60
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:26:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-9-marcandre.lureau@redhat.com>
	<87pof86750.fsf@dusky.pond.sub.org>
Date: Wed, 17 May 2017 18:26:22 +0200
In-Reply-To: <87pof86750.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 16 May 2017 19:31:07 +0200")
Message-ID: <87d1b71mc1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/17] qapi: update the qobject visitor to
 use QUInt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> On the subject: there is no such thing as "QUInt".  I guess you mean
> "uint type" (like in PATCH 06's subject).  Could also say "QNUM_U64".
>
> Apropos subject: humor me, and start your subjects with a capital
> letter, like this:
>
>     qapi: Update the qobject visitor ...
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Switch to use QNum/uint where appropriate to remove i64 limitation.
>>
>> The input visitor will cast i64 input to u64 for compatibility
>> reasons (existing json QMP client already use negative i64 for large
>> u64, and expect an implicit cast in qemu).
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qapi/qobject-input-visitor.c        | 13 +++++++++++--
>>  qapi/qobject-output-visitor.c       |  3 +--
>>  tests/test-qobject-output-visitor.c | 21 ++++++++++++++++-----
>>  3 files changed, 28 insertions(+), 9 deletions(-)
>>
>> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
>> index 785949ebab..72cefcf677 100644
>> --- a/qapi/qobject-input-visitor.c
>> +++ b/qapi/qobject-input-visitor.c
>> @@ -420,9 +420,9 @@ static void qobject_input_type_int64_keyval(Visitor =
*v, const char *name,
>>  static void qobject_input_type_uint64(Visitor *v, const char *name,
>>                                        uint64_t *obj, Error **errp)
>>  {
>> -    /* FIXME: qobject_to_qnum mishandles values over INT64_MAX */
>>      QObjectInputVisitor *qiv =3D to_qiv(v);
>>      QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
>> +    Error *err =3D NULL;
>>      QNum *qnum;
>>=20=20
>>      if (!qobj) {
>> @@ -435,7 +435,16 @@ static void qobject_input_type_uint64(Visitor *v, c=
onst char *name,
>>          return;
>>      }
>>=20=20
>> -    *obj =3D qnum_get_int(qnum, errp);
>> +    /* XXX: compatibility case, accept negative values as u64 */
>
> What does "XXX" signify?
>
>> +    *obj =3D qnum_get_int(qnum, &err);
>> +
>
> Shouldn't the comment go right here?

Nope, I misread the code.

We first try qnum_get_int().  Works for integers between -2^63 and
2^63-1.  The assignment to *obj adds 2^64 to negative ones.

When it doesn't work, we try qnum_get_uint().  Works for integers
between 0 and 2^64-1, but only integers between 2^63 and 2^64-1 can
occur.

>> +    if (err) {
>> +        error_free(err);
>> +        err =3D NULL;
>> +        *obj =3D qnum_get_uint(qnum, &err);
>> +    }
>> +
>> +    error_propagate(errp, err);
>>  }

Let's do this the other way round:

    *obj =3D qnum_get_uint(qnum, &err);
    if (err) {
        /* Need to accept negative values for backward compatibility */
        error_free(err);
        err =3D NULL;
        *obj =3D qnum_get_int(qnum, &err);
    }

    error_propagate(errp, err);

This way, the backward compatibility code is entirely contained in the
conditional.

It's also how I misread the code :)

[...]
