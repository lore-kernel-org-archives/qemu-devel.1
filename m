Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602D1C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A5C206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3jSk4g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A5C206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVv0-0006X1-JO
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYVld-0002Wn-Mt
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYVla-00041j-Uj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604069554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vqu0rV0cOSyl+5SSlJ72JCTq1DZwy2EtpKqlnXFM2jQ=;
 b=i3jSk4g3YM0c2Y6Hj6+S7VYPS942m3oFR38+pffqArc4FhjbZorrVKj+t/AoYDWXPIVTHQ
 M0fRC+q0SNsJWAxL0xFkI71ruL5dxFCubciGhPHr/mdW4/hg+1g5dhGcKR/LaHodurs62z
 ed19EWstLdbT+ny7wGr4p+3SVHlmDAg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-cMbX7Qf0PTC-XTCWHycL5A-1; Fri, 30 Oct 2020 10:52:32 -0400
X-MC-Unique: cMbX7Qf0PTC-XTCWHycL5A-1
Received: by mail-wm1-f70.google.com with SMTP id f7so718715wmc.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pZgKSk8ygvE23+ghK6eHP5e/78YniwWL3wCh9oEPuGY=;
 b=e813C4HiZ0IExmx/mowBL4S3DMNK3p13L7/K+0ay00bnXvdrIAaxGqZ1I2s5sIDGI/
 1Z/n5lZhFZm4n6ZV8O8WyVI+53W8xHCmy6ZjDhpZI6SrnRhHgzWwtfwoeIuoEYKAKKQo
 IEX3pMa9KMpybMYIOZb7lz43pFNCh4BIwrl5urNowr/cg+zN7Vjcs+Y76Ru53BpDN9rv
 m+7jbaZ6iwY7RiYuNtQe1dtz8fDAuYL1ZT3XxBreRZ13NOSL8Jy+fiS9njRmocOF2Ek9
 u5c4+CF3eDaAQHy19qBsK5tHCnB119KrobPdtfSoCtA4lcTTGhyrlsqVaqGmbfxY6dgm
 iM5g==
X-Gm-Message-State: AOAM532bOymT7vEEE/rE7z2ReQ+K1NJGoJUwrfuRi3yGICK0ky096rGH
 /z5/gG9r4v4nbTnYzTzwJ/mAcoE8MosrS7B1UmfqWCUkPRPt/cDhv7KS5VOcL06gUfoSj6Z74pc
 tcRRV8ChLxXeGYms=
X-Received: by 2002:a5d:6a0a:: with SMTP id m10mr3711999wru.189.1604069550984; 
 Fri, 30 Oct 2020 07:52:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvUSOym0YB/Z/jrRlDyBvFCdH68irtd18Avda02QGXIqTFsCq9kBSqZMwSiT2+vjzYThrkNg==
X-Received: by 2002:a5d:6a0a:: with SMTP id m10mr3711974wru.189.1604069550818; 
 Fri, 30 Oct 2020 07:52:30 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f1sm2017598wmj.3.2020.10.30.07.52.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 07:52:30 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 v2 12/25] block/nvme: Introduce Completion Queue
 definitions
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
 <20201029093306.1063879-13-philmd@redhat.com>
 <20201030140340.GD330921@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7779d2aa-3a5d-7d2f-adc4-f15740711e20@redhat.com>
Date: Fri, 30 Oct 2020 15:52:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030140340.GD330921@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 3:03 PM, Stefan Hajnoczi wrote:
> On Thu, Oct 29, 2020 at 10:32:53AM +0100, Philippe Mathieu-Daudé wrote:
>> Rename Submission Queue flags with 'Sq' to differentiate
>> submission queue flags from command queue flags, and introduce
>> Completion Queue flag definitions.
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Tested-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/block/nvme.h | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> I mentioned more possible cleanups in the previous revision, but they
> are not a blocker:

Your cleanups haven't been ignored, simply postponed :)

> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>

Thanks!


