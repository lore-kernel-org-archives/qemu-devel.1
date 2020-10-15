Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF01C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D96220714
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4h3BF/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D96220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9Pg-0002el-HY
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT9NU-0000ln-Fy
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT9NS-0008Gn-95
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602791848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ARkASEz6vY3RxZMJMx6mZ30ggbtc1gxHRuDRD/c78g=;
 b=H4h3BF/AaZnBdTq+gfC9/iNkFI/5GZD1cVV6f9qEgCkUFbrHtvIo+8AhocIjJaf+Lce1js
 UFnXDkGoJVztNoQ3TNZvCOXVVcl1HHFl0rumIcCSAd+QgyJzTkCutWYb5fBT0dlEqva/Yh
 Wt2KuwdU8fmj0TvnYYPokwNgRdgRQZM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-T-xNQmkDNAStr-r5iYKVvg-1; Thu, 15 Oct 2020 15:57:26 -0400
X-MC-Unique: T-xNQmkDNAStr-r5iYKVvg-1
Received: by mail-wr1-f70.google.com with SMTP id n14so242368wrp.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 12:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4ARkASEz6vY3RxZMJMx6mZ30ggbtc1gxHRuDRD/c78g=;
 b=s05OloHAghEPSQfxEmjiwfG3mnA93j3gZ01weXQmh/d49eLpU/3EpwcW7vOpxO1LTW
 VtvEDFDcLjExWMp6q2bl0Bp5L2bo1ANLVlhcQucw8MrzMGHjbpVYkulVtOwurkKOWwFW
 ryZCHbWvKaI4Qs/JrynzKNzw28GijjNtb4m9YL3Tu1PAPw5xMbot7lDAGPor6rdUdYyB
 D2KOE+xwARvQnHdWm/Tk3Z94L/hXn0xueKrXdwmRyjyAIQvG+RYz/iXnLVow3/vPfE+V
 sJIQddpEhGM12aSRlxAHcez2xbtzmet1mguqRDfj68PE5m+AxXISgyehLifmTKG6Td3Y
 FcwQ==
X-Gm-Message-State: AOAM533mhBF/pjCYtE3aQw/bnrhd8G/xl9VZkDwxSkebTDB0AFiQEYMB
 y+fU6MbRmUUKtq9I4eqwznWEvEH1Q5AKFrW9UnNRyx98BrkKmcMPZLoTfGL/57jRhMqb+3cpASc
 aRpsZv4n95RC9bVo=
X-Received: by 2002:a1c:e082:: with SMTP id x124mr310342wmg.60.1602791845585; 
 Thu, 15 Oct 2020 12:57:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDQqwEQa94ZVZ91n9Ijj3B/Oy+YgC0nUqU6HuUtxfWlmozEkezE66ygNovU6qirgZGPGMatA==
X-Received: by 2002:a1c:e082:: with SMTP id x124mr310334wmg.60.1602791845434; 
 Thu, 15 Oct 2020 12:57:25 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x81sm145910wmb.11.2020.10.15.12.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 12:57:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] pci: Change error_report to assert(3)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Ben Widawsky <ben.widawsky@intel.com>, qemu-devel@nongnu.org
References: <20201015181411.89104-1-ben.widawsky@intel.com>
 <d9c27793-7686-5bf3-bf5a-74800311657b@redhat.com>
Message-ID: <df84435c-89c2-e2f1-a4c7-422b8b1071ef@redhat.com>
Date: Thu, 15 Oct 2020 21:57:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <d9c27793-7686-5bf3-bf5a-74800311657b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 9:55 PM, Philippe Mathieu-Daudé wrote:
> On 10/15/20 8:14 PM, Ben Widawsky wrote:
>> Asserts are used for developer bugs. As registering a bar of the wrong
>> size is not something that should be possible for a user to achieve,
>> this is a developer bug.
>>
>> While here, use the more obvious helper function.
>>
>> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>> ---
>>   hw/pci/pci.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Maybe 'assert(3)' -> 'assert()' in subject.


