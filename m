Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B1C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8304C221FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXEeQZI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8304C221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVUri-0007UH-8N
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVUq9-0006ei-GT
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 03:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVUq6-0006GE-PQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 03:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603351004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USI71u2ALBhuehTYDPSjvoShq/L25BSzEMFHGb2Irxs=;
 b=FXEeQZI1O2NePHpb3bXlwuCb9mmXQRFsX1qFyVQHKXYnmqyjBWYOHhiCFvQspNoOF68u+c
 uyEZlS9UeheXMohbJ/Zg288/6Zq4vvI1ChM1IKeupA1FAYW3RZcmd5SZcoX+H5rNrAx1wz
 28o9qWWXtxqlD1USfvxHE6ve8WgfQV8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-1O7zFiy0OmGM--uhoLtPPA-1; Thu, 22 Oct 2020 03:16:40 -0400
X-MC-Unique: 1O7zFiy0OmGM--uhoLtPPA-1
Received: by mail-wm1-f71.google.com with SMTP id s25so258955wmj.7
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 00:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=USI71u2ALBhuehTYDPSjvoShq/L25BSzEMFHGb2Irxs=;
 b=JoESn4i/D0cNNV9UaLzJE5yqQ9ozuejVYvJUgEYNqtyGgWPQTwNX1vo6Cwt7FPCKM+
 ZOu7aH8+ur1i7q8KS6pUZ+uG6MeofqUd0zW4MUB4vsbabZakZ9mHxEeGHTSTJitEacr5
 WTeYYWyKBC49AI6fmuaZ20InHY+DplFdYobWxVvlMQaZ9Salza3Hn/X2m5OSG9zCK42Y
 e9azFaD+izeE1vj7SlaI0Buy1rytlkFR2Pkkabn3V8KdCrxAC8+NftybA9MrjcOTaAq9
 K2vSQ3s4atR1FVV9GcxRQD2ok2VU+mJzqe1rVNXMJSe/UdflXWr3y3od2fG9TStMMnur
 wUDw==
X-Gm-Message-State: AOAM530Hy4I4oYD5v7xswmGix8G102EW1Tj7LQwI/CALfTHtq6IxfBqP
 lG269/qKj4ICQNkQZBP15hTrbpgesise5fjo3T3PTA6GRzfqrsSbPVk3IcVRejsfrQ+ksP14eDY
 eZOr3tkft/9yABeg=
X-Received: by 2002:a1c:7d0f:: with SMTP id y15mr1119381wmc.84.1603350999741; 
 Thu, 22 Oct 2020 00:16:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZy8Fz685CV4AlFGcVRYsO4eBcb9xpbOGKjYfKZqsOUJktizNhw4Rb1gsnNNtu+TRGBGaZSw==
X-Received: by 2002:a1c:7d0f:: with SMTP id y15mr1119365wmc.84.1603350999575; 
 Thu, 22 Oct 2020 00:16:39 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q8sm1811290wro.32.2020.10.22.00.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 00:16:38 -0700 (PDT)
Subject: Re: [PATCH 04/22] machine: move SMP initialization from vl.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201021205716.2359430-1-pbonzini@redhat.com>
 <20201021205716.2359430-5-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cf2a5b1b-22f4-b07b-0593-2f6455b38e07@redhat.com>
Date: Thu, 22 Oct 2020 09:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021205716.2359430-5-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, jsnow@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 10:56 PM, Paolo Bonzini wrote:
> Initialize the object's values from the class when the object is
> created, no need to have vl.c do it for us.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/machine.c | 7 +++++++
>   softmmu/vl.c      | 7 -------
>   2 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


