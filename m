Received: from eggs.gnu.org ([2001:4830:134:3::10]:57646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9AXB-0008Da-CH
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9AX9-00004q-H8
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:27:37 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f9AX9-0008MG-99
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:27:35 -0400
Received: by mail-wr0-x244.google.com with SMTP id s18-v6so14596624wrg.9
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:27:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877ep3yb4m.fsf@dusky.pond.sub.org>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-4-marcandre.lureau@redhat.com>
	<877ep3yb4m.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Apr 2018 16:27:32 +0200
Message-ID: <CAJ+F1CJugZDRaU5SUvx_VJG=uRFQU-n+MUfJ5Hob5oHN0v6zRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/5] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Apr 19, 2018 at 8:16 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Now that we can safely call QOBJECT() on QObject * as well as its
>> subtypes, we can have macros qobject_ref() / qobject_unref() that work
>> everywhere instead of having to use QINCREF() / QDECREF() for QObject
>> and qobject_incref() / qobject_decref() for its subtypes.
>>
>> Note that the new macros evaluate their argument exactly once, thus no
>> need to shout them.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi/events.py              |   2 +-
>>  include/qapi/qmp/qnull.h            |   2 +-
>>  include/qapi/qmp/qobject.h          |  36 +++++-----
> [...]
>>  tests/wdt_ib700-test.c              |  14 ++--
>>  util/keyval.c                       |  12 ++--
>>  util/qemu-config.c                  |   4 +-
>>  docs/devel/qapi-code-gen.txt        |   2 +-
>>  scripts/coccinelle/qobject.cocci    |   8 +--
>>  94 files changed, 606 insertions(+), 610 deletions(-)
>
> The patch is not entirely mechanical (evidence: Eric's observations).
> How did you create it?

git sed (as said in previous reviews). And fixing the new compiler warning =
iirc.

>> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
>> index 3dc523cf39..4426861ff1 100644
>> --- a/scripts/qapi/events.py
>> +++ b/scripts/qapi/events.py
>> @@ -142,7 +142,7 @@ out:
>>  ''')
>>      ret +=3D mcgen('''
>>      error_propagate(errp, err);
>> -    QDECREF(qmp);
>> +    qobject_unref(qmp);
>>  }
>>  ''')
>>      return ret
>> diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
>> index e8ea2c315a..75b29c6a39 100644
>> --- a/include/qapi/qmp/qnull.h
>> +++ b/include/qapi/qmp/qnull.h
>> @@ -23,7 +23,7 @@ extern QNull qnull_;
>>
>>  static inline QNull *qnull(void)
>>  {
>> -    QINCREF(&qnull_);
>> +    qobject_ref(&qnull_);
>>      return &qnull_;
>>  }
>>
>> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
>> index 0a7f800d58..e08fbb80b9 100644
>> --- a/include/qapi/qmp/qobject.h
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -16,16 +16,16 @@
>>   *
>>   *  - Returning references: A function that returns an object may
>>   *  return it as either a weak or a strong reference.  If the reference
>> - *  is strong, you are responsible for calling QDECREF() on the referen=
ce
>> + *  is strong, you are responsible for calling qobject_unref() on the r=
eference
>
> Long line.

fixed thanks

>
>>   *  when you are done.
>>   *
>>   *  If the reference is weak, the owner of the reference may free it at
>>   *  any time in the future.  Before storing the reference anywhere, you
>> - *  should call QINCREF() to make the reference strong.
>> + *  should call qobject_ref() to make the reference strong.
>>   *
>>   *  - Transferring ownership: when you transfer ownership of a referenc=
e
>>   *  by calling a function, you are no longer responsible for calling
>> - *  QDECREF() when the reference is no longer needed.  In other words,
>> + *  qobject_unref() when the reference is no longer needed.  In other w=
ords,
>>   *  when the function returns you must behave as if the reference to th=
e
>>   *  passed object was weak.
>>   */
> [...]
>



--=20
Marc-Andr=C3=A9 Lureau
