Received: from eggs.gnu.org ([2001:4830:134:3::10]:34167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rw1-00085t-BU
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rvy-0007aN-8Y
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:51:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54218
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7rvy-0007Zp-2K
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:51:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QNeRtd021080
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:51:29 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dusbcs06k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:51:29 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 17:51:28 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170813155849.11368-1-sameeh@daynix.com>
References: <20170813155849.11368-1-sameeh@daynix.com>
Date: Thu, 26 Oct 2017 18:51:13 -0500
Message-Id: <150906187318.17222.17361197183146152660@sif>
Subject: Re: [Qemu-devel] [PATCH 0/3]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: yan@daynix.com

Quoting Sameeh Jubran (2017-08-13 10:58:46)
> From: Sameeh Jubran <sjubran@redhat.com>
> =

> This series fixes qemu-ga's behaviour upon facing a missing serial/serial
> driver by listening to the serial device's events.
> =

> For more info on why this series is needed checkout the commit message
> of the third patch and the following bugzilla: https://bugzilla.redhat.co=
m/show_bug.cgi?id=3D990629.
> =

> Sameeh Jubran (3):
>   qga: Channel: Add functions for checking serial status
>   qga: main: make qga config and socket activation global
>   qga: Prevent qemu-ga exit if serial doesn't exist

Hi Sameeh,

The event handling stuff is spiffy and could be useful for other use-cases
(e.g. cpu/mem hotplug events that can be consumed by management), but since
the actual bug here is somewhat of an edge case (we *could* just tell
people that installing the agent before virtio-serial drivers is a bug,
or that unplugging the agent's communication channel is a bad idea),
I'm not too comfortable with adding this much complexity unless there's
a stronger argument for it.

There's also a couple issues I had with this series as it stands, namely
the lack of a ./configure check for udev (which could cause build
breakage in some environments), and a lot of spillage of GAConfig into
qga/channel-*, which I think could be avoided.

I've sent an alternative series that I think we should consider as it
uses a much simpler mechanism to implement this support (basically
just periodically retrying the channel if it doesn't exist, or if it
disappears for whatever reason). I've tested it on Windows, but would
be good to confirm that it adequately addresses the use-case you were
looking at. Thanks!

> =

>  Makefile            |   4 +
>  qga/channel-posix.c |  54 ++++++++++
>  qga/channel-win32.c |  60 +++++++++++
>  qga/channel.h       |   9 ++
>  qga/main.c          | 284 ++++++++++++++++++++++++++++++++++++++++++++++=
------
>  qga/service-win32.h |   4 +
>  6 files changed, 385 insertions(+), 30 deletions(-)
> =

> -- =

> 2.9.4
>=20
