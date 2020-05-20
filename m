Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B476C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFB6207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4TgtLP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFB6207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbM0e-0005Rl-CU
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbLya-0002Ru-53
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:29:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26018
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbLyZ-0000cz-C1
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589970566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6uUcRVWruGw0BDIPX0ILWO5/0sUnnqv82ZIJD7gK5ns=;
 b=J4TgtLP5xX4pLDme50BWt6z9yQrfamhRdTEoR24aiw1e+3Q3FceIKE2Y4xTcEG6kAs2tjJ
 gIymMAVwcdeuMB+xxqAg/6k+rafywfuu3oKz614k9k3qsfoKVLk1Unu4Tpa/XhZSfDehol
 YWayJ+UgsfD6orjQa3QVQIZFgLAJDCw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-A3NQ__y-OW2y6JpXeah9FQ-1; Wed, 20 May 2020 06:29:25 -0400
X-MC-Unique: A3NQ__y-OW2y6JpXeah9FQ-1
Received: by mail-wm1-f72.google.com with SMTP id x11so738583wmc.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6uUcRVWruGw0BDIPX0ILWO5/0sUnnqv82ZIJD7gK5ns=;
 b=G7QV0ssjBBbS8dJFrM96QR/Jurq2cYZCkrHYl/P0VaaoMib2dhJuky3aC9RZHU5Vxx
 VEYqECvPBw1/LmcDZjmL5jfM71VntPBDKDLI1AO1Qq2ZgPJDoCMxp/iJyWvcs0R3dySO
 jMkjAAKJXFNg1G+gNEEgQVHu/80jzHnVAwnt6lKXpbPGIWf+xMXhLPNEZD/39R2h60tc
 TvE1+RXPoPHvFdZjVTevS2BSFaDsdOtaff4QoKcA7iUD0dqnFTNLqs1FemhIpTXuhy81
 VmYw+FSS7JJbcFi1kakfKJZ8xWrjg003FKOGhMqjSdTEQSToWiMmzrFchKv7uk5CKo2y
 2aiA==
X-Gm-Message-State: AOAM530wUOi0AL8qqCY95Obj46iRctY53thsYdcUHVWCO6DobYDJjphe
 BUJcGJisUsiMfNyqa3iGe79vhUh8X+FW62eyPygAaOnsWFx8NqdBwP0SLtZ6FjA4IMbSWiVR1zf
 obm78pYkaLMd+El0=
X-Received: by 2002:adf:fa91:: with SMTP id h17mr3500387wrr.111.1589970564009; 
 Wed, 20 May 2020 03:29:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3ZPF+Wjp8zd3V5neqhJKDaZu4ePgHHOhkKiRK2ITkzYmpaOd/rB/mJxY+on89qM8h/qZJQA==
X-Received: by 2002:adf:fa91:: with SMTP id h17mr3500371wrr.111.1589970563757; 
 Wed, 20 May 2020 03:29:23 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z132sm2900340wmc.29.2020.05.20.03.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 03:29:23 -0700 (PDT)
Subject: Re: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows
 Hypervisor Platform
To: Sunil Muthuswamy <sunilmut@microsoft.com>, Stefan Weil <sw@weilnetz.de>,
 "Justin Terry (SF)" <juterry@microsoft.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
References: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <BN8PR21MB1297D3D88C41B6AFADE36DCCB6110@BN8PR21MB1297.namprd21.prod.outlook.com>
 <ecc9b0c5-7cd7-1f8d-d10c-bee7aff8fa01@redhat.com>
 <BN8PR21MB12974CEDAEC173FC8CD626DFB6100@BN8PR21MB1297.namprd21.prod.outlook.com>
 <6b5c046a-af4b-8adf-e3a2-64d904c9ff16@weilnetz.de>
 <SN4PR2101MB08803B0317F0F5314535136CC0EC0@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bab3a217-43b2-98f3-1a32-292d89f16207@redhat.com>
Date: Wed, 20 May 2020 12:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB08803B0317F0F5314535136CC0EC0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: 1879672@bugs.launchpad.net, Mike Battista <Mike.Battista@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Mike Battista & lanchpad ticket

On 2/24/20 8:43 PM, Sunil Muthuswamy wrote:
>> -----Original Message-----
>> From: Stefan Weil <sw@weilnetz.de>
>> Sent: Thursday, February 20, 2020 11:54 PM
>> To: Justin Terry (SF) <juterry@microsoft.com>; Philippe Mathieu-Daudé <philmd@redhat.com>; Sunil Muthuswamy
>> <sunilmut@microsoft.com>; Eduardo Habkost <ehabkost@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard Henderson
>> <rth@twiddle.net>
>> Cc: qemu-devel@nongnu.org
>> Subject: Re: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor Platform
>>
>> Am 19.02.20 um 16:50 schrieb Justin Terry (SF):
>>
>>
>> Hello Justin, hello Sunil,
>>
>> just a reminder: we still have the problem with the proprietary license
>> for the required Microsoft header files.
>>
>> Can you estimate when this will be solved?
>>
> 
> Thanks for the reminder, Stefan. Yes, agreed this problem still exists. We followed up with
> the SDK team and the legal team end of last year. I will nudge them again for an update
> here.
> 
>> Regards,
>> Stefan
>>
> 


