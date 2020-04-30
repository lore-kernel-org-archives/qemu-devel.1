Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5546BC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C16E20775
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H224HyzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C16E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBbH-0006GE-38
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 11:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBWh-0007mG-SY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBUS-000347-Jm
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:55:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUBUS-00033U-7E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588261963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/B6Ruk3HgSfcXrGljG9iNkxqs39o3NPNdgS86Uzrzo=;
 b=H224HyzQIAUIAxqOETRvRi5yAbmnpuANh6hggwOPjPg4n2yNTd+M/DaMyQtYPPMpQAKzW6
 iKCPi93MUoKl1FV+VowSaW5aDJBIvsBDDxeDh0RrSxnFrWJWHzoiViT3M8mp55y41WBm/9
 aU4XcDIxRYa5Na4X5HMEn3XoeIeW0EU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-io-vs5xQMGGEAUqtI6ffcA-1; Thu, 30 Apr 2020 11:52:41 -0400
X-MC-Unique: io-vs5xQMGGEAUqtI6ffcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3AA9835B59;
 Thu, 30 Apr 2020 15:52:39 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D31AE77355;
 Thu, 30 Apr 2020 15:52:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/15] qcow2: Add incompatibility note between backing files
 and raw external data files
Date: Thu, 30 Apr 2020 17:52:17 +0200
Message-Id: <20200430155231.473156-2-kwolf@redhat.com>
In-Reply-To: <20200430155231.473156-1-kwolf@redhat.com>
References: <20200430155231.473156-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

Backing files and raw external data files are mutually exclusive.
The documentation of the raw external data bit (in autoclear_features)
already indicates that, but we should also mention it on the other
side.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20200410121816.8334-1-berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/interop/qcow2.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 640e0eca40..298a031310 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -25,6 +25,9 @@ The first cluster of a qcow2 image contains the file head=
er:
                     is stored (NB: The string is not null terminated). 0 i=
f the
                     image doesn't have a backing file.
=20
+                    Note: backing files are incompatible with raw external=
 data
+                    files (auto-clear feature bit 1).
+
          16 - 19:   backing_file_size
                     Length of the backing file name in bytes. Must not be
                     longer than 1023 bytes. Undefined if the image doesn't=
 have
--=20
2.25.3


