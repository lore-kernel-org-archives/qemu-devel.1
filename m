Received: from eggs.gnu.org ([2001:4830:134:3::10]:51112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0gyT-0003s8-UQ
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 01:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0gyQ-0006Hj-Jf
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 01:49:01 -0400
Received: from mail.ispras.ru ([83.149.199.45]:41160)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0gyQ-0006DW-6u
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 01:48:58 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081950.3228.68987.stgit@pasha-VirtualBox>
	<f7b7533c-a9db-d660-4981-678ae5143950@redhat.com>
In-Reply-To: <f7b7533c-a9db-d660-4981-678ae5143950@redhat.com>
Date: Fri, 14 Sep 2018 08:48:53 +0300
Message-ID: <002101d44bee$9edf9720$dc9ec560$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v6 21/25] replay: replay BH for IDE trim
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'John Snow' <jsnow@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: John Snow [mailto:jsnow@redhat.com]
> On 09/12/2018 04:19 AM, Pavel Dovgalyuk wrote:
> > This patch makes IDE trim BH deterministic, because it affects
> > the device state. Therefore its invocation should be replayed
> > instead of running at the random moment.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  hw/ide/core.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/ide/core.c b/hw/ide/core.c
> > index 2c62efc..04e22e7 100644
> > --- a/hw/ide/core.c
> > +++ b/hw/ide/core.c
> > @@ -35,6 +35,7 @@
> >  #include "sysemu/block-backend.h"
> >  #include "qapi/error.h"
> >  #include "qemu/cutils.h"
> > +#include "sysemu/replay.h"
> >
> >  #include "hw/ide/internal.h"
> >  #include "trace.h"
> > @@ -479,7 +480,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
> >  done:
> >      iocb->aiocb = NULL;
> >      if (iocb->bh) {
> > -        qemu_bh_schedule(iocb->bh);
> > +        replay_bh_schedule_event(iocb->bh);
> >      }
> >  }
> >
> Just passing by: Why do we need to change this call, but nothing else in
> IDE?

This call is responsible for a bug that was reproducible.

> I don't mind conceptually, but it's odd to me that of all the calls I
> make in this emulator that change state somewhere that this is the only
> one you need to hijack for the replay feature.
> 
> Is this a necessarily complete change?

Maybe not. We can hardly analyze all peripheral devices code and fix all the calls.
But I think we can improve that patch and at least look through ide core to fix other calls.

Pavel Dovgalyuk
