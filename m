Received: from eggs.gnu.org ([2001:4830:134:3::10]:60682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUEIq-0007Kd-Um
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUEIn-0001r1-Iw
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:07:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cUEIn-0001qe-E0
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:07:01 -0500
Date: Thu, 19 Jan 2017 17:06:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170119170645-mutt-send-email-mst@kernel.org>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-5-git-send-email-mst@redhat.com>
	<29f56f57-76f5-8585-c286-70bc0eb60b92@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f56f57-76f5-8585-c286-70bc0eb60b92@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] ARRAY_SIZE: check that argument is
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Sergey Fedorov <serge.fdrv@gmail.com>

On Thu, Jan 19, 2017 at 08:53:34AM -0600, Eric Blake wrote:
> On 01/18/2017 02:55 PM, Michael S. Tsirkin wrote:
> > It's a familiar pattern: some code uses ARRAY_SIZE, then refactoring
> > changes the argument from an array to a pointer to a dynamically
> > allocated buffer.  Code keeps compiling but any ARRAY_SIZE calls now
> > return the size of the pointer divided by element size.
> > 
> > Let's add build time checks to ARRAY_SIZE before we allow more
> > of these in the code-base.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/qemu/osdep.h | 8 +++++++-
> 
> >  
> >  #ifndef ARRAY_SIZE
> > -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > +/*
> > + * &(x)[0] is always a pointer - if it's same type as x then the argument is a
> > + * pointer, not an array as expected.
> > + */
> > +#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + QEMU_BUILD_BUG_ON_ZERO( \
> > +                        __builtin_types_compatible_p(typeof(x), \
> 
> Are we sure that __builtin_types_compatible_p() is supported for all
> versions of gcc and clang that we support, or does this need further
> #ifdefs?
> 
> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 


We seem to use it without ifdefs elsewhere.

-- 
MST
