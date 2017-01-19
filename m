Received: from eggs.gnu.org ([2001:4830:134:3::10]:34436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUJrR-0003Ps-OR
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUJrN-0007ha-Pi
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:03:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cUJrN-0007gl-HL
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:03:05 -0500
Date: Thu, 19 Jan 2017 23:02:58 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170119230205-mutt-send-email-mst@kernel.org>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-4-git-send-email-mst@redhat.com>
	<87r33zii2m.fsf@dusky.pond.sub.org>
	<8721518c-5063-bd5b-60a9-3a3752894e74@redhat.com>
	<8737gfb2dn.fsf@dusky.pond.sub.org>
	<20170119212409-mutt-send-email-mst@kernel.org>
	<57dd50a6-73ce-ecfa-4f5e-bca433465e6b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57dd50a6-73ce-ecfa-4f5e-bca433465e6b@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Thu, Jan 19, 2017 at 02:58:48PM -0600, Eric Blake wrote:
> On 01/19/2017 01:25 PM, Michael S. Tsirkin wrote:
> 
> >>>>> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x) ? -1 : 1]) - sizeof(int))
> >>>
> >>> Linux here uses:
> >>>
> >>> #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
> >>>
> >>> and the issue is that sizeof(int[(x) ? -1 : 1]) could be
> >>> runtime-evaluated (the type is a variable-length array).
> 
> Use of the struct with an int bitfield forces 'e' to be a non-zero
> compile-time constant to compile; while [(x) ? -1 : 1] could indeed
> compile even if not a compile-time constant.  So I agree that we want to
> prefer something that forces x to be a compile-time constant.
> 
> >>
> >> Let's copy both macros from Linux.
> > 
> > I prefer our variant, I don't think it's portable to assume that
> > sizeof(struct {int:0}) is 0. Besides, Linux code is GPLv2 only and this
> > file is 2 or later.
> 
> I agree that using the Linux version is problematic from a licensing
> perspective, as well as the portability of getting sizeof() to produce
> 0.  But at least it uses bitfields to force a compile time constant.
> 
> Here's a third approach: gnulib has a LGPLv2+ version that does:
> 
> ====
> # define _GL_VERIFY_TYPE(R, DIAGNOSTIC) \
>     struct { unsigned int _gl_verify_error_if_negative: (R) ? 1 : -1; }
> 
> #define _GL_VERIFY_TRUE(R, DIAGNOSTIC) \
>    (!!sizeof (_GL_VERIFY_TYPE (R, DIAGNOSTIC)))
> 
> /* Verify requirement R at compile-time, as a declaration without a
>    trailing ';'.  If R is false, fail at compile-time, preferably
>    with a diagnostic that includes the string-literal DIAGNOSTIC.
> 
>    Unfortunately, unlike C11, this implementation must appear as an
>    ordinary declaration, and cannot appear inside struct { ... }.  */
> 
> #ifdef _GL_HAVE__STATIC_ASSERT
> # define _GL_VERIFY _Static_assert
> #else
> # define _GL_VERIFY(R, DIAGNOSTIC)                                     \
>     extern int (*_GL_GENSYM (_gl_verify_function) (void))              \
>       [_GL_VERIFY_TRUE (R, DIAGNOSTIC)]
> #endif
> 
> /* Verify requirement R at compile-time.  Return the value of the
>    expression E.  */
> 
> #define verify_expr(R, E) \
>    (_GL_VERIFY_TRUE (R, "verify_expr (" #R ", " #E ")") ? (E) : (E))
> 
> /* Verify requirement R at compile-time, as a declaration without a
>    trailing ';'.  */
> 
> #define verify(R) _GL_VERIFY (R, "verify (" #R ")")
> ====
> 
> where BUILD_BUG_ON_ZERO(e) pretty much maps to verify_expr(!(e), 0), if
> you want to copy any of those ideas.
> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 




I coded up something similar independently.
Will post in a minute.

-- 
MST
