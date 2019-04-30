Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDC1C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3613C20652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3613C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVFC-0008V8-EV
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:04:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-0007y7-Dq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUum-00022w-LS
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUuJ-0001cV-Ce; Tue, 30 Apr 2019 11:42:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7BE859468;
	Tue, 30 Apr 2019 15:42:58 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C3AEE4C7;
	Tue, 30 Apr 2019 15:42:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:21 +0200
Message-Id: <20190430154244.30083-5-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 30 Apr 2019 15:42:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/27] vmdk: Set vmdk parent backing_format to
 vmdk
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430154221.7WhEL4DSc6lUx4p-YPV5DcfjFxPwySsswlFC4nqC6Gc@z>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Commit b69864e5a ("vmdk: Support version=3D3 in VMDK descriptor files")
fixed the probe function to correctly guess vmdk descriptors with
version=3D3.

This solves the issue where vmdk snapshot with parent vmdk descriptor
containing "version=3D3" would be treated as raw instead vmdk.

In the future case where a new vmdk version is introduced, we will again
experience this issue, even if the user will provide "-f vmdk" it will
only apply to the tip image and not to the underlying "misprobed" parent
image.

The code in vmdk.c already assumes that the backing file of vmdk must be
vmdk (see vmdk_is_cid_valid which returns 0 if backing file is not
vmdk).

So let's make it official by supplying the backing_format as vmdk.

Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-By: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Shmuel Eiderman <shmuel.eiderman@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index 8dec6ef767..de8cb859f8 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -397,6 +397,8 @@ static int vmdk_parent_open(BlockDriverState *bs)
         pstrcpy(bs->auto_backing_file, end_name - p_name + 1, p_name);
         pstrcpy(bs->backing_file, sizeof(bs->backing_file),
                 bs->auto_backing_file);
+        pstrcpy(bs->backing_format, sizeof(bs->backing_format),
+                "vmdk");
     }
=20
 out:
--=20
2.20.1


