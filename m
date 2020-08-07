Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25869C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E508C2075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6n/3R8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E508C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zVM-0003hJ-8Q
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zUj-000351-Vk
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zUi-0000Fd-0Y
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596795659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLsrpC3Q/zg5goAdyAeTRYgOFamzx7Q/PWSsppJ2pp8=;
 b=F6n/3R8irG7Pb237XM2J0AU72snpNhsSUEYmvxFST/P2GVUaPGjAtZgNCS406yM0AopTeT
 hwrvpT/xNAJIWqvYwGrSMt1n/u/Y33+4BxeJQhtSZI6PxEVoF75HK6kvfq21JVTwc5jz5c
 4XCl26g8z/0GSuepgVEBsSojzVxy9Qk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-2Bim4jkFOS2FTp30GgEWdg-1; Fri, 07 Aug 2020 06:20:55 -0400
X-MC-Unique: 2Bim4jkFOS2FTp30GgEWdg-1
Received: by mail-wr1-f71.google.com with SMTP id w7so562012wre.11
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qLsrpC3Q/zg5goAdyAeTRYgOFamzx7Q/PWSsppJ2pp8=;
 b=cFmZ9aC5D8FYfGQcojcn+jLvfYHKwj6O42s7hVG2+kp7zpedQCZYo+y4q5f9oL7Cy3
 /IxzGwybUqJ8HaPjk/fq9FRSN6+TmRN0fPAb+MzUmzyMZsvnyLL8ZDQ9bJ/WC5rI6XWZ
 wwm6FlchzBFvWqxtNFKCQZana37e4UvB/0EETGXia8FRjuipaadraBZ/VjK6O2wQjtGP
 luRJGOkJDKmRZEeoHzrUvwFyDaHwuDEgpDFcZVL/YGZV3M6wnj6r7Z4/8OxvnC2WG2sg
 IgXYNfGaBcJXVQtqyyqS2T4T/+GIAntS+PFWSknoP0Z8lvxcxy+g298deCFBJ8rNDoZ1
 1Zxg==
X-Gm-Message-State: AOAM532+f68fRSypP7Q/0n7zbmlSaEa8Ifnme2y4iNIsIAuCrmdnKhP1
 njRTtOOK24IRaKS1ZbesnsrKrdzlbhyUDBxDv3R0Ka9ghhJQyWP3Z4Mp9AVbln6U2KieLgperQD
 CCo/RkoEHJrlhxQY=
X-Received: by 2002:a1c:1b93:: with SMTP id
 b141mr12238710wmb.150.1596795654508; 
 Fri, 07 Aug 2020 03:20:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMHcRYfCJa4eyc1bvA9HfnerxIzL8fj5VnXJcnElKn1Ae06hQ1bxXcVchxP57617WNr/OehQ==
X-Received: by 2002:a1c:1b93:: with SMTP id
 b141mr12238685wmb.150.1596795654269; 
 Fri, 07 Aug 2020 03:20:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id n11sm9199742wmi.15.2020.08.07.03.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 03:20:53 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
 <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
 <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
 <ac18da61-6f54-b9d4-7591-e1296f9d3a32@redhat.com>
 <353ff6f7-c67f-7665-b631-967512417fa2@redhat.com>
 <fa3570e7-1f2a-c44c-91f2-411c1f51e6ef@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9cc3875-1780-5fcc-5c2a-5408e6aba2e5@redhat.com>
Date: Fri, 7 Aug 2020 12:20:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fa3570e7-1f2a-c44c-91f2-411c1f51e6ef@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 05:20:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 07/08/20 12:00, Thomas Huth wrote:
> FreeBSD fails since dbus-daemon is not found:
> 
>  https://cirrus-ci.com/task/6446150314098688?command=main#L203
> 
> macOS now stops because the qemu_nbd variable is not set:
> 
>  https://cirrus-ci.com/task/5038775430545408?command=main#L207

A little refactoring needed for the latter, while the former is a one-liner.

diff --git a/meson.build b/meson.build
index dbe1d08..0a24116 100644
--- a/meson.build
+++ b/meson.build
@@ -1051,12 +1051,14 @@ endif
 if have_tools
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
+  qemu_io = executable('qemu-io', files('qemu-io.c'),
+             dependencies: [block, qemuutil], install: true)
+  qemu_block_tools = [qemu_img, qemu_io]
   if host_machine.system() == 'linux' or host_machine.system() == 'sunos' or host_machine.system().endswith('bsd')
     qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                dependencies: [block, qemuutil], install: true)
+    qemu_block_tools += [qemu_nbd]
   endif
-  qemu_io = executable('qemu-io', files('qemu-io.c'),
-             dependencies: [block, qemuutil], install: true)
 
   subdir('storage-daemon')
   subdir('contrib/rdmacm-mux')
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 60e81a2..3de09fb 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -1,8 +1,10 @@
-dep = [qemu_img, qemu_io, qemu_nbd, emulators]
 if 'CONFIG_LINUX' in config_host
-    dep += executable('socket_scm_helper', 'socket_scm_helper.c',
-                      build_by_default: false)
+    socket_scm_helper = executable('socket_scm_helper', 'socket_scm_helper.c',
+                                    build_by_default: false)
+else
+    socket_scm_helper = []
 endif
-test('qemu-iotests', sh, args: [files('../check-block.sh')], depends: dep,
+test('qemu-iotests', sh, args: [files('../check-block.sh')],
+     depends: [qemu_block_tools, emulators, socket_scm_helper],
      suite: 'block', timeout: 10000)
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c2601d9..507ee12 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -66,7 +66,7 @@ qtests_i386 = \
    'test-x86-cpuid-compat',
    'numa-test']
 
-dbus_daemon = find_program('dbus-daemon')
+dbus_daemon = find_program('dbus-daemon', required: false)
 if dbus_daemon.found() and config_host.has_key('GDBUS_CODEGEN')
   # Temporarily disabled due to Patchew failures:
   #qtests_i386 += ['dbus-vmstate-test']


I pushed again to meson-poc-next, diffstat is

 configure                      |  2 +-
 hw/display/meson.build         |  7 -------
 meson.build                    | 19 +++++++++++--------
 tests/qemu-iotests/meson.build | 10 ++++++----
 tests/qtest/meson.build        |  2 +-
 5 files changed, 19 insertions(+), 21 deletions(-)

Git submodules still not fixed


