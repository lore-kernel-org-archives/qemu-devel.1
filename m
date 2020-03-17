Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D76C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB7F206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDnojsDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB7F206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE7ZY-0002gc-0P
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 04:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jE7Yf-0001UD-1k
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jE7Ye-0000fV-6H
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:26:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jE7Ye-0000cp-24
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584433599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VESC7OQKqU3rtzs4Wq31Jt0RRx9Sf5HDHJefSWtcT0g=;
 b=WDnojsDYG4yJ65lE5/ogfIyIBAWzJNNvth5QpbH0YdxWOp/srOYCVxxHuqyNKOFVEW+per
 6XxC+8bgsbDCJnonSyviyorhWw8n2rEL0dgxH1x4AKtN3W8NLDx38TjdCKwqop4xcczH43
 EeOYjZle4XlrxknZ72QncueGRLnTvU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-UJGoWfxdN9GP1YXHEMBosg-1; Tue, 17 Mar 2020 04:26:35 -0400
X-MC-Unique: UJGoWfxdN9GP1YXHEMBosg-1
Received: by mail-wm1-f69.google.com with SMTP id y7so6832206wmd.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 01:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VESC7OQKqU3rtzs4Wq31Jt0RRx9Sf5HDHJefSWtcT0g=;
 b=tG0mmWJF/mJYKN3W3FhCLmdnvNvRZ7R4eC39PXoXmkjKWRgFDc3XIzeLJyKX1vjBwf
 t3tFRw8la7f3t6nUzqpJTjawERLHIMESUrMhv8BEHihv5HYyh8OBq7wgUMpG4qa6eOLT
 WGISkkPRGPFPBtdJr8seWLNKFt8Mm19E8HQet4iMSJ/pdOzTNU/3bZ6OYGRA2vkaxOuC
 WSbIWiIokRoXWTcTlZ6mJ+qteYqeXNHKNbYnnVcn7CAWjWI9uReXA4qqXgJEd4MrfeX6
 cjSlU4FeRtbi4pa5quUtMXEtJ52a1oNP1Zroq6Yf+V4jtRim/BRA6FakD/AYfrFNhXgO
 MK4w==
X-Gm-Message-State: ANhLgQ0g5BqcpquqzWRwcuWLHSYlZMU49QO2P7+H3DYfHDoZ7AmG6FMw
 AgSor6MDVy7FG9ugswm/J8jK8aCVx1H0VwSbrEuO1mSeeYdizwr7EJbixIIl2gxJm7lfJ1rnybU
 n87mdcL7sxDkteh4=
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr3925779wmk.131.1584433594879; 
 Tue, 17 Mar 2020 01:26:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvZtCDZH1KV0kCyLrrkPpHLlUbR2KWpLpGUbz4uGi6gkCNSK2nGpYyXZEL4QU128S7MDuLudg==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr3925753wmk.131.1584433594572; 
 Tue, 17 Mar 2020 01:26:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01?
 ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
 by smtp.gmail.com with ESMTPSA id z4sm3602278wrr.6.2020.03.17.01.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 01:26:34 -0700 (PDT)
Subject: Re: [PULL 09/61] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
To: Colin.Xu@intel.com, qemu-devel@nongnu.org
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
 <1584394048-44994-10-git-send-email-pbonzini@redhat.com>
 <d9e9e44f-ba54-c2e7-01c8-72337d3f5993@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc354cda-b731-183f-3860-43c3a0af434c@redhat.com>
Date: Tue, 17 Mar 2020 09:26:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d9e9e44f-ba54-c2e7-01c8-72337d3f5993@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Wenchao Wang <wenchao.wang@intel.com>, Hang Yuan <hang.yuan@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/03/20 08:46, Colin Xu wrote:
> Hi Paolo,
> 
> For future HAX patch, once it's "Reviewed-by" haxm maintainers and other
> reviewers, do we need "SubmitAPullRequest" separately or you will do it
> together with other patches?

As you prefer.  I wouldn't mind having to send fewer pull requests. :)

Paolo


