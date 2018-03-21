Received: from eggs.gnu.org ([2001:4830:134:3::10]:57958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eyeQ3-0005C5-KV
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eyePy-0001JD-MJ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:08:47 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eyePy-0001Io-Hl
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:08:42 -0400
Received: by mail-qt0-f196.google.com with SMTP id a20so5362352qtj.3
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 07:08:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 15:08:40 +0100
Message-ID: <CAMxuvay1j+E1YRggpqm9+ETE_FxD-ThGtPBenUtvt8oeYweS8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qobject: assume base of a qobject is
 at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
	Daniel" <berrange@redhat.com>, "Blake, Eric" <eblake@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

Hi

On Wed, Mar 21, 2018 at 3:01 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 21/03/2018 14:40, Marc-Andr=C3=A9 Lureau wrote:
>> +/* A typecast, checking for the type of arguments */
>> +/* QObject is at offset 0, for all QObject-derived types */
>> +#define QOBJECT(x) QEMU_GENERIC(x,              \
>> +    (QNull *, (QObject *) x),                   \
>> +    (const QNull *, (const QObject *) x),       \
>> +    (QNum *, (QObject *) x),                    \
>> +    (const QNum *, (const QObject *) x),        \
>> +    (QString *, (QObject *) x),                 \
>> +    (const QString *, (const QObject *) x),     \
>> +    (QDict *, (QObject *) x),                   \
>> +    (const QDict *, (const QObject *) x),       \
>> +    (QList *, (QObject *) x),                   \
>> +    (const QList *, (const QObject *) x),       \
>> +    (QBool *, (QObject *) x),                   \
>> +    (const QBool *, (const QObject *) x),       \
>> +    (QObject *, x),                             \
>> +    (const QObject *, x),                       \
>> +    qobject_unknown_type(x))
>
> Why not just
>
>         QEMU_GENERIC(x,
>                 (QObject *, x),
>                 (const QObject *, x),
>                 ({ \
>                         QEMU_BUILD_BUG_ON(offsetof(typeof(*x), base));
>                         &(x)->base;
>                 }))
>
> That is just an extension of what was being done before, and it is
> resilient against people putting a random "QObject base" in the middle
> of a struct.
>

Yeah, I tried a few of those approaches. Here the problem is that
QObject doesn't have base field. So you get a compile time error with
a QObject * as argument.

thanks
