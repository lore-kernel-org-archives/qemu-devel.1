Received: from eggs.gnu.org ([2001:4830:134:3::10]:58105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtvBs-00077l-HN
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtvBr-000715-BO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:30:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dtvBr-00070Q-2D
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:30:19 -0400
Date: Mon, 18 Sep 2017 20:30:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170918123012.GN15551@lemon.lan>
References: <77c55c6c-3397-5a32-6276-6b88f13fa531@siemens.com>
	<CAFEAcA_bpija3nfB2URJbsqyGZfkziszFf16Q2U9TkC9HbnAJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_bpija3nfB2URJbsqyGZfkziszFf16Q2U9TkC9HbnAJQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] seccomp: Fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Eduardo Otubo <otubo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Mon, 09/18 09:31, Peter Maydell wrote:
> On 18 September 2017 at 08:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > vl.c includes seccomp.h, thus requires the related CFLAGS as well.
> >
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  Makefile.objs | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile.objs b/Makefile.objs
> > index d9cf7ad791..4f1488d65d 100644
> > --- a/Makefile.objs
> > +++ b/Makefile.objs
> > @@ -61,7 +61,7 @@ bt-host.o-cflags := $(BLUEZ_CFLAGS)
> >
> >  common-obj-y += dma-helpers.o
> >  common-obj-y += vl.o
> > -vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
> > +vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS) $(SECCOMP_CFLAGS)
> >  common-obj-y += tpm.o
> >
> >  common-obj-$(CONFIG_SLIRP) += slirp/
> 
> ...I get the feeling we're going to get a whole bunch of these
> compile errors and fixups as we switch over to trying to specify
> package-dependent cflags only on certain source files. Is
> there anything we can do to make this changeover more reliable?

I think we should spot those risky headers and clean them up. See below.

> 
> In particular I think that just adding a new #include line
> to a source file shouldn't suddenly require us to change
> the makefile to add a FOO_CFLAGS if we can avoid it. If
> it is necessary, then we need to make sure that's a compile
> error on all platforms and configurations (including those
> where pkg-config happens to set FOO_CFLAGS to the empty string.)

My apologies in advance that I'm not directly answering your question, because I
don't know. Anyway..  IMHO being prudent on which library headers to pull in
from a source file is a good thing, so I feel the conversion a worthwhile
effort.  It also forces developers to fully hide the implementation details
behind an internal API:

> qemu-foo.h:
  void qemu_foo_do_a(void);
  void qemu_foo_do_b(void);
> qemu-foo-internal.h:
  /* A header that includes the library header, if necessary */
  #include <libfoo.h>
  #include "qemu-foo.h"
> qemu-foo-a.c:
  #include "qemu-foo.h"
  #include "qemu-foo-internal.h"
  void qemu_foo_do_a(void)
  {
      ...
  }
> qemu-foo-b.c:
  #include "qemu-foo.h"
  #include "qemu-foo-internal.h"
  void qemu_foo_do_b(void)
  {
      ...
  }

So in general we could clean up non-internal headers (as in the above example
the qemu-foo.h versus qemu-foo-internal.h) so that the library headers are not
included there, whenever possible.

If a library header is indeed wanted by different .c files, it probably should
goto QEMU_CFLAGS, like the glib headers.

But if a .c file does need to include a library header, it probably also wants
the libs flag as well. So, commonly -cflags and -libs still go together.

In the case of this patch, I think we should do this:

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index e67c2dc840..9b092aa23f 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -21,7 +21,5 @@
 #define QEMU_SECCOMP_SET_SPAWN       (1 << 3)
 #define QEMU_SECCOMP_SET_RESOURCECTL (1 << 4)

-#include <seccomp.h>
-
 int seccomp_start(uint32_t seccomp_opts);
 #endif
