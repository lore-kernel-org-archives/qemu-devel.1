Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1298C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 21:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26F320738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 21:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esWTOWx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26F320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ENe-0002RO-Te
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 17:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9EMe-0001Ca-H6
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 17:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9EMc-0003rC-I0
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 17:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598044457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJ+D+OofnlaL/VVAsUmcGDGdBaAKcHF2G3ULnVaUy4Q=;
 b=esWTOWx39oosNs5Xygt6us6uJD/bjVmwi00o5AYh4u/Oe1NRbUyt4kfYo5NxlYBHLk7uXU
 lzixo3XvwNRUKwj4Z+SKvYTwTiXSbzn8FZ6p//ytgLiacq1LE18bpbe9s+p2NeTXWAlYHp
 qnoC7pFQeSWWhcoZpQABrfp9C8gRVt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-ieEbzHhXOmWqa8irm1H95Q-1; Fri, 21 Aug 2020 17:14:15 -0400
X-MC-Unique: ieEbzHhXOmWqa8irm1H95Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ACC356BE3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 21:14:14 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29C515C1D0;
 Fri, 21 Aug 2020 21:14:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] configure: silence 'shift' error message in version_ge()
Date: Fri, 21 Aug 2020 17:14:09 -0400
Message-Id: <20200821211412.17321-4-pbonzini@redhat.com>
In-Reply-To: <20200821211412.17321-1-pbonzini@redhat.com>
References: <20200821211412.17321-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

If there are less than 2 arguments in version_ge(), the second
'shift' prints this error:
    ../configure: line 232: shift: shift count out of range

As Eric suggested, we can use 'shift ${2:+2}' which works out to
'shift 2' if $2 is set, or 'shift' (implicitly shift 1) if $2
is not set.

This patch replaces both 'shift; shift' occurrences in version_ge()
with 'shift ${2:+2}'.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200821203558.10338-1-sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 4e5fe33211..d9ca87fbbb 100755
--- a/configure
+++ b/configure
@@ -228,15 +228,15 @@ version_ge () {
     while true; do
         set x $local_ver1
         local_first=${2-0}
-        # shift 2 does nothing if there are less than 2 arguments
-        shift; shift
+        # 'shift 2' if $2 is set, or 'shift' if $2 is not set
+        shift ${2:+2}
         local_ver1=$*
         set x $local_ver2
         # the second argument finished, the first must be greater or equal
         test $# = 1 && return 0
         test $local_first -lt $2 && return 1
         test $local_first -gt $2 && return 0
-        shift; shift
+        shift ${2:+2}
         local_ver2=$*
     done
 }
-- 
2.26.2



