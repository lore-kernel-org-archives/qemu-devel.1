Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C57FC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A917207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="LL91mR9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A917207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKJob-0005el-Gb
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kKJn7-0004o4-4v; Mon, 21 Sep 2020 07:15:29 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kKJn2-0007PR-HH; Mon, 21 Sep 2020 07:15:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600686884; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=OYeFS2a6OCWNuvDqQ7V+LC+AM/UxLZ6TXh80vFYOzDyrrO8aovdKjsGf0bF/PqJrAFDiPxLke6XmNNqVVjgHurh0eOvlOrw3cmiFo0XaKq7w8YjYLY0ztjtpKKuaiv3kf7gauLjDLSa21qcWC8yQzRuKOoCtTi8ST8wtPIBZD/U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1600686884;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=PX1BTR5mxwnI47REs0pz5e8y4Tugq2jkXj+bmeH8MaQ=; 
 b=TZ5pxby0kfeObFBAd+EsZ14PAFyBUoO8K8+exxyyS60iQaVFeoywyZ2NXa4Kg4OUaGTF7vQi3cVIJ2RTP4MZkRT/8AIOe20quhsBMSEJNgwEOJAwfoEMm25um7sywc9m37lF9KwDRxMWNuCKie5LOCVY1P75Krai3TxyeKAWYZ0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1600686884; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 bh=PX1BTR5mxwnI47REs0pz5e8y4Tugq2jkXj+bmeH8MaQ=;
 b=LL91mR9hGcCM0iRn2lr6Yob5iJv1FqihyEz39krL7FZZSVfz9QtxeoRei4lK6Ibp
 3CQeNlOOEOgeaMvWMQqX+LfVNCe2qzl73sprGiSI6dTf6WicUL4hLMSVD20uidXqxaD
 W8Ps4tVn8xA5QaLmJLUtDJINoXT1HFY7gltUOR3I=
Received: from localhost (ec2-52-56-101-76.eu-west-2.compute.amazonaws.com
 [52.56.101.76]) by mx.zoho.com.cn
 with SMTPS id 1600686881080449.06929488691924;
 Mon, 21 Sep 2020 19:14:41 +0800 (CST)
Date: Mon, 21 Sep 2020 11:14:35 +0000
From: Fam Zheng <fam@euphon.net>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
Message-ID: <20200921111435.GA2524022@dev>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
 <20200917154415.GB839531@stefanha-x1.localdomain>
 <20200917160054.GA2453251@dev>
 <5a5822ec-f3bc-a247-2b5a-f764b941c820@huawei.com>
 <20200918140628.GA2509473@dev>
 <1ba06b0d-3fcf-3676-f9e0-52875851ff19@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba06b0d-3fcf-3676-f9e0-52875851ff19@huawei.com>
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 07:15:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, armbru@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-09-19 10:22, Zhenyu Ye wrote:
> On 2020/9/18 22:06, Fam Zheng wrote:
> > 
> > I can see how blocking in a slow io_submit can cause trouble for main
> > thread. I think one way to fix it (until it's made truly async in new
> > kernels) is moving the io_submit call to thread pool, and wrapped in a
> > coroutine, perhaps.
> >
> 
> I'm not sure if any other operation will block the main thread, other
> than io_submit().

Then that's a problem with io_submit which should be fixed. Or more
precisely, that is a long held lock that we should avoid in QEMU's event
loops.

> 
> > I'm not sure qmp timeout is a complete solution because we would still
> > suffer from a blocked state for a period, in this exact situation before
> > the timeout.
> 
> Anyway, the qmp timeout may be the last measure to prevent the VM
> soft lockup. 

Maybe, but I don't think baking such a workaround into the QMP API is a
good idea. No QMP command should be synchronously long running, so
having a timeout parameter is just a wrong design.

Thanks,

Fam

