Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEBEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA2021744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eu/cXC7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA2021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k449U-0005m5-AS
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 11:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k448x-0005Mk-VJ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:18:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21689
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k448w-0002Ek-8x
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596813529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dVxh0fr9yxN2gyTQjbJxy+gprK2kTRz10iTpcxG653A=;
 b=eu/cXC7UH+VIH3sFWj4iBS4fnXmMyE6JYDVZVUsJRy8OtFpRQqReIAM7c/vkpJHF8boK57
 26uUeN4z6Bbgwv5KVrFFyNGVtBSS51Xq7WO6ZFqSQ6SX2aE1uXYSW9uL+6APLhUH9sWKE1
 GSrftIMZ8ktkLxmZ0KlLgq4NkGgKkDs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-thJm57GiMzuUG6KQEFoumw-1; Fri, 07 Aug 2020 11:18:47 -0400
X-MC-Unique: thJm57GiMzuUG6KQEFoumw-1
Received: by mail-wr1-f72.google.com with SMTP id f14so856620wrm.22
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 08:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dVxh0fr9yxN2gyTQjbJxy+gprK2kTRz10iTpcxG653A=;
 b=tnLBVn/HOeD86n8F8MtGD+BrRkuvP5+s0x82U5byncCLhZvB7Uq3zjDUvFbOMaVrsn
 SQyDW9nvjGLH+Catb6exuVQ9F0B2SJnLR8Yzsbi9foPW3H60xzSLhlvJwHPFkDW9SPpy
 Thg+8dy05xVLrnoI7ifvoZDCFYpKd71U8xR6FF/1NIdbJ+nm9GogRGdCsOyNoTKB3h8i
 tc74gxdx3I7exTsZymBlgSmbxjmI6jlYeDst7+hZV9OIo5ASP+pgz/92ELlMfbeF0izB
 DBKainbqqEPFNDPgJId1pZwBKeSIGnwtfy+E+MhHpmNfwtIR2kTCgA/wGxnrzQpIxVJo
 rwRA==
X-Gm-Message-State: AOAM533ocBj+EjdEuUbGDUKYRjJGVhQziIXLZn++C1h5295VB+3AaMAr
 OzbPwhz/uN8NHdr+/Uo4HspS9ZUpHmVjJ5KOZQ8Qh3Nadynybi7vqNQrvoxBbILNkmWvyzjdidC
 KDmg+UN/0aFEFahg=
X-Received: by 2002:adf:f590:: with SMTP id f16mr11632206wro.98.1596813526490; 
 Fri, 07 Aug 2020 08:18:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTyg0SBEkjPdcJnqNT+Xrjr3EI/ym6diC9kV3jJTMEk0un/ChuNFKmV6l4qm19tP1SEqdv0Q==
X-Received: by 2002:adf:f590:: with SMTP id f16mr11632179wro.98.1596813526202; 
 Fri, 07 Aug 2020 08:18:46 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id 111sm10898943wrc.53.2020.08.07.08.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 08:18:45 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Cornelia Huck <cohuck@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
 <499b18ae-b15d-abbb-faf5-d9bdd5262fa4@redhat.com>
 <20200807113557.178825af.cohuck@redhat.com>
 <20200807142021.53967299.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b8cacc4-e60e-d436-4666-1457ec68e510@redhat.com>
Date: Fri, 7 Aug 2020 17:18:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200807142021.53967299.cohuck@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alex.bennee@linaro.org,
 stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 14:20, Cornelia Huck wrote:
>> - on an s390x system, it mostly builds, but I end up with a bunch of
>>   link errors for libblock.fa, where it fails to find various ZSTD_
>>   symbols
> Still happening after switching to the latest version of your branch.
> 

Fixed thusly:

diff --git a/block/meson.build b/block/meson.build
index c59e9ebd94..cd3bff5d80 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -40,7 +40,7 @@ block_ss.add(files(
   'vmdk.c',
   'vpc.c',
   'write-threshold.c',
-))
+), zstd)
 
 block_ss.add(when: [zlib, 'CONFIG_QCOW1'], if_true: files('qcow.c'))
 block_ss.add(when: 'CONFIG_VDI', if_true: files('vdi.c'))
diff --git a/configure b/configure
index 54c60bc8d6..610801ddaa 100755
--- a/configure
+++ b/configure
@@ -2623,8 +2623,6 @@ if test "$zstd" != "no" ; then
     if $pkg_config --atleast-version=$libzstd_minver libzstd ; then
         zstd_cflags="$($pkg_config --cflags libzstd)"
         zstd_libs="$($pkg_config --libs libzstd)"
-        LIBS="$zstd_libs $LIBS"
-        QEMU_CFLAGS="$QEMU_CFLAGS $zstd_cflags"
         zstd="yes"
     else
         if test "$zstd" = "yes" ; then
@@ -7394,6 +7392,8 @@ fi
 
 if test "$zstd" = "yes" ; then
   echo "CONFIG_ZSTD=y" >> $config_host_mak
+  echo "ZSTD_CFLAGS=$zstd_cflags" >> $config_host_mak
+  echo "ZSTD_LIBS=$zstd_libs" >> $config_host_mak
 fi
 
 if test "$libiscsi" = "yes" ; then
diff --git a/meson.build b/meson.build
index 155f7f8065..0323968aec 100644
--- a/meson.build
+++ b/meson.build
@@ -141,6 +141,11 @@ if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
                                 link_args: config_host['LIBISCSI_LIBS'].split())
 endif
+zstd = not_found
+if 'CONFIG_ZSTD' in config_host
+  zstd = declare_dependency(compile_args: config_host['ZSTD_CFLAGS'].split(),
+                            link_args: config_host['ZSTD_LIBS'].split())
+endif
 gbm = not_found
 if 'CONFIG_GBM' in config_host
   gbm = declare_dependency(compile_args: config_host['GBM_CFLAGS'].split(),


