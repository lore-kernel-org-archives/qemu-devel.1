Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41A5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64BE20679
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWfauQ+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64BE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1ye-0000N5-S5
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 03:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jc1y7-0008MH-AV
 for qemu-devel@nongnu.org; Fri, 22 May 2020 03:19:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38947
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jc1y5-0006Uf-Nf
 for qemu-devel@nongnu.org; Fri, 22 May 2020 03:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590131984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=th0EFB8ShCpucYv5enUng83kJTzcJ2VZPwSJ6X/jJZk=;
 b=DWfauQ+VvqdfCIlVgQkkvsDprbebmvI+0NjESO3VfxvSRPP7mqU2+x0WRns/GX/PzJu5u2
 X4X43foeAm9dXawrU2z9ZgWlbQZ2yfLe0ZpZgvmKFHSU2Lq4CPa0+FfTtEd+uuDm3IWWnx
 52zkrl95ZIvsyHWYZz8q+7HqsJDQ828=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-XC-WBhb0MFqDKTvloYM96A-1; Fri, 22 May 2020 03:19:42 -0400
X-MC-Unique: XC-WBhb0MFqDKTvloYM96A-1
Received: by mail-ed1-f72.google.com with SMTP id df5so3523740edb.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 00:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=th0EFB8ShCpucYv5enUng83kJTzcJ2VZPwSJ6X/jJZk=;
 b=chm4ojWAVCq6ROdhy+hsBsJIWagNrZngGPCyxx+SVc+yoj5felJRCZspfSbKLR3KXA
 6PPPa+yJCwWnlYVzaXHFlHnkT5NSM30r4EHZt4IXps4Wu0+DF3VvYT2b4e/Rv84yBeQH
 g9cs6Le80p7y3q5dn4jShoVx/tzKNGEmfG4+pINdp/HeDUW7awJWNIsEiXoECIIJlWYd
 T3wP/psnT/e1715cjNfvHAYF9+gWjppfyaH0uA65ZES0if/XsaYI4uSPrZeWJ2D80GPt
 eFaAX1UKacaKUqt87LF2SPAEc0sSegmovWX7WpgW6b+zxCmT4ll3UFH9uQucgH0hzAoi
 1akg==
X-Gm-Message-State: AOAM530bJZACm4/XW+0bXzIKOW+i1x95uxZA8ArcnLWwyMGbmybNzQPE
 FiYk77C5RH5magI1lKULsJY0kh2bDFcxiM2n0ux8RsgPO+o9TqeQkmC2P1ZPFcGCwDzQ3MpTnBG
 YhazcxADXkRlA0nA=
X-Received: by 2002:aa7:d35a:: with SMTP id m26mr1908957edr.25.1590131981665; 
 Fri, 22 May 2020 00:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywTSvet0XtWaeIMkaXTCdq0Jvvj6YCwFH3Zrh7sjWen7Y8DANqUHC4syAlUV1av0scC9WQcg==
X-Received: by 2002:aa7:d35a:: with SMTP id m26mr1908939edr.25.1590131981385; 
 Fri, 22 May 2020 00:19:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:71e6:9616:7fe3:7a17?
 ([2001:b07:6468:f312:71e6:9616:7fe3:7a17])
 by smtp.gmail.com with ESMTPSA id g20sm7150811ejx.85.2020.05.22.00.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2020 00:19:40 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] hyperv: VMBus implementation
To: Jon Doron <arilou@gmail.com>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <fd3d2c9f-f163-f430-caf3-6468b6ac7548@redhat.com>
 <20200522025353.GC2900329@jondnuc>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f034ff1-ce26-f5f3-dfe4-7a96efb4767a@redhat.com>
Date: Fri, 22 May 2020 09:19:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200522025353.GC2900329@jondnuc>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:07:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, qemu-devel@nongnu.org, liran.alon@oracle.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/20 04:53, Jon Doron wrote:
>>>
>>>
>>
>> Queued, thanks.  I'll take a look at the EOM handling threads next.
>>
>> Paolo
>>
> 
> Hi Paolo, there is no need to look at the EOM, we have scraped it as you
> can see in v4 :)

I mean in order to un-scrape it. :)

Paolo


