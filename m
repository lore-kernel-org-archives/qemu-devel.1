Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C162C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C3E21919
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dh+VLkSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C3E21919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1lh-0000mQ-NG
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG1kD-0007qy-0p
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:10:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40297
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG1k9-0003Km-T5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599664240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIsLOwQ5HX9HHyOJSMntwTbtxy4p3e9Pq9rJeDW3whU=;
 b=Dh+VLkSuMLIYJDdXaIsITWNxIQmRHrtVry6pyjmxfQq2Gm62gH/lznNms5j1zrZM88XGvm
 yu3j4rP3RMEr/a/M5iosvFNB4d5dsr1gTbV/SliQdNS0FCMxhadDSbhE1IELCAjhSgJJhA
 ktgWLGCeyL4oCl4WBS0kDMQRuGLqE0o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-tPJVWmH1OeujOx-onazGlQ-1; Wed, 09 Sep 2020 11:10:36 -0400
X-MC-Unique: tPJVWmH1OeujOx-onazGlQ-1
Received: by mail-ej1-f72.google.com with SMTP id f17so1439072ejq.5
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 08:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YIsLOwQ5HX9HHyOJSMntwTbtxy4p3e9Pq9rJeDW3whU=;
 b=GMIXn6r5DLzxigBsy+TipUGjK+aCMD48bRq+aewgROiy9hxdJaGfwAwppxLSF0zCys
 9Czctb2mH1euxbc/S1r0YP5aavtgR5mIQD0wK45/ahD01QBSE0OTFIqKZHh016fXEyUj
 f0D0Qb2HD1vPCBBWO1gszTrr3GKEBVmJ/EjJuEQqP3xlu/J4HXD2HP1HGi/SrpdUv3CL
 HqdQAt4Fg3HU7AY1HIfN6f53tdruSASusaBrOY0CPasPgAqeKRIOK74lEpn05mNeATTf
 PbHJDXmKZm0hh2eo2OkfAXsPu7L9O2/B8a7vYT7FcqJA2wt3f9mkFIlzxtcYWFiEYEhm
 /pmQ==
X-Gm-Message-State: AOAM532Nae/UGoZz4e5MkOwIU7AM0leF+Ie5/rXXb50+FZL4sVfsyOXU
 gexCgB5+fifZHlne5mMAebLDvcz8kl307pHM/g6FLkkBeIyK5/iBOiourEgqHz2CR+iv5YgoEib
 zrQoJKt39Y2owAEs=
X-Received: by 2002:a50:eb92:: with SMTP id y18mr4385457edr.373.1599664235228; 
 Wed, 09 Sep 2020 08:10:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeeyKM1MrZExIsOS+Idz9aP9gmVV3skOY5TIt7ic2YRzrSpeF9k33EIj2Q7RGIk13kJnri2Q==
X-Received: by 2002:a50:eb92:: with SMTP id y18mr4385429edr.373.1599664235023; 
 Wed, 09 Sep 2020 08:10:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4025:be55:3943:81a0?
 ([2001:b07:6468:f312:4025:be55:3943:81a0])
 by smtp.gmail.com with ESMTPSA id y24sm2732840eds.35.2020.09.09.08.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 08:10:34 -0700 (PDT)
Subject: Re: Meson can't recover from deletion of generated QAPI file(s)
To: Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <87pn6vw2he.fsf@dusky.pond.sub.org>
 <ff7ef6e4-254a-b171-22bf-c5cca4945160@redhat.com>
 <26432e3f-2b22-4966-ebea-8be448636fbb@suse.de>
 <2d49cdbb-41e2-ae1d-79cd-3a05678e9b87@redhat.com>
 <a443d9fe-d831-c7f2-5300-7f1d8660c81f@suse.de>
 <0b2617b8-10dd-d487-cfa0-67b646c72ac0@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25206eb0-8f06-5f38-0cfd-f92e65494eb9@redhat.com>
Date: Wed, 9 Sep 2020 17:10:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0b2617b8-10dd-d487-cfa0-67b646c72ac0@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/20 17:05, Claudio Fontana wrote:
> Hmm, I still encounter problems:

And another:

diff --git a/tests/meson.build b/tests/meson.build
index 998e4c48f9..95789f43b3 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -56,7 +56,7 @@ test_qapi_files = custom_target('Test QAPI files',
 # perhaps change qapi_gen to replace / with _, like Meson itself does?
 subdir('include')
 
-libtestqapi = static_library('testqapi', sources: [test_qapi_files, test_qapi_outputs_extra])
+libtestqapi = static_library('testqapi', sources: [test_qapi_files, genh, test_qapi_outputs_extra])
 testqapi = declare_dependency(link_with: libtestqapi)
 
 testblock = declare_dependency(dependencies: [block], sources: 'iothread.c')

Paolo


