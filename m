Received: from eggs.gnu.org ([209.51.188.92]:59300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1giy7u-0002ke-Em
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1giy7p-0000TG-Lc
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:01:46 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57082)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1giy7p-0000Lr-Cr
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:01:41 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>	<154703594341.13472.10192138424843641646.stgit@pasha-VirtualBox>
	<87y37r8upr.fsf@dusky.pond.sub.org>
In-Reply-To: <87y37r8upr.fsf@dusky.pond.sub.org>
Date: Mon, 14 Jan 2019 12:01:21 +0300
Message-ID: <000b01d4abe7$b8a76440$29f62cc0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v9 11/21] replay: introduce info hmp/qmp
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Markus Armbruster' <armbru@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

> From: Markus Armbruster [mailto:armbru@redhat.com]
> Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:


> > diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> > new file mode 100644
> > index 0000000..9956405
> > --- /dev/null
> > +++ b/replay/replay-debugging.c
> 
> The file name suggests the instruction count is just for debugging.  If
> that's true, the documentation should mention it.  Else, the file should
> be named less misleadingly, perhaps replay-control.c.

The main purpose of this file is providing an implementation of reverse
debugging methods.
Querying the rr information is mostly for debugging/problem solving too.
(until someone suggests any other manner of using these functions)

> 
> > @@ -0,0 +1,42 @@
> > +/*
> > + * replay-debugging.c
> > + *
> > + * Copyright (c) 2010-2018 Institute for System Programming
> > + *                         of the Russian Academy of Sciences.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "sysemu/replay.h"
> > +#include "replay-internal.h"
> > +#include "hmp.h"
> > +#include "monitor/monitor.h"
> > +#include "qapi/qapi-commands-replay.h"
> > +
> > +void hmp_info_replay(Monitor *mon, const QDict *qdict)
> > +{
> > +    if (replay_mode == REPLAY_MODE_NONE) {
> > +        monitor_printf(mon, "No record/replay\n");
> 
> Perhaps something like "Record/replay not active" would be friendlier.
> 
> > +    } else {
> > +        monitor_printf(mon, "%s execution '%s': current step = %"PRId64"\n",
> > +            replay_mode == REPLAY_MODE_RECORD ? "Recording" : "Replaying",
> > +            replay_get_filename(), replay_get_current_step());
> 
> You improved documentation to consistently say "instruction count".  The
> code still calls it current_step.  So does the HMP UI here.  In your
> shoes, I'd go all the way.  Consistent terminology really helps
> readers.  Advice, not demand.

Sounds reasonable. I'll probably refactor replay_get_current_step() too.

Pavel Dovgalyuk
