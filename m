Received: from eggs.gnu.org ([2001:4830:134:3::10]:42229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fSTgZ-0007G5-RQ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fSTgZ-0003nl-4J
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:45:07 -0400
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:35149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fSTgY-0003nQ-Ue
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:45:07 -0400
Received: by mail-it0-x22b.google.com with SMTP id a3-v6so12717300itd.0
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 13:45:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tvq9lps3.fsf@dusky.pond.sub.org>
References: <1528653731-4920-1-git-send-email-keno@juliacomputing.com>
	<87tvq9lps3.fsf@dusky.pond.sub.org>
From: Keno Fischer <keno@juliacomputing.com>
Date: Mon, 11 Jun 2018 16:44:25 -0400
Message-ID: <CABV8kRwu7=FaYtZhOBCXZBbtmDXQgJpYCU3LGJToc_sk=6n9vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

> Suggest return strchrnul("Hello World", 'W') != 6, to avoid worries
> about a sufficiently smart compilers optimizing out a call that would
> otherwise fail to link, say because headers don't match libraries.

I'm happy to do that, but then again, a sufficiently smart compiler might
constant fold this call entirely, so to be completely safe maybe we need

extern char *haystack;
extern char needle;
int main(void) { return strchrnul(haystack, needle) != 6; }

Though frankly if you're in a position for this to be a problem, you've
got bigger problems. Happy to change this though.

> Should this be named HAVE_STRCHRNUL?  It's how it would be named with
> Autoconf...

Ok, I will rename this.

>> +const char *qemu_strchrnul(const char *s, int c)
>> +{
>> +    const char *e = strchr(s, c);
>> +    if (!e) {
>> +        e = s + strlen(s);
>> +    }
>> +    return e;
>
> Stupidest solution that could possibly work.  Okay :)

Well, it's the pattern that was used everywhere in place of this function,
so certainly from a commit factoring this seemed like the most sensible
thing to do.

> How did you find the spots to convert to strchrnul()?

I audited uses of `strchr` and checked for whether they were really doing
`strchrnul` (plus the one use case in code that used to only ever be compiled
on Linux).
