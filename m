Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AC6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 21:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08BC208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 21:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlyYlM3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08BC208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2hwe-0003HM-RP
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 17:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k2hve-0002YE-U3
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 17:23:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43539
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k2hvc-0000yT-32
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 17:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596489806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWuqYgiw0i9fDzJ8fTFbj1iChgX2Y8KiNLT3/e/Aafw=;
 b=OlyYlM3GueoujM2pjokmrSszy/W9DZux6SjtaB2PpOzyxRXCgaJYaaS9hTs44yLI+YJjL/
 hZ3YGiHc7qVbFLgH+Zv6QauMmiOJpfk3EyiE56wxvCNBdPU40DJCEuEMKURqBIY2yy+eaY
 t9c93w690eZ4kV0wK8m1aSc5O0BtC1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-60uM9dMnOMWlpYgH4o24uA-1; Mon, 03 Aug 2020 17:23:22 -0400
X-MC-Unique: 60uM9dMnOMWlpYgH4o24uA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B098218FF662;
 Mon,  3 Aug 2020 21:23:21 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com (unknown
 [10.10.115.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28CE05C1BD;
 Mon,  3 Aug 2020 21:23:20 +0000 (UTC)
Subject: Re: [PATCH] tests/Makefile: test-image-locking needs CONFIG_POSIX
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200803065803.20836-1-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <11268c07-aca7-c3c1-d597-80326b6fefbc@redhat.com>
Date: Mon, 3 Aug 2020 17:23:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803065803.20836-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 17:23:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-trivial@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 2:58 AM, Thomas Huth wrote:
> test-image-locking.c uses the qemu_lock_fd_test() function which is
> only available on Posix-like systems.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>   tests/Makefile.include | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 5ff731be2b..430119db74 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -87,7 +87,9 @@ check-unit-$(CONFIG_BLOCK) += tests/test-blockjob$(EXESUF)
>   check-unit-$(CONFIG_BLOCK) += tests/test-blockjob-txn$(EXESUF)
>   check-unit-$(CONFIG_BLOCK) += tests/test-block-backend$(EXESUF)
>   check-unit-$(CONFIG_BLOCK) += tests/test-block-iothread$(EXESUF)
> +ifeq ($(CONFIG_POSIX),y)
>   check-unit-$(CONFIG_BLOCK) += tests/test-image-locking$(EXESUF)
> +endif
>   check-unit-y += tests/test-x86-cpuid$(EXESUF)
>   # all code tested by test-x86-cpuid is inside topology.h
>   ifeq ($(CONFIG_SOFTMMU),y)
> 


