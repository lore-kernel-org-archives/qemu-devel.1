Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2798EC33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EDA20661
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="BZngSCd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EDA20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir0aG-0006U6-Tz
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 09:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ir0YY-0005iY-RU
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ir0YV-0006P3-N9
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:19:00 -0500
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:57550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ir0YV-0006Md-4v
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:18:59 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 408D22E14CB;
 Mon, 13 Jan 2020 17:18:56 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 uh2AMYZbMN-ItUiGiiX; Mon, 13 Jan 2020 17:18:56 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1578925136; bh=vAUclmrteYCLkVKjwkT9pOpud6Yq+ZPROxH3erBZoCk=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=BZngSCd3rE0AhJ7Fyl2BYarDwULl2Jv0vN9NKZo8BBt5LgUlAm2jUWHeHQL0p7u3U
 T63ChDYdBc2Gmh5iTS3xMlCDfln34qmyEmMvlvLoeBG8kFu/5kRrsh7UL2zPW7/ZlG
 a3xx4MBsDXhsgnqPed5N9Q4wn1wRZBCkl28yuNCU=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (localhost [::1])
 by mxbackcorp1j.mail.yandex.net with LMTP id M16lFqBCcA-ws9aq3fD
 for <yury-kotov@yandex-team.ru>; Mon, 13 Jan 2020 17:18:45 +0300
Received: by vla5-c30c59847b9e.qloud-c.yandex.net with HTTP;
 Mon, 13 Jan 2020 17:18:44 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Michael S. Tsirkin <mst@redhat.com>,
 Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <20200107150301-mutt-send-email-mst@kernel.org>
References: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
 <20191211111655.GC3875@work-vm>
 <279541577091067@sas1-eb34c5849710.qloud-c.yandex.net>
 <20200103114427.GD3804@work-vm>
 <20200107150301-mutt-send-email-mst@kernel.org>
Subject: Re: [RFC PATCH 0/1] Removing RAMBlocks during migration
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 13 Jan 2020 17:18:54 +0300
Message-Id: <1135331578925124@vla5-c30c59847b9e.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
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
 Juan Quintela <quintela@redhat.com>, "jusual@redhat.com" <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

07.01.2020, 23:08, "Michael S. Tsirkin" <mst@redhat.com>:
> On Fri, Jan 03, 2020 at 11:44:27AM +0000, Dr. David Alan Gilbert wrote:
>> =C2=A0> 1) Guest: writes to slot's pci config
>> =C2=A0> 2) QEMU: pcie_cap_slot_write_config -> pcie_unplug_device
>> =C2=A0>
>> =C2=A0> So, it's only guest driven action and qdev_unplug doesn't help=
 here.
>>
>> =C2=A0Hmm we need to find a way to stop that; lets see if Michael Tsir=
kin has
>> =C2=A0any ideas (cc'd) - I'm thinking if we could defer the unplug unt=
il the
>> =C2=A0end of the migration we'd be OK; but it feels racy as to whether=
 the
>> =C2=A0destination is started with the device that the guest is unplugg=
ing.
>>
>> =C2=A0Dave
>
> It's true - and same is possible with PCI, guest can remove device
> at will.
>
> Also, while libvirt learned not to start device del while migration
> is active, it's annoying to have to wait for device del
> to complete before migration can be started.
>
> I guess we can make device invisible to guest - that concept
> now exists because of failover, and can maybe be reused here.
>
> Alternatively or additionally - for a while now I wanted to only remove
> the device if guest powered it out and removal was requested. Again it
> might be easier now that we have a concept of an invisible device.
>

I sent an rfc patch that implements deferred device unplug:
  pcie: Defer hot unplug until migration is complete

Please take a look at it.

Regards,
Yury

