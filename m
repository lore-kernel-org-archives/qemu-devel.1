Received: from eggs.gnu.org ([2001:4830:134:3::10]:37492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ew1NS-00011n-IX
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 04:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ew1NP-00017d-Fp
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 04:03:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ew1NP-00017E-Ar
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 04:03:11 -0400
Date: Wed, 14 Mar 2018 09:03:01 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
References: <20180313154826.20436-1-kraxel@redhat.com>
	<20180313161035.GL4788@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180313161035.GL4788@phenom.ffwll.local>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RfC PATCH] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dri-devel@lists.freedesktop.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

  Hi,

> Either mlock account (because it's mlocked defacto), and get_user_pages
> won't do that for you.
>=20
> Or you write the full-blown userptr implementation, including mmu_notif=
ier
> support (see i915 or amdgpu), but that also requires Christian K=F6nigs
> latest ->invalidate_mapping RFC for dma-buf (since atm exporting userpt=
r
> buffers is a no-go).

I guess I'll look at mlock accounting for starters then.  Easier for
now, and leaves the door open to switch to userptr later as this should
be transparent to userspace.

> > Known issue:  Driver API isn't complete yet.  Need add some flags, fo=
r
> > example to support read-only buffers.
>=20
> dma-buf has no concept of read-only. I don't think we can even enforce
> that (not many iommus can enforce this iirc), so pretty much need to
> require r/w memory.

Ah, ok.  Just saw the 'write' arg for get_user_pages_fast and figured we
might support that, but if iommus can't handle that anyway it's
pointless indeed.

> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
> btw there's also the hyperdmabuf stuff from the xen folks, but imo thei=
r
> solution of forwarding the entire dma-buf api is over the top. This her=
e
> looks _much_ better, pls cc all the hyperdmabuf people on your next
> version.

Fun fact: googling for "hyperdmabuf" found me your mail and nothing else =
:-o
(Trying "hyper dmabuf" instead worked better then).

Yes, will cc them on the next version.  Not sure it'll help much on xen
though due to the memory management being very different.  Basically xen
owns the memory, not the kernel of the control domain (dom0), so
creating dmabufs for guest memory chunks isn't that simple ...

Also it's not clear whenever they really need guest -> guest exports or
guest -> dom0 exports.

> Overall I like the idea, but too lazy to review.

Cool.  General comments on the idea was all I was looking for for the
moment.  Spare yor review cycles for the next version ;)

> Oh, some kselftests for this stuff would be lovely.

I'll look into it.

thanks,
  Gerd
