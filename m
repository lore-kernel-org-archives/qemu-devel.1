Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393F7C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69F42074F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ddc6udEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69F42074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqsP-0000Gj-PA
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMqrH-000888-0K
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMqqN-00084p-0C
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:58:13 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601290637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGCxguFyh/Ui2C8+N8jFiAjBheF8ptz38fY8joy7zz4=;
 b=Ddc6udEc/DSfIQfm+ZAfmdakfBH+y1X47iGvaLBmaDaFHJV2XjiEaakv+XW0KVu16lDC5Q
 5p+u1dkkIB3ie6XcL8mwqikXsxlL+v9vS2hR8p7bzexeQ3QXw3j7HfvpOT7OqbAGh5h1Bs
 V5lfFL8rmqQtRPuoycYQz0kdrQVxmUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-l34VLxV5OkeGySpesX5f9g-1; Mon, 28 Sep 2020 06:57:15 -0400
X-MC-Unique: l34VLxV5OkeGySpesX5f9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A048015A4;
 Mon, 28 Sep 2020 10:57:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-193.ams2.redhat.com [10.36.114.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B9D678437;
 Mon, 28 Sep 2020 10:57:13 +0000 (UTC)
Date: Mon, 28 Sep 2020 12:57:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [RFC PATCH 0/7] block-backend: Introduce I/O hang
Message-ID: <20200928105711.GF5451@linux.fritz.box>
References: <20200927130420.1095-1-fangying1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200927130420.1095-1-fangying1@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.09.2020 um 15:04 hat Ying Fang geschrieben:
> A VM in the cloud environment may use a virutal disk as the backend storage,
> and there are usually filesystems on the virtual block device. When backend
> storage is temporarily down, any I/O issued to the virtual block device will
> cause an error. For example, an error occurred in ext4 filesystem would make
> the filesystem readonly. However a cloud backend storage can be soon recovered.
> For example, an IP-SAN may be down due to network failure and will be online
> soon after network is recovered. The error in the filesystem may not be
> recovered unless a device reattach or system restart. So an I/O rehandle is
> in need to implement a self-healing mechanism.
> 
> This patch series propose a feature called I/O hang. It can rehandle AIOs
> with EIO error without sending error back to guest. From guest's perspective
> of view it is just like an IO is hanging and not returned. Guest can get
> back running smoothly when I/O is recovred with this feature enabled.

What is the problem with setting werror=stop and rerror=stop for the
device? Is it that QEMU won't automatically retry, but management tool
interaction is required to resume the guest?

I haven't checked your patches in detail yet, but implementing this
functionality in the backend means that blk_drain() will hang (or if it
doesn't hang, it doesn't do what it's supposed to do), making the whole
QEMU process unresponsive until the I/O succeeds again. Amongst others,
this would make it impossible to migrate away from a host with storage
problems.

Kevin


