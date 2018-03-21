Received: from eggs.gnu.org ([2001:4830:134:3::10]:40579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eyf57-0007ZL-2Q
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eyf54-0006l8-0q
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:51:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eyf53-0006ki-Sc
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:51:09 -0400
Received: by mail-qk0-f194.google.com with SMTP id o64so5697044qkl.7
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 07:51:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5321b7df-215e-e56d-ae6d-2ada8706cdcc@redhat.com>
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-4-marcandre.lureau@redhat.com>
	<5321b7df-215e-e56d-ae6d-2ada8706cdcc@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 15:51:08 +0100
Message-ID: <CAMxuvazWmEuDeBPTPCatr_o0rKiUk8MddvTE6u70w_-ML8B7kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
	Daniel" <berrange@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>, "Bonzini,
	Paolo" <pbonzini@redhat.com>

On Wed, Mar 21, 2018 at 3:28 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/21/2018 08:40 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Now that we can safely call QOBJECT() on QObject * and children types,
>> we can have a single macro to ref/unref the object.
>>
>> Change the incref/decref prefix name for the more common ref/unref.
>
>
> I know you did this by sed (for the most part); but it would be worth
> including the command line you used in the commit message to make it easi=
er
> to reproduce the same mechanical portion of the patch when rebasing.

git sed QINCREF qobject_ref
git sed QDECREF qobject_unref
git sed qobject_incref qobject_ref
git sed qobject_decref qobject_ref

>
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>
>
>> +++ b/include/qapi/qmp/qobject.h
>
>
>> @@ -74,13 +74,16 @@ qobject_unknown_type(const void *unused)
>>       (const QObject *, x),                       \
>>       qobject_unknown_type(x))
>>   -/* High-level interface for qobject_incref() */
>> -#define QINCREF(obj)      \
>> -    qobject_incref(QOBJECT(obj))
>> +/**
>> + * qobject_ref(): Increment QObject's reference count
>> + */
>> +#define qobject_ref(x) qobject_ref_impl(QOBJECT(x))
>
>
> The meat of the patch; looks fine to me.
>
>> +++ b/scripts/coccinelle/qobject.cocci
>> @@ -3,11 +3,11 @@
>>   expression Obj, Key, E;
>>   @@
>>   (
>> -- qobject_incref(QOBJECT(E));
>> -+ QINCREF(E);
>> +- qobject_ref(QOBJECT(E));
>> ++ qobject_ref(E);
>>   |
>> -- qobject_decref(QOBJECT(E));
>> -+ QDECREF(E);
>> +- qobject_unref(QOBJECT(E));
>> ++ qobject_unref(E);
>
>
> I wonder if these branches should just be removed; they made sense when w=
e
> had two spellings, but after your mass conversion, the .cocci script is
> unlikely to ever find regressions on this front.

They would still remove extra cast, wouldn't they?

thanks
