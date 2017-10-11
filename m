Received: from eggs.gnu.org ([2001:4830:134:3::10]:38982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2B1S-0002fI-GG
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2B1P-0003OJ-BC
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2B1P-0003Mj-4W
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:01:39 -0400
Message-ID: <1507705293.31518.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Oct 2017 09:01:33 +0200
In-Reply-To: <20171010142706.360019aa@t450s.home>
References: <20171010140334.8231-1-kraxel@redhat.com>
	<20171010140334.8231-7-kraxel@redhat.com>
	<20171010142706.360019aa@t450s.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RfC PATCH 6/6] vfio/display: add dmabuf support
 (v15)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org

  Hi,

> Looks pretty straight forward otherwise.=C2=A0=C2=A0I like the LRU dmab=
uf
> freeing, but is it mostly for validating the interface?=C2=A0=C2=A0My
> impression
> is that we'd reach a steady state with a single plane and single
> cursor so I wonder if keeping that cache really provides a noticeable
> benefit.

Really depends on what the guest is doing.  I didn't do too much
testing with various cache sizes and guests yet.

> =C2=A0=C2=A0Perhaps for a Linux guest switching between vt and graphics
> mode?

fbcon/vt is one dmabuf.  xorg I have seen using multiple primary plane
dma-bufs, dunno why, doesn't change often.  wayland does page-flipping
on each rendered frame, which translates to very frequent dma-buf
changes and I expect the caching will pay off here.

cursor dma-buf with xorg changes each time the cursor shape changes.

> =C2=A0=C2=A0It also seems like the primary and cursor will be fighting =
for
> the head of the list, so if we keep lists, maybe they should be per
> plane type.

Makes sense indeed.

> This uses the x-display option for now, how do we move past that to
> get
> automatic configuration?

I think a OnOffAuto display property would be the best choice.

cheers,
  Gerd
