Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B140BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E80E206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqlQSkse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E80E206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtV1P-0008VR-Ph
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtV0n-00080w-VP
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:46:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54189
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtV0m-0004PB-CE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594295203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9s8+xaLpJowXJeOc8UULArtwCwJpBBRxlVybYwMlLs=;
 b=MqlQSkse9hoz9cOXWisuOAI+dcm0qIX/UfxxH82vJ9xMCdquCX/9CLdBgIKoOZB1XNEcbu
 h7ZmSH5rCQU1JTbQmxX85iHf/De5KMCHmKYWWtMU27HMU13mg4byvSdICPyE48M5q240wo
 k0FCHT4SryGkqlzy0v1kp5FOX6TMMgc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-IrA7Om1nOC6P6dqts2bstg-1; Thu, 09 Jul 2020 07:46:41 -0400
X-MC-Unique: IrA7Om1nOC6P6dqts2bstg-1
Received: by mail-wm1-f69.google.com with SMTP id c81so1893868wmd.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 04:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z9s8+xaLpJowXJeOc8UULArtwCwJpBBRxlVybYwMlLs=;
 b=VtqoQlkAk7ZFY60fhi1Qu8cdhHgt8A0q3fIyMmPgMJmeZIW6pmsacC6KaXouUOsJ48
 PwPRGcIfKJ1jTJB3+L1GMmA/honicPc0QnSEyCcp04KRmDFHPI31i5BInMy0WPpO4Feh
 f1K+LL4Cn9FlCa3DxIk7ztePjAsdWnisgH3iRF6b9iDZvDu+B4frNP1vSRnRS7NfLzBE
 eF+IvLfz3bxN0TDc0paSh6QTHIb3pZuoL2gy+UVbMPiK9dHBtrXpFf9aWz/3acMDeeJi
 Z3JF4dgOnBplA2R4F9hzicIDKpTqTWqfEYldgkvcuz7+/X+L/RLm0+ewBpYUvtfYPXc8
 Sy5A==
X-Gm-Message-State: AOAM533mBKGXqSwAffPbOLtUw0EfIroqqFRNl27yitylefl/7Xl/5RAH
 cEAErECxconFqJ2gVaLajjgIFwlBLfS5oAvrXaJNxBzEkE3NoF9W5Azx1srk12L8dekNiyjuNIg
 Hl1aQVmawpZjrKXU=
X-Received: by 2002:a1c:9cd4:: with SMTP id
 f203mr14437163wme.155.1594295200570; 
 Thu, 09 Jul 2020 04:46:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYG/KtTii1wtf4jp1BRzHrCKSk8rLZQRunZFDw/GDyG1HvAECvUfyqGQSc70++sR8Chndqkg==
X-Received: by 2002:a1c:9cd4:: with SMTP id
 f203mr14437105wme.155.1594295199692; 
 Thu, 09 Jul 2020 04:46:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id 26sm4198759wmj.25.2020.07.09.04.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 04:46:38 -0700 (PDT)
Subject: Re: [qemu-web PATCH] new page: conservancy.md
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200707145110.10906-1-alex.bennee@linaro.org>
 <06e4b9a6-4ea7-8d90-3aca-68c0474a57be@redhat.com>
 <872e60f3-22e8-990b-4442-685b2f1877f5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <412a7b56-d2ed-32db-d95f-f1f42b6f18e6@redhat.com>
Date: Thu, 9 Jul 2020 13:46:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <872e60f3-22e8-990b-4442-685b2f1877f5@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 13:32, Thomas Huth wrote:
> Paolo, could you please update the link on
> https://wiki.qemu.org/Main_Page ? I do not have the access rights to
> edit that page. Once that is done, I think we can delete the old page
> https://wiki.qemu.org/Conservancy in the wiki (or turn it into a
> redirect page instead?).

Done, thanks.

Paolo


