Received: from eggs.gnu.org ([209.51.188.92]:33619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkWhR-0005SA-F2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkWhP-00072c-2f
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:08:52 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:40243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkWhL-0006a0-7b
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:08:49 -0500
Received: by mail-ot1-x32b.google.com with SMTP id s5so14808829oth.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 08:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20190118132750.25932-1-peter.maydell@linaro.org>
	<64316a28-affa-11ca-2d25-5a34a7787a4a@redhat.com>
In-Reply-To: <64316a28-affa-11ca-2d25-5a34a7787a4a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 16:08:11 +0000
Message-ID: <CAFEAcA_SQ_zMeGxoTb4sYchv_7K=eNTV5XCUTjSp1mz7-igzng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Don't spuriously warn about
 /** comment starters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Reported-by : Thomas Huth" <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Fri, 18 Jan 2019 at 15:53, Eric Blake <eblake@redhat.com> wrote:
>
> On 1/18/19 7:27 AM, Peter Maydell wrote:
> > In checkpatch we attempt to check for and warn about
> > block comments which start with /* or /** followed by a
> > non-blank. Unfortunately a bug in the regex meant that
> > we would incorrectly warn about comments starting with
> > "/**" with no following text:
> >
> >   git show 9813dc6ac3954d58ba16b3920556f106f97e1c67|./scripts/checkpatch.pl -
> >   WARNING: Block comments use a leading /* on a separate line
> >   #34: FILE: tests/libqtest.h:233:
> >   +/**
> >
> > The sequence "/\*\*?" was intended to match either "/*" or "/**",
> > but Perl's semantics for '?' allow it to backtrack and try the
> > "matches 0 chars" option if the "matches 1 char" choice leads to
> > a failure of the rest of the regex to match.  Switch to "/\*\*?+"
> > which uses what perlre(1) calls the "possessive" quantifier form:
> > this means that if it matches the "/**" string it will not later
> > backtrack to matching just the "/*" prefix.
>
> Just wondering if "/\*{1,2}" would also work (it may have to be spelled
> "/\*\{1,2}" - I never remember which flavors of regex have which
> extensions without rereading docs)

Oh yes, that would probably be the less perl-specific way
to write it.

Perl regexes have the convenient property that backslash
followed by a punctuation character always means "that
character literally", whether or not that punctuation
character has a metacharacter meaning when not escaped.
So it's definitely the non-backslash version.
(As an aside, it's a bit sad that Rust regexes don't have
this property.)

> > This comment check is unique to QEMU checkpatch so the bug
> > doesn't exist in the Linux version.
> > ---
> >  scripts/checkpatch.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index d10dddf1be4..5f1ec537d21 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1624,7 +1624,7 @@ sub process {
> >
> >               # Block comments use /* on a line of its own
> >               if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&      #inline /*...*/
> > -                 $rawline =~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-blank
> > +                 $rawline =~ m@^\+.*/\*\*?+[ \t]*.+[ \t]*$@) { # /* or /** non-blank
>
> Hmm - Isn't "[ \t]*.+[ \t]*$" the same as ".+$?"

(do you mean '$?"' at the end of your sentence, or '$" ?' ?)

I'm not sure exactly what I was aiming for with that
part of the regex when I wrote it. The comment suggests
that I was looking for "non-blank", ie I didn't want to
fire on /* or /** followed by just trailing whitespace.
The regex as written is clearly not actually doing that,
though...

-- PMM
