Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9321EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601B820748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iG9eszE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601B820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zJG-00041P-Jj
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zIZ-0003at-8m
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:08:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zIX-00073I-JD
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596794904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUUP6RzPGw1GgTlsmxDApKJ7v44QUYtYQREv7RbPNHw=;
 b=iG9eszE2XnDsPwI7m7TJTpTsd11A/h6mTbPXBoCQEuMp4Ea0L7o3S9hCOkTiwLzuLiUJZG
 fMmLmfzGeFOlRJlCeXwQmral45ejx2q8r79iFMB3fDhlBblyXoV/YO/YtQ6dC5KgdwPeCm
 jxbBbmNnrhH6JUa4PvVS4GA3HHWdE78=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-pCf1-m1ZMqOoTQpxdyC1gA-1; Fri, 07 Aug 2020 06:08:21 -0400
X-MC-Unique: pCf1-m1ZMqOoTQpxdyC1gA-1
Received: by mail-wm1-f71.google.com with SMTP id z10so586804wmi.8
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iUUP6RzPGw1GgTlsmxDApKJ7v44QUYtYQREv7RbPNHw=;
 b=kkLabxBiYFP+DPYWRElZx0CWDA81ooA0PYrzN7ebpGeXrnVxPdle3A2f3zjQ8dZFDg
 UXOXudkaKsAafTjgCGMsNR64BWeuUdB/75dwjjjKCFNT883l/eu6QHgd5kGaABTvmFFn
 KXP9zUXQ5QjgfWGIbpxTUqeT2lo9+qhVOSK2AzXxe6PxTFZ3A1AaDaw8yXHoAPVQYPCI
 PCsihZSCKKwdKX+Bj1LpKr/mPDsFsKG3gkpshHMv7uR3ykIS4AYwE8KS3YXeSxg6VJPr
 XkiD23NPxd4oKtKjnyW2c++vDs6ZJH+BPQ7p5iqP9JswHGivUWib8iHtgLThc4P1L/eY
 wL8w==
X-Gm-Message-State: AOAM532EfWfqxVzHQvKo1vgnAM+frkiqpkfh/4gIEDX4krVsSXjjR/GC
 KmkdpVR40OnwIA8ZVsL61K7L1Aryo7boEft+ZRi3mhwQG/aeh6X+KbuqXd1VD7GHqHwPJW/xFf7
 k6qUg/3lKdcAfy6A=
X-Received: by 2002:adf:dc83:: with SMTP id r3mr12324257wrj.172.1596794899807; 
 Fri, 07 Aug 2020 03:08:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH1XegNcvidM0m6yP6+9FY5oJ4JEP2iQVsdd8k0AAwXa/0q0BbUtQfiXplZ6pJ9IpU9Y3hVg==
X-Received: by 2002:adf:dc83:: with SMTP id r3mr12324237wrj.172.1596794899591; 
 Fri, 07 Aug 2020 03:08:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id a11sm10886200wrq.0.2020.08.07.03.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 03:08:19 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
 <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
 <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
 <4a79a167-ccd6-159a-0f67-072192b54b0d@redhat.com>
 <f4233923-f82e-6edf-8a56-2e4f62038d0e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73398402-2038-ccf7-203b-e6e911d056a0@redhat.com>
Date: Fri, 7 Aug 2020 12:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f4233923-f82e-6edf-8a56-2e4f62038d0e@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On 07/08/20 12:02, Thomas Huth wrote:
> Thanks! With the fix, it now gets a little bit further, but then stops with:
> 
>   ../meson.build:1258:3: ERROR: Key CONFIG_QEMU_PRIVATE_XTS is not in dict
>  https://gitlab.com/huth/qemu/-/jobs/675699330#L130

diff --git a/meson.build b/meson.build
index d14d4bb..5bcfa09 100644
--- a/meson.build
+++ b/meson.build
@@ -944,12 +944,12 @@ summary_info += {'GNUTLS support':    config_host.has_key('CONFIG_GNUTLS')}
 summary_info += {'libgcrypt':         config_host.has_key('CONFIG_GCRYPT')}
 if config_host.has_key('CONFIG_GCRYPT')
    summary_info += {'  hmac':            config_host.has_key('CONFIG_GCRYPT_HMAC')}
-   summary_info += {'  XTS':             config_host['CONFIG_QEMU_PRIVATE_XTS'] != 'y'}
+   summary_info += {'  XTS':             not config_host.has_key('CONFIG_QEMU_PRIVATE_XTS')}
 endif
 # TODO: add back version
 summary_info += {'nettle':            config_host.has_key('CONFIG_NETTLE')}
 if config_host.has_key('CONFIG_NETTLE')
-   summary_info += {'  XTS':             config_host['CONFIG_QEMU_PRIVATE_XTS'] != 'y'}
+   summary_info += {'  XTS':             not config_host.has_key('CONFIG_QEMU_PRIVATE_XTS')}
 endif
 summary_info += {'libtasn1':          config_host.has_key('CONFIG_TASN1')}
 summary_info += {'PAM':               config_host.has_key('CONFIG_AUTH_PAM')}

:)

Thanks very much.  Sorry for the amount of breakage, at least it's all
been trivial to fix so far.

Paolo


