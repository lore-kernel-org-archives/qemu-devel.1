Received: from eggs.gnu.org ([2001:4830:134:3::10]:53367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5uPd-0003bS-Ur
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5uPa-0005Se-S5
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:33:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170503104441.1349-1-pbonzini@redhat.com>
	<874lx21880.fsf@dusky.pond.sub.org>
	<8e6b18bc-eb3e-c77f-2b9a-c797c3c15680@redhat.com>
	<87pofqxfna.fsf@dusky.pond.sub.org>
	<cba7fc39-0b43-7514-7bf1-8375f3f7cc38@redhat.com>
Date: Wed, 03 May 2017 15:33:41 +0200
In-Reply-To: <cba7fc39-0b43-7514-7bf1-8375f3f7cc38@redhat.com> (Paolo
	Bonzini's message of "Wed, 3 May 2017 15:10:24 +0200")
Message-ID: <87inlivzd6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] jazz_led: fix bad snprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org, leon.alrae@imgtec.com, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/05/2017 14:56, Markus Armbruster wrote:
>>> snprintf writes at most 2 bytes here including the terminating NUL, so
>>> the result is truncated".
>>
>> You're right; I forgot that snprintf() always adds a NUL.  So this *is*
>> broken: we write NUL instead of the second digit.  Mentioning this in
>> the commit message wouldn't hurt.
>
> Well, it does, see the quote. :)

Yes, snprintf() truncates, but that's *internal* to
jazz_led_text_update().  The *external* effect isn't quite truncation,
it's writing NUL to the console instead of the second digit.  That's
truncation only if the console ignores NUL.  It might; I don't know.
Anyway, no big deal.
