Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAAEC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234722073D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234722073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXiD-0000Io-FF
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53139)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1htXhd-0007hX-Qo
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1htXhc-0006eY-Ua
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1htXha-0006d4-P8; Fri, 02 Aug 2019 09:34:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16EA0307D88D;
 Fri,  2 Aug 2019 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-107.ams2.redhat.com
 [10.36.117.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 202DE60A97;
 Fri,  2 Aug 2019 13:34:29 +0000 (UTC)
Date: Fri, 2 Aug 2019 15:34:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190802133428.GC6379@localhost.localdomain>
References: <20190801173900.23851-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190801173900.23851-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 13:34:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 for-4.1 0/2] backup: Copy only dirty
 areas
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
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.08.2019 um 19:38 hat Max Reitz geschrieben:
> Hi,
>=20
> In a discussion with Vladimir today, we noticed that the backup job
> currently is pretty broken when using copy offloading.  I don=E2=80=99t=
 know
> about you, but my local filesystem (XFS) supports copy offloading, so
> the job uses it automatically.  That means, that backup is broken and
> has been broken for a year on my local FS.
>=20
> The last working version was 2.12, so this isn=E2=80=99t a regression i=
n 4.1.
> We could thus justify moving it to 4.2.  But I think this should really
> go into 4.1, because this is not really an edge case and as far as I
> know users cannot do anything to prevent the backup job from performing
> copy offloading if the system and all involved block drivers support it=
.
> I just wonder why nobody has noticed...

This sounds bad indeed. But are we already going to have an -rc4 for
other reasons, or would this mean to have one only for the backup fix?

Also, if you say this was broken in 4.0, Cc: qemu-stable

Kevin

