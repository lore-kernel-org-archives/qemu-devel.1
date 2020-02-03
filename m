Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878A3C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB1520661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/kmhTB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB1520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVNV-00034F-DQ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyVMw-0002fi-18
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyVMu-00019i-Qk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:38:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45725
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyVMu-00018v-N1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580711880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=iglujBkb2v0hJXtcZgwBqamTVtRFKPWeRZbegkCmvfY=;
 b=W/kmhTB1joxADHmR5PatQu8nhoVwa4wMfnNE2sQWsoMGZ3MBc4LzYmvTma2DM5bzr0B80K
 Or/+gEIS/UJz202N9ib8Vt+DojSS94CvZcI4B33RpC1nx4oXeO3v4+CbR3d7c/yJsiBiI2
 iP2F1wZw2xFqmJ0LcASk0T+IryVi1f8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-JppwjKhBPq6yfpU2KkSkQA-1; Mon, 03 Feb 2020 01:37:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D27471005502;
 Mon,  3 Feb 2020 06:37:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 120D360BE0;
 Mon,  3 Feb 2020 06:37:54 +0000 (UTC)
Subject: Re: [PATCH] boot-order-test: fix memleaks in boot-order-test
To: pannengyuan@huawei.com, lvivier@redhat.com, pbonzini@redhat.com
References: <20200203025935.36228-1-pannengyuan@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c676640c-ac12-178c-8afa-010e90dff977@redhat.com>
Date: Mon, 3 Feb 2020 07:37:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200203025935.36228-1-pannengyuan@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JppwjKhBPq6yfpU2KkSkQA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Euler Robot <euler.robot@huawei.com>, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/2020 03.59, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> It's not a big deal, but 'check qtest-ppc/ppc64' runs fail if sanitizers is enabled.
> The memory leak stack is as follow:
> 
> Direct leak of 128 byte(s) in 4 object(s) allocated from:
>     #0 0x7f11756f5970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
>     #1 0x7f1174f2549d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x556af05aa7da in mm_fw_cfg_init /mnt/sdb/qemu/tests/libqos/fw_cfg.c:119
>     #3 0x556af059f4f5 in read_boot_order_pmac /mnt/sdb/qemu/tests/boot-order-test.c:137
>     #4 0x556af059efe2 in test_a_boot_order /mnt/sdb/qemu/tests/boot-order-test.c:47
>     #5 0x556af059f2c0 in test_boot_orders /mnt/sdb/qemu/tests/boot-order-test.c:59
>     #6 0x556af059f52d in test_pmac_oldworld_boot_order /mnt/sdb/qemu/tests/boot-order-test.c:152
>     #7 0x7f1174f46cb9  (/lib64/libglib-2.0.so.0+0x73cb9)
>     #8 0x7f1174f46b73  (/lib64/libglib-2.0.so.0+0x73b73)
>     #9 0x7f1174f46b73  (/lib64/libglib-2.0.so.0+0x73b73)
>     #10 0x7f1174f46f71 in g_test_run_suite (/lib64/libglib-2.0.so.0+0x73f71)
>     #11 0x7f1174f46f94 in g_test_run (/lib64/libglib-2.0.so.0+0x73f94)
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  tests/qtest/boot-order-test.c | 6 +++---
>  tests/qtest/libqos/fw_cfg.h   | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)

Thanks, queued to my qtest-next branch:

 https://gitlab.com/huth/qemu/commits/qtest-next

Reviewed-by: Thomas Huth <thuth@redhat.com>


