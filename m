Received: from eggs.gnu.org ([2001:4830:134:3::10]:58500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eyg5D-0000gW-1K
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eyg58-00025G-UJ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:55:22 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eyg58-000252-PJ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:55:18 -0400
Received: by mail-qt0-f196.google.com with SMTP id n12so5746386qtl.5
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 08:55:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 16:55:17 +0100
Message-ID: <CAMxuvax_7QPP5rc3aAPKdUFWtfdEphfiN76mM6jnCKk4=QkauQ@mail.gmail.com>
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

That would work with an anonymous union though:

struct QObject {
    union {
        QType type;
        QType base;
    };
    size_t refcnt;
};

If it's acceptable, I think I'll take this approach.
