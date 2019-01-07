Received: from eggs.gnu.org ([209.51.188.92]:44080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ggWVL-0007Dx-GL
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ggWVJ-0002t9-Tm
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:07:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ggWVJ-0002se-Lg
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:07:49 -0500
Date: Mon, 7 Jan 2019 15:07:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190107150737.GB2442@work-vm>
References: <20190106013802.3645-1-eblake@redhat.com>
	<20190107094927.GA2442@work-vm>
	<96a72fff-a7ab-ca0f-2d1b-5efdc0a9868e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a72fff-a7ab-ca0f-2d1b-5efdc0a9868e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] osdep: Make MIN/MAX evaluate arguments
 only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, dirty.ice.hu@gmail.com, f4bug@amsat.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 1/7/19 3:49 AM, Dr. David Alan Gilbert wrote:
> > * Eric Blake (eblake@redhat.com) wrote:
> >> Add the macro QEMU_TYPEOF() to access __auto_type in new enough
> >> compilers, while falling back to typeof on older compilers (the
> >> fallback doesn't handle variable length arrays, but we don't use
> >> those; it also expands to more text).
> >>
> >> Then use that macro to make MIN/MAX only evaluate their argument
> >> once; this uses type promotion (by adding to 0) to work around
> >> the fact that typeof(bitfield) won't compile.  However, we are
> >> unable to work around gcc refusing to compile ({}) in a constant
> >> context, even when only used in the dead branch of a
> >> __builtin_choose_expr(),
> 
> 
> >> +#undef MIN
> >> +#define MIN(a, b)                            \
> >> +    ({                                       \
> >> +        QEMU_TYPEOF((a) + 0) _a = (a) + 0;   \
> >> +        QEMU_TYPEOF((b) + 0) _b = (b) + 0;   \
> >> +        _a < _b ? _a : _b;                   \
> >> +    })
> >> +#define MIN_CONST(a, b)                                         \
> >> +    __builtin_choose_expr(                                      \
> >> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
> >> +        (a) < (b) ? (a) : (b),                                  \
> >> +        __builtin_unreachable())
> > 
> > Why do these need to be separate macros? Can't you just put the 
> > non-constant code in what you have as the 'builtin_unreachable' side of
> > the choose_expr:
> > 
> > #define DMIN(a,b) __builtin_choose_expr(                  \
> >     __builtin_constant_p(a) && __builtin_constant_p(b),   \
> >     (a) < (b) ? (a) : (b),                                \
> >     ({                                       \
> >         QEMU_TYPEOF((a) + 0) _a = (a) + 0;   \
> >         QEMU_TYPEOF((b) + 0) _b = (b) + 0;   \
> >         _a < _b ? _a : _b;                   \
> >     }))
> 
> Because it doesn't work - gcc treats ({}) as a syntax error inside
> constant expressions, even in dead code (although 'info gcc' said that
> might change in the future, we can't wait for that change).  I also
> tried it as documented here:
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00715.html
> hence my mention in the commit message.

Ah, I didn't understand the context in your message;  you say 'even in
the dead branch of a __builtin_choose_expr()' but the following works
for me (on f29 and rhel7):

#include <stdio.h>

# define QEMU_TYPEOF(a) typeof(a)

#define DMIN(a,b) __builtin_choose_expr(                  \
    __builtin_constant_p(a) && __builtin_constant_p(b),   \
    (a) < (b) ? (a) : (b),                                \
    ({                                       \
        QEMU_TYPEOF((a) + 0) _a = (a) + 0;   \
        QEMU_TYPEOF((b) + 0) _b = (b) + 0;   \
        _a < _b ? _a : _b;                   \
    }))


int main(int argc, char *argv[])
{
    int anarray[DMIN(5, 10)];
    int a=5;
    int b=6;
    fprintf(stderr, "sizeof(anarray)=%zd DMIN(a,b)=%d\n", sizeof(anarray), DMIN(a++,b++));
    fprintf(stderr, "a=%d b=%d\n", a,b);
}

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
