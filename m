Received: from eggs.gnu.org ([209.51.188.92]:50184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghuNp-00013G-D8
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghuNn-0003Dp-9v
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:49:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghuNh-0003B8-U4
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:49:42 -0500
Date: Fri, 11 Jan 2019 11:49:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111104923.GD5010@dhcp-200-186.str.redhat.com>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
	<154703599022.13472.1704009113561450219.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154703599022.13472.1704009113561450219.stgit@pasha-VirtualBox>
Subject: Re: [Qemu-devel] [PATCH v9 19/21] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Am 09.01.2019 um 13:13 hat Pavel Dovgalyuk geschrieben:
> Replay is capable of recording normal BH events, but sometimes
> there are single use callbacks scheduled with aio_bh_schedule_oneshot
> function. This patch enables recording and replaying such callbacks.
> Block layer uses these events for calling the completion function.
> Replaying these calls makes the execution deterministic.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This still doesn't come even close to catching all BHs that need to be
caught. While you managed to show a few BHs that actually don't need to
be considered for recording when I asked for this in v7, most BHs in the
block layer can in some way lead to device callbacks and must therefore
be recorded.

How bad would it be to record some BHs even if recording them isn't
necessary? I'd definitely try to err on the safe side here. Having two
different sets of BH functions, you can't expect that people always use
the right one (especially if you don't even make the existing code base
consistently use the right one intially).

Kevin
