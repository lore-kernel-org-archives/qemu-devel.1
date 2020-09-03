Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE6EC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676AC20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676AC20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDhbl-0006w5-8j
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 01:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1kDhYH-00067O-PG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:12:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:47589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1kDhYE-0003Fn-Kq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:12:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 73A3240017;
 Thu,  3 Sep 2020 08:12:35 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id 93CA610;
 Thu,  3 Sep 2020 08:09:46 +0300 (MSK)
Subject: Re: [RFC 3/3] virtio-gpu: make the IO handler reentrant
To: Li Qiang <liq3ea@163.com>, mst@redhat.com, kraxel@redhat.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, alxndr@bu.edu,
 peter.maydell@linaro.org, pbonzini@redhat.com
References: <20200902162206.101872-1-liq3ea@163.com>
 <20200902162206.101872-4-liq3ea@163.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <01e9f449-00c8-5a9d-b212-4df0147b6e5c@msgid.tls.msk.ru>
Date: Thu, 3 Sep 2020 08:12:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200902162206.101872-4-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:12:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.324,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.09.2020 19:22, Li Qiang wrote:
..
> @@ -809,6 +809,10 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>  {
>      struct virtio_gpu_ctrl_command *cmd;
>  
> +    if (atomic_read(&g->in_io)) {
> +        return;
> +    }
> +    atomic_set(&g->in_io, 1);

Can't we race in these two instructions? Both
threads atomic_reads at the same time, both see zero,
and both are trying to set it to 1, no?

Just asking really, b/c despite of the atomic_ prefix,
to me this look a bit unsafe..

Thanks,

/mjt

