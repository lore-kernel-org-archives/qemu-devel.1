Received: from eggs.gnu.org ([2001:4830:134:3::10]:44107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eerHI-0000os-Oz
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 18:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eerHF-0008Te-HI
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 18:49:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eerHF-0008T2-84
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 18:49:53 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0PNnOE9051915
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 18:49:50 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fqr62t2p2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 18:49:49 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 25 Jan 2018 18:49:47 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAKPgXcFhy0-7xa3K3Co3x9EFys8yv0ZJC0S59Stc=xdggFY1aQ@mail.gmail.com>
References: <20170813155849.11368-1-sameeh@daynix.com>
	<150906187318.17222.17361197183146152660@sif>
	<CAKPgXcGfgdMUt3tYKynrn+0nioi+qju10E+Jg9tjRhhObtUNqg@mail.gmail.com>
	<CAKPgXcFhy0-7xa3K3Co3x9EFys8yv0ZJC0S59Stc=xdggFY1aQ@mail.gmail.com>
Date: Thu, 25 Jan 2018 17:49:38 -0600
Message-Id: <151692417819.4211.15296736041606011881@sif>
Subject: Re: [Qemu-devel] [PATCH 0/3]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

Quoting Sameeh Jubran (2018-01-22 08:24:29)
> Ping.

I think I would still prefer the alternative series I sent. Your
approach may be more correct/elegant but the asynchronous event-handling
nature of it makes it inherently more different to debug than the
boring synchronous loop in my series. There's also more work needed to
get this in shape and I honestly don't think it's worth the extra effort
it will take.

But if you feel strongly enough about it I wouldn't be opposed to a hybrid
of the 2 approaches that basically boils down to the following:

1) Base your code on top of my full series here:

     https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg06157.html

2) Drop the udev side of your code and only implement the
   win32 side of your code.

3) Modify your handle_serial_device_events() logic to not actually
   manage closing/opening the Channel, but to simply set a global flag,
   e.g. ga_state->channel_path_available appropriately based on
   DBT_DEVICEARRIVAL/DBT_DEVICEREMOVECOMPLETE. And since it's a
   win32-only optimization make sure it's just set to true permanently
   for !win32.

   Then use that flag as an optimization to the retry loop
   in run_agent() that was introduced in patch 4 of my series:
   =

   static int run_agent(GAState *s)
   {
       int ret =3D EXIT_SUCCESS;
   =

       s->force_exit =3D false;
   =

       do {
           ret =3D run_agent_once(s);
           if (s->config->retry_path && !s->force_exit) {
               g_warning("agent stopped unexpectedly, restarting...");
               sleep(QGA_RETRY_INTERVAL);
           }
       } while (s->config->retry_path && !s->force_exit);
   =

       return ret;
   }
   =

   by having your code changes introduce something like this:

   static int run_agent(GAState *s)
   {
       int ret =3D EXIT_SUCCESS;
   =

       s->force_exit =3D false;
   =

       do {
           ret =3D run_agent_once(s);
           if (s->config->retry_path && !s->force_exit) {
               g_warning("agent stopped unexpectedly, restarting...");
               while (!ga_state->channel_path_available) {
                 g_warning("waiting for channel path...");
                 sleep(QGA_RETRY_INTERVAL);
               }
           }
       } while (s->config->retry_path && !s->force_exit);
   =

       return ret;
   }

   It's still a loop but at least it's not trial-and-error based. If
   you want to get fancy with it though you can use something based
   around WaitForSingleObject or SetEvent to avoid gratuitous looping.

I think that would be much easier to make sense of, and it also lets us
handle this for POSIX without necessarily commiting to udev event loops
(though it also leaves that option open if we really wanted to).

It should also allow you to drop all your changes to the Channel code
since it's based around the changes I made to have Channel
implementations exit cleanly if their underlying device dies.

> =

> On Fri, Oct 27, 2017 at 10:08 AM, Sameeh Jubran <sameeh@daynix.com> wrote:
> =

