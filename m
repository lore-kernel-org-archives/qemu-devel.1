Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48D5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DC121556
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8E6ohOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DC121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if1tb-0004Ni-Ns
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1if1s3-0003K6-2y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1if1rz-0000p7-TV
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:17:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33836
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1if1rz-0000ne-OZ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576070254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mo0z5QojFHlBv/jCsdFtEh+2kA9z5SolgPHUFAC+3DI=;
 b=Z8E6ohOpQVzj2QJgPcHwuOZEFRQw7mfcb7ihwgVJc1nY58MVb0WPQYAP8/7o03jczjFSp+
 7uYqLZNZGPOTKV8wFEZQoqsU88LK/mNM5G5TX7kbFAjWsdI4k8UR5VGTLZt0Pd1dRjGjX3
 Imjxb+4Orvse86fydI8o14x22LhR4q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-p4yD34fRMeSLaU8sKx5XKw-1; Wed, 11 Dec 2019 06:17:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86691800D5E;
 Wed, 11 Dec 2019 11:17:08 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 872806A022;
 Wed, 11 Dec 2019 11:16:57 +0000 (UTC)
Date: Wed, 11 Dec 2019 11:16:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [RFC PATCH 0/1] Removing RAMBlocks during migration
Message-ID: <20191211111655.GC3875@work-vm>
References: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: p4yD34fRMeSLaU8sKx5XKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, yc-core@yandex-team.ru,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Hi,
>=20
> I found that it's possible to remove a RAMBlock during migration.
> E.g. device hot-unplugging initiated by a guest (how to reproduce is belo=
w).
> And I want to clarify whether RAMBlock removing (or even adding) during
> migration is valid operation or it's a bug.
>=20
> Currently, it may cause some race conditions with migration thread and
> migration may fail because of them. For instance, vmstate_unregister_ram
> function which is called during PCIe device removing does these:
> - Memset idstr -> target may receive unknown/zeroed idstr -> migration fa=
il
> - Set RAMBlock flags as non-migratable -> migration fail
>=20
> RAMBlock removing itself seems safe for migration thread because of RCU.
> But it seems to me there are other possible race conditions (didn't test =
it):
> - qemu_put_buffer_async -> saves pointer to RAMBlock's memory
>    -> block will be freed out of RCU (between ram save iterations)
>    -> qemu_fflush -> access to freed memory.
>=20
> So, I have the following questions:
> 1. Is RAMBlock removing/adding OK during migration?

I don't think that any hot(un)plug is safe during migration.
While it's true we hold RCUs as we walk lists, we can't hold the RCU
around the entire migration.

There's lots of other problems;  for example we call the .save_setup
methods on devices at the start of migration, but then call the iterate
on those devices later - if the device is added/removed between stages
we'll end up either having done a setup and not calling the actual save,
or the other way around.

Juan added checks to qdev_device_add/qdev_unplug in b06424d ~2.5 years
ago.

> 2. If yes then what should we do with vmstate_unregister_ram?
>    - Just remove vmstate_unregister_ram (my RFC patch)
>    - Refcount RAMBlock's migratable/non-migratable state
>    - Something else?
> 3. If it mustn't be possible, so may be
>    assert(migration_is_idle()) in qemu_ram_free?
>=20
> P.S.
> I'm working on a fix of below problem and trying to choose better way:
> allow device removing and fix all problem like this or fix a particular d=
evice.
>=20
> --------
> How to reproduce device removing during migration:
>=20
> 1. Source QEMU command line (target is similar)
>   $ x86_64-softmmu/qemu-system-x86_64 \
>     -nodefaults -no-user-config -m 1024 -M q35 \
>     -qmp unix:./src.sock,server,nowait \
>     -drive file=3D./image,format=3Draw,if=3Dvirtio \
>     -device ioh3420,id=3Dpcie.1 \
>     -device virtio-net,bus=3Dpcie.1
> 2. Start migration with slow speed (to simplify reproducing)
> 3. Power off a device on the hotplug pcie.1 bus:
>   $ echo 0 > /sys/bus/pci/slots/0/power
> 4. Increase migration speed and wait until fail
>=20
> Most likely you will get something like this:
>   qemu-system-x86_64: get_pci_config_device: Bad config data:
>           i=3D0xaa read: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
>   qemu-system-x86_64: Failed to load PCIDevice:config
>   qemu-system-x86_64: Failed to load
>           ioh-3240-express-root-port:parent_obj.parent_obj.parent_obj
>   qemu-system-x86_64: error while loading state for instance 0x0 of devic=
e
>           '0000:00:03.0/ioh-3240-express-root-port'
>   qemu-system-x86_64: load of migration failed: Invalid argument
>=20
> This error is just an illustration of the removing device possibility,
> but not actually an illustration of the race conditions for removing RAMB=
lock.

What path does this actually take - does it end up going via qdev_unplug
or some other way?

Dave

> Regards,
> Yury
>=20
> Yury Kotov (1):
>   migration: Remove vmstate_unregister_ram
>=20
>  hw/block/pflash_cfi01.c     | 1 -
>  hw/block/pflash_cfi02.c     | 1 -
>  hw/mem/pc-dimm.c            | 5 -----
>  hw/misc/ivshmem.c           | 2 --
>  hw/pci/pci.c                | 1 -
>  include/migration/vmstate.h | 1 -
>  migration/savevm.c          | 6 ------
>  7 files changed, 17 deletions(-)
>=20
> --=20
> 2.24.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


