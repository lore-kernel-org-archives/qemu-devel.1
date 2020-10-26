Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DF1C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FEC2242A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqLQpCy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FEC2242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX37f-0004uu-Kj
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uo-0005iw-JY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uW-0001l6-Me
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GH14LsTnaeCVc39D/8a6ieYNRnbEw0Ngq6iIvuKEW1Q=;
 b=DqLQpCy0gJvBsD3mCfQome0CbLa3z+QTwpiGt7yJYC0MK31TEDyapPeXio41X9wLEImlNV
 0PiRASP/xUvFzdPRpl7rTs9fXRHCndneJI9ubUWBdYYSVMlXjubxu1eU7yO/eB/MATFxRg
 s/4qvjx3kUKELB2+ccvk1x4YhXEihHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-twK6MpWsPmqJD7rq67IHbw-1; Mon, 26 Oct 2020 09:51:37 -0400
X-MC-Unique: twK6MpWsPmqJD7rq67IHbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1623804354
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A69D86EF40
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/17] configure: allow configuring localedir
Date: Mon, 26 Oct 2020 09:51:23 -0400
Message-Id: <20201026135131.3006712-10-pbonzini@redhat.com>
In-Reply-To: <20201026135131.3006712-1-pbonzini@redhat.com>
References: <20201026135131.3006712-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Meson has a localedir option, so passing the path through that option
is the cleanest way when we move directories out of config-host.mak.
In preparation for doing that without changing semantics and without
special-casing localedir code, add a configure option.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index e6754c1e87..c214e9b38e 100755
--- a/configure
+++ b/configure
@@ -962,6 +962,8 @@ for opt do
   ;;
   --docdir=*) docdir="$optarg"
   ;;
+  --localedir=*) localedir="$optarg"
+  ;;
   --sysconfdir=*) sysconfdir="$optarg"
   ;;
   --localstatedir=*) local_statedir="$optarg"
@@ -971,7 +973,7 @@ for opt do
   --host=*|--build=*|\
   --disable-dependency-tracking|\
   --sbindir=*|--sharedstatedir=*|\
-  --oldincludedir=*|--datarootdir=*|--infodir=*|--localedir=*|\
+  --oldincludedir=*|--datarootdir=*|--infodir=*|\
   --htmldir=*|--dvidir=*|--pdfdir=*|--psdir=*)
     # These switches are silently ignored, for compatibility with
     # autoconf-generated configure scripts. This allows QEMU's
@@ -1525,6 +1527,7 @@ firmwarepath="${firmwarepath:-$prefix/share/qemu-firmware}"
 libdir="${libdir:-$prefix/lib}"
 libexecdir="${libexecdir:-$prefix/libexec}"
 includedir="${includedir:-$prefix/include}"
+localedir="${localedir:-$datadir/locale}"
 
 if test "$mingw32" = "yes" ; then
     mandir="$prefix"
@@ -1670,6 +1673,7 @@ Advanced options (experts only):
   --static                 enable static build [$static]
   --mandir=PATH            install man pages in PATH
   --datadir=PATH           install firmware in PATH/$qemu_suffix
+  --localedir=PATH         install translation in PATH/$qemu_suffix
   --docdir=PATH            install documentation in PATH/$qemu_suffix
   --bindir=PATH            install binaries in PATH
   --libdir=PATH            install libraries in PATH
@@ -5728,7 +5732,6 @@ fi
 qemu_confdir="$sysconfdir/$qemu_suffix"
 qemu_moddir="$libdir/$qemu_suffix"
 qemu_datadir="$datadir/$qemu_suffix"
-qemu_localedir="$datadir/locale"
 qemu_icondir="$datadir/icons"
 qemu_desktopdir="$datadir/applications"
 
@@ -5912,7 +5915,7 @@ if test "$mingw32" = "no" ; then
   echo "qemu_localstatedir=$local_statedir" >> $config_host_mak
 fi
 echo "qemu_helperdir=$libexecdir" >> $config_host_mak
-echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
+echo "qemu_localedir=$localedir" >> $config_host_mak
 echo "qemu_icondir=$qemu_icondir" >> $config_host_mak
 echo "qemu_desktopdir=$qemu_desktopdir" >> $config_host_mak
 echo "GIT=$git" >> $config_host_mak
-- 
2.26.2



