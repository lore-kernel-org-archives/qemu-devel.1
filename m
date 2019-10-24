Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7F6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E1C20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agDkMh6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E1C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaC9-0006vQ-Ip
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iNZpK-0001sg-1a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iNZpH-0006Sj-GT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:54:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42763
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iNZnL-0005az-AE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571910757;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hodvQnmNN+tFxBHPDXssPGepaUvJh9H/fTL98ptJnhM=;
 b=agDkMh6W+aj3a+HfEoyCclo4RyHywVe45Pp+PiA/uDL7ucpBYotc98Jb7fkfd9SmQXDNaZ
 GrsdwV2Yw55m+sLZJw41ynE1YuebJ5Q1dfsmA/td+e01Mm9i6vVdKV0/IflcZAkKBjgkWN
 h6BXKUsZi/tdPT4q77CvDj84d4VHEbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-NIrt-JouOp-s8CZ-MDLNEw-1; Thu, 24 Oct 2019 05:52:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61890107AD31;
 Thu, 24 Oct 2019 09:52:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B49EF1001B07;
 Thu, 24 Oct 2019 09:52:29 +0000 (UTC)
Date: Thu, 24 Oct 2019 10:52:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: cenjiahui <cenjiahui@huawei.com>
Subject: Re: [PATCH 3/3] migration/multifd: fix potential wrong acception
 order of IOChannel
Message-ID: <20191024095227.GC3700@redhat.com>
References: <20191023033214.31592-1-cenjiahui@huawei.com>
 <20191023033214.31592-3-cenjiahui@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20191023033214.31592-3-cenjiahui@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NIrt-JouOp-s8CZ-MDLNEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, zhouyibo3@huawei.com,
 dgilbert@redhat.com, peterx@redhat.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 11:32:14AM +0800, cenjiahui wrote:
> From: Jiahui Cen <cenjiahui@huawei.com>
>=20
> Multifd assumes the migration thread IOChannel is always established befo=
re
> the multifd IOChannels, but this assumption will be broken in many situat=
ions
> like network packet loss.
>=20
> For example:
> Step1: Source (migration thread IOChannel)  --SYN-->  Destination
> Step2: Source (migration thread IOChannel)  <--SYNACK  Destination
> Step3: Source (migration thread IOChannel, lost) --ACK-->X  Destination
> Step4: Source (multifd IOChannel) --SYN-->    Destination
> Step5: Source (multifd IOChannel) <--SYNACK   Destination
> Step6: Source (multifd IOChannel, ESTABLISHED) --ACK-->  Destination
> Step7: Destination accepts multifd IOChannel
> Step8: Source (migration thread IOChannel, ESTABLISHED) -ACK,DATA->  Dest=
ination
> Step9: Destination accepts migration thread IOChannel
>=20
> The above situation can be reproduced by creating a weak network environm=
ent,
> such as "tc qdisc add dev eth0 root netem loss 50%". The wrong acception =
order
> will cause magic check failure and thus lead to migration failure.
>=20
> This patch fixes this issue by sending a migration IOChannel initial pack=
et with
> a unique id when using multifd migration. Since the multifd IOChannels wi=
ll also
> send initial packets, the destination can judge whether the processing IO=
Channel
> belongs to multifd by checking the id in the initial packet. This mechani=
sm can
> ensure that different IOChannels will go to correct branches in our test.

Isn't this going to break back compatibility when new QEMU talks to old
QEMU with multifd enabled ? New QEMU will be sending a packet that old
QEMU isn't expecting IIUC.

> Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
> Signed-off-by: Ying Fang <fangying1@huawei.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


