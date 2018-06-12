Received: from eggs.gnu.org ([2001:4830:134:3::10]:35589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSdP9-0004sY-Nl
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSdP6-0007hQ-I1
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:07:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSdP6-0007h6-DC
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:07:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1528653731-4920-1-git-send-email-keno@juliacomputing.com>
	<87tvq9lps3.fsf@dusky.pond.sub.org>
	<CABV8kRwu7=FaYtZhOBCXZBbtmDXQgJpYCU3LGJToc_sk=6n9vA@mail.gmail.com>
Date: Tue, 12 Jun 2018 09:07:42 +0200
In-Reply-To: <CABV8kRwu7=FaYtZhOBCXZBbtmDXQgJpYCU3LGJToc_sk=6n9vA@mail.gmail.com>
	(Keno Fischer's message of "Mon, 11 Jun 2018 16:44:25 -0400")
Message-ID: <87muw0wkht.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Keno Fischer <keno@juliacomputing.com> writes:

>> Suggest return strchrnul("Hello World", 'W') != 6, to avoid worries
>> about a sufficiently smart compilers optimizing out a call that would
>> otherwise fail to link, say because headers don't match libraries.
>
> I'm happy to do that, but then again, a sufficiently smart compiler might
> constant fold this call entirely, so to be completely safe maybe we need
>
> extern char *haystack;
> extern char needle;
> int main(void) { return strchrnul(haystack, needle) != 6; }
>
> Though frankly if you're in a position for this to be a problem, you've
> got bigger problems. Happy to change this though.

Yes, please.  You even get to pick your favorite number for the right
hand side of the comparison ;)

>> Should this be named HAVE_STRCHRNUL?  It's how it would be named with
>> Autoconf...
>
> Ok, I will rename this.
>
>>> +const char *qemu_strchrnul(const char *s, int c)
>>> +{
>>> +    const char *e = strchr(s, c);
>>> +    if (!e) {
>>> +        e = s + strlen(s);
>>> +    }
>>> +    return e;
>>
>> Stupidest solution that could possibly work.  Okay :)
>
> Well, it's the pattern that was used everywhere in place of this function,
> so certainly from a commit factoring this seemed like the most sensible
> thing to do.
>
>> How did you find the spots to convert to strchrnul()?
>
> I audited uses of `strchr` and checked for whether they were really doing
> `strchrnul` (plus the one use case in code that used to only ever be compiled
> on Linux).

Sounds good.  Thanks!
