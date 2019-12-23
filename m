Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F1FC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8F3206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="m72ZjsJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8F3206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJRm-0003TW-T9
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 03:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ijJR5-0002ml-IK
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ijJR1-0003hZ-Q1
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:51:29 -0500
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:55164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ijJR1-0003Gf-0h
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:51:27 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C5EC12E1324;
 Mon, 23 Dec 2019 11:51:20 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 4kgEUdnXyy-pHEOeR6d; Mon, 23 Dec 2019 11:51:20 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1577091080; bh=Rn0jVvlKdWJVHTZwGZ478v0wTYUvQAhBbcIY1Hol8UE=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=m72ZjsJ9qngWHFRbOWF/PyfeeMIJAJ+BB5S8mGu/iMoo9pEIqTFwkNfLClHug9uaC
 tBOccYqXBvjRYSPZyvHy42Dx9R5x8DNQ0P99eHyoYi4mAPoQZupKXky7YYpRbokPtG
 m2IbJM00kLAhsD90CZdMekqN/z/5cBohzHYP3HQQ=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net (localhost [::1])
 by mxbackcorp1g.mail.yandex.net with LMTP id OVKjRRCKue-ESrhiKUl
 for <yury-kotov@yandex-team.ru>; Mon, 23 Dec 2019 11:51:07 +0300
Received: by sas1-eb34c5849710.qloud-c.yandex.net with HTTP;
 Mon, 23 Dec 2019 11:51:07 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <20191211111655.GC3875@work-vm>
References: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
 <20191211111655.GC3875@work-vm>
Subject: Re: [RFC PATCH 0/1] Removing RAMBlocks during migration
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 23 Dec 2019 11:51:17 +0300
Message-Id: <279541577091067@sas1-eb34c5849710.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1619::183
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
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
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

11.12.2019, 14:17, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0Hi,
>>
>> =C2=A0I found that it's possible to remove a RAMBlock during migration=
.
>> =C2=A0E.g. device hot-unplugging initiated by a guest (how to reproduc=
e is below).
>> =C2=A0And I want to clarify whether RAMBlock removing (or even adding)=
 during
>> =C2=A0migration is valid operation or it's a bug.
>>
>> =C2=A0Currently, it may cause some race conditions with migration thre=
ad and
>> =C2=A0migration may fail because of them. For instance, vmstate_unregi=
ster_ram
>> =C2=A0function which is called during PCIe device removing does these:
>> =C2=A0- Memset idstr -> target may receive unknown/zeroed idstr -> mig=
ration fail
>> =C2=A0- Set RAMBlock flags as non-migratable -> migration fail
>>
>> =C2=A0RAMBlock removing itself seems safe for migration thread because=
 of RCU.
>> =C2=A0But it seems to me there are other possible race conditions (did=
n't test it):
>> =C2=A0- qemu_put_buffer_async -> saves pointer to RAMBlock's memory
>> =C2=A0=C2=A0=C2=A0=C2=A0-> block will be freed out of RCU (between ram=
 save iterations)
>> =C2=A0=C2=A0=C2=A0=C2=A0-> qemu_fflush -> access to freed memory.
>>
>> =C2=A0So, I have the following questions:
>> =C2=A01. Is RAMBlock removing/adding OK during migration?
>
> I don't think that any hot(un)plug is safe during migration.
> While it's true we hold RCUs as we walk lists, we can't hold the RCU
> around the entire migration.

I agree. Currently, it's unsafe to do any hot(un)plug.
But I thought (and wanted to clarify) it would be nice to make it safe.
Hold the RCU around the entire migration is not the only way actually.
For example, we can defer RAMBlock deletion: refcount RAMBlocks before
migration and unref them after migration.

>
> There's lots of other problems; for example we call the .save_setup
> methods on devices at the start of migration, but then call the iterate
> on those devices later - if the device is added/removed between stages
> we'll end up either having done a setup and not calling the actual save=
,
> or the other way around.

Hm... Yeah, that's a problem, thanks for mentioning it!

>
> Juan added checks to qdev_device_add/qdev_unplug in b06424d ~2.5 years
> ago.

I see that hot(un)plug during migration has many issues.
But generally it has three groups (if I didn't miss something):
1) RAMBlock add/del
2) Device add/del
3) VMState add/del

