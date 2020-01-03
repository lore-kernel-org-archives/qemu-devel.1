Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40F8C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A094221835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKj/I0y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A094221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inLPA-0005dc-NF
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1inLNl-0004iQ-1u
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1inLNi-0006zd-Gi
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:44:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1inLNi-0006oe-6F
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578051880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIhHOZ7DVBsAYfTvFN38Vw76cUT9sCw2fvgmVkYb+X8=;
 b=gKj/I0y1eFc+Q21hWpcomcJYk9FUoSe2CTOS9Qgs1bAX9AN8VtNt9FYt12X8XqRf7ArTNX
 YPqa/E14vkeJwvL8QmhvKVTQ7b6+QDjIQs0DHvFZ2piJ+w7oyvvZRTmpt+JE0iupX9l1yp
 GGobIQodADODogdzFcWRO5i4nyQrnoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-KoXI53XxP6SdBsFBU-lHFQ-1; Fri, 03 Jan 2020 06:44:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7535A107ACC4;
 Fri,  3 Jan 2020 11:44:37 +0000 (UTC)
Received: from work-vm (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4B2C5D9C9;
 Fri,  3 Jan 2020 11:44:29 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:44:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 0/1] Removing RAMBlocks during migration
Message-ID: <20200103114427.GD3804@work-vm>
References: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
 <20191211111655.GC3875@work-vm>
 <279541577091067@sas1-eb34c5849710.qloud-c.yandex.net>
MIME-Version: 1.0
In-Reply-To: <279541577091067@sas1-eb34c5849710.qloud-c.yandex.net>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: KoXI53XxP6SdBsFBU-lHFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Hi!
>=20
> 11.12.2019, 14:17, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> >> =A0Hi,
> >>
> >> =A0I found that it's possible to remove a RAMBlock during migration.
> >> =A0E.g. device hot-unplugging initiated by a guest (how to reproduce i=
s below).
> >> =A0And I want to clarify whether RAMBlock removing (or even adding) du=
ring
> >> =A0migration is valid operation or it's a bug.
> >>
> >> =A0Currently, it may cause some race conditions with migration thread =
and
> >> =A0migration may fail because of them. For instance, vmstate_unregiste=
r_ram
> >> =A0function which is called during PCIe device removing does these:
> >> =A0- Memset idstr -> target may receive unknown/zeroed idstr -> migrat=
ion fail
> >> =A0- Set RAMBlock flags as non-migratable -> migration fail
> >>
> >> =A0RAMBlock removing itself seems safe for migration thread because of=
 RCU.
> >> =A0But it seems to me there are other possible race conditions (didn't=
 test it):
> >> =A0- qemu_put_buffer_async -> saves pointer to RAMBlock's memory
> >> =A0=A0=A0=A0-> block will be freed out of RCU (between ram save iterat=
ions)
> >> =A0=A0=A0=A0-> qemu_fflush -> access to freed memory.
> >>
> >> =A0So, I have the following questions:
> >> =A01. Is RAMBlock removing/adding OK during migration?
> >
> > I don't think that any hot(un)plug is safe during migration.
> > While it's true we hold RCUs as we walk lists, we can't hold the RCU
> > around the entire migration.
>=20
> I agree. Currently, it's unsafe to do any hot(un)plug.
> But I thought (and wanted to clarify) it would be nice to make it safe.
> Hold the RCU around the entire migration is not the only way actually.
> For example, we can defer RAMBlock deletion: refcount RAMBlocks before
> migration and unref them after migration.

Yes, that might work.

> >
> > There's lots of other problems; for example we call the .save_setup
> > methods on devices at the start of migration, but then call the iterate
> > on those devices later - if the device is added/removed between stages
> > we'll end up either having done a setup and not calling the actual save=
,
> > or the other way around.
>=20
> Hm... Yeah, that's a problem, thanks for mentioning it!
>=20
> >
> > Juan added checks to qdev_device_add/qdev_unplug in b06424d ~2.5 years
> > ago.
>=20
> I see that hot(un)plug during migration has many issues.
> But generally it has three groups (if I didn't miss something):
> 1) RAMBlock add/del
> 2) Device add/del
> 3) VMState add/del
>=20
> IIUC, RAMBlocks are not always connected to some devices.
> So, in theory, it might become possible to hot(un)plug a block
> without hot adding/removing a device. It's why I wanted to clarify
> is there a sense to fix separately the problems related to RAMBlocks.

Possibly true.

