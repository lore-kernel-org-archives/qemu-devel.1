Received: from eggs.gnu.org ([2001:4830:134:3::10]:60789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBfYE-0006Qu-M0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBfYB-0005KW-FN
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:26:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eBfYB-0005KJ-8k
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:26:43 -0500
Date: Mon, 6 Nov 2017 11:26:38 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171106112638.GF23361@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171106005656.GC84093@humpty.home.comstyle.com>
	<CAFEAcA_2i0p9C3amtoB0o9Y4K83aCP7Gkw1cDqmLjrkLwJTZxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_2i0p9C3amtoB0o9Y4K83aCP7Gkw1cDqmLjrkLwJTZxg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] osdep: Deal with TIME_MAX and OpenBSD
 64-bit time_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Brad Smith <brad@comstyle.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Nov 06, 2017 at 10:51:16AM +0000, Peter Maydell wrote:
> On 6 November 2017 at 00:56, Brad Smith <brad@comstyle.com> wrote:
> > Define TIME_MAX to LLONG_MAX for OpenBSD since OpenBSD uses 64-bit time_t.
> >
> > Signed-off-by: Brad Smith <brad@comstyle.com>
> >
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 6855b94bbf..824714049b 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -132,8 +132,12 @@ extern int daemon(int, int);
> >  #define ESHUTDOWN 4099
> >  #endif
> >  #ifndef TIME_MAX
> > +#ifdef __OpenBSD__
> > +#define TIME_MAX LLONG_MAX
> > +#else
> >  #define TIME_MAX LONG_MAX
> >  #endif
> > +#endif
> 
> I'm not really a fan of adding new OS-specific #ifdefs --
> what if one of the other BSDs uses or switches to 64-bit
> time_t for 32-bit platforms? Is there some way we can detect
> this generically at compile time (possibly in configure) ?

You could use a pair of compile time asserts to figure it out.

Would need one compile test to check 32 vs 64 bit:

  #include <time.h>
  char time_t_64bit[sizeof(time_t) == 8 ? 1 : -1];

and a second to check signed vs unsigned:

  #include <time.h>
  char time_t_signed[(time_t) -1 < 0 ? 1 : -1];


Save each of these programs to the file $TMPC, and then run 'compile_object'
from configure. You then have a decision matrix for 4 different TIME_MAX
values to write into config-host.h.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
