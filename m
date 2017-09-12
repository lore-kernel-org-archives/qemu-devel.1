Received: from eggs.gnu.org ([2001:4830:134:3::10]:36890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1drlx2-0000Ci-Lg
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1drlwy-0004Me-LK
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:14:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1drlwy-0004LQ-Ff
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:14:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2560C0587DD
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 14:14:03 +0000 (UTC)
Message-ID: <1505225092.31639.22.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 12 Sep 2017 16:04:52 +0200
In-Reply-To: <20170912124731.GF17633@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<20170912123744.14730-6-berrange@redhat.com>
	<20170912124731.GF17633@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 05/12] input: convert virtio-input-hid
 device to keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

  Hi,

> From what I can see the guest OS will read this bitmap when it first
> probes the virtio device, and never updates it.=C2=A0=C2=A0If so, then =
is it
> actually a problem if we don't preserve the same map across save/
> restore/migrate ?

virtio-input config space size isn't fixed, instead it'll take up as
many bytes as actually needed.  So, when adding keys it can happen that
the bitmap needed grows, therefore the config space grows.  Not sure
whenever live migration trips over that, needs checking.

> If we added a key to the bitmap, we would potentially be sending
> a key to the guest that we hadn't previously declared support for.
> Either the guest OS will handle this normally, despite it not
> being in the declared bitmap, or it will silently drop the event.
> Neither behaviour seems problematic.

Yes, in theory the guest drivers should be robust enough.
We should check though whenever that is actually the case.

> If we did need to preserve ABI for this bitmap, then it seems we're
> going to create alot of work for ourselves, having to maintain
> many historical copies of the keycode maps tables, adding a new
> copy every time support for a new key is added in QEMU.

That's why I've suggested to not touch that for now, and once the dust
has settled and QKeyCode got all the keys still missing create a v2 of
the device, so we don't end up with many different versions.

cheers,
  Gerd
