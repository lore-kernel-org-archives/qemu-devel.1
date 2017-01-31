Received: from eggs.gnu.org ([2001:4830:134:3::10]:42116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYaxg-0003w8-RB
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYaxd-0005gW-LY
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:07:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cYaxd-0005g7-FB
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:07:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<87zii75jze.fsf@dusky.pond.sub.org>
	<20170131172752-mutt-send-email-mst@kernel.org>
Date: Tue, 31 Jan 2017 17:07:10 +0100
In-Reply-To: <20170131172752-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Tue, 31 Jan 2017 17:29:15 +0200")
Message-ID: <87o9yn2oy9.fsf@dusky.pond.sub.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Jan 31, 2017 at 04:26:13PM +0100, Markus Armbruster wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > Some headers use QEMU_BUILD_BUG_ON. This causes a problem
>> > if the C file including that header happens to have
>> > QEMU_BUILD_BUG_ON at the same line number.
>> >
>> > Fix using a widely available extension: __COUNTER__.
>> > If unavailable, provide a stub.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > ---
>> >  include/qemu/compiler.h | 6 +++++-
>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> > index e0fb18b..bad25a9 100644
>> > --- a/include/qemu/compiler.h
>> > +++ b/include/qemu/compiler.h
>> > @@ -89,8 +89,12 @@
>> >      struct { \
>> >          int:(x) ? -1 : 1; \
>> >      }
>> > +#ifdef __COUNTER__
>> >  #define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
>> > -    glue(qemu_build_bug_on__, __LINE__) __attribute__((unused))
>> > +    glue(qemu_build_bug_on__, __COUNTER__) __attribute__((unused))
>> > +#else
>> > +#define QEMU_BUILD_BUG_ON(x)
>> > +#endif
>> 
>> __COUNTER__ was added to GNU cpp in 2007.  Good.  What about clang?
>> "clang -dM -E -x c /dev/null" comes up empty on my machine (3.8.0).
>> 
>> Can we use an extern declaration instead?  You can have any number of
>> these, as long as they match.  Have a look at the appended sketch.  It
>> compiles without -DBUGGY, and errors out with -DBUGGY, as it should.
>
> I tried that first thing.
> This generates lots of warnings if you have multiple users
> within a function: gcc is unhappy about the redundant extern
> declarations.

#define QEMU_BUILD_BUG_ON(x) \
    _Pragma("GCC diagnostic push") \
    _Pragma("GCC diagnostic ignored \"-Wredundant-decls\"") \
    extern char qemu_build_bug_on_[QEMU_BUILD_BUG_ON_ZERO((x))] __attribute__((unused)); \
    _Pragma("GCC diagnostic pop")

Drawback: natural use like

    QEMU_BUILD_BUG_ON(x);

expands into a declaration followed by an extra semicolon.
