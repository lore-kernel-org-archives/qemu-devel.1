Received: from eggs.gnu.org ([2001:4830:134:3::10]:43831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY4Ie-0004OC-7i
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY4Ib-0007uh-5E
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:51:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fY4Ib-0007tK-0Y
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:51:29 -0400
Date: Wed, 27 Jun 2018 08:51:26 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
Subject: Re: [Qemu-devel] [PULL 1/6] audio/hda: create millisecond timers
 that handle IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Martin Schrodt <martin@schrodt.org>

> > Signed-off-by: Martin Schrodt <martin@schrodt.org>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > Message-id: 20180622111200.30561-2-kraxel@redhat.com
> > Message-id: 20171015184033.2951-3-martin@schrodt.org
> > 
> > [ kraxel: keep old code for compatibility with older qemu versions,
> >           add property to switch code paths at runtime ]
> > [ kraxel: new code is disabled by default, use-timer=on enables it ]
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  hw/audio/hda-codec.c | 263 ++++++++++++++++++++++++++++++++++++++++++++++-----
> >  hw/audio/intel-hda.c |   7 --
> >  2 files changed, 237 insertions(+), 33 deletions(-)
> 
> This patch breaks compilation on clang with -m32 for me, because I
> apparently I don't have 64 bit atomics there.  Should there be
> CONFIG_ATOMIC64 guards and handling for when that isn't defined?

Given the code runs under big qemu lock anyway the atomics are not
needed, so we could drop just them.  I left them in nevertheless because

  (a) we might want try run the code in a thread instead of using a timer, and
  (b) I was too lazy to rewrite the code to drop the atomics.

I'd prefer to keep option (a) ...

Using int32_t instead of int64_t for rpos and wpos would be another way.
Also not that great because they will wrap then after playing sound for
roughly 6 hours.

Using int32_t on 32bit hosts only (or depending on CONFIG_ATOMIC64) is
bad too because rpos and wpos are in vmstate, so the live migration
stream format changes.

Hmm.

Drop support for 32bit hosts in qemu?

cheers,
  Gerd
