Received: from eggs.gnu.org ([2001:4830:134:3::10]:36796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dFyD2-00078C-4v
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dFyD1-0004yY-2w
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:38:24 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dFyD0-0004yF-Mi
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:38:23 -0400
Received: by mail-lf0-x243.google.com with SMTP id q24so634955lfb.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 00:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-8-marcandre.lureau@redhat.com>
	<87tw4mgr07.fsf@dusky.pond.sub.org>
	<CAJ+F1CKctXGjPOghFGXQTyTdT9Oaxn8w3x0N+L5vBp4m8U4XCA@mail.gmail.com>
	<ad923132-af5a-07e4-723c-df115b902538@redhat.com>
In-Reply-To: <ad923132-af5a-07e4-723c-df115b902538@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2017 07:38:09 +0000
Message-ID: <CAJ+F1CJYrRvrVW3_bjUgB0Kq8VDb_M+9za=dpE0a1JfZd7hGgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/17] json: learn to parse uint64 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Tue, May 30, 2017 at 6:22 PM Eric Blake <eblake@redhat.com> wrote:

> On 05/30/2017 06:35 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, May 15, 2017 at 6:00 PM Markus Armbruster <armbru@redhat.com>
> wrote:
> >
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >>> Switch strtoll() usage to qemu_strtoi64() helper while at it.
> >>>
> >>> Replace temporarily the error in qnum_get_int() with values >INT64_MA=
X
> >>> until the visitor is updated.
> >>>
> >>> Add a few tests for large numbers.
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>  qobject/json-lexer.c               |  4 ++++
> >>>  qobject/json-parser.c              | 30 ++++++++++++++++++++++------=
--
> >>>  qobject/qnum.c                     |  4 ++--
> >>>  tests/check-qjson.c                | 28 ++++++++++++++++++++++++++++
> >>>  tests/check-qnum.c                 |  9 +++++----
> >>>  tests/test-qobject-input-visitor.c |  7 ++-----
> >>>  6 files changed, 63 insertions(+), 19 deletions(-)
> >>>
> >>> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
> >>> index af4a75e05b..a0beb0b106 100644
> >>> --- a/qobject/json-lexer.c
> >>> +++ b/qobject/json-lexer.c
> >>> @@ -227,15 +227,18 @@ static const uint8_t json_lexer[][256] =3D  {
> >>>      /* escape */
> >>>      [IN_ESCAPE_LL] =3D {
> >>>          ['d'] =3D JSON_ESCAPE,
> >>> +        ['u'] =3D JSON_ESCAPE,
>
> Do we really want to add MORE escape sequences to our pseudo-JSON escape
> parser? I had a series a while back that was able to completely kill the
> pseudo-JSON escapes, in favor of teaching the testsuite how to directly
> handle %s (which is really the most useful of the escapes - we really
> aren't using many others).
>
> If there's interest in removing the JSON parser escape sequences, I can
> revive my series.
>

I don't have a full picture of what we use it for, but if you can simplify
it, I am all for it.

In the meantime, I'll keep my change for testing and consistency. If your
patch goes first, I'll adapt it.

--=20
Marc-Andr=C3=A9 Lureau
