Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20961C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E165620575
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxU82bqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E165620575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT17A-0000au-VV
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jT165-0007ee-AH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jT163-00054R-7d
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:34:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36852
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jT162-000541-R5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587983681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCCB4xG0cAD1wS6RprzUT4lC5ZjbIZ3Z7qxKh+Me/Fc=;
 b=dxU82bqpRaZIJb0UDhemAvnDTxGLLOrElj0tCSGT29KLrr9ESY2P6vRzPa/QFR4VfNM8Tb
 Vkb/Xx7HbgTP5dUxsscQDnd1BFlDHaRrC1FjOBpLSwoQZjGG+3yLWAxSo9ai4FhFaX+694
 IABBEVZwGA1MI11jImLvzvSAV47E+Nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-U6vPChFLMHKXxFyD9zySQg-1; Mon, 27 Apr 2020 06:34:37 -0400
X-MC-Unique: U6vPChFLMHKXxFyD9zySQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AFAD107ACCA;
 Mon, 27 Apr 2020 10:34:36 +0000 (UTC)
Received: from work-vm (ovpn-114-175.ams2.redhat.com [10.36.114.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 170A919C4F;
 Mon, 27 Apr 2020 10:34:34 +0000 (UTC)
Date: Mon, 27 Apr 2020 11:34:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: colo: qemu 4.2.0 vs. qemu 5.0.0-rc2 performance regression
Message-ID: <20200427103432.GH2923@work-vm>
References: <20200411191655.0365532d@luklap> <20200413153432.224e46b6@luklap>
MIME-Version: 1.0
In-Reply-To: <20200413153432.224e46b6@luklap>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
> On Sat, 11 Apr 2020 19:16:54 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
>=20
> > Hello Everyone,
> > I did some Benchmarking with iperf3 and memtester (to dirty some guest =
memory)
> > of colo performance in qemu 4.2.0 and in qemu 5.0.0-rc2
> > with my bugfixes on top.( https://lists.nongnu.org/archive/html/qemu-de=
vel/2020-04/msg01432.html )
> >=20
> > I have taken the average over 4 runs.
> > Client-to-server tcp bandwidth rose slightly from ~83.98 Mbit/s to ~89.=
40 Mbits.
> > Server-to-client tcp bandwidth fell from ~9.73 Mbit/s to ~1.79 Mbit/s.
> > Client-to-server udp bandwidth stayed the same at 1.05 Mbit/s
> > and jitter rose from ~5.12 ms to ~10.77 ms.
> > Server-to-client udp bandwidth fell from ~380.5 Kbit/s to ~33.6 Kbit/s
> > and jitter rose from ~41.74 ms to ~83976.15 ms (!).
> >=20
> > I haven't looked closely into it, but i think
> > 0393031a16735835a441b6d6e0495a1bd14adb90 "COLO: Optimize memory back-up=
 process"
> > is the culprint as it reduces vm downtime for the checkpoints but incre=
ases
> > the overall checkpoint time and we can only release miscompared primary=
 packets
> > after the checkpoint is completely finished.
> >=20
> > Another thing that I noticed: With 4.2.0, the secondary qemu uses thric=
e
> > the amount of gest memory. With 5.0.0-rc2 it's just double the amount o=
f
> > guest memory. So maybe the ram cache isn't working properly?
> >=20
> > Regards,
> > Lukas Straub
>=20
> Hmm,
> I looked at my test again and saw that the results where very noisy, so q=
emu 5.0.0-rc2
> being slower was just a coincidence. I did increase the test time and the=
 results are=20
> more meaningful now. Now qemu 5.0.0-rc2 is around the same speed and stil=
l faster
> in the client-to-server tcp case.
>=20
> Sorry for the noise.

Is it back to using 3x RAM in the secondary?

Dave

>=20
> Regards,
> Lukas Straub


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


