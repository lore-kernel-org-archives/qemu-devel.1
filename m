Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B795C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333602177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEFe9Uq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333602177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40Bl-0006H5-EM
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k40Ao-0005Tq-0g
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:04:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23498
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k40Al-0005Uc-Cp
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596798266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=76OBAPI2GOVJLbEWkY2yOsz7t2eMx64XjFA1bCcmyeY=;
 b=XEFe9Uq7+yCNgv/oCQzfEjogyx+k9LwuBTrUwzgVu9/u3ltH0e6N5+H9vbuoyQqdtEDWLo
 tsEI7skRjCb8p9nTLlyaPAe+wvMuULZePL6t82Qlh4rEbirM41kIoL2LjfOZNVbmryPaBN
 5TW5r4gs5o7imyQVt9gAifUkb7Q7uC8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-L2nWxPiVPca7JNiBN1e1iw-1; Fri, 07 Aug 2020 07:04:24 -0400
X-MC-Unique: L2nWxPiVPca7JNiBN1e1iw-1
Received: by mail-wm1-f69.google.com with SMTP id c124so530348wme.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 04:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=76OBAPI2GOVJLbEWkY2yOsz7t2eMx64XjFA1bCcmyeY=;
 b=ifP/HFG2RhRjCFSF2hseI89v9TvEo5z0Vw2+ZYDyl1CVKt3dwNihsz37muMh1pWNHp
 pgvE+sCMHXW1obK73rg0+nxu2dhcxB8gzcdxTjA097E5O2aAY8WquUiEzIrsOUFIexYP
 o/vjVncfYv2of1qhuTvs42rD+GJkoAxpNFtC7op5RAPNgHmfvr7ewczKfunm62V9R3dH
 JNq5T2GY5Fe2/6HFAkKgQXQUG4G0TiOaaZejy5wmfKc9S78INL4mbWVjKecP7UOLCFl4
 5gwMK/uNzppe8cfgtQkS42vDPs0/dbVRRHcyk2RXQkNI/anS4MHofXArYWaxHh58yHP1
 uT+Q==
X-Gm-Message-State: AOAM530MGaQ99K47FEpI0QYxrvO1ODADGDs2jmKA25qsPKh5PllK1VHb
 BBZOCAzkjZdMRKIDKHu4eXdlGPUTaoaTdT9YziSQs9W8d64hHDQXSL+L0jrDAHCSiO+z94/bAMX
 2VTYiJCGaJCOSzwA=
X-Received: by 2002:adf:b34a:: with SMTP id k10mr11388909wrd.402.1596798263359; 
 Fri, 07 Aug 2020 04:04:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzkltYrF4YBr6qjAbxetGPYEEn9OvtnUj9DkrnLArkxgMz+mjJlIg100gvZjYavwUIpCSUUg==
X-Received: by 2002:adf:b34a:: with SMTP id k10mr11388890wrd.402.1596798263145; 
 Fri, 07 Aug 2020 04:04:23 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id m1sm9371375wmc.28.2020.08.07.04.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 04:04:22 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
 <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
 <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
 <ac18da61-6f54-b9d4-7591-e1296f9d3a32@redhat.com>
 <353ff6f7-c67f-7665-b631-967512417fa2@redhat.com>
 <fa3570e7-1f2a-c44c-91f2-411c1f51e6ef@redhat.com>
 <d9cc3875-1780-5fcc-5c2a-5408e6aba2e5@redhat.com>
 <cd17b073-57bb-e121-f55e-c89f6e005801@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b20db8c2-3201-0172-b6e9-ca1f2c0ef05b@redhat.com>
Date: Fri, 7 Aug 2020 13:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cd17b073-57bb-e121-f55e-c89f6e005801@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 12:52, Thomas Huth wrote:
> Thanks! Now, both, macOS and FreeBSD builds stop with:
> 
>  ../tests/qtest/meson.build:204:0: ERROR: Unknown variable "dbus_vmstate1".
>  https://cirrus-ci.com/task/6220295902068736?command=main#L210

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 507ee126e7..9a7daad59d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -76,7 +76,9 @@ if dbus_daemon.found() and config_host.has_key('GDBUS_CODEGEN')
                                 command: [config_host['GDBUS_CODEGEN'],
                                           '@INPUT@',
                                           '--interface-prefix', 'org.qemu',
-                                          '--generate-c-code', '@BASENAME@'])
+                                          '--generate-c-code', '@BASENAME@']).to_list()
+else
+  dbus_vmstate1 = []
 endif
 
 qtests_x86_64 = qtests_i386
@@ -207,7 +209,7 @@ extra_qtest_srcs = {
   'cdrom-test': files('boot-sector.c'),
   'migration-test': files('migration-helpers.c'),
   'ivshmem-test': files('../../contrib/ivshmem-server/ivshmem-server.c'),
-  'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1.to_list(),
+  'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1,
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'tpm-crb-swtpm-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tests.c'),
   'tpm-crb-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tests.c'),


Easy peasy lemon squeezy! :)

Paolo


