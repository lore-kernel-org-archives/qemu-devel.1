Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDBBC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAC4221E3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAC4221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSnl-00027W-Uc
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 16:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>)
 id 1kGSn6-0001J4-DH; Thu, 10 Sep 2020 16:03:32 -0400
Received: from kerio.kamp.de ([195.62.97.192]:41031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>)
 id 1kGSn3-0002Qa-MA; Thu, 10 Sep 2020 16:03:31 -0400
X-Footer: a2FtcC5kZQ==
Received: from [82.141.7.52] ([79.200.90.160]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Thu, 10 Sep 2020 22:03:20 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Peter Lieven <pl@kamp.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] qemu-img: avoid unaligned read requests during convert
Date: Thu, 10 Sep 2020 22:03:24 +0200
Message-Id: <63904FDF-0B57-40A3-8DE2-B68A5071E757@kamp.de>
References: <ca868c21-eabc-d146-d13c-8ab63a383d50@redhat.com>
In-Reply-To: <ca868c21-eabc-d146-d13c-8ab63a383d50@redhat.com>
To: Max Reitz <mreitz@redhat.com>
X-Mailer: iPhone Mail (17G80)
Received-SPF: pass client-ip=195.62.97.192; envelope-from=pl@kamp.de;
 helo=kerio.kamp.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 16:03:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 10.09.2020 um 18:58 schrieb Max Reitz <mreitz@redhat.com>:
>=20
> =EF=BB=BFOn 01.09.20 14:51, Peter Lieven wrote:
>> in case of large continous areas that share the same allocation status
>> it happens that the value of s->sector_next_status is unaligned to the
>> cluster size or even request alignment of the source. Avoid this by
>> stripping down the s->sector_next_status position to cluster boundaries.
>>=20
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>> qemu-img.c | 22 ++++++++++++++++++++++
>> 1 file changed, 22 insertions(+)
>=20
> I've just noticed that with this patch, the iotest 251 fails for vhdx.
> Would you be OK with squashing this in?

Sure, squash it in.

Thanks
Peter



