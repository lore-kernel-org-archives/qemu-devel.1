Received: from eggs.gnu.org ([2001:4830:134:3::10]:58383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f96VD-0005Rh-SG
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f96VC-0001qP-Th
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:09:19 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:43524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f96VC-0001p4-M9
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:09:18 -0400
Received: by mail-wr0-x231.google.com with SMTP id u4-v6so12423253wrg.10
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 03:09:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87r2nbwv9j.fsf@dusky.pond.sub.org>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<87r2nbwv9j.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Apr 2018 12:09:16 +0200
Message-ID: <CAJ+F1CLAh8kg6YH1jZPBy1Ec+A4bQP-05yo9BqKqdyqEWL-e+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Simplify qobject refcount
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

On Thu, Apr 19, 2018 at 8:44 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Hi,
>>
>> This series aims to get rid of the distinction between QObject, that
>> must use qobject_incref/qobject_decref and its various derived types
>> that have to use QINCREF/QDECREF. Instead, replace it with
>> qobject_ref/qobject_unref for all types.
>
> This is a lovely improvement.

That's a good sign.

> However, I think the code can't quite decide whether to embrace or
> eschew type casts between QObject and its subtypes.

It uses both, for different reasons

> On the one hand, we provide safe conversion macros QOBJECT() and
> qobject_to().  By the way, shouting one but not the other is a bit ugly.

QOBJECT is static upcast, the compiler will shout.
qobject_to() is dynamic downcast, the runtime shout.

> On the other hand, we still use type casts, and enforce "base comes
> first" to make them work.
>
> If we want to eschew type casts, we should clean up the remaining ones.
> The case for "base must come first" is quite weak then.  Not worth the
> bother, I think.
>
> I doubt we want to embrace type casts here.  If we wanted to, I'd go all
> the way and unwrap base in QObjects and its subtypes with suitable "must
> match QObject" comments.  Alternatively, use an unnamed member.  Then
> convert with type casts rather than container_of() and &->base.
>

Can you make a different patch? Can it be done after? Should we add a
note there for future improvements?

I don't like to spent too much time on this, yet as you said, this is
a lovely improvement, so is there any real blocker left?

--=20
Marc-Andr=C3=A9 Lureau
