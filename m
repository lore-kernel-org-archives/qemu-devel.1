Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F1AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A04206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiTgWRxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A04206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3Wv-0007bP-5D
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc3Vi-0006oL-IH
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:30:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc3VY-0005u4-DR
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604914227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHTZNPTKBYC8yN6NlupMEmen4ImAp/Oj7IPCMjpZev8=;
 b=hiTgWRxRnhqFLGyj1iIaSRdbqNOOU00l+R/evZxxyjQT8PQIsK/zck6PXVyBb8xhxdw73I
 AXfNSCJTSdGELylT0LYAAtaaBEsRsT3DpyzUfIOBgce0HnhLlfsefKhzwm91m842rD8zGC
 g31+p5LlzSWIBgF9jm12lPo8Q1z8kLY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-Rmv04AIsNiGhZ353eblXmA-1; Mon, 09 Nov 2020 04:30:25 -0500
X-MC-Unique: Rmv04AIsNiGhZ353eblXmA-1
Received: by mail-wr1-f71.google.com with SMTP id k1so2752280wrg.12
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yHTZNPTKBYC8yN6NlupMEmen4ImAp/Oj7IPCMjpZev8=;
 b=q79jabwIJjnm0VHvEmbL1Wq44z4ccw4DcqRJRcSGIHzd3mG+fjf6PjC4YEpzu4TJeT
 6RB1Wy3BgSIaXFyxeC9rXi7Mo2zYa3opEqYUCiz0mu2PcEhQhbLNXuD0dd9Y/smBD+qB
 4jS22DifjPp1fd97BwB4Hc081kOBIT1BdBlguFfxk3jLr4P0h2cySU1k89aryiVKlADO
 wSaCTCVKb6mOvrbIn8Spo7u+6GOJ/YZ75BzkocHCUXlMCM0wS9ZA2pmHdvHq3iWO4nFi
 IVfzAJ02cSxYzx1R7jqEsJmB6kjDx5KO+WaOYz8ikOmiRf2BmxEPbM+w+EWz0gtYfyUn
 rmRA==
X-Gm-Message-State: AOAM530NNPhQhc+G5xBjlhMBPVd2O8qWPfsd5YYWbqyr3j/RhAkgEBAP
 GKTyBlLqqP4G8SUeq5i1epSF52BgDPv8YICuk78njAyLMHj+8Ytj7MTWjkfJw+fhFbUjDMCl8Cc
 f4Ior4d0YuZyqvCs=
X-Received: by 2002:a5d:5048:: with SMTP id h8mr17103511wrt.135.1604914224067; 
 Mon, 09 Nov 2020 01:30:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwk9Zuyo6c+Y8J/OmS+WRHVh4okZt5HQGNtVMHK7H/QoxIvjYsHzkrrygczPMGKc1cXAKaBlg==
X-Received: by 2002:a5d:5048:: with SMTP id h8mr17103489wrt.135.1604914223855; 
 Mon, 09 Nov 2020 01:30:23 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m126sm12536757wmm.0.2020.11.09.01.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 01:30:23 -0800 (PST)
Subject: Re: dtrace warnings for trace/trace-dtrace-hw_virtio.dtrace
To: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <87r1p2syo9.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2a6ed7d2-4c0f-1764-f8a2-c3ffa7fe2ad7@redhat.com>
Date: Mon, 9 Nov 2020 10:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87r1p2syo9.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 9:48 AM, Markus Armbruster wrote:
> I get this on Fedora 32:
> 
> [12/8327] Generating trace-dtrace-hw_virtio.h with a custom command
> Warning: /usr/bin/dtrace:trace/trace-dtrace-hw_virtio.dtrace:76: syntax error near:
> probe vhost_vdpa_dev_start

A warning at 12/8327 is unlikely to be noticed by normal developer...
Why "syntax error" is simply reported as warning? Shouldn't it be
an error, so we can catch/fix?

> 
> Warning: Proceeding as if --no-pyparsing was given.
> 
> 


