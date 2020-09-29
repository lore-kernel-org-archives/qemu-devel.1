Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36416C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B930A207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U08m/YGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B930A207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA9t-0002cH-Qb
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yI-0004Oe-MD
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yF-0001nz-Rd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:46 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0g5K5CUjVa2QgPkjnSBYRFmkoKQ6IkhV7beBCx5g004=;
 b=U08m/YGbUbIBEflUJn4W6qR5OIvGjgweWI6ZeXZ3rK+Fp29e2pslXbkhF1HPEN+/kN0zIo
 l0pzxDvYTh0sdyLL1rGnaAI2uIMm0V7ukHaivBSnyc0DvkDqNtyySoIdfNsJnjcwe0pkgz
 rsIsHaXhSnFGvX6R2ADd7intQUzpmuQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-77_-JigrPXiT0CPXiY5bjQ-1; Tue, 29 Sep 2020 03:22:24 -0400
X-MC-Unique: 77_-JigrPXiT0CPXiY5bjQ-1
Received: by mail-wm1-f71.google.com with SMTP id t8so1351281wmj.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0g5K5CUjVa2QgPkjnSBYRFmkoKQ6IkhV7beBCx5g004=;
 b=EgLAc0nVzVGv8evhhE77dqW3NjKSbovkio9Wit/ejmhbDyOiesZyua9YUFEPBgfwEi
 4P6PBoqBefSrwHzrre3n9aZ/tStxjvjQ38TfNuQH44ArNt4hLhkVwNMQMS16319oGkb+
 Ciy3xHmwPjlF59DMNn/O0owkgJTYGqyq9s7z9Xf+v893INxNs3rzSTjdY6wcBI2gwpCC
 YNf/Qqg6EeVpvOfAFk3F0OKLtf8cdYobw71s1+EWmIhk3G+YFPKEartmlFe5Zc/dHtOt
 TKvdne+8Ch5RKDuCAaDQVBevVP/t8OUprKB3dQh2WgUNd1ZJTRTPWS1LXuPRWp4gENfq
 J4ZQ==
X-Gm-Message-State: AOAM533kyfKvcpG8CmYev4hbqFcfez2l1W20d4eLgl16cvs0VBwfFhar
 dEaPqWngtMHCgGmqKpI0Ixuh5FwosJz03z2xBnus3GhgM8bHmtn59os66g2pS441afi5PzVZgWe
 j0YxhAGnJkQahYgs=
X-Received: by 2002:a1c:9c13:: with SMTP id f19mr2816210wme.97.1601364143313; 
 Tue, 29 Sep 2020 00:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFsX0A/bvXO21sl053FhSgqTPGx6izlNDDAouB7BwmFc4SnRNBBxBMAs8Jkie4/8Nc83quWg==
X-Received: by 2002:a1c:9c13:: with SMTP id f19mr2816192wme.97.1601364143057; 
 Tue, 29 Sep 2020 00:22:23 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id u66sm4144303wmg.44.2020.09.29.00.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:22 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 33/48] qemu-options: document SMBIOS type 11 settings
Message-ID: <20200929071948.281157-34-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NUMERIC_HTTP_ADDR=1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200923133804.2089190-4-berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qemu-options.hx | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 47f64be0c0..3564c2303f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2296,6 +2296,8 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str]\n"
     "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
     "                specify SMBIOS type 4 fields\n"
+    "-smbios type=11[,value=str][,path=filename]\n"
+    "                specify SMBIOS type 11 fields\n"
     "-smbios type=17[,loc_pfx=str][,bank=str][,manufacturer=str][,serial=str]\n"
     "               [,asset=str][,part=str][,speed=%d]\n"
     "                specify SMBIOS type 17 fields\n",
@@ -2319,6 +2321,45 @@ SRST
 ``-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str][,asset=str][,part=str]``
     Specify SMBIOS type 4 fields
 
+``-smbios type=11[,value=str][,path=filename]``
+    Specify SMBIOS type 11 fields
+
+    This argument can be repeated multiple times, and values are added in the order they are parsed.
+    Applications intending to use OEM strings data are encouraged to use their application name as
+    a prefix for the value string. This facilitates passing information for multiple applications
+    concurrently.
+
+    The ``value=str`` syntax provides the string data inline, while the ``path=filename`` syntax
+    loads data from a file on disk. Note that the file is not permitted to contain any NUL bytes.
+
+    Both the ``value`` and ``path`` options can be repeated multiple times and will be added to
+    the SMBIOS table in the order in which they appear.
+
+    Note that on the x86 architecture, the total size of all SMBIOS tables is limited to 65535
+    bytes. Thus the OEM strings data is not suitable for passing large amounts of data into the
+    guest. Instead it should be used as a indicator to inform the guest where to locate the real
+    data set, for example, by specifying the serial ID of a block device.
+
+    An example passing three strings is
+
+    .. parsed-literal::
+
+        -smbios type=11,value=cloud-init:ds=nocloud-net;s=http://10.10.0.1:8000/,\\
+                        value=anaconda:method=http://dl.fedoraproject.org/pub/fedora/linux/releases/25/x86_64/os,\\
+                        path=/some/file/with/oemstringsdata.txt
+
+    In the guest OS this is visible with the ``dmidecode`` command
+
+     .. parsed-literal::
+
+         $ dmidecode -t 11
+         Handle 0x0E00, DMI type 11, 5 bytes
+         OEM Strings
+              String 1: cloud-init:ds=nocloud-net;s=http://10.10.0.1:8000/
+              String 2: anaconda:method=http://dl.fedoraproject.org/pub/fedora/linux/releases/25/x86_64/os
+              String 3: myapp:some extra data
+
+
 ``-smbios type=17[,loc_pfx=str][,bank=str][,manufacturer=str][,serial=str][,asset=str][,part=str][,speed=%d]``
     Specify SMBIOS type 17 fields
 ERST
-- 
MST