> But, if you think there is no sense to fix all related problems
> to let hot(un)plugging during migration be allowed, I think we can add
> an assert(!migrate_is_idle()) in qemu_ram_free.

is_idle is probably the wrong thing, because of the new WAIT_UNPLUG
state that happens just after setup and is designed to allow vfio
devices to be unplugged before we actually start the guts of the
migration; however the idea makes sense.

> >> =A02. If yes then what should we do with vmstate_unregister_ram?
> >> =A0=A0=A0=A0- Just remove vmstate_unregister_ram (my RFC patch)
> >> =A0=A0=A0=A0- Refcount RAMBlock's migratable/non-migratable state
> >> =A0=A0=A0=A0- Something else?
> >> =A03. If it mustn't be possible, so may be
> >> =A0=A0=A0=A0assert(migration_is_idle()) in qemu_ram_free?
> >>
> >> =A0P.S.
> >> =A0I'm working on a fix of below problem and trying to choose better w=
ay:
> >> =A0allow device removing and fix all problem like this or fix a partic=
ular device.
> >>
> >> =A0--------
> >> =A0How to reproduce device removing during migration:
> >>
> >> =A01. Source QEMU command line (target is similar)
> >> =A0=A0=A0$ x86_64-softmmu/qemu-system-x86_64 \
> >> =A0=A0=A0=A0=A0-nodefaults -no-user-config -m 1024 -M q35 \
> >> =A0=A0=A0=A0=A0-qmp unix:./src.sock,server,nowait \
> >> =A0=A0=A0=A0=A0-drive file=3D./image,format=3Draw,if=3Dvirtio \
> >> =A0=A0=A0=A0=A0-device ioh3420,id=3Dpcie.1 \
> >> =A0=A0=A0=A0=A0-device virtio-net,bus=3Dpcie.1
> >> =A02. Start migration with slow speed (to simplify reproducing)
> >> =A03. Power off a device on the hotplug pcie.1 bus:
> >> =A0=A0=A0$ echo 0 > /sys/bus/pci/slots/0/power
> >> =A04. Increase migration speed and wait until fail
> >>
> >> =A0Most likely you will get something like this:
> >> =A0=A0=A0qemu-system-x86_64: get_pci_config_device: Bad config data:
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i=3D0xaa read: 0 device: 40 cmask: ff=
 wmask: 0 w1cmask:19
> >> =A0=A0=A0qemu-system-x86_64: Failed to load PCIDevice:config
> >> =A0=A0=A0qemu-system-x86_64: Failed to load
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ioh-3240-express-root-port:parent_obj=
.parent_obj.parent_obj
> >> =A0=A0=A0qemu-system-x86_64: error while loading state for instance 0x=
0 of device
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'0000:00:03.0/ioh-3240-express-root-p=
ort'
> >> =A0=A0=A0qemu-system-x86_64: load of migration failed: Invalid argumen=
t
> >>
> >> =A0This error is just an illustration of the removing device possibili=
ty,
> >> =A0but not actually an illustration of the race conditions for removin=
g RAMBlock.
> >
> > What path does this actually take - does it end up going via qdev_unplu=
g
> > or some other way?
>=20
> 1) Guest: writes to slot's pci config
> 2) QEMU: pcie_cap_slot_write_config -> pcie_unplug_device
>=20
> So, it's only guest driven action and qdev_unplug doesn't help here.

Hmm we need to find a way to stop that; lets see if Michael Tsirkin has
any ideas (cc'd) - I'm thinking if we could defer the unplug until the
end of the migration we'd be OK; but it feels racy as to whether the
destination is started with the device that the guest is unplugging.

Dave

> >
> > Dave
> >
> >> =A0Regards,
> >> =A0Yury
> >>
> >> =A0Yury Kotov (1):
> >> =A0=A0=A0migration: Remove vmstate_unregister_ram
> >>
> >> =A0=A0hw/block/pflash_cfi01.c | 1 -
> >> =A0=A0hw/block/pflash_cfi02.c | 1 -
> >> =A0=A0hw/mem/pc-dimm.c | 5 -----
> >> =A0=A0hw/misc/ivshmem.c | 2 --
> >> =A0=A0hw/pci/pci.c | 1 -
> >> =A0=A0include/migration/vmstate.h | 1 -
> >> =A0=A0migration/savevm.c | 6 ------
> >> =A0=A07 files changed, 17 deletions(-)
> >>
> >> =A0--
> >> =A02.24.0
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
> Regards,
> Yury
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


