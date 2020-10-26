Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6B0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8357720732
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeMmlc3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8357720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4B2-0001hH-MD
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX4AS-0001G8-4S
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX4AQ-0005mJ-ES
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603725133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpWHRxPv0IM71EXU0korKAgr/a1o32AyVALKHKJphNE=;
 b=NeMmlc3sBGIQYjXsfEGzXrikza33erYn7PS8Ek3KBCgu4YM8qPTX+xB4vmlx11F3jb74PZ
 sFYkSO19lrgQGzx0Fzh4tXVCPKeke6xiy1xBWAAkjJynfwsnGyxht90U8MbjFKYr6e6FMh
 SVd0b7RPGCMuSdHvEen+eNZj12qNlY8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-HMUxVusrMdiY3OpaSuJaIQ-1; Mon, 26 Oct 2020 11:12:11 -0400
X-MC-Unique: HMUxVusrMdiY3OpaSuJaIQ-1
Received: by mail-wm1-f69.google.com with SMTP id c204so6598875wmd.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 08:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UpWHRxPv0IM71EXU0korKAgr/a1o32AyVALKHKJphNE=;
 b=hLM4vtrhsctEn8B+PzbhbLzwlPuEjCPKhzrb/8EGo3jgDpnuavl2LGgbWmUgbhR/+5
 jcH7fECD9eaQ/00s5R+gRNhgkI/2uTmNmIX8nP1Za2+IPH6Sz9bLl/gIcHPFzkBpEqpV
 smXrx3ltiXZ4OIypIpDhVMHipK4f26LlbyejjF56rKdd/iUYSdkA+inkDCAovojWkEO9
 1+oB/MufGRSX4CAj1VfLWek1m1CHTmhTcA85xauiQvMFJRS2Y0s7CamsYxrzD+HRXlD4
 mYEUvmd9B5FiqBxYIYnyB7GTANWJJHwaTrDKxsCBEHIzLKhtpNhluv0r4T8ugrquDUt9
 H7Hw==
X-Gm-Message-State: AOAM532QGktiYjyVU5h8OxLHY8fzWVpMjw6iC8YYvNE0iNqLxMju0JRE
 LudMXAcoSQ4iadNrC0NmWM5vhIrIWl+PK0RSLwA4I4GwQdzkSkndhwT7v9gVsjTdCgFIUq6ay/H
 lf9z2FpwObETk1gM=
X-Received: by 2002:a05:6000:1084:: with SMTP id
 y4mr17402266wrw.138.1603725129959; 
 Mon, 26 Oct 2020 08:12:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysZcowqRbLP9fQACTm3NwL99PvSuM23IagkfvQx33xy37E6nqlS4CvZzeM1z3bqi0DPUTmzA==
X-Received: by 2002:a05:6000:1084:: with SMTP id
 y4mr17402244wrw.138.1603725129693; 
 Mon, 26 Oct 2020 08:12:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id e15sm22109144wro.13.2020.10.26.08.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 08:12:09 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] configure: avoid new clang 11+ warnings
To: Daniele Buono <dbuono@linux.vnet.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
 <96d4c76c-dfbb-f985-2718-0892ea1b83d4@redhat.com>
 <a5a32430-6eaa-1734-a402-4b0a3e079827@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98a03470-4694-f63a-7104-ae576e4799ce@redhat.com>
Date: Mon, 26 Oct 2020 16:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <a5a32430-6eaa-1734-a402-4b0a3e079827@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/20 16:03, Daniele Buono wrote:
> Hi Paolo,
> I reorganized UASStatus to put uas_iu at the end and it works fine.
> Unfortunately, this uncovered another part of the code with a similar
> issue (variable sized type not at the end of the struct), here:
> 
> In file included from ../qemu-cfi-v3/target/s390x/diag.c:21:
> ../qemu-cfi-v3/hw/s390x/ipl.h:161:23: error: field 'iplb' with variable
> sized type 'IplParameterBlock' (aka 'union IplParameterBlock') not at
> the end of a struct or class is a GNU extension
> [-Werror,-Wgnu-variable-sized-type-not-at-end]
>     IplParameterBlock iplb;
>                       ^
> ../qemu-cfi-v3/hw/s390x/ipl.h:162:23: error: field 'iplb_pv' with
> variable sized type 'IplParameterBlock' (aka 'union IplParameterBlock')
> not at the end of a struct or class is a GNU extension
> [-Werror,-Wgnu-variable-sized-type-not-at-end]
>     IplParameterBlock iplb_pv;
> 
> My understanding is that each of these IplParameterBlock may contain
> either a IPLBlockPV or a IplBlockFcp, which both end with a variable
> sized field (an array).
> 
> Adding maintainers of s390x to see if they have a suggested solution to
> avoid disabling the warning.

This one seems okay because the union constrains the size to 4K. If
"[0]" is enough to shut up the compiler, I'd say do that.

Paolo


