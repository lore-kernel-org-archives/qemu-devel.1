Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E52C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9AE20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+dYNQE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9AE20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRBV-00088t-47
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDR9A-0006Og-EV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:41:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54419
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDR98-0005PX-5i
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599046905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SoCVG9BorLFUkdn+NRpKWQC2uGdyka8Wt05BItvtj1I=;
 b=N+dYNQE7UoZkXpvEm+klxSC+jJ54L6In+otRsWpMcAQzgajIkNnpWXeJxJAnnhAArKtL4G
 c8QZNL4PyIrg/5h/znn3O30ZnHmWgl9zMt+z2LQJsj2lrYBW3FKWvXUSXltc3j7mBSFqXQ
 n/qRU4RLvQtoeSbBmwIKWlnpAyMf+Bo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-LISV5Ap2NseuAteXvoP-Yg-1; Wed, 02 Sep 2020 07:41:43 -0400
X-MC-Unique: LISV5Ap2NseuAteXvoP-Yg-1
Received: by mail-wm1-f70.google.com with SMTP id c72so1550339wme.4
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 04:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SoCVG9BorLFUkdn+NRpKWQC2uGdyka8Wt05BItvtj1I=;
 b=Xu+dlTa8xiTNiN2exrGEM5jpJFrHre6pxEOXTeow6IcQYeXPA7NQnSqOnH1BF8LdzJ
 /W1hksaYFppf1u2wNdi4DmdkFrhPErT7zbR3xbt0Ryp+oyDWj6OdBC4hqf+9u3op0JAb
 o6W99q2s/JifksnSSsssH2G1Ze5HkJtt2iO3C1UulsxJ47d1hVsGVDaiczJzS16ubzBh
 Nk8Abu300n9i4WXJSyfx9PFXndbnibwJiodOj8buagPU1zlWKVyFldEfLnxh0OsBqlH+
 zRPIh/mt4MKQOw+2CssQCNqrawjzPFv+ewg8x2h1TqoiLkeF7UwKPK3bsQOH/9IN/rLM
 x7qg==
X-Gm-Message-State: AOAM5338l2ZI6x9STxGQvD/D3LCSgVLhYINMahcmt30ka7B1cL4rztgj
 Z9J/zNLiTtrmyiZVvedwArTqz1mfMyISdApJPJOzRI2cnt6lmG6SE5G39k4KqQ1Wu7bGYqel1eC
 o7ODvriNlDPz/Exg=
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr268015wmd.104.1599046902189; 
 Wed, 02 Sep 2020 04:41:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0KpzgfcEgEG0F3lSLuJUpCjvtWEkEJfIjMwLUS+35sijIgrsNBWaIvT1L4wlyensKZA/P9g==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr268001wmd.104.1599046901985; 
 Wed, 02 Sep 2020 04:41:41 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id f126sm6140513wmf.13.2020.09.02.04.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 04:41:41 -0700 (PDT)
Subject: Re: Cirrus CI for msys2 are working now, but still buiding failed
To: Thomas Huth <thuth@redhat.com>, luoyonggang@gmail.com,
 qemu-level <qemu-devel@nongnu.org>
References: <CAE2XoE_SkH-2dNULFAZNiRNRNP=OncwCy=xrDk0J3bzS1Th=tg@mail.gmail.com>
 <c61f6420-ffdb-b2b1-44ec-60b8a55f9c8a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac9ee76a-bc7f-0715-4324-d33c2fb2bb66@redhat.com>
Date: Wed, 2 Sep 2020 13:41:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c61f6420-ffdb-b2b1-44ec-60b8a55f9c8a@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 12:38, Thomas Huth wrote:
> Wow, that looks quite promising already! But I wonder why the build
> system is trying to link libfdt to targets like qemu-system-avr that do
> not need it?
> And for the targets that need fdt, it should use the dtc submodule... I
> can see in the log that the dtc submodule is checked out, but it does
> not seem to be compiled ? As a test, could you please try to run
> "configure" with "--disable-fdt" there?

Mark and Yonggang have reported an issue where the linker gets
an msys path like -L/e/qemu/dtc but it wants -LE:/qemu/dtc instead.
But fortunately we can just use -Ldtc instead, which would be a patch like

diff --git a/configure b/configure
index 56ceca2f68..34e81a7b60 100755
--- a/configure
+++ b/configure
@@ -943,7 +943,7 @@ Linux)
   linux="yes"
   linux_user="yes"
   kvm="yes"
-  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
+  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -Ilinux-headers $QEMU_INCLUDES"
   libudev="yes"
 ;;
 esac
@@ -4259,7 +4259,7 @@ EOF
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
           fi
           fdt_cflags="-I${source_path}/dtc/libfdt"
-          fdt_ldflags="-L$PWD/dtc/libfdt"
+          fdt_ldflags="-Ldtc/libfdt"
           fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
@@ -5244,7 +5244,7 @@ case "$capstone" in
     else
       LIBCAPSTONE=libcapstone.a
     fi
-    capstone_libs="-L$PWD/capstone -lcapstone"
+    capstone_libs="-Lcapstone -lcapstone"
     capstone_cflags="-I${source_path}/capstone/include"
     ;;
 
@@ -6244,8 +6244,8 @@ case "$slirp" in
       git_submodules="${git_submodules} slirp"
     fi
     mkdir -p slirp
-    slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
-    slirp_libs="-L$PWD/slirp -lslirp"
+    slirp_cflags="-I${source_path}/slirp/src -Islirp/src"
+    slirp_libs="-Lslirp -lslirp"
     if test "$mingw32" = "yes" ; then
       slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
     fi

Paolo


