Received: from eggs.gnu.org ([2001:4830:134:3::10]:33430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYaS9-00087B-Tn
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYaS5-0005VL-6W
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:34:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cYaS5-0005VF-1N
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:34:37 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<b1e5af37-6547-e688-0365-2bb1bfe45954@redhat.com>
	<CAFEAcA-UPQrgq8h1LbqsUWP-MKwkOBLsAk0R0u0YuSfyA=nQAg@mail.gmail.com>
Date: Tue, 31 Jan 2017 16:34:34 +0100
In-Reply-To: <CAFEAcA-UPQrgq8h1LbqsUWP-MKwkOBLsAk0R0u0YuSfyA=nQAg@mail.gmail.com>
	(Peter Maydell's message of "Tue, 31 Jan 2017 15:12:32 +0000")
Message-ID: <87wpdb4511.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 31 January 2017 at 15:03, Eric Blake <eblake@redhat.com> wrote:
>> On 01/31/2017 08:43 AM, Michael S. Tsirkin wrote:
>>> Some headers use QEMU_BUILD_BUG_ON. This causes a problem
>>> if the C file including that header happens to have
>>> QEMU_BUILD_BUG_ON at the same line number.
>>>
>>> Fix using a widely available extension: __COUNTER__.
>>
>> gcc 4.3 and later; clang documents it but doesn't say when it was added.
>>
>>> If unavailable, provide a stub.
>>
>> What fails in our build farm if we don't provide the stub? Can we just
>> require that our compiler is new enough to have __COUNTER__, or will
>> that break some of our existing targets?
>
> I think the problem is not so much our build farm (which is
> I think all recent enough to postdate introduction of
> __COUNTER__) but the probability of there being users
> out there who are still using older compilers to build
> QEMU releases. We don't need to enforce compile time
> asserts on those old compilers but given that it's
> trivial to avoid actually breaking the build for them,
> why not provide the do-nothing fallback?

I don't think we actually need __COUNTER__.

If we want it, providing a fallback is nice.  However, the "expand to
nothing" fallback is syntactically unsound.  A sound fallback expands to
the exact same syntactic construct as the real thing does, in this case
a declaration.  When it doesn't, we risk parse errors.

Of course, we may decide to accept that risk.
