Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F301C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187AF2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr20RDpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187AF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHP3s-0006K1-4R
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 05:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jHP3C-0005eV-IG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jHP3B-0004k1-Mk
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:43:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41463)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jHP3B-0004jd-JA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585215825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NhyXXU9Obgqam13uryhalZ6Dl3KUPZMBTJpKDfIA+5w=;
 b=Xr20RDpktmbmz+IM8RILYiWsTfmDAJDFK27CohWAIi/cVHieSRj2sel6xkE+APLXIvBwPF
 JWQ0dLi2j2jmU1wo8FgyrtgD/QZhKiz1Y5lQUQFnjTQ8xM4RUSIQGz8TSllHwQjqijJPa5
 ZlM+vpWMd90n/Ulgv0i6FSwnHp6FyDs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-Jn0DsKhtMiuXbqQpnnWduQ-1; Thu, 26 Mar 2020 05:43:41 -0400
X-MC-Unique: Jn0DsKhtMiuXbqQpnnWduQ-1
Received: by mail-wm1-f71.google.com with SMTP id i9so393575wmb.5
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 02:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NhyXXU9Obgqam13uryhalZ6Dl3KUPZMBTJpKDfIA+5w=;
 b=FPQeDZMXjoTU8SLU8/yEUOecAkbtu484QxUKZrwRxFI9ASCt+dcW6dtSejIa/0vyQV
 3rYgE2AqQy3P9Rpavhulr0qoNUAow/p+EETTIGuERmRxhT1Q4QN+HaATKpbq6Xzf41JC
 Eh7rRuvQVxT2iY6j7I9buESiUAwj7iteUBe+9MtJ+ohTDzXCYpzkawl4p7Rh1dIh+MIf
 NS+6ptQYytiziwVdkWp7yc49FNmlPxc/L59vp2X28Wopws1nqXOYh7x2DuM9HezMvPWk
 NccoHl0ujHqxxbDqo89vlltL3ZAWZH3d1LUZTOCmS4Lm+qshzRNgcz1uN/GqE7JyHhtQ
 3ufg==
X-Gm-Message-State: ANhLgQ0Io/buFUlXwZcPPVe8siLEwjzpKq/26nbTYYISFJM31Q4oocfC
 V0j7y7nvdxJcCBl5Ku5qkvTVm/4V2MuUxbP15Ss8OQxGWJ2gZ1HLJxOPsqsg8GKkDxz2/6wMDYs
 JbJ5hoD8+FrLBL8I=
X-Received: by 2002:a7b:c842:: with SMTP id c2mr2359306wml.154.1585215820301; 
 Thu, 26 Mar 2020 02:43:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtyAhVzl5vU+epEXzL+OtVaaptHYtbQrT38VjqrAqSKOjWV58Mrxd4UX3Hxi5YChhB0UK6ZLg==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr2359289wml.154.1585215820100; 
 Thu, 26 Mar 2020 02:43:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e4f4:3c00:2b79:d6dc?
 ([2001:b07:6468:f312:e4f4:3c00:2b79:d6dc])
 by smtp.gmail.com with ESMTPSA id a1sm3046013wro.72.2020.03.26.02.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 02:43:39 -0700 (PDT)
Subject: Re: [PATCH 2/2] util/bufferiszero: improve avx2 accelerator
To: "Hu, Robert" <robert.hu@intel.com>, Eric Blake <eblake@redhat.com>,
 Robert Hoo <robert.hu@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
References: <1585119021-46593-1-git-send-email-robert.hu@linux.intel.com>
 <1585119021-46593-2-git-send-email-robert.hu@linux.intel.com>
 <9eea6e9c-e35c-72e7-4574-7b9a6b72f9a7@redhat.com>
 <9E79D1C9A97CFD4097BCE431828FDD31178F147A@SHSMSX104.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <01974c7d-8f44-a9d8-b068-2b80642d6d45@redhat.com>
Date: Thu, 26 Mar 2020 10:43:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9E79D1C9A97CFD4097BCE431828FDD31178F147A@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/03/20 03:09, Hu, Robert wrote:
> BTW, do I need to resend these 2 patches?

No, thanks!  I have queued them.

Paolo


