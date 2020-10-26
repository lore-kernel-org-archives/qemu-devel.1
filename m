Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C31AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6ED24641
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdAKkjcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6ED24641
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Z7-0004bI-1U
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX0Jd-0001ZB-Lo
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX0Jb-0003HT-Sa
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603710321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yT+2V1CB86GSe5cXLQISnAFcA6eUras1WdS9AparUt4=;
 b=ZdAKkjcCwkxID5VD29XZTmJsZXJsFD194dTvy6GiVRSKzdr3nnV/7PuuKrjn6knICsnb9E
 EfZzCqy1Xzmvv0P88FqFWGTPzFVAtJ7NkpVveC2N6kHy7xFTajKFMeICF6ybjfsMGCn1Yu
 GiWeDW9yhF2EAbw3AsM9uEFh5EFq7Ws=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-QJ5-Fp6oMACvwb2uCzCePg-1; Mon, 26 Oct 2020 07:05:20 -0400
X-MC-Unique: QJ5-Fp6oMACvwb2uCzCePg-1
Received: by mail-wr1-f72.google.com with SMTP id i1so8174541wrb.18
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 04:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yT+2V1CB86GSe5cXLQISnAFcA6eUras1WdS9AparUt4=;
 b=BH/H+XEX1grxGAJacBLT+nURmIITw5rWaCiZmNsgwk2lz9nsdQgY8bdPnKZJwKgLus
 sdOXyPfn7spRplKvCnsMfdy5MigwcFt7K3D0Q7gjdl91UX0ShjliANflQuj1lc8BTpzY
 2Tf6xeL474QoIgM6SAcHYo+eA2ZX25D/9KPmU1Pc5BaM9Ih7w+lmLU2vmo5uF2hD0LUZ
 P5/AlxTKBxobseEN+dCwURIGkjwa+bG6xAl4GMyWc1NMKh120TBm6HD27QMBXPP6WV6S
 0PWdo6ZnMfC1tiPaKHVRR/eqX4gtGSQjMUhU93xrMdaorvxdRONxY0uplQOLxy8Y07bk
 wzRw==
X-Gm-Message-State: AOAM533ttMpHcRe2ZGP5wJXAKvrQfNHUIUraHIFP8rGE0Sa6BOB8JOI3
 iiKYLrxoczH+B+H/MK2hhhIx68CsfAmGxxVvviFRhgjQsuMniChR3EfMdXmAMh/TGt9zzs/+lvS
 wjDUkeeONYinv8nM=
X-Received: by 2002:adf:81f4:: with SMTP id 107mr17195405wra.272.1603710318703; 
 Mon, 26 Oct 2020 04:05:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2/verCdp1bFzbsi4AE8ExwU+HjdkKRmIlHmhnYUXC08uHEcdDT+uXD8l06ByFwhrDztVs0g==
X-Received: by 2002:adf:81f4:: with SMTP id 107mr17195382wra.272.1603710318533; 
 Mon, 26 Oct 2020 04:05:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id q5sm24895430wrs.54.2020.10.26.04.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 04:05:17 -0700 (PDT)
Subject: Re: [PATCH] CHANGELOG: remove disused file
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
References: <20201022162843.1841780-1-jsnow@redhat.com>
 <576a881d-2c64-3e40-31b7-43680a1988f8@redhat.com>
 <22839fc4-a1b9-0510-ff19-3a713fd8a187@redhat.com>
 <88ac9998-51fb-0cca-8b7a-a2204ee0f9b2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2399870d-d6f8-ba3f-9793-15d42f23e827@redhat.com>
Date: Mon, 26 Oct 2020 12:05:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <88ac9998-51fb-0cca-8b7a-a2204ee0f9b2@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 20:51, Thomas Huth wrote:
> Ok, but IIRC the "ChangeLog" file is a standard file in GNU coding
> conventions, so it might be worth to keep the information in this file ...
> of course we are not bound to the GNU conventions in QEMU, but users still
> might expect to find the information in here...

The contents of the Changelog file would be in NEWS according to the GNU
conventions.  ChangeLog is essentially "git log" output (most GNU
projects in fact generate it from the latter).

Paol


