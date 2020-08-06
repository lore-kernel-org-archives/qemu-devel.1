Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50651C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58AB2204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXadHutt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AB2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gfB-0004af-Eb
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 10:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3geP-0003lY-6Q
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:13:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3geM-0007QJ-LY
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596723221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KuexCdPgJbUwVKecECy//1dwm6a6nFKW+hu+VovLckM=;
 b=aXadHuttQtFkkzQloqAjPVY6u6XohLzRVAGGBM/ehe5QlDcBVxvwdTzWtwrdOFwmnoFNCl
 LkWtlPJXnF1+FEZDMAi4e9XMPtahUzqaSpQbULYUF5s8uOzPUsCd2v6AxGv2G4ADFkj3ys
 JK6AYyXfLlr7KeA+CGr8pU3SmZDjYKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-Yr4SFJZkN-2LAaFcpBTfxA-1; Thu, 06 Aug 2020 10:13:39 -0400
X-MC-Unique: Yr4SFJZkN-2LAaFcpBTfxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E946D8017FB
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 14:13:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A587A5DA83;
 Thu,  6 Aug 2020 14:13:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1944D114207B; Thu,  6 Aug 2020 16:13:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] scripts/cleanup-trace-events: Fix for vcpu property
Date: Thu,  6 Aug 2020 16:13:31 +0200
Message-Id: <20200806141334.3646302-2-armbru@redhat.com>
In-Reply-To: <20200806141334.3646302-1-armbru@redhat.com>
References: <20200806141334.3646302-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: philmd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit a44cf524f8 "scripts/cleanup-trace-events: Update for current
practice" limited search to the input file's directory.  That's wrong
for events with the vcpu property, because these can only be defined
in root directory.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/cleanup-trace-events.pl | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/cleanup-trace-events.pl b/scripts/cleanup-trace-events.pl
index d4f0e4cab5..6c3767bd6a 100755
--- a/scripts/cleanup-trace-events.pl
+++ b/scripts/cleanup-trace-events.pl
@@ -31,10 +31,12 @@ open(IN, $in) or die "open $in: $!";
 chdir($dir) or die "chdir $dir: $!";
 
 while (<IN>) {
-    if (/^(disable |(tcg) |vcpu )*([a-z_0-9]+)\(/i) {
-        my $pat = "trace_$3";
-        $pat .= '_tcg' if (defined $2);
-        open GREP, '-|', 'git', 'grep', '-lw', '--max-depth', '1', $pat
+    if (/^(disable |(tcg) |(vcpu) )*([a-z_0-9]+)\(/i) {
+        my $pat = "trace_$4";
+        $pat .= '_tcg' if defined $2;
+        open GREP, '-|', 'git', 'grep', '-lw',
+	    defined $3 ? () : ('--max-depth', '1'),
+	    $pat
             or die "run git grep: $!";
         while (my $fname = <GREP>) {
             chomp $fname;
-- 
2.26.2


