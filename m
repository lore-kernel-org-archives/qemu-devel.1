Received: from eggs.gnu.org ([2001:4830:134:3::10]:34914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUCqZ-0008CL-UJ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUCqV-000347-Pk
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:33:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cUCqV-00033v-KA
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:33:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-4-git-send-email-mst@redhat.com>
	<87r33zii2m.fsf@dusky.pond.sub.org>
	<8721518c-5063-bd5b-60a9-3a3752894e74@redhat.com>
Date: Thu, 19 Jan 2017 14:33:40 +0100
In-Reply-To: <8721518c-5063-bd5b-60a9-3a3752894e74@redhat.com> (Paolo
	Bonzini's message of "Thu, 19 Jan 2017 11:01:11 +0100")
Message-ID: <8737gfb2dn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/4] compiler: expression version of
 QEMU_BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 19/01/2017 09:12, Markus Armbruster wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>>> QEMU_BUILD_BUG_ON uses a typedef in order to be safe
>>> to use outside functions, but sometimes it's useful
>>> to have a version that can be used within an expression.
>>> Following what Linux does, introduce QEMU_BUILD_BUG_ON_ZERO
>>> that return zero after checking condition at build time.
>> 
>> Following Linux's example makes sense, but I can't help but wonder
>> whether we need both QEMU_BUILD_BUG_ON_ZERO() and QEMU_BUILD_BUG_ON().
>
> I think so, most notably QEMU_BUILD_BUG_ON was added to C11 as
> _Static_assert but QEMU_BUILD_BUG_ON_ZERO wasn't.

Okay.

> But we can indeed redefine QEMU_BUILD_BUG_ON to
> (void)QEMU_BUILD_BUG_ON_ZERO(x) like Linux does, until we add optional
> support for _Static_assert.

Yes, please.

>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>  include/qemu/compiler.h | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>>> index 2882470..f4cf13b 100644
>>> --- a/include/qemu/compiler.h
>>> +++ b/include/qemu/compiler.h
>>> @@ -89,6 +89,8 @@
>>>      typedef char glue(qemu_build_bug_on__,__LINE__)[(x) ? -1 : 1] \
>>>          __attribute__((unused))
>>>  
>>> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x) ? -1 : 1]) - sizeof(int))
>
> Linux here uses:
>
> #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>
> and the issue is that sizeof(int[(x) ? -1 : 1]) could be
> runtime-evaluated (the type is a variable-length array).

Let's copy both macros from Linux.
