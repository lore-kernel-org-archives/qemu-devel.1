Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1CC20867
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gsx8pf4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1CC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGOi-0007Qi-J6
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaGNl-0006v6-EZ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaGNh-0005nQ-Mx
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604487066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uY7nE+n5g4pjNMQCyEF+5QUT28X4EbGGbSKE2vWMTJE=;
 b=Gsx8pf4itGzKSvOqGoMDXNHvNwYdoRmQwB76l+yQtJPUY8lfwqS+Ba/fSuMbwXqKFxDlPu
 oJIbvn8guwdPDOfPvfnUGGdfPkSDxg3blmfCJAojdmgRwTULMr5vSxaTaZZ0+ejgHEN6Tg
 138mn494qfAoaxZ5uJzVRi5toJ9dAR4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-c7dWiuI7NzufxL0gHiVdag-1; Wed, 04 Nov 2020 05:51:04 -0500
X-MC-Unique: c7dWiuI7NzufxL0gHiVdag-1
Received: by mail-wm1-f69.google.com with SMTP id y187so1059028wmy.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 02:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uY7nE+n5g4pjNMQCyEF+5QUT28X4EbGGbSKE2vWMTJE=;
 b=GIwzNFZqz2+Um6Qc0Tvi1efcf9w1ZvoYGeviAK0nTtPMRm4r8ZOCXsZ2dWZ2QOeCsg
 U+7obXgiKjk2ckWAjycD6DFhLpVPwHQLz/eGawfYE1M1PgSr3fGmVaEGyXzU94z4HfdD
 kkMr836cmK3knO3OAvbNH/8rN7rngM0Ct3fAQezeGZGVYHEPo0T04nrAdXhkuWK+HlDN
 QdqgUhDit5Iau2IueyoYSK5DmaVerb7rbicOOhQqA1/UDmM5KcGZxfowbtB2iU3ngnDH
 ZRnpWPbPyK2LsmC0R7qSxOmkVdpg/thiJllpO0/WfBNrzygO8IJW4eTzntIUEezSCiTD
 ujtw==
X-Gm-Message-State: AOAM532/KYHNgKR/3NVMSQSrJ0cEwweiHHZVKU8nXcZcg40y4/b1+V8C
 Hs8pkX14Fh/1dPhKrus1ma746VKN6cUVEyrACHCk6OARAwYtfTRq5l2NA8gD5InU2Qzu9cLk6Gs
 HBLQnYeln8C3OxEs=
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr4075463wma.151.1604487063636; 
 Wed, 04 Nov 2020 02:51:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx41X/+tXw/rQnJcFyLBS43Y+2VyWXKz11NhX0t2Hu2tuwUGBaDwtXQbfiPXhY80O36gKEUww==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr4075439wma.151.1604487063417; 
 Wed, 04 Nov 2020 02:51:03 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h4sm1780956wrp.52.2020.11.04.02.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 02:51:02 -0800 (PST)
Subject: Re: [PATCH for-5.2 3/3] hw/block/nvme: fix free of array-typed value
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20201104102248.32168-1-its@irrelevant.dk>
 <20201104102248.32168-4-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4285991a-9bdc-a9eb-9527-0209fbe89c5c@redhat.com>
Date: Wed, 4 Nov 2020 11:51:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104102248.32168-4-its@irrelevant.dk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 11:22 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Since 7f0f1acedf15 ("hw/block/nvme: support multiple namespaces"), the
> namespaces member of NvmeCtrl is no longer a dynamically allocated
> array. Remove the free.
> 
> Fixes: 7f0f1acedf15 ("hw/block/nvme: support multiple namespaces")
> Reported-by: Coverity (CID 1436131)
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


