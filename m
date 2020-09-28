Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E2CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5D320774
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="FOjTuEBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5D320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMrrM-00076Q-Tj
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kMrqP-0006Yk-Jo
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:01:25 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:37634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kMrqK-0001J0-BD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:01:23 -0400
Received: by mail-pj1-x1032.google.com with SMTP id kk9so522352pjb.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2I9+DKPWB7x+ETdX8g0mejJT6CixeMfMBdWMM+11lGE=;
 b=FOjTuEBRqraZ+YL8UPf6nVrBBvNRb/+0XM3u+H2k5N0OMpLJBcR+hCx/7GjLm5Eo9Q
 E2WPfBMg3Bj3kU3kZq1tV7y7AeXw+u6Pfm4agzVsa0MisDwDYBX5Zjbu/DC8RR1i/0lx
 lLaSASr/8wGm+rTf3DgwYXuKUXoUbE0TD8MfGHYu0A9Lkvq+NMNZ/O7Fbtu/rGjvL+Ro
 UWmrMORaxihhV/bFoo/HDzTuRZ9O9bHDteH/gs7bC2Jfoxv+ytEBUj82eI1JXuwxcGMP
 /6HW7/u4wqKUeWBg8fsX97H+9jS8ed9cQqJjv7uSKPVwHjDLKgIz8lB4qcbzJZsVa+3D
 Tp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2I9+DKPWB7x+ETdX8g0mejJT6CixeMfMBdWMM+11lGE=;
 b=qNsy7ON4uHmlgiDVcjFGwYRXS7VgQX2OR2X4eoN5BZ1kc0mrng3ykUiOtDv2DGnWSK
 +JSs+FGL317NtXM/W9vNKj2qXnkzPPWc0+j0tbwz2MMKiwvnFFEaD0w1DpV2tHilp1mI
 AX1jeoD+BaQE6DngtieBya9j1RvrCUtwBskHuC3lx8XWscxuQ6onTumGsbe9eQt/MLRf
 BJ7iwegDc88sCS6Qeotuko7zkFxld6ZjUR7GJxGpgvensvcg7Pj/MEHbQjKkrVfSiAxU
 EpbjcoYVMOc+Wfnc7G1KEaS95h/PNzHP8cnJCurhYDu0yN1iDUHQzgjErEQsN/WjrgSZ
 Tgiw==
X-Gm-Message-State: AOAM531QQSM6HWivN3GxuX75PmTmh1h2gHWiIYCV0y08nNGHLWwWeoSh
 GJh6lqX05H3aS5O7N/JzHU0mAxAal4yAMg==
X-Google-Smtp-Source: ABdhPJyt/NGC4jfarZbXUn2trrGQCb4eSAibYhqIhNApj7u5sL4PhH3HFx5x9wWexdUuEUe2FbCwmg==
X-Received: by 2002:a17:90a:db05:: with SMTP id
 g5mr1085639pjv.22.1601294476900; 
 Mon, 28 Sep 2020 05:01:16 -0700 (PDT)
Received: from [10.2.24.220] ([61.120.150.77])
 by smtp.gmail.com with ESMTPSA id x3sm1491328pfo.95.2020.09.28.05.01.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 05:01:16 -0700 (PDT)
Subject: PING: [PATCH v2 0/3] add MEMORY_FAILURE event
To: pbonzini@redhat.com, peter.maydell@linaro.org
References: <20200922095630.394893-1-pizhenwei@bytedance.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <10d89842-b1c2-35fa-4009-ad32b25e4c18@bytedance.com>
Date: Mon, 28 Sep 2020 20:01:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200922095630.394893-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pj1-x1032.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: mtosatti@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PING

On 9/22/20 5:56 PM, zhenwei pi wrote:
> v1->v2:
> Suggested by Peter Maydell, rename events to make them
> architecture-neutral:
> 'PC-RAM' -> 'guest-memory'
> 'guest-triple-fault' -> 'guest-mce-fatal'
> 
> Suggested by Paolo, add more fields in event:
> 'action-required': boolean type to distinguish a guest-mce is AR/AO.
> 'recursive': boolean type. set true if: previous MCE in processing
>               in guest, another AO MCE occurs.
> 
> v1:
> Although QEMU could catch signal BUS to handle hardware memory
> corrupted event, sadly, QEMU just prints a little log and try to fix
> it silently.
> 
> In these patches, introduce a 'MEMORY_FAILURE' event with 4 detailed
> actions of QEMU, then uplayer could know what situaction QEMU hit and
> did. And further step we can do: if a host server hits a 'hypervisor-ignore'
> or 'guest-mce', scheduler could migrate VM to another host; if hitting
> 'hypervisor-stop' or 'guest-triple-fault', scheduler could select other
> healthy servers to launch VM.
> 
> Zhenwei Pi (3):
>    target-i386: seperate MCIP & MCE_MASK error reason
>    qapi/run-state.json: introduce memory failure event
>    target-i386: post memory failure event to uplayer
> 
>   qapi/run-state.json  | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   target/i386/helper.c | 40 +++++++++++++++++++++++++------
>   target/i386/kvm.c    |  7 +++++-
>   3 files changed, 106 insertions(+), 8 deletions(-)
> 

-- 
zhenwei pi