IIUC, RAMBlocks are not always connected to some devices.
So, in theory, it might become possible to hot(un)plug a block
without hot adding/removing a device. It's why I wanted to clarify
is there a sense to fix separately the problems related to RAMBlocks.

But, if you think there is no sense to fix all related problems
to let hot(un)plugging during migration be allowed, I think we can add
an assert(!migrate_is_idle()) in qemu_ram_free.

>> =C2=A02. If yes then what should we do with vmstate_unregister_ram?
>> =C2=A0=C2=A0=C2=A0=C2=A0- Just remove vmstate_unregister_ram (my RFC p=
atch)
>> =C2=A0=C2=A0=C2=A0=C2=A0- Refcount RAMBlock's migratable/non-migratabl=
e state
>> =C2=A0=C2=A0=C2=A0=C2=A0- Something else?
>> =C2=A03. If it mustn't be possible, so may be
>> =C2=A0=C2=A0=C2=A0=C2=A0assert(migration_is_idle()) in qemu_ram_free?
>>
>> =C2=A0P.S.
>> =C2=A0I'm working on a fix of below problem and trying to choose bette=
r way:
>> =C2=A0allow device removing and fix all problem like this or fix a par=
ticular device.
>>
>> =C2=A0--------
>> =C2=A0How to reproduce device removing during migration:
>>
>> =C2=A01. Source QEMU command line (target is similar)
>> =C2=A0=C2=A0=C2=A0$ x86_64-softmmu/qemu-system-x86_64 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-nodefaults -no-user-config -m 1024 -M q=
35 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-qmp unix:./src.sock,server,nowait \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-drive file=3D./image,format=3Draw,if=3D=
virtio \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device ioh3420,id=3Dpcie.1 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net,bus=3Dpcie.1
>> =C2=A02. Start migration with slow speed (to simplify reproducing)
>> =C2=A03. Power off a device on the hotplug pcie.1 bus:
>> =C2=A0=C2=A0=C2=A0$ echo 0 > /sys/bus/pci/slots/0/power
>> =C2=A04. Increase migration speed and wait until fail
>>
>> =C2=A0Most likely you will get something like this:
>> =C2=A0=C2=A0=C2=A0qemu-system-x86_64: get_pci_config_device: Bad confi=
g data:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i=3D=
0xaa read: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
>> =C2=A0=C2=A0=C2=A0qemu-system-x86_64: Failed to load PCIDevice:config
>> =C2=A0=C2=A0=C2=A0qemu-system-x86_64: Failed to load
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ioh-=
3240-express-root-port:parent_obj.parent_obj.parent_obj
>> =C2=A0=C2=A0=C2=A0qemu-system-x86_64: error while loading state for in=
stance 0x0 of device
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0'000=
0:00:03.0/ioh-3240-express-root-port'
>> =C2=A0=C2=A0=C2=A0qemu-system-x86_64: load of migration failed: Invali=
d argument
>>
>> =C2=A0This error is just an illustration of the removing device possib=
ility,
>> =C2=A0but not actually an illustration of the race conditions for remo=
ving RAMBlock.
>
> What path does this actually take - does it end up going via qdev_unplu=
g
> or some other way?

1) Guest: writes to slot's pci config
2) QEMU: pcie_cap_slot_write_config -> pcie_unplug_device

So, it's only guest driven action and qdev_unplug doesn't help here.

>
> Dave
>
>> =C2=A0Regards,
>> =C2=A0Yury
>>
>> =C2=A0Yury Kotov (1):
>> =C2=A0=C2=A0=C2=A0migration: Remove vmstate_unregister_ram
>>
>> =C2=A0=C2=A0hw/block/pflash_cfi01.c | 1 -
>> =C2=A0=C2=A0hw/block/pflash_cfi02.c | 1 -
>> =C2=A0=C2=A0hw/mem/pc-dimm.c | 5 -----
>> =C2=A0=C2=A0hw/misc/ivshmem.c | 2 --
>> =C2=A0=C2=A0hw/pci/pci.c | 1 -
>> =C2=A0=C2=A0include/migration/vmstate.h | 1 -
>> =C2=A0=C2=A0migration/savevm.c | 6 ------
>> =C2=A0=C2=A07 files changed, 17 deletions(-)
>>
>> =C2=A0--
>> =C2=A02.24.0
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Yury

