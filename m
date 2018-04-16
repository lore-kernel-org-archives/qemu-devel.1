Received: from eggs.gnu.org ([2001:4830:134:3::10]:55119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f87Lr-0001H3-E2
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f87Ln-00060r-CD
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:51:35 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:39313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f87Ln-0005sP-6a
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:51:31 -0400
Received: by mail-it0-f53.google.com with SMTP id 85-v6so9807783iti.4
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 09:51:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87r2nfsh7w.fsf@dusky.pond.sub.org>
References: <20180413161842.5117-1-marcandre.lureau@redhat.com>
	<20180413161842.5117-3-marcandre.lureau@redhat.com>
	<87r2nfsh7w.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Apr 2018 18:51:24 +0200
Message-ID: <CAMxuvawfVz-Q-XemOXDzHPSB-pvOLw3-zERea1nYDRT5Nf0FJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/4] qobject: use a QObjectBase_ struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>

Hi

On Mon, Apr 16, 2018 at 10:12 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> By moving the base fields to a QObjectBase_, QObject can be a type
>> which also has a 'base' field. This allows to write a generic
>> QOBJECT() macro that will work with any QObject type, including
>> QObject itself. The container_of() macro ensures that the object to
>> cast has a QObjectBase_ base field, giving some type safety
>> guarantees. However, for it to work properly, all QObject types must
>> have 'base' at offset 0 (which is ensured by static checking from
>> the previous patch)
>
> I'm afraid this condition is neither sufficient nor necessary.
>
> QOBJECT() maps a pointer to some subtype to the base type QObject.  For
> this to work, the subtype must contain a QObject.
>
> Before the patch, this is trivially the case: the subtypes have a member
> QObject base, and QOBJECT() returns its address.
>
> Afterwards, the subtypes have a member QObjectBase_ base, and QOBJECT()
> returns the address of a notional QObject wrapped around this member.
> Works because QObject has no other members.
>
> The condition 'base is at offset 0' does not ensure this, and is
> therefore not sufficient.
>
> It's not necessary, either: putting base elsewhere would work just fine
> as long as we put *all* of QObject there.
>
> Please document the real condition "QObject must have no members but
> QObjectBase_ base, or else QOBJECT() breaks".  Feel free to check their
> sizes are the same (I wouldn't bother).

ok

>
> If requiring base to be at offset zero for all subtypes materially
> simplifies code, then go ahead and do that in a separate patch.  My gut
> feeling is it doesn't, but I could be wrong.

what is missing from patch 1?

>
>> QObjectBase_ is not typedef and use a trailing underscore to make it
>> obvious it is not for normal use and to avoid potential abuse.
>
> Trailing underscore I like, lack of typedef I don't mind (but I'm firmly
> in the "eschew typedef for structs" camp).  It does violate the common
> QEMU coding style, though.
>
> A comment /* Not for use outside include/qapi/qmp/ */ next to
> QObjectBase_ wouldn't hurt.
>

ok
