Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE35C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10475208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4INP6te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10475208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHoG-0006Sa-0l
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVHjq-0002H0-JQ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVHjo-0003aP-Tz
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603300643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCrHmHPGiPETrzyQMhxr572HueGUgL4Dw7WSlBOek7k=;
 b=N4INP6teLnG7Mxj8x4ro3/SxVEo/RIvbaxh9ZnAHPj/n94YVNEuIPOATyCOBoIg5WL5wqx
 utDMOSJfh60+g+vZeQJ/mlA7QZJ7e2Q4naU3zrzEVIxGURXsb6FrGxFhLrOkASxiXSYyYh
 FK76oN7UOAIXwG/ezutQk3eKADKXO+M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-OU47x8hrNbaBiIvdI9xjZg-1; Wed, 21 Oct 2020 13:17:22 -0400
X-MC-Unique: OU47x8hrNbaBiIvdI9xjZg-1
Received: by mail-wr1-f69.google.com with SMTP id b6so2960370wrn.17
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RCrHmHPGiPETrzyQMhxr572HueGUgL4Dw7WSlBOek7k=;
 b=GsSXuV4tNfHjrrNxhgFXF645PPrCOYzLCsyqvRDslpy8Fah8fKBxo8JDqqVa+NZkX5
 YUCuF42ifO/rjxbS8KtVjA1ucSHx3fhMdojwnVuHuyl3YCuEZ1wqxg9lXsm9jpoY+SIP
 9tvXAnz+4pcRHGje0NhJi+TBSXXIvWg0NEHP50AV0SIugDSOo3S3apKbPA2Pi79hucsd
 s5cPOdsFte4leWDi7vqym8gypFtCHyzz1iRpcE3EaTPHtx37z98nl4PEv2wanBdsX06Y
 CqzqyLnIgdRcGfhwPj6TUmAC6id9QXmBFmD3lpAk+VzdHXDnfgwQEzflQyPieIQF3jtQ
 qdqQ==
X-Gm-Message-State: AOAM5327tqsDpEQ7s4ikxwPk58T3vfIiGpeC0DxZhA+6IQp669BhZC+1
 bH/YdR7+7CWSGlVenugNY5KyCCmoIjFXwpSNMXp2Z9GG4fiWL0NG9P/Crw8CqP7lxQbu5nGgEdw
 AJWVSFZA+GQRbSHU=
X-Received: by 2002:a1c:8087:: with SMTP id b129mr4657142wmd.10.1603300640796; 
 Wed, 21 Oct 2020 10:17:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSLaq06hJ307EwOiVkIM0F2ShHoZmoo9FGhg1E1ZHXbpaZ1Htt66RQ9WiMDOJUeGwMtlj7Xg==
X-Received: by 2002:a1c:8087:: with SMTP id b129mr4657127wmd.10.1603300640576; 
 Wed, 21 Oct 2020 10:17:20 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x6sm5077422wmb.17.2020.10.21.10.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 10:17:19 -0700 (PDT)
Subject: Re: [PATCH v1 3/6] tests/docker/dockerfiles/centos: Use SDL2 instead
 of SDL1
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201021163136.27324-1-alex.bennee@linaro.org>
 <20201021163136.27324-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2e4242c4-6288-6fdf-a8b5-4a6b7d249987@redhat.com>
Date: Wed, 21 Oct 2020 19:17:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021163136.27324-4-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 6:31 PM, Alex Bennée wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We do not support SDL1 in QEMU anymore. Use SDL2 instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20201021072308.9224-1-thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/centos7.docker | 2 +-
>   tests/docker/dockerfiles/centos8.docker | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


