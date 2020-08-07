Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B2920866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WF5btVU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B2920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k43GN-0007Nv-Nm
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k43Fa-0006l4-7L
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:21:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k43FY-0004PO-5r
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596810093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7lac5uLMYukZ9rxLMdYaYSoYm3mH5DfC4dKnmQchVM=;
 b=WF5btVU7W1dIdHcoYSSWLZzAM80fE7L54RwszbHU++raXME1RdSSl85BtoXvHxMkg5W0zh
 si7dtD4jzrhIFca1fugn81Zs23JbofhCoP58W62hS/kU3+Ed+b3jpdAiECY0E4uMLyWyfh
 let+mhHYy5Txb2EKWzpZ/8rRL5LuQHM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-4PN2eCX_PIGirYliE0I4mA-1; Fri, 07 Aug 2020 10:21:31 -0400
X-MC-Unique: 4PN2eCX_PIGirYliE0I4mA-1
Received: by mail-wm1-f72.google.com with SMTP id z10so847118wmi.8
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 07:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T7lac5uLMYukZ9rxLMdYaYSoYm3mH5DfC4dKnmQchVM=;
 b=R6Hhyr8VwfYYkv4WwXgqvoxBzQen1zdYZgopGT9IyaReLWuXoEVu4A/OKCCU8i4uYC
 /1Z9avXXA/iXzAAB8M5hFtLjPG++lV3zSUwD5O/HqYMDmG34rbUcKj6ynRUOMwfnAuWY
 ixU1rRB0k2fcawHuxy98CobdNOhRJ+AsCVAB1Bw8Cj013XboNX30/kCFUu2Ev/+/qqlu
 IaiO557guWQ5fPy/QruLxzWCNSmxv0KEI8rlSLRFcbUxbltZ42MtdWGSfU9e/x4toHuC
 BXhems+680jOSOAlc1CiCSfMgP9RsuoLA1VR0XETBokmTCrdnRXWU5lOiqDk3WnLCWD9
 aP3g==
X-Gm-Message-State: AOAM5318rXhAFxW0tqlcVWKf/fjU8+tixc8X5ZfvFXwmbtkv9ALeG4D/
 d35kYXhinUumatLbZvhloi2E7C3vcN9L8XjqzfLLYegdha/ERLK0MYKhhJraWrlYyjeTnHmhD/S
 YlNubKBkDwnGBe8E=
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr13924392wml.133.1596810090805; 
 Fri, 07 Aug 2020 07:21:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX0fUClAlwN79JQF6SXLD0lx75s3xs0g56d7thBR2Ib6HIG3JKUxjmjQb68+famvFxwrxs/w==
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr13924377wml.133.1596810090577; 
 Fri, 07 Aug 2020 07:21:30 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id j2sm11283436wrp.46.2020.08.07.07.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 07:21:29 -0700 (PDT)
Subject: Re: [PATCH 070/143] meson: convert block/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-71-git-send-email-pbonzini@redhat.com>
 <1292192b-9237-29e0-0d25-40a076a53370@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a5f14ab-204c-8ef3-316c-e90c9e3b0dd1@redhat.com>
Date: Fri, 7 Aug 2020 16:21:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1292192b-9237-29e0-0d25-40a076a53370@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:11:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 15:37, Philippe Mathieu-Daudé wrote:
> On 8/6/20 9:15 PM, Paolo Bonzini wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  Makefile.objs | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index a5c919d..0f3074b 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -47,8 +47,7 @@ storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
>>  # single QEMU executable should support all CPUs and machines.
>>  
>>  ifeq ($(CONFIG_SOFTMMU),y)
>> -common-obj-y = block/
> 
> Left-over from 58/143 "meson: convert block"?

More or less.  It used to be bigger but it was merged back into 58 due
to the introduction of storage-daemon.

Good catch though, it broke bisectability because block/Makefile.objs
has gone away in 58.

Paolo

>> -common-obj-y += dump/
>> +common-obj-y = dump/
>>  common-obj-y += monitor/
>>  common-obj-y += net/
>>  common-obj-$(CONFIG_LINUX) += fsdev/
>>
> 


