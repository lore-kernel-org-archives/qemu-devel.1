Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03916C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 06:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FED0223FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 06:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnHUJG03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FED0223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVUVz-0002fu-UO
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 02:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVUUs-00027P-GE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 02:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVUUq-0006Va-0I
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 02:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603349686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NgRZcQ2VB1aKSr0HFjqds4m9pZWuzA4ilSl6HZyKlhU=;
 b=FnHUJG03kxXgKSPLNSAcrkbs2tFLV7skTspC2pX+xoE/17Njhwf9Xu3Bdnhr/ZSE7RNAq0
 EDADfOREaSZOFvr6gqYMnjHvf+OIzzmzLLK4b2pqIpjRsR6MrLMrbWka8DdW8WxYAzj7HS
 WS2rv7m5tv/utA7grY36I7xyP2MfQO8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-5dyR8ODrNYOHccYcAyQrXQ-1; Thu, 22 Oct 2020 02:54:44 -0400
X-MC-Unique: 5dyR8ODrNYOHccYcAyQrXQ-1
Received: by mail-wm1-f69.google.com with SMTP id r19so239535wmh.9
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 23:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NgRZcQ2VB1aKSr0HFjqds4m9pZWuzA4ilSl6HZyKlhU=;
 b=UeI1Fi2Z3D6yrx1QM14MvplHT4SX4v0NuzFK5vqVmw31a/+VOn37nSa96GbkOvw0D/
 a/jMR59vJMIy2SPqOSyiIRTKbBFHDNo+AuxAxmp7/LjfsD1R7f9NRrkvxOGncewcvOzZ
 NGLPoF1M1JZHYhJ0ED6h6UV0sTUq8KqoaYoLGS5IYWVju2YDztgKFFmt8SjrFd8XzjBv
 NI/r67SxNSFkejt28aNUOC/alDm6K8783Gmo1fl5J0mvWgBkAvxaiAfZmhSu3ZxezqYa
 C8zQ++uPX0HSsFTxrhumeAjsI5hiqdod/T4lqgXMVVNXZNL5Lt6V28HlV46Ob7KAEJ2M
 yPaA==
X-Gm-Message-State: AOAM5322TRdYs2WhrofjAMhpmsSTw35o/YrxfPxwli1f4wBIagrOUbWr
 whygHZZLyolpEok+gehN46l/VPt78SW+g/3hq5/AR9aTk42ZYQyFdjXlCTMH+SjvNXrYsY4v9il
 /M2SZGtTakb8HJFI=
X-Received: by 2002:adf:e942:: with SMTP id m2mr987994wrn.123.1603349683454;
 Wed, 21 Oct 2020 23:54:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxmNZV9dCGbfc5ip+YgcRlmDDB+1Iafz55UDcB97VYIGRVVAKlMooBBUVR7W03bA+W9+2Nuw==
X-Received: by 2002:adf:e942:: with SMTP id m2mr987978wrn.123.1603349683247;
 Wed, 21 Oct 2020 23:54:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id g144sm1812328wmg.30.2020.10.21.23.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 23:54:42 -0700 (PDT)
Subject: Re: [PATCH 02/22] machine: remove deprecated -machine
 enforce-config-section option
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201021205716.2359430-1-pbonzini@redhat.com>
 <20201021205716.2359430-3-pbonzini@redhat.com>
 <3d3e6f4d-c977-d691-295d-0928828e50b2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9df7fe80-f4bc-ebac-9a51-98b4c534a824@redhat.com>
Date: Thu, 22 Oct 2020 08:54:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3d3e6f4d-c977-d691-295d-0928828e50b2@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: berrange@redhat.com, jsnow@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/20 07:09, Thomas Huth wrote:
>> +#include "migration/misc.h"
> This new include does not make much sense to me, if all you did was removing
> code from this file. Why did you add this here?

Yeah, it's not needed anymore.  It's part of a different patch that I
threw away when I noticed the deprecation.

Paolo

> With this hunk removed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


