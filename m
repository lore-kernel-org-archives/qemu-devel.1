Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9B2FA374A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C805E217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUlkO8UT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C805E217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvJg-0005N8-V3
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iRvIq-0004Er-CN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iRvIn-0000wF-62
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:39:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iRvIn-0000uQ-1W
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572946744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gG8o93G1sglggJMz6anutO/LlkzOBk+K0RWvMl+DqH0=;
 b=TUlkO8UT2Re6K9TvdqwdxoMdiKUBHnjazR8eHFuawJLC19+/PYb/bMc3kfEyfNhBlaHcz+
 vZUrkghiwQjuciHd0bKlbVQFLWm9YpVt4mIxQhKFQcxkQicwGnvbqw9ypMp1wUU1vOgFA/
 JBDJ5+Hek7UsN6YT2kc0K3v6jgkjYGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-J4AMI4SBNlmXylo58nvuew-1; Tue, 05 Nov 2019 04:39:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45C6D107ACC2;
 Tue,  5 Nov 2019 09:39:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A777B1001B00;
 Tue,  5 Nov 2019 09:39:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 83E2F16E08; Tue,  5 Nov 2019 10:38:59 +0100 (CET)
Date: Tue, 5 Nov 2019 10:38:59 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: geoff@hostfission.com
Subject: Re: RFC: New device for zero-copy VM memory access
Message-ID: <20191105093859.53zmee2w4dcguaym@sirius.home.kraxel.org>
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
 <20191104102656.caomxar3xbv2wd5n@sirius.home.kraxel.org>
 <3296a09c5696d746b8295912892c4265@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <3296a09c5696d746b8295912892c4265@hostfission.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: J4AMI4SBNlmXylo58nvuew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 04, 2019 at 09:31:47PM +1100, geoff@hostfission.com wrote:
>=20
> On 2019-11-04 21:26, Gerd Hoffmann wrote:
> > Hi,
> >=20
> > > This new device, currently named `introspection` (which needs a more
> > > suitable name, porthole perhaps?), provides a means of translating
> > > guest physical addresses to host virtual addresses, and finally to th=
e
> > > host offsets in RAM for file-backed memory guests. It does this by
> > > means of a simple protocol over a unix socket (chardev) which is
> > > supplied the appropriate fd for the VM's system RAM. The guest (in
> > > this case, Windows), when presented with the address of a userspace
> > > buffer and size, will mlock the appropriate pages into RAM and pass
> > > guest physical addresses to the virtual device.
> >=20
> > So, if I understand things correctly, the workflow looks like this:
> >=20
> >   (1) guest allocates buffers, using guest ram.
> >   (2) guest uses these buffers as render target for the gpu
> > (pci-assigned I guess?).
> >   (3) guest passes guest physical address to qemu (via porthole device)=
.
> >   (4) qemu translates gpa into file offset and passes offsets to
> >       the client application.
> >   (5) client application maps all guest ram, then uses the offsets from
> >       qemu to find the buffers.  Then goes displaying these buffers I
> > guess.
> >=20
> > Correct?
>=20
> Correct, however step 5 might be a proxy to copy the buffers into another
> porthole device in a second VM allowing VM->VM transfers.
>=20
> > Performance aside for now, is it an option for your use case to simply
> > use both an emulated display device and the assigned gpu, then configur=
e
> > screen mirroring inside the guest to get the guest display scanned out
> > to the host?
>=20
> Unfortunately no, NVidia and AMD devices do not support mirroring their
> outputs to a separate GPU unless it's a professional-grade GPU such as a
> Quadro or Firepro.

Ok.

We had discussions about buffer sharing between host and guest before.


One possible approach would be to use virtio-gpu for that, because it
already has the buffer management bits (and alot of other stuff not
needed for this use case).  There is no support for shared buffers right
now (atm there are guest-side and host-side buffers and commands for
data transfers).  Shared buffer support is being worked on though, this
(and other changes) are here (look for udmabuf commits):
    https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/virtio-gpu-memory-v2

Note: udmabuf is a linux driver which allows to create dma-bufs from
guest memory pages.  These dma-bufs can be passed to other applications
using unix file descriptor passing, that way we could pass the buffers
from qemu to the client application.  The client can map them, or even
pass them on to the (host) gpu driver for display.

Requiring a full-blown display device just for buffer sharing might be a
bit of overkill though.  Another obvious drawback for your specific use
case is that there are no virtio-gpu windows drivers yet.


Another approach would be to design a new virtio device just for buffer
sharing.  Would probably be pretty simple, with one guest -> host queue
for sending buffer management commands.  Each buffer would be a list of
pages or (guest physical) address ranges.  Adding some properties would
probably be very useful too, so you can attach some metadata to the
buffers (i.e. id=3D42, application=3Dporthole, width=3D1024, height=3D768,
stride=3D4094, format=3DXR24, you get the idea ...).

On the host side we could again have qemu using the udmabuf driver to
create dma-bufs and hand them out to other applications so they can use
the buffers.  Alternatively use the vhost-user approach outlined
elsewhere in this thread.  Having qemu manage the buffers makes client
reconnects and multiple parallel applications alot easier though.

cheers,
  Gerd


