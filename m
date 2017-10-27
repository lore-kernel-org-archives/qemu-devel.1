Received: from eggs.gnu.org ([2001:4830:134:3::10]:41449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1e7zhE-0001dy-5E
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1e7zhA-00030w-0G
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:08:52 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:46668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1e7zh9-00030i-Lk
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:08:47 -0400
Received: by mail-io0-x243.google.com with SMTP id 101so10997708ioj.3
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 01:08:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150906187318.17222.17361197183146152660@sif>
References: <20170813155849.11368-1-sameeh@daynix.com>
	<150906187318.17222.17361197183146152660@sif>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Fri, 27 Oct 2017 11:08:46 +0300
Message-ID: <CAKPgXcGfgdMUt3tYKynrn+0nioi+qju10E+Jg9tjRhhObtUNqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

On Fri, Oct 27, 2017 at 2:51 AM, Michael Roth <mdroth@linux.vnet.ibm.com>
wrote:

> Quoting Sameeh Jubran (2017-08-13 10:58:46)
> > From: Sameeh Jubran <sjubran@redhat.com>
> >
> > This series fixes qemu-ga's behaviour upon facing a missing serial/serial
> > driver by listening to the serial device's events.
> >
> > For more info on why this series is needed checkout the commit message
> > of the third patch and the following bugzilla:
> https://bugzilla.redhat.com/show_bug.cgi?id=990629.
> >
> > Sameeh Jubran (3):
> >   qga: Channel: Add functions for checking serial status
> >   qga: main: make qga config and socket activation global
> >   qga: Prevent qemu-ga exit if serial doesn't exist
>
> Hi Sameeh,
>
> The event handling stuff is spiffy and could be useful for other use-cases
> (e.g. cpu/mem hotplug events that can be consumed by management), but since
> the actual bug here is somewhat of an edge case (we *could* just tell
> people that installing the agent before virtio-serial drivers is a bug,
> or that unplugging the agent's communication channel is a bad idea),
> I'm not too comfortable with adding this much complexity unless there's
> a stronger argument for it.
>
I can relate to your concerns, it is somehow an edge case but I think that
this
is the elegant way to handle it instead of just polling forever. This patch
series
is more related to Windows than Linux as this edge case is much more common
on Windows since when the virtio-serial driver is installed sometimes
usually
it requires a post-installation reboot and when the system is up, qemu-ga
runs before
the virtio-serial driver is fully configured and it fails to load and then
another reboot is needed.


>
> There's also a couple issues I had with this series as it stands, namely
> the lack of a ./configure check for udev (which could cause build
> breakage in some environments), and a lot of spillage of GAConfig into
> qga/channel-*, which I think could be avoided.
>
I think we can use the --retry with linux clients and use the device
notifications
API provided by Windows as it is supported since xp.

>
> I've sent an alternative series that I think we should consider as it
> uses a much simpler mechanism to implement this support (basically
> just periodically retrying the channel if it doesn't exist, or if it
> disappears for whatever reason). I've tested it on Windows, but would
> be good to confirm that it adequately addresses the use-case you were
> looking at. Thanks!
>
I haven't tested it yet, but I think it might solve the issue. Your series
is much
simpler and less intrusive to the code but I don't think this is the right
approach.

>
> >
> >  Makefile            |   4 +
> >  qga/channel-posix.c |  54 ++++++++++
> >  qga/channel-win32.c |  60 +++++++++++
> >  qga/channel.h       |   9 ++
> >  qga/main.c          | 284 ++++++++++++++++++++++++++++++
> ++++++++++++++++------
> >  qga/service-win32.h |   4 +
> >  6 files changed, 385 insertions(+), 30 deletions(-)
> >
> > --
> > 2.9.4
> >
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
