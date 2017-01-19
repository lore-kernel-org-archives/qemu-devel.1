Received: from eggs.gnu.org ([2001:4830:134:3::10]:52533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUKvE-0007Kj-PA
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 17:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUKvA-0005Dj-Th
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 17:11:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cUKvA-0005D2-O3
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 17:11:04 -0500
Date: Fri, 20 Jan 2017 00:11:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170120000636-mutt-send-email-mst@kernel.org>
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-5-git-send-email-mst@redhat.com>
	<aa9a259a-a649-d399-5895-837a5a23f56c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9a259a-a649-d399-5895-837a5a23f56c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] ARRAY_SIZE: check that argument is
 an array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Sergey Fedorov <serge.fdrv@gmail.com>

On Thu, Jan 19, 2017 at 03:59:33PM -0600, Eric Blake wrote:
> On 01/19/2017 03:07 PM, Michael S. Tsirkin wrote:
> > It's a familiar pattern: some code uses ARRAY_SIZE, then refactoring
> > changes the argument from an array to a pointer to a dynamically
> > allocated buffer.  Code keeps compiling but any ARRAY_SIZE calls now
> > return the size of the pointer divided by element size.
> > 
> > Let's add build time checks to ARRAY_SIZE before we allow more
> > of these in the code-base.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  include/qemu/osdep.h | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> > 
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 689f253..56c9e22 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -198,8 +198,15 @@ extern int daemon(int, int);
> >  #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> >  #endif
> >  
> > +/*
> > + * &(x)[0] is always a pointer - if it's same type as x then the argument is a
> > + * pointer, not an array.
> > + */
> > +#define QEMU_IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), \
> > +                                                        typeof(&(x)[0])))
> >  #ifndef ARRAY_SIZE
> > -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > +#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
> > +                       QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
> 
> We've got some double-negation going on here ("cause a build bug if the
> negation of QEMU_IS_ARRAY() is not 0") which takes some mental
> gymnastics, but it is the correct result.  [I kind of like that gnulib
> uses positive logic in its 'verify(x)' meaning "verify that x is true,
> or cause a build error"; compared to the negative logic in the kernal
> 'BUILD_BUG_ON[_ZERO](x)' meaning "cause a build bug if x is non-zero" -
> but that's personal preference and not something for qemu to change]

I can rename QEMU_IS_ARRAY to QEMU_IS_PTR and reverse the logic - would
this be preferable?

-- 
MST
