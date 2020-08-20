Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B39C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0779A208B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlPnpBge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0779A208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pH8-0004Pb-5z
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8pGR-0003ks-0g
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 14:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8pGO-0001EZ-Jk
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 14:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597947970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5upAFTAwTYQ2jxhDAq1whJGHTAdalY/dTreqh8yGbk=;
 b=XlPnpBgeoyzuVjIXgKqyexhqn1IKiWTSyh2aM26v7Ejk5o8mpTROWH2Mc/EicSTW7ZEYe4
 XaKcg35S/sLP3/DwWPfirN68n4MhHj4ieFqa/LYm4SXsrmmpOMzpi7k+/Jjtv/Qq54pNcV
 xwFvjDoHlOJPU2/FJp1b5BltAAjYsHI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-kXLq2hocPVKi6bFbdSnX9g-1; Thu, 20 Aug 2020 14:26:09 -0400
X-MC-Unique: kXLq2hocPVKi6bFbdSnX9g-1
Received: by mail-wm1-f72.google.com with SMTP id c124so1286528wme.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 11:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z5upAFTAwTYQ2jxhDAq1whJGHTAdalY/dTreqh8yGbk=;
 b=mekMmbMcb56x0cdsTxMBHxEj7ZOsNRPiWFQhs+N8AQt0gf73BRNrl2gDXKOMsN4bOK
 cizFmQuWxLvtL8yZJwYjib1GBfntfz5PS1O9G1NZprwHCpFlGsOpPjIyhVn26bk5tkRc
 dOwt3OMZDsP8DARp0t12DglMNLtltgDMD3vrEXK7NQQyS0x+5gqZ4+KLXQSwih9I0s5e
 QZVT0JuX2TsA/7ufSt5L7cK/PCxjqIYjfVNFT0bf1SMTfzWVdJtE00VfuNOI4fZt8WMV
 lWOBLxa0JkJoSP73wwC6WAeRedSWH/d7VOlO4e92KxKVBKHdV7v9nXbeMzrCxadZeIXY
 KPXw==
X-Gm-Message-State: AOAM532pUbyr9RWd3k3CGiHM/LlCf/pw4sq3po+5uZqsJ9tKYD0pDLeH
 66Twk16+48bCeMgIXlUVC3SvV8SSkODdh1iBOa6FrtmJ2Xha7Uh0ecc+IEgoPNt+VrR2/S3d7eH
 2Bb9ZeP/v6U8vEyc=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr89683wmc.53.1597947967948;
 Thu, 20 Aug 2020 11:26:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweHo58SAJI8U0VmKmbrOwxTS+slNsj2ySeQHBLBglXh+zYGM8YNdL4v/6H5CYCncLie3f/Yg==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr89670wmc.53.1597947967745;
 Thu, 20 Aug 2020 11:26:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id s19sm6276539wrb.54.2020.08.20.11.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 11:26:07 -0700 (PDT)
Subject: Re: [PATCH] configure: add support for psuedo-"in source tree" builds
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
References: <20200820165543.215372-1-berrange@redhat.com>
 <938bfa57-01f9-a50a-6439-0965c91dce1b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3635ac4-835e-9938-c938-16c62615fbfb@redhat.com>
Date: Thu, 20 Aug 2020 20:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <938bfa57-01f9-a50a-6439-0965c91dce1b@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:28:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/20 19:42, Eric Blake wrote:
>>
>> This goes on top of Paolo's most recent meson port v175 posting,
>> or whatever number it is upto now :-)
> 
> Nice comment for reviewers, but doesn't quite need to be preserved in git.

I for one don't mind. :)

Paolo


