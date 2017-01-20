Received: from eggs.gnu.org ([2001:4830:134:3::10]:42941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUTVw-0004ne-Qt
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUTVr-0007VU-T3
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:21:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cUTVr-0007V3-KI
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:21:31 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-4-git-send-email-mst@redhat.com>
	<87r33zii2m.fsf@dusky.pond.sub.org>
	<8721518c-5063-bd5b-60a9-3a3752894e74@redhat.com>
	<8737gfb2dn.fsf@dusky.pond.sub.org>
	<20170119212409-mutt-send-email-mst@kernel.org>
Date: Fri, 20 Jan 2017 08:21:28 +0100
In-Reply-To: <20170119212409-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Thu, 19 Jan 2017 21:25:49 +0200")
Message-ID: <87d1fi42o7.fsf@dusky.pond.sub.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Jan 19, 2017 at 02:33:40PM +0100, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>> > On 19/01/2017 09:12, Markus Armbruster wrote:
>> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> >> 
>> >>> QEMU_BUILD_BUG_ON uses a typedef in order to be safe
>> >>> to use outside functions, but sometimes it's useful
>> >>> to have a version that can be used within an expression.
>> >>> Following what Linux does, introduce QEMU_BUILD_BUG_ON_ZERO
>> >>> that return zero after checking condition at build time.
>> >> 
>> >> Following Linux's example makes sense, but I can't help but wonder
>> >> whether we need both QEMU_BUILD_BUG_ON_ZERO() and QEMU_BUILD_BUG_ON().
>> >
>> > I think so, most notably QEMU_BUILD_BUG_ON was added to C11 as
>> > _Static_assert but QEMU_BUILD_BUG_ON_ZERO wasn't.
>> 
>> Okay.
>> 
>> > But we can indeed redefine QEMU_BUILD_BUG_ON to
>> > (void)QEMU_BUILD_BUG_ON_ZERO(x) like Linux does, until we add optional
>> > support for _Static_assert.
>> 
>> Yes, please.
>
>
> I don't think we can because we use QEMU_BUILD_BUG_ON outside
> any functions. I don't think you can put 0 there.

Point taken.  Still, we should be able to factor out a common core of
the bug condition.

>> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> >>> ---
>> >>>  include/qemu/compiler.h | 2 ++
>> >>>  1 file changed, 2 insertions(+)
>> >>>
>> >>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> >>> index 2882470..f4cf13b 100644
>> >>> --- a/include/qemu/compiler.h
>> >>> +++ b/include/qemu/compiler.h
>> >>> @@ -89,6 +89,8 @@
>> >>>      typedef char glue(qemu_build_bug_on__,__LINE__)[(x) ? -1 : 1] \
>> >>>          __attribute__((unused))
>> >>>  
>> >>> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x) ? -1 : 1]) - sizeof(int))
>> >
>> > Linux here uses:
>> >
>> > #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>> >
>> > and the issue is that sizeof(int[(x) ? -1 : 1]) could be
>> > runtime-evaluated (the type is a variable-length array).
>> 
>> Let's copy both macros from Linux.
>
> I prefer our variant, I don't think it's portable to assume that
> sizeof(struct {int:0}) is 0. Besides, Linux code is GPLv2 only and this
> file is 2 or later.

Use (sizeof(struct { int: X }) - sizeof(struct { int: 0 })) if you care
for portability to lesser compilers.  I don't, because we use common
extensions supported by both GCC and Clang all over the place.

The idea to use bitfield size is not copyrightable, only expressions of
the idea.
