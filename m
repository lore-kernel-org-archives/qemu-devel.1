Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550F7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2273320708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeWVOqiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2273320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTJp-0008Iz-Eo
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtTJ8-0007Sg-3A
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:57:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27586
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtTJ6-00048M-FE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594288651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wj7KegTJa2Q9NbOTr0ydHEVsMSm3L1lOz4g1lbVynx4=;
 b=OeWVOqiYKYa8+BGq4yhXESWu6QWjf7bY1WPRETsMPjS7985cC0Clct0ZiKL9kfjtrhT9vh
 RAAMccW2xfpCWmEbwGK2OgmbVm7M/htxcRG8s7Wsn5X7brhySas3/uVCV5KDtIdjc71qXb
 81uCc1b/JPF0CzAnsCZQMZZur1PaAvg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-AIIFOlKPMCaNN9l6qGf9pQ-1; Thu, 09 Jul 2020 05:57:29 -0400
X-MC-Unique: AIIFOlKPMCaNN9l6qGf9pQ-1
Received: by mail-wr1-f70.google.com with SMTP id b8so1544655wro.19
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 02:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wj7KegTJa2Q9NbOTr0ydHEVsMSm3L1lOz4g1lbVynx4=;
 b=oO8eZ+71f7U7np3OvdMklHbtl6AjXvQhwVgOpgvuESJSozg7FYns1Sk6omEszanA3S
 vU2Nt2RjINg7PJ+zghlwsmdPGVZz6w4XoFT6X1ewRdQHBLiPkRnt93eAtQFWpmzRTp45
 OClT7RwnIr78NiEWFpfyWmRHxQp2mI+AlwIPHyTmCLzxOITCppwzsJjNUFGkZHJMocSg
 eAul5+1+CXOh4JFDrPUD1IKyG3vCmAD0wZ0rnbVngKCQV+MXw5wZ3ZvZ31P7tq6VDWnz
 LUcGAu6VG7IRceKSqfQIvbRhrvAP+T1pFMYVShVgmhpNeDt3WFh2jtAWFWa5V9FC0xpw
 nSkg==
X-Gm-Message-State: AOAM532/xHHgOW+mraYsaNQr28oUHShPHkigWHAYRhEEbRLrjp6g3YGr
 LMQBpezn74DwGx1TQqzP72x7Gl83T2mEG8JS57Q8teGfy9SY6Ho3bTaEbjGun75MI92+APF3TBe
 O90ky8ZlJ5dmgEvY=
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr13193421wmh.121.1594288648542; 
 Thu, 09 Jul 2020 02:57:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOyhSfP1cLqMFev5YKD4s+e5sfEsm95rFbgo1blOXKhPabMNuFElMQ9UlPj4GKfkc52K9s8A==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr13193399wmh.121.1594288648252; 
 Thu, 09 Jul 2020 02:57:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id l14sm4903684wrn.18.2020.07.09.02.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 02:57:27 -0700 (PDT)
Subject: Re: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
To: Claudio Fontana <cfontana@suse.de>
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
 <1a9ad36f-f4ae-2ea5-3d69-03aa5580b60e@suse.de>
 <de27589f-6afb-b8cf-05a0-f5d34f9d2a58@redhat.com>
 <f17ca47d-f5e9-e710-5edb-9d92839ee7c1@suse.de>
 <56c7e153-e47b-aa5c-80c0-ab4f5c3d85e8@redhat.com>
 <57c79f36-4cf9-6188-ef40-b4f775add83d@suse.de>
 <0a3ab45d-468a-65f2-5b9d-440a0a950ded@suse.de>
 <CABgObfZA4+7q9+mg2NTXQC1f+usEsF0sXaNVt0+ursiJ4rAS=A@mail.gmail.com>
 <717d9f61-56c1-875a-7de2-35a3376d515c@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8bec990b-8e3a-039f-317b-aff5c9dcdb25@redhat.com>
Date: Thu, 9 Jul 2020 11:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <717d9f61-56c1-875a-7de2-35a3376d515c@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 08:59, Claudio Fontana wrote:
> anything else that we could use to find the real problem?

I'm using

$ gcc -v
...
gcc version 8.3.1 20191121 (Red Hat 8.3.1-5) (GCC)
$ ld -v
GNU ld version 2.30-68.el8

> Of course I can try a blind fix, where I suggest to explicitly provide the stubs,
> or you can apply the workaround you already suggested if you want,
> but currently I do not have any way to ensure that what I build is ok,
> since apparently the local build or any of the CI (travis, cirrus) is not sufficient to capture this.

No problem, I can test it myself on my machine when applying the patch.

Paolo


