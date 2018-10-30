Received: from eggs.gnu.org ([2001:4830:134:3::10]:43136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHV4W-00066v-3Z
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHV4S-0007BH-2Q
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:32:43 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHV4R-00078r-Pa
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:32:39 -0400
Received: by mail-oi1-x244.google.com with SMTP id u130-v6so5826834oie.7
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:32:37 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181007110223.129692-1-bishara@daynix.com>
References: <20181007110223.129692-1-bishara@daynix.com>
Message-ID: <154090993308.20054.3946200530560282137@sif>
Date: Tue, 30 Oct 2018 09:32:13 -0500
Subject: Re: [Qemu-devel] [PATCH v2 0/7] qga: add support for re-opening
 channel on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bishara AbuHattoum <bishara@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Sameeh Jubran <sameeh@daynix.com>

Quoting Bishara AbuHattoum (2018-10-07 06:02:16)
> Changes from v1:
>  [1/7] qga: group agent init/cleanup init separate routines
>          Fixed typo in the commit message and dropped the unnecessary mes=
sage ID
>  [2/7] qga: hang GAConfig/socket_activation off of GAState global
>          Dropped the unnecessary message ID
>  [3/7] qga: move w32 service handling out of run_agent()
>          Fixed run_agent() extra call and dropped the unnecessary message=
 ID =

>  [4/7] qga: add --retry-path option for re-initializing channel on failure
>          Dropped the unnecessary message ID
>  [5/7] qga-win: install service with --retry-path set by default
>          Dropped the unnecessary message ID
>  [6/7] qga-win: report specific error when failing to open channel
>          Dropped the unnecessary message ID
>  [7/7] qga-win: changing --retry-path option behavior
>          Dropped the use of two events and WaitForMultipleObjects, and us=
ed
>          one 'wakeup_event'.
> =

> A patch series was firstly introduced about a year ago which resolves an =
issue
> with qemu-ga and virtio-serial functionality. The issue was discussed in =
the
> following thread:
>   https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06256.html
> =

> In short, Sameeh sent an implementation which uses udev on Linux and devi=
ce
> events API on Windows. Since udev API is only supported for kernels 2.6+ =
it is
> not a good approach and Michael suggested his alternative series which us=
es a
> loop and checks if the serial is present or not. Since the Windows API is
> supported and has backward compatibility up until Windows xp, there is no=
 reason
> for not using the Windows API. It was finally agreed by Michael and Samee=
h that
> a combination of both approaches should be used.
> =

> This series does just that, it rebases Michael's patches on top of upstre=
am and
> merges Sameeh's patches for Windows API into Michael's implementation.
> =

> Michael's series:
>   https://github.com/mdroth/qemu/commits/qga-retry-path
> Sameeh's series:
>   https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02400.html
>   https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02399.html
>   https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02401.html

Thanks, applied to qga tree with some minor fix-ups:
  https://github.com/mdroth/qemu/commits/qga

> =

> Bishara AbuHattoum (1):
>   qga-win: changing --retry-path option behavior
> =

> Michael Roth (6):
>   qga: group agent init/cleanup init separate routines
>   qga: hang GAConfig/socket_activation off of GAState global
>   qga: move w32 service handling out of run_agent()
>   qga: add --retry-path option for re-initializing channel on failure
>   qga-win: install service with --retry-path set by default
>   qga-win: report specific error when failing to open channel
> =

>  qga/channel-win32.c       |   3 +-
>  qga/installer/qemu-ga.wxs |   2 +-
>  qga/main.c                | 288 +++++++++++++++++++++++++++++---------
>  qga/service-win32.h       |   4 +
>  4 files changed, 229 insertions(+), 68 deletions(-)
> =

> -- =

> 2.17.0
>=20
