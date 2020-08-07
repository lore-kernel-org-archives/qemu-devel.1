Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40230C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E3F221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2LTSU35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E3F221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k44M5-0002NW-1k
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 11:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k44KH-0000iT-Bc
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:30:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k44KE-0003bN-SS
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596814230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2Q7MNFhvXR8h5/XVGRpzzocXih7C9loEW/Rvn7azqc=;
 b=i2LTSU35ANrClpfqfYCjzeIRB4pvB1WpiBDHmwfaZ+3ImDQz061o6xm/fVfHCqYAjHr73v
 rbhIeleKvB8Csbwdp4U4SKAUrKnpYIREgE9HNQCc9qbOHe3gfIsityDEcVL8jvplpMl/vL
 PqxSyMF+21WQdpvLy92diQHYXUVQHCQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-kdxonSasO9OQ4g2YnipyyQ-1; Fri, 07 Aug 2020 11:30:28 -0400
X-MC-Unique: kdxonSasO9OQ4g2YnipyyQ-1
Received: by mail-wr1-f70.google.com with SMTP id f14so869551wrm.22
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 08:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c2Q7MNFhvXR8h5/XVGRpzzocXih7C9loEW/Rvn7azqc=;
 b=AjboOIeL06R/FQF3WSbndfjtAzEzPt3TsRsdVpklAceB2e7FofIyPw3wY3UaA89lzG
 a2rCkaSlNDICEO5w0ZoE5vMSGJuDWPscqhL58zF9EfEeMt7ivJ5PbfaBovMEVYZ+T/ml
 ZeaoqYb84P3f+ET3TJfcUIbg7ksBtYkGzhBQSamwlwYVca3v7olMzEHqZZ96wld6yGyw
 nLtMr86paV7xSxyfjQ0K/x2NK6RNS3rEKqEwCEE63OI7cHrmWrkQERFgD7/dlpuOktBj
 Wcm/k0HfTOR+yW3zj0uAZCkK3TvayyU57Cq6DQyGPFWgmg+LqQ8t/xJY0MF96IPohCjL
 3s0g==
X-Gm-Message-State: AOAM532HvlE/crCOkB5ODQU0SfQo/lX/SuZ7tb/M5CIQzDr6GMpZoJDL
 EXD5HkqMFJBJybjtaaYlsEqSQOqRu4WSkeAvLOWchh5hgbdWRvCwb7rbjYECEppERXYuW77YEY3
 T92VV7j+LzBmXP9g=
X-Received: by 2002:a1c:6604:: with SMTP id a4mr12892105wmc.81.1596814227063; 
 Fri, 07 Aug 2020 08:30:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeMCS86JeMd3OBdYImst9/Em6Q+umwGXGOtB/3pA/1ZHRxNfeAilddp67NnSIVrMjzh95JJA==
X-Received: by 2002:a1c:6604:: with SMTP id a4mr12892080wmc.81.1596814226825; 
 Fri, 07 Aug 2020 08:30:26 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id c14sm10644271wrw.85.2020.08.07.08.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 08:30:26 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807142939.GK120942@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d39936b-fd7c-6545-4ecf-03f140d13a08@redhat.com>
Date: Fri, 7 Aug 2020 17:30:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200807142939.GK120942@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 16:29, Daniel P. Berrangé wrote:
> New binaries have lost a bunch of libraries they previously linked
> to. This isn't neccessarily a bug, if the old make code was incorrectly
> adding too many libraries.

Yes this is because Meson uses --as-needed.

> Comparing 'make install', I see some differences:
> 
> < /vroot/usr/local/bin/elf2dmp
> < /vroot/usr/local/bin/qemu-edid
> < /vroot/usr/local/bin/qemu-ga
> < /vroot/usr/local/bin/qemu-storage-daemon
> > /vroot/usr/local/bin/qemu-pr-helper
> < /vroot/usr/local/libexec/qemu-pr-helper
> < /vroot/usr/local/libexec/vhost-user-gpu
> < /vroot/usr/local/libexec/virtfs-proxy-helper
> < /vroot/usr/local/libexec/virtiofsd
> < /vroot/usr/local/share/locale/sv/LC_MESSAGES/qemu.mo
> 
> Some documentation files have moved - gaining a bogus extra directory
> component, and others are missing...

I see no missing files after removing the extra directory component.

0a1,38
> /vroot/usr/local/share/doc/qemu/devel/atomics.html
> /vroot/usr/local/share/doc/qemu/devel/bitops.html
> /vroot/usr/local/share/doc/qemu/devel/.buildinfo
> /vroot/usr/local/share/doc/qemu/devel/clocks.html
> /vroot/usr/local/share/doc/qemu/devel/decodetree.html
> /vroot/usr/local/share/doc/qemu/devel/genindex.html
> /vroot/usr/local/share/doc/qemu/devel/index.html
> /vroot/usr/local/share/doc/qemu/devel/kconfig.html
> /vroot/usr/local/share/doc/qemu/devel/loads-stores.html
> /vroot/usr/local/share/doc/qemu/devel/memory.html
> /vroot/usr/local/share/doc/qemu/devel/migration.html
> /vroot/usr/local/share/doc/qemu/devel/multi-thread-tcg.html
> /vroot/usr/local/share/doc/qemu/devel/objects.inv
> /vroot/usr/local/share/doc/qemu/devel/reset.html
> /vroot/usr/local/share/doc/qemu/devel/s390-dasd-ipl.html
> /vroot/usr/local/share/doc/qemu/devel/search.html
> /vroot/usr/local/share/doc/qemu/devel/searchindex.js
> /vroot/usr/local/share/doc/qemu/devel/secure-coding-practices.html
> /vroot/usr/local/share/doc/qemu/devel/stable-process.html
> /vroot/usr/local/share/doc/qemu/devel/_static/alabaster.css
> /vroot/usr/local/share/doc/qemu/devel/_static/basic.css
> /vroot/usr/local/share/doc/qemu/devel/_static/custom.css
> /vroot/usr/local/share/doc/qemu/devel/_static/doctools.js
> /vroot/usr/local/share/doc/qemu/devel/_static/documentation_options.js
> /vroot/usr/local/share/doc/qemu/devel/_static/file.png
> /vroot/usr/local/share/doc/qemu/devel/_static/jquery-3.2.1.js
> /vroot/usr/local/share/doc/qemu/devel/_static/jquery.js
> /vroot/usr/local/share/doc/qemu/devel/_static/language_data.js
> /vroot/usr/local/share/doc/qemu/devel/_static/minus.png
> /vroot/usr/local/share/doc/qemu/devel/_static/plus.png
> /vroot/usr/local/share/doc/qemu/devel/_static/pygments.css
> /vroot/usr/local/share/doc/qemu/devel/_static/searchtools.js
> /vroot/usr/local/share/doc/qemu/devel/_static/underscore-1.3.1.js
> /vroot/usr/local/share/doc/qemu/devel/_static/underscore.js
> /vroot/usr/local/share/doc/qemu/devel/tcg.html
> /vroot/usr/local/share/doc/qemu/devel/tcg-icount.html
> /vroot/usr/local/share/doc/qemu/devel/tcg-plugins.html
> /vroot/usr/local/share/doc/qemu/devel/testing.html
10a49,50
> /vroot/usr/local/share/doc/qemu/interop/qemu-ga-ref.info
> /vroot/usr/local/share/doc/qemu/interop/qemu-qmp-ref.info

I'll stop installing the devel manual and keep the .info file in interop
(which hopefully will go away anyway in 5.2).

Paolo


