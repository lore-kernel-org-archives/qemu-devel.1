Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1A3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01BA20671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKgPDW64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01BA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmMH-0005YU-2Z
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmLX-0004Sh-Rg
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:38:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23355
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmLV-0000z1-OK
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590071932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DfaOOIU3Jc/X3j8HAd5xhzoH+oh5AgD76ME72w2Q30=;
 b=EKgPDW64ReWn6Htz3cvoU+vmsJAqB6TMKU0CRKgu/C1ND67Z/xnnbXw/lrAYMaIbpUKDjl
 ELC1jeb5oo5i0p5SVdvcuWtaCwgqlSFa30mSkqecW3kABFDfd2AXPossz8peRH1QwJGoyv
 4oywoYUjJt+cxY3+e2F34Lbgis2KtuY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-CHr04IE7NzOi4OUWmbJSSA-1; Thu, 21 May 2020 10:38:50 -0400
X-MC-Unique: CHr04IE7NzOi4OUWmbJSSA-1
Received: by mail-wm1-f69.google.com with SMTP id f62so2776719wme.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9DfaOOIU3Jc/X3j8HAd5xhzoH+oh5AgD76ME72w2Q30=;
 b=Q9XTOmzEeZeG/NnqlP8enueWVyTVoD6Ww9ca+JdcUqfulOllWrdoIuZ/xcK1tInOsO
 J+0vrB3t6CB07ik3wNhKuInW4RkHf/arFuJBn3lrOLjnIFmhzXt9I3sAC0+DCyOb0V7B
 CmjjfqdWatUcjJ87CsLPSJt1EG/z5iT/PtyOYGxtZ+jft0LE8bqADcD09BbZQVmOttVM
 T7PduFp0JCy9CEF/+wKErbRNKVQJid8pwDQMtCCE95a/8gCxxkz3o/aq5c/GDp84ZHs0
 ga08rouA9GsdqCUmoYBSPXwjskVcS9KoW+GbggAqQ0jpy1C2Mz4V63781ZrT3/F+y6fY
 oiyA==
X-Gm-Message-State: AOAM531znmgRo5L+kfnbZvXyyOLrhc2/FTR2d9yZWd2XWuCawRtjac2C
 3f0PdnxX7Oj25KY5bcz09XN5qfuQR5O6y1Rd7G0vX0QzE/i94LyJa4nELMdkGsg2zGxeIqH4jNN
 uWq1eIOCN48OtOaA=
X-Received: by 2002:a5d:608d:: with SMTP id w13mr4740997wrt.298.1590071929076; 
 Thu, 21 May 2020 07:38:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+L01hjEhUuc+yu5QmP7aH3iFi2UjH6g91QxsEz/m9AJvKr7GenHeftfARqIkQA6L09EGeUQ==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr4740983wrt.298.1590071928808; 
 Thu, 21 May 2020 07:38:48 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id q9sm6519493wmb.34.2020.05.21.07.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:38:48 -0700 (PDT)
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
To: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
Date: Thu, 21 May 2020 16:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, xin.zeng@intel.com,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/04/20 11:40, Peter Maydell wrote:
>> This does not "drop" a write to a r/o region -- it causes it to generate
>> whatever the guest architecture's equivalent of a bus error is (eg data
>> abort on Arm).


> More generally, this change seems a bit odd: currently we do not
> check the mr->readonly flag here, but in general guests don't get
> to write to ROM areas. Where is that check currently done

Writes to ROM are directed to mr->ops unassigned_mem_ops.  Because _all_
ram-device reads and writes go through the ops, for ram-device we have
to stick the check for mr->readonly in the ops.

On one hand, I was quite surprised to see that unassigned_mem_write does
not return MEMTX_ERROR now that I looked at it.

On the other hand, we should use MEMTX_ERROR in patch 2 as well, if we
decide it's the way to go.

(Sorry Yan for the late response).

Paolo


