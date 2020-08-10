Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984D7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE1C20885
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lh8I9Ckw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE1C20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CvF-0001yj-Jd
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5CuR-0000mi-5r
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5CuO-000712-8g
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597085550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXNqGW5WsXYau69O9qtSdNgJFVIxITrldZZNYXJCEZ0=;
 b=Lh8I9Ckw7P+0rXUe2JL0xSdL1bBzJEr8WNI1VuBCMJD/Ye/kL4FygmHm7IIzlgyyW1FZ+m
 XyxkFd24GUn/dn/84PGX1KEnJfrJWF8+CM795wdV0TBXQthI1HwJeCQYz7k2QHUA+1z1Ex
 wyfukj11axh4l9g5i0auJOyVcwSnHLI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-Ev5uDDSBPS65s5yfTQuPUQ-1; Mon, 10 Aug 2020 14:52:28 -0400
X-MC-Unique: Ev5uDDSBPS65s5yfTQuPUQ-1
Received: by mail-wr1-f70.google.com with SMTP id t3so4558068wrr.5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 11:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WXNqGW5WsXYau69O9qtSdNgJFVIxITrldZZNYXJCEZ0=;
 b=QM5BnGTLTaBkKlrfR0Ha1mO+zrprBVSFlFIXONzxQC+6ClVJ9VdrrNaltn3XEmfwbH
 vBv8wuRtDrmOkIvlZxtwpOk0z2O3ZjfqEzDuEl7E+8DIQGoxEO52BwSRBDxF2KUS2LWF
 88MVLgfkeReUHxWlBjx6+EXjdGravVQRItkSS3XktwoqQIvM8sqUQ/Ck+IvXeJkAloHv
 9+MOI43jJP/YfphAbzvjCjPUUtfsJt+F/MyQnmSX8/0zStd7pn1EAmarAcg70SA22I2Z
 nBvmmSLxkO9egR/tR78bQAN9BZqFLmKUudIwTJKztiz/XFrTF5ybDUhvLm4WP5GAR/Gu
 jxuA==
X-Gm-Message-State: AOAM533qrjjj2/FfY/XjNNGSYwD4Gtj2oBeGyo1+vDwmHTbn29UTeBbQ
 WKwzXFbo5Kj4blRgiTLQrQS3HikhbfcQPJqUONudZWo9Ip4/k8cyFNfgGCawPnnj8lO3qTeWlGq
 u7SqsJpnIZVFzVTY=
X-Received: by 2002:a7b:c38a:: with SMTP id s10mr617506wmj.13.1597085546748;
 Mon, 10 Aug 2020 11:52:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhrXy6DeBhdJ9pQQuU6JePVxOz7iHh/fwySNOh+JoQi0i6628bkHX7mrUmzBlxO02sqyc0CQ==
X-Received: by 2002:a7b:c38a:: with SMTP id s10mr617496wmj.13.1597085546574;
 Mon, 10 Aug 2020 11:52:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id p6sm21252493wru.33.2020.08.10.11.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 11:52:25 -0700 (PDT)
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
 <CAFEAcA_cBDHNgNsDMJS+WqX+W-xbo18c1Eno2RqGnwa-iGw3-w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd576941-5620-f6b8-46d2-f2c73d3813a9@redhat.com>
Date: Mon, 10 Aug 2020 20:52:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_cBDHNgNsDMJS+WqX+W-xbo18c1Eno2RqGnwa-iGw3-w@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 13:09:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 20:20, Peter Maydell wrote:
> (Looks like an error in the version of the system header
> file on this system, which, unlike my x86 box, defines
> the prototypes with "inline" (a change that came in upstream
> in commit
> https://github.com/sahlberg/libiscsi/commit/7692027d6c11c58948ec3c493abea808af00fdd0
> ).

What's the version of libiscsi?

Paolo


