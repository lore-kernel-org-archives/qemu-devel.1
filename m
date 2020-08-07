Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120A0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEEB206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BucWyeqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEEB206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xYZ-0000Kh-31
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3xTb-00004t-9p
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:11:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51734
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3xTY-0001t2-IU
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596787895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xhFQLbUOPu45pjb6Xas0l2cxxEFY9bHl7zoPQIIZdHs=;
 b=BucWyeqY68FhW5eOFTcXKg8bmVkVvo5WKgxj/Ax7ldqE9PBSsjLwANMIekg/3ke1A+YDWg
 v6Uj6nO9Yg3V+zIUBx9L7StIpXWukjG4gpjrz92ealiBMMz0fRGartrdOJJ1ubMNAQxu9A
 zL2CbujCS4ORNRp1joDrobTAIVJ3/Wc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-_T5L4empP0iHckNZVemoJw-1; Fri, 07 Aug 2020 04:11:34 -0400
X-MC-Unique: _T5L4empP0iHckNZVemoJw-1
Received: by mail-wr1-f69.google.com with SMTP id r14so439735wrq.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xhFQLbUOPu45pjb6Xas0l2cxxEFY9bHl7zoPQIIZdHs=;
 b=oMKLk46v1JJI7iTqrmcrrpaayy/NnUhuUsvUvLQqHSQcTvmCW3yvIABZZMiPlIYElJ
 HrB7afm1Nhcj1jHic171guUXoBNsdWqGiClzi1up+54GkX+8Nu645ozdrMIAATvo2jNS
 AaIu9P6flcVocWn23Hm2RTUWqQmbaqwLj6s4N76qLSgmiAGNrF5TfbwrIKmM105NZQKT
 D5AV2bxa7+KdRedHveLxQy1PT8D2pQO70cNGOmjo413lXfQSRGn2uRoebXc2CAcJjjr3
 pSb3tvH5BfuyTgYVXRIvMTgX4l7Xn3ubfpOiJmpc++qw/CABXjM3z2JyYTbdMpeBvaU8
 8lMA==
X-Gm-Message-State: AOAM532AQndJiPBgnz/AHuUog45kOsOWfuDBrsVrxPeyaNorDRHeXwDd
 nXDMpSQCvPBWB9L1iJNqTwugivBdsNd45Oxj2PCmL4GzXRqiewiUtrfyDg6tPeCKH21MSrhcspq
 yM5MRJbM8QIcEodo=
X-Received: by 2002:adf:808f:: with SMTP id 15mr10325078wrl.97.1596787892977; 
 Fri, 07 Aug 2020 01:11:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhtzdLjwaDMbqZjvDXXqRYCNnPP170M7PTY/4ZE3umdRx2PUh/gWytFoLRDmeSgzxNU+/L5g==
X-Received: by 2002:adf:808f:: with SMTP id 15mr10325065wrl.97.1596787892791; 
 Fri, 07 Aug 2020 01:11:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id g16sm9181197wrs.88.2020.08.07.01.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 01:11:32 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: luoyonggang@gmail.com, Cornelia Huck <cohuck@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
 <CAE2XoE_eMv_=zoEe-v1HiqcKX+FNobKSKzV=9eLkJNivnuYg-A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e8addca-7400-f1a1-ee56-991def2959ae@redhat.com>
Date: Fri, 7 Aug 2020 10:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_eMv_=zoEe-v1HiqcKX+FNobKSKzV=9eLkJNivnuYg-A@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, armbru@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 10:01, 罗勇刚(Yonggang Luo) wrote:
> Could meson can generate CMake file or directly using CMake?
> cause Cmake have better IDE support.

No, Meson generates ninja files.  In QEMU I am translating them to
Makefile to aid in bisectability.

Paolo


