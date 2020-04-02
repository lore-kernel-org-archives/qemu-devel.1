Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F28C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2088206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eatydHKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2088206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJykJ-0003NM-5l
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJyjh-0002dA-JS
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJyjg-0000vm-9E
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:14:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJyjg-0000u4-4y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585829655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULhth1Sb5jjgPQOkYttVjSCRZ2WjwnA5sbu1d+YqJdg=;
 b=eatydHKBPTQZhWhew5OeEgK63tb8K5gKmv/Oj4pjZ1QR/i17rYYD70/BDoB3C428xqKL0F
 SbBAEwKEJZsKwwxu4TE2ni82VCatdTnPa3u1akeYL8syR8M8rH1sgBgpxARTkxh210yHj+
 9W71eFoCvE48WTgQMRpSO1gSugZcmsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-xKUz4pKnN5OH0k6__7p0IA-1; Thu, 02 Apr 2020 08:14:13 -0400
X-MC-Unique: xKUz4pKnN5OH0k6__7p0IA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A043E8017F3;
 Thu,  2 Apr 2020 12:14:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-227.ams2.redhat.com [10.36.114.227])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFF5B5E000;
 Thu,  2 Apr 2020 12:14:05 +0000 (UTC)
Date: Thu, 2 Apr 2020 14:14:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
Message-ID: <20200402121403.GB4006@linux.fritz.box>
References: <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
 <713436887.61.1585668262838@webmail.proxmox.com>
 <20200331153719.GI7030@linux.fritz.box>
 <518198448.62.1585671498399@webmail.proxmox.com>
 <20200401103748.GA4680@linux.fritz.box>
 <997901084.0.1585755465486@webmail.proxmox.com>
 <20200401181256.GB27663@linux.fritz.box>
 <1403939459.52.1585765681569@webmail.proxmox.com>
 <20200401184431.GD27663@linux.fritz.box>
 <903538836.29.1585818619688@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <903538836.29.1585818619688@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.04.2020 um 11:10 hat Dietmar Maurer geschrieben:
> > It seems to fix it, yes. Now I don't get any hangs any more.=20
>=20
> I just tested using your configuration, and a recent centos8 image
> running dd loop inside it:
>=20
> # while dd if=3D/dev/urandom of=3Dtestfile.raw bs=3D1M count=3D100; do sy=
nc; done
>=20
> With that, I am unable to trigger the bug.
>=20
> Would you mind running the test using a Debian Buster image running "stre=
ss-ng -d 5" inside?
> I (and to other people here) can trigger the bug quite reliable with that=
.
>=20
> On Debian, you can easily install stress-ng using apt:
>=20
> # apt update
> # apt install stress-ng
>=20
> Seems stress-ng uses a different write pattern which can trigger the bug=
=20
> more reliable.

I was going to, just give me some time...

Kevin


