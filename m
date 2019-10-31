Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB969CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 13:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7691D20862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 13:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTi0VCHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7691D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQATt-00029w-8l
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 09:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iQARb-0008Gz-Lk
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iQARZ-0004o4-IM
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:24:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iQARZ-0004i9-Dh
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572528292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BfPoJkXOtx1cbXQLBkjEk8zqwOokfiGSxQ8AkDHHex4=;
 b=gTi0VCHIs/4BDRgGlOrhb4OFI/CivtS6L0VGGKluCqtdfjSfaMf2ZmQV2P3nNpcAxxrTAJ
 H0Nweanj9zZGmnUNM7eD8StFYD/2GVtz29waiPDkJrc1XV0vjq9CL+80O7BV+Bh0q2d228
 KkmDRaL7Mnqd1Cy/5fzawB38b4tOYjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-dsY5JN3TMOumkKIL0l5e2g-1; Thu, 31 Oct 2019 09:24:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBCA11005500;
 Thu, 31 Oct 2019 13:24:46 +0000 (UTC)
Received: from work-vm (ovpn-116-247.ams2.redhat.com [10.36.116.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C1FF19C5B;
 Thu, 31 Oct 2019 13:24:45 +0000 (UTC)
Date: Thu, 31 Oct 2019 13:24:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: geoff@hostfission.com
Subject: Re: RFC: New device for zero-copy VM memory access
Message-ID: <20191031132443.GB3128@work-vm>
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
 <20191030185248.GC3114@work-vm>
 <88f1c3701740665b0ebe2f24c8ce7ade@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <88f1c3701740665b0ebe2f24c8ce7ade@hostfission.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dsY5JN3TMOumkKIL0l5e2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

* geoff@hostfission.com (geoff@hostfission.com) wrote:
> Hi Dave,
>=20
> On 2019-10-31 05:52, Dr. David Alan Gilbert wrote:
> > * geoff@hostfission.com (geoff@hostfission.com) wrote:
> > > Hi All,
> > >=20
> > > Over the past week, I have been working to come up with a solution
> > > to the
> > > memory transfer performance issues that hinder the Looking Glass
> > > Project.
> > >=20
> > > Currently Looking Glass works by using the IVSHMEM shared memory
> > > device
> > > which
> > > is fed by an application that captures the guest's video output.
> > > While this
> > > works it is sub-optimal because we first have to perform a CPU copy
> > > of the
> > > captured frame into shared RAM, and then back out again for display.
> > > Because
> > > the destination buffers are allocated by closed proprietary code
> > > (DirectX,
> > > or
> > > NVidia NvFBC) there is no way to have the frame placed directly into
> > > the
> > > IVSHMEM shared ram.
> > >=20
> > > This new device, currently named `introspection` (which needs a more
> > > suitable
> > > name, porthole perhaps?), provides a means of translating guest
> > > physical
> > > addresses to host virtual addresses, and finally to the host offsets
> > > in RAM
> > > for
> > > file-backed memory guests. It does this by means of a simple
> > > protocol over a
> > > unix socket (chardev) which is supplied the appropriate fd for the
> > > VM's
> > > system
> > > RAM. The guest (in this case, Windows), when presented with the
> > > address of a
> > > userspace buffer and size, will mlock the appropriate pages into RAM
> > > and
> > > pass
> > > guest physical addresses to the virtual device.
> >=20
> > Hi Geroggrey,
> >   I wonder if the same thing can be done by using the existing
> > vhost-user
> > mechanism.
> >=20
> >   vhost-user is intended for implementing a virtio device outside of th=
e
> > qemu process; so it has a character device that qemu passes commands
> > down
> > to the other process, where qemu mostly passes commands via the virtio
> > queues.   To be able to read the virtio queues, the external process
> > mmap's the same memory as the guest - it gets passed a 'set mem table'
> > command by qemu that includes fd's for the RAM, and includes base/offse=
t
> > pairs saying that a particular chunk of RAM is mapped at a particular
> > guest physical address.
> >=20
> >   Whether or not you make use of virtio queues, I think the mechanism
> > for the device to tell the external process the mappings might be what
> > you're after.
> >=20
> > Dave
> >=20
>=20
> While normally I would be all for re-using such code, the vhost-user whil=
e
> being very feature-complete from what I understand is overkill for our
> requirements. It will still allocate a communication ring and an events
> system
> that we will not be using. The goal of this device is to provide a dumb &
> simple method of sharing system ram, both for this project and for others
> that
> work on a simple polling mechanism, it is not intended to be an end-to-en=
d
> solution like vhost-user is.
>=20
> If you still believe that vhost-user should be used, I will do what I can=
 to
> implement it, but for such a simple device I honestly believe it is
> overkill.

It's certainly worth having a look at vhost-user even if you don't use
most of it;  you can configure it down to 1 (maybe 0?) queues if you're
really desperate - and you might find it comes in useful!  The actual
setup is pretty easy.

The process of synchronising with (potentially changing) host memory
mapping is a bit hairy; so if we can share it with vhost it's probably
worth it.

Dave

> -Geoff
>=20
> > > This device and the windows driver have been designed in such a way
> > > that
> > > it's a
> > > utility device for any project and/or application that could make
> > > use of it.
> > > The PCI subsystem vendor and device ID are used to provide a means
> > > of device
> > > identification in cases where multiple devices may be in use for
> > > differing
> > > applications. This also allows one common driver to be used for any
> > > other
> > > projects wishing to build on this device.
> > >=20
> > > My ultimate goal is to get this to a state where it could be accepted
> > > upstream
> > > into Qemu at which point Looking Glass would be modified to use it
> > > instead
> > > of
> > > the IVSHMEM device.
> > >=20
> > > My git repository with the new device can be found at:
> > > https://github.com/gnif/qemu
> > >=20
> > > The new device is:
> > > https://github.com/gnif/qemu/blob/master/hw/misc/introspection.c
> > >=20
> > > Looking Glass:
> > > https://looking-glass.hostfission.com/
> > >=20
> > > The windows driver, while working, needs some cleanup before the
> > > source is
> > > published. I intend to maintain both this device and the windows
> > > driver
> > > including producing a signed Windows 10 driver if Redhat are
> > > unwilling or
> > > unable.
> > >=20
> > > Kind Regards,
> > > Geoffrey McRae
> > >=20
> > > HostFission
> > > https://hostfission.com
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


