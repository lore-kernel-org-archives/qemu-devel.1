Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEBAC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 05:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8D220674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 05:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkSrjrh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8D220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jur9Z-0007F5-Li
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 01:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jur8k-0006XA-4K
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 01:36:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29147
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jur8h-0002jX-Az
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 01:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594618589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=j1+7kY0zFi+tFiF+akrq2PWIFfhBuB1zVc4sfP+iZ9k=;
 b=YkSrjrh7kRx3J3ZtSWk99PAdg1MSVJJaeCfAFiIOm/R2FZYdO+8ZvngWv1DMlinm3gyQz7
 jLhQv6sWzAqITyU6qb6svmNfAX7673GdOa3fYreCWZkr6cDgrjcEYGyAhpH2jmw4qEFUbq
 0mltlWOU6Wud1lNexA9UGbOxoe1wlfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-z5P819Z4M9e9SjvuGz4ijg-1; Mon, 13 Jul 2020 01:36:27 -0400
X-MC-Unique: z5P819Z4M9e9SjvuGz4ijg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE1D6100CCC0;
 Mon, 13 Jul 2020 05:36:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AFE678520;
 Mon, 13 Jul 2020 05:36:22 +0000 (UTC)
Subject: Re: [PATCH 1/2] tests: fix "make check-qtest" for modular builds
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200710203652.9708-1-kraxel@redhat.com>
 <20200710203652.9708-2-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6936f087-35b0-47f0-88f8-aed15582fd43@redhat.com>
Date: Mon, 13 Jul 2020 07:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200710203652.9708-2-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/2020 22.36, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/qtest/Makefile.include | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> index 98af2c2d9338..6a0276fd42dd 100644
> --- a/tests/qtest/Makefile.include
> +++ b/tests/qtest/Makefile.include
> @@ -277,6 +277,7 @@ tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj-y)
>  tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o
>  tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o
>  tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o
> +tests/qtest/modules-test$(EXESUF): tests/qtest/modules-test.o
>  tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o
>  tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test.o
>  tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o

What was the error that you run into here? ... some words in the commit
message would be nice. Actually, I always wondered why we need a
separate entry for each and every test here ... I'd rather expect that
this is handled by a normal generic make rule instead?

 Thomas