> =

> =

>     On Fri, Oct 27, 2017 at 2:51 AM, Michael Roth <mdroth@linux.vnet.ibm.=
com>
>     wrote:
> =

>         Quoting Sameeh Jubran (2017-08-13 10:58:46)
>         > From: Sameeh Jubran <sjubran@redhat.com>
>         >
>         > This series fixes qemu-ga's behaviour upon facing a missing ser=
ial/
>         serial
>         > driver by listening to the serial device's events.
>         >
>         > For more info on why this series is needed checkout the commit
>         message
>         > of the third patch and the following bugzilla: https://
>         bugzilla.redhat.com/show_bug.cgi?id=3D990629.
>         >
>         > Sameeh Jubran (3):
>         >=C2=A0 =C2=A0qga: Channel: Add functions for checking serial sta=
tus
>         >=C2=A0 =C2=A0qga: main: make qga config and socket activation gl=
obal
>         >=C2=A0 =C2=A0qga: Prevent qemu-ga exit if serial doesn't exist
> =

>         Hi Sameeh,
> =

>         The event handling stuff is spiffy and could be useful for other
>         use-cases
>         (e.g. cpu/mem hotplug events that can be consumed by management),=
 but
>         since
>         the actual bug here is somewhat of an edge case (we *could* just =
tell
>         people that installing the agent before virtio-serial drivers is =
a bug,
>         or that unplugging the agent's communication channel is a bad ide=
a),
>         I'm not too comfortable with adding this much complexity unless t=
here's
>         a stronger argument for it.
> =

>     I can relate to your concerns, it is somehow an edge case but I think=
 that
>     this
>     is the elegant way to handle it instead of just polling forever. This=
 patch
>     series
>     is more related to Windows than Linux as this edge case is much more =
common
>     on Windows since when the virtio-serial driver is installed sometimes
>     usually
>     it requires a post-installation reboot and when the system is up, qem=
u-ga
>     runs before
>     the virtio-serial driver is fully configured and it fails to load and=
 then
>     another reboot is needed.=C2=A0
>     =C2=A0
> =

> =

>         There's also a couple issues I had with this series as it stands,
>         namely
>         the lack of a ./configure check for udev (which could cause build
>         breakage in some environments), and a lot of spillage of GAConfig=
 into
>         qga/channel-*, which I think could be avoided.
> =

>     I think we can use the --retry with linux clients and use the device
>     notifications
>     API provided by Windows as it is supported since xp.
>    =

> =

>         I've sent an alternative series that I think we should consider a=
s it
>         uses a much simpler mechanism to implement this support (basically
>         just periodically retrying the channel if it doesn't exist, or if=
 it
>         disappears for whatever reason). I've tested it on Windows, but w=
ould
>         be good to confirm that it adequately addresses the use-case you =
were
>         looking at. Thanks!
> =

>     I haven't tested it yet, but I think it might solve the issue. Your s=
eries
>     is much
>     simpler and less intrusive to the code but I don't think this is the =
right
>     approach.
>    =

> =

>         >
>         >=C2=A0 Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A04 +
>         >=C2=A0 qga/channel-posix.c |=C2=A0 54 ++++++++++
>         >=C2=A0 qga/channel-win32.c |=C2=A0 60 +++++++++++
>         >=C2=A0 qga/channel.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 ++
>         >=C2=A0 qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 284 ++++++=
++++++++++++++++++++++++
>         ++++++++++++++++------
>         >=C2=A0 qga/service-win32.h |=C2=A0 =C2=A04 +
>         >=C2=A0 6 files changed, 385 insertions(+), 30 deletions(-)
>         >
>         > --
>         > 2.9.4
>         >
> =

> =

>    =

> =

>    =

>     --
>     Respectfully,
>     Sameeh Jubran
>     Linkedin
>     Software Engineer @ Daynix.
> =

> =

> =

> =

> --
> Respectfully,
> Sameeh Jubran
> Linkedin
> Software Engineer @ Daynix.
