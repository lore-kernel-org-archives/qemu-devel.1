Received: from eggs.gnu.org ([209.51.188.92]:37810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfcb-0005q8-1G
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfcZ-0007vN-S8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:04:44 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmfcZ-0007sw-I8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:04:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id a11so5272953otr.10
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 06:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20190118165050.22270-1-peter.maydell@linaro.org>
	<e0d4eed9-c715-a20e-d3bc-85ab11876cca@redhat.com>
In-Reply-To: <e0d4eed9-c715-a20e-d3bc-85ab11876cca@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 14:04:29 +0000
Message-ID: <CAFEAcA-5eU+rqBEMqpVSpjTPPZ51qqq+awa3TZcJFnVLnRYb5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: Don't emit spurious
 warnings about block comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Thomas Huth <thuth@redhat.com>

On Fri, 18 Jan 2019 at 17:06, Eric Blake <eblake@redhat.com> wrote:
>
> On 1/18/19 10:50 AM, Peter Maydell wrote:
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
> >
> > The other end of the regex is also wrong: it is attempting
> > to check for "/* or /** followed by something that isn't
> > just whitespace", but [ \t]*.+[ \t]* will match on pure
> > whitespace. This is less significant but means that a line
> > with just a comment-starter followed by trailing whitespace
> > will generate an incorrect warning about block comment style
> > as well as the correct error about trailing whitespace which
> > a different checkpatch test emits.
> >
>
> Fixes: 8c06fbdf36bf4d4d486116200248730887a4d7d6
>
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Reported-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
>
> >               # Block comments use /* on a line of its own
> >               if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&      #inline /*...*/
> > -                 $rawline =~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-blank
> > +                 $rawline =~ m@^\+.*/\*\*?+[ \t]*[^ \t]@) { # /* or /** non-blank
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks. I'll take this via target-arm.next, just for convenience...

-- PMM
