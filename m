Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFB2C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DFD21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlCIdkc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DFD21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43bn-0007gw-1d
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xr-0007DO-E4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xq-0001VT-3x
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xp-0001Ub-Vz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16J3FoexV5sgDLI1l/6fENHvOTRhrME/qffaBPywCi8=;
 b=ZlCIdkc9CV4OOpj7W0dC6fj2hfEV1E/N66ZQVReyxsQJA1N4DFm/UxXnU33MLtqWj05OSh
 MppFOFv77PzPWtWVAcUc9+rw/THbVTCPoyWPPhxDVacxqxIKF47C519ZWAS7/vmkIGavLy
 8L4apOB191mpAKwKiWn5B3qBglSi6jM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-wpm2TKbCM52fimdOvPiZEQ-1; Tue, 18 Feb 2020 09:08:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F2D0800EB2;
 Tue, 18 Feb 2020 14:08:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 362EE863CC;
 Tue, 18 Feb 2020 14:08:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 13/36] commit: Fix is_read for block_job_error_action()
Date: Tue, 18 Feb 2020 15:06:59 +0100
Message-Id: <20200218140722.23876-14-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: wpm2TKbCM52fimdOvPiZEQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

block_job_error_action() needs to know if reading from the top node or
writing to the base node failed so that it can set the right 'operation'
in the BLOCK_JOB_ERROR QMP event.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200214200812.28180-6-kwolf@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index 2992a1012f..8e672799af 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -143,6 +143,7 @@ static int coroutine_fn commit_run(Job *job, Error **er=
rp)
=20
     for (offset =3D 0; offset < len; offset +=3D n) {
         bool copy;
+        bool error_in_source =3D true;
=20
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
@@ -162,11 +163,15 @@ static int coroutine_fn commit_run(Job *job, Error **=
errp)
             ret =3D blk_co_pread(s->top, offset, n, buf, 0);
             if (ret >=3D 0) {
                 ret =3D blk_co_pwrite(s->base, offset, n, buf, 0);
+                if (ret < 0) {
+                    error_in_source =3D false;
+                }
             }
         }
         if (ret < 0) {
             BlockErrorAction action =3D
-                block_job_error_action(&s->common, s->on_error, false, -re=
t);
+                block_job_error_action(&s->common, s->on_error,
+                                       error_in_source, -ret);
             if (action =3D=3D BLOCK_ERROR_ACTION_REPORT) {
                 goto out;
             } else {
--=20
2.20.1


