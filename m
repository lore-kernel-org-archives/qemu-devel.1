Received: from eggs.gnu.org ([2001:4830:134:3::10]:46348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f71Ct-0008V3-AV
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f71Cq-00036L-3B
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:05:47 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f71Cp-00035x-Uk
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:05:44 -0400
Received: by mail-io0-f195.google.com with SMTP id t13so3271622ioc.13
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 09:05:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49475649-b8d8-e09a-8e95-7ce36c7396f2@redhat.com>
References: <20180329154833.566-1-marcandre.lureau@redhat.com>
	<20180329154833.566-5-marcandre.lureau@redhat.com>
	<49475649-b8d8-e09a-8e95-7ce36c7396f2@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Apr 2018 18:05:42 +0200
Message-ID: <CAMxuvazz_Zzget3-oVD_Fa4-G4YT+HLXg9Psh0bjpD9tbPxO3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] qobject: modify qobject_ref() to
 assert on NULL and return obj
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

Hi

On Thu, Mar 29, 2018 at 6:10 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/29/2018 10:48 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Following a discussion on the mailing list: while it may be convenient
>> to accept NULL value in qobject_unref() (for similar reasons as free()
>> accepts NULL), it is a probably a bad idea to accept NULL argument in
>> qobject_ref().
>>
>> Furthermore, it is convenient and more clear to call qobject_ref() at
>> the time when the reference is associated with a variable, or
>> argument. For this reason, make qobject_ref() return the same pointer
>> as given.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>
>
>> @@ -101,13 +101,18 @@ static inline void qobject_unref(QObject *obj)
>>     /**
>>    * qobject_ref(): Increment QObject's reference count
>> + * @obj: a #QObject or children type instance (must not be NULL)
>
>
> s/children/child/
>
>> + *
>> + * Returns: the same @obj. The type of @obj will be propagated to the
>> + * return type.
>>    */
>>   #define qobject_ref(obj)                        \
>> -    qobject_ref(QOBJECT(obj))
>> +    (typeof(obj)) qobject_ref(QOBJECT(obj))
>
>
> You're missing outer ().  There are cases where '(cast) (expr)' and
> '((cast)(expr))' can behave differently when combined with surrounding
> syntax; for example, -> has higher precedence than cast.  Consider:
>
> qobject_ref(my_qdict)->size;
>
> As you wrote it, you would attempt to dereference the 'size' member of vo=
id*
> (compile error), prior to casting that result to QDict*; with the
> parenthesis, you get the intended dereference of the size member of the
> QDict pointer.
>

ok

>> +++ b/block.c
>> @@ -5134,8 +5134,8 @@ static bool append_open_options(QDict *d,
>> BlockDriverState *bs)
>>               continue;
>>           }
>>   -        qobject_ref(qdict_entry_value(entry));
>> -        qdict_put_obj(d, qdict_entry_key(entry),
>> qdict_entry_value(entry));
>> +        qdict_put_obj(d, qdict_entry_key(entry),
>> +                      qobject_ref(qdict_entry_value(entry)));
>
>
> However, I like this simplification that your patch enables.  How did you
> find candidate spots? Manually, or via Coccinelle?

Manual review (there are not that many qobject_ref())

thanks
