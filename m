Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FCEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB59C21744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UL80yT2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB59C21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yEk-0007tQ-0t
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3yE7-0007SZ-Qg
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:59:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43696
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3yE5-0007Xu-W8
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596790784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2YlJZcNOZN4Tw5NEpeUqdrlfaQcox6yPEozKKLxvOo=;
 b=UL80yT2yIqY8bteZyRSpooeXrP+NHxrBmxUduSlLbn35JFz/uHyVrC3Bq+RWL9nbH+2lws
 NDN0ERXZVJpjcA6vG0aHkVdgDyaM7XQZMnKOaHhzwdVdE/8gUZjYcrPcHBy3trhkKtJRIT
 VU7y75sCoVVmtXaDq9h6mJz2DvwoHJ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-iTg-oYRXN_y_VK7RNbiQDw-1; Fri, 07 Aug 2020 04:59:39 -0400
X-MC-Unique: iTg-oYRXN_y_VK7RNbiQDw-1
Received: by mail-wm1-f71.google.com with SMTP id p23so394751wmc.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u2YlJZcNOZN4Tw5NEpeUqdrlfaQcox6yPEozKKLxvOo=;
 b=tDWyrjNJ9KC1xjjT9zUvE1fV+FgHL73YfZNTKQiQozJEu5fNREqSYq8WKTWCqcomj9
 wqMJzKUxFMJQNPP9oKIE8k+aDSdSgS57diwOtSVecizxV/t0rBijNP9VAZEITcTFRico
 pNbUzbs8AiW3MeJGotoo7NFD0WTN0RvJuI6OESSVE4HwPktQI5hlpI0OAyUFXOAg3ZoB
 l+1Gv3T72GfA15o3rhgf8k61Zutbehxmv30SE59RK4dt/gTHeqhMSsE52C2szyaMsgde
 eB/4e4Mf+7H11KW6kk4xmegffvSc++Hd+6jHkWnKr1rhNhswXENHFXKaZxKfSfnhQVZ8
 T1ZA==
X-Gm-Message-State: AOAM531rfZTqigpyQE7dInO02WCybYaGd2b7lwIW6cEL1oFXuRPkg+fm
 owl4Hb710zoNAv877Q6dyIJJ1aTYI4tCE7fNIVZipvucd0rjapptxPQnvtn6nKakqTmdbC6ol8C
 gRabqPLEIYz+bfQc=
X-Received: by 2002:adf:f247:: with SMTP id b7mr11828587wrp.128.1596790778339; 
 Fri, 07 Aug 2020 01:59:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx0Ble2QeORZALPSFNQqx9d/+pduybe8A1NHe03jNqBlekeFq6PVrmwxjh/hkgDqGPXg7z+Q==
X-Received: by 2002:adf:f247:: with SMTP id b7mr11828567wrp.128.1596790778073; 
 Fri, 07 Aug 2020 01:59:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id w64sm9970848wmb.26.2020.08.07.01.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 01:59:37 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a927bf16-20ec-e8e7-d7a3-ebc1c9e17db1@redhat.com>
Date: Fri, 7 Aug 2020 10:59:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 armbru@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 10:51, Thomas Huth wrote:
> ../meson.build:1:0: ERROR: Value "gnu++03" for combo option "C++
> language standard to use" is not one of the choices. Possible choices
> are: "none", "c++98", "c++03", "c++11", "c++14", "c++17", "c++1z",
> "c++2a", "gnu++11", "gnu++14", "gnu++17", "gnu++1z", "gnu++2a".
> A full log can be found at
> /private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/build/meson-logs/meson-log.txt
> ERROR: meson setup failed
> 
>  https://cirrus-ci.com/task/6514035426328576
> 
> Maybe we should use gnu++11 for C++ code nowadays? ... we still used
> gnu++98 in the past since GCC 4.8 (from CentOS/RHEL 7) has only
> "experimental" support for c++11 ... but since we're soon (in less than
> a year) going to drop support for that anyway, maybe we could switch it
> now already to gnu++11 ... ?

Yes, I can.  And I'll look at the others, thanks!!!

Paolo


