Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2508C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1DA2075D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hthbX2hB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1DA2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip8Wo-0006Q0-Rn
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ip8WD-0005zv-Gs
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ip8WB-0000aq-JX
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:24:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ip8WB-0000Zy-Fw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578479090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZQzTVUhteJ0VlibZFWrpb30VJb+bA+dcrRUDaEO6TQ=;
 b=hthbX2hB9h9nbz2T+bzyy/36Xshb5xqIF4j8z3Nvv+18t2OQUhWfOyhHpSi/ibBxv5iK+H
 FD8hcaYx7D1QJanZRHWPaGglA73UyEIcUjwmwWgfPYuYXgJrhayO0+ertFUZnMICemJPnM
 FYzHysjP4fePvup9IcGvdQzXcKIUD40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-Va0Zzrt-NASAaw18iDAV9Q-1; Wed, 08 Jan 2020 05:24:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0A58C4977;
 Wed,  8 Jan 2020 10:24:45 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B43F80F40;
 Wed,  8 Jan 2020 10:24:19 +0000 (UTC)
Date: Wed, 8 Jan 2020 10:24:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 0/1] Removing RAMBlocks during migration
Message-ID: <20200108102417.GC3136@work-vm>
References: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
 <20191211111655.GC3875@work-vm>
 <279541577091067@sas1-eb34c5849710.qloud-c.yandex.net>
 <20200103114427.GD3804@work-vm>
 <20200107150301-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200107150301-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Va0Zzrt-NASAaw18iDAV9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>, jusual@redhat.com,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Fri, Jan 03, 2020 at 11:44:27AM +0000, Dr. David Alan Gilbert wrote:
> > > 1) Guest: writes to slot's pci config
> > > 2) QEMU: pcie_cap_slot_write_config -> pcie_unplug_device
> > >=20
> > > So, it's only guest driven action and qdev_unplug doesn't help here.
> >=20
> > Hmm we need to find a way to stop that; lets see if Michael Tsirkin has
> > any ideas (cc'd) - I'm thinking if we could defer the unplug until the
> > end of the migration we'd be OK; but it feels racy as to whether the
> > destination is started with the device that the guest is unplugging.
> >=20
> > Dave
>=20
> It's true - and same is possible with PCI, guest can remove device
> at will.
>=20
> Also, while libvirt learned not to start device del while migration
> is active, it's annoying to have to wait for device del
> to complete before migration can be started.
>=20
> I guess we can make device invisible to guest - that concept
> now exists because of failover, and can maybe be reused here.
>=20
> Alternatively or additionally - for a while now I wanted to only remove
> the device if guest powered it out and removal was requested.  Again it
> might be easier now that we have a concept of an invisible device.

How do invisible devices wrok? Is that something that each device has to
learn about?
Would we only make them invisible for migration and then do a full
hotunplug on the destination after the migration finishes?

Dave

>=20
>=20
> --=20
> MST
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


