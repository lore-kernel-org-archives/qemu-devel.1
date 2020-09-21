Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6018DC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E19720874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWhp4YVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E19720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKLDU-0003Xd-QT
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kKLCM-0002n2-DN
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kKLCJ-0003Kb-Tv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600692334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRaYQeABCq5zvQFptaQvK21ARBCKPhQDuNhVVqHvFUA=;
 b=EWhp4YVOFq4Nfdonmrz7QC5o0DtcKXAeA+G9OD/ZU9L0EzfYCez9xNcvGs357q61pL6CQP
 GFFuBVo6i0tPNt6cVh0aAKtxJkBZRJE7+jJ/N0XN/Otv6U3714Cb/5OzXCsN9QwFIpBjej
 ckqlfWgqyuZd6NILo2DRXVsHT7pxOmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-Dk-rmTGsPPOS7ydU9VcbzQ-1; Mon, 21 Sep 2020 08:45:22 -0400
X-MC-Unique: Dk-rmTGsPPOS7ydU9VcbzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9477C801AB3;
 Mon, 21 Sep 2020 12:45:21 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AA497B7A0;
 Mon, 21 Sep 2020 12:45:15 +0000 (UTC)
Date: Mon, 21 Sep 2020 13:45:14 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 0/8] Configurable policy for handling deprecated
 interfaces
Message-ID: <20200921124514.GB27434@redhat.com>
References: <20200914084802.4185028-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200914084802.4185028-1-armbru@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com,
 libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some general comments on using the patch:

* For libguestfs I chose to add

  -compat deprecated-input=reject,deprecated-output=hide

  This is only enabled in developer builds of libguestfs when we
  are running qemu directly (not via libvirt).  The patch for
  this is attached.

* What's the point/difference in having reject vs crash?

* I hope that by hiding deprecated QAPI fields we may detect
  errors in libguestfs, but I suspect what'll happen is it'll
  cause fall-back behaviour which might be harder to detect.

* Be *really* good to have this for command line parameters!

Notes on the attached patch:

* https://libguestfs.org/guestfs-building.1.html

* Simple test:

LIBGUESTFS_BACKEND=direct \
LIBGUESTFS_HV=~/d/qemu/build/x86_64-softmmu/qemu-system-x86_64 \
./run libguestfs-test-tool

* Run the full test suite:

LIBGUESTFS_HV=~/d/qemu/build/x86_64-softmmu/qemu-system-x86_64 \
make -k check-direct

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-lib-direct-Pass-qemu-compat-to-detect-deprecated-fea.patch"

From 90df6dc8a3278800f9f9dc23f626df5fa00b5950 Mon Sep 17 00:00:00 2001
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Mon, 21 Sep 2020 13:18:05 +0100
Subject: [PATCH] lib: direct: Pass qemu -compat to detect deprecated features.

In developer versions of libguestfs only, pass the qemu -compat option
which will reject deprecated qemu features, giving us early warning if
we are using something that may be removed in future.  This does not
affect stable branch builds or old versions of qemu which did not have
this flag.
---
 lib/guestfs-internal.h |  3 +++
 lib/launch-direct.c    | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/lib/guestfs-internal.h b/lib/guestfs-internal.h
index d7ec7215d..4ad1cd125 100644
--- a/lib/guestfs-internal.h
+++ b/lib/guestfs-internal.h
@@ -33,6 +33,9 @@
 
 #include <pcre.h>
 
+/* Is this a developer version of libguestfs? */
+#define IS_DEVELOPER_VERSION ((PACKAGE_VERSION_MINOR & 1) == 1)
+
 /* Minimum required version of libvirt for the libvirt backend.
  *
  * This is also checked at runtime because you can dynamically link
diff --git a/lib/launch-direct.c b/lib/launch-direct.c
index b6ed9766f..3e42609ff 100644
--- a/lib/launch-direct.c
+++ b/lib/launch-direct.c
@@ -501,6 +501,17 @@ launch_direct (guestfs_h *g, void *datav, const char *arg)
   if (guestfs_int_qemu_supports (g, data->qemu_data, "-enable-fips"))
     flag ("-enable-fips");
 
+  /* In non-stable versions of libguestfs, pass the -compat option to
+   * qemu so we can look for potentially deprecated features.
+   */
+  if (IS_DEVELOPER_VERSION &&
+      guestfs_int_qemu_supports (g, data->qemu_data, "-compat")) {
+    start_list ("-compat") {
+      append_list ("deprecated-input=reject");
+      append_list ("deprecated-output=hide");
+    } end_list ();
+  }
+
   /* Newer versions of qemu (from around 2009/12) changed the
    * behaviour of monitors so that an implicit '-monitor stdio' is
    * assumed if we are in -nographic mode and there is no other
-- 
2.28.0.rc2


--Kj7319i9nmIyA2yE--


