Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC112C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B262145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcC1zqWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B262145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIZ1-0000w4-0i
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59788)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYW-0007sP-He
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYV-000396-8d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYV-00038I-1j
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id x15so17659981wmj.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=LYTPu7psuc85Dpnmvnd3GNUHtSt1nCg5qgokDKUHd0w=;
 b=KcC1zqWOmSIa9mrjwskY+NScdT6DFe904LAly52ad/Fy4HJYMO0qMISHaZGSDuFm9N
 WIXYSrStySxEjL0hEexS8tPuATh/VHCZP591GqPfgm/DY8q6oPfnvszhO6Kk6ychnIP3
 3Vqo56C3A++nEksYynPJeM7nW0LWV+V3rZaKF1rZuP9wHYTCsu0H3D6qnRWBTokNHBwV
 EQonMnFIQVilOXW/S3Bsn+R2u57iy/2yNwD0DqTY7FgDxOgsogXso7I5dOJUUBkOVDOg
 CkqR0DHnKeHngVnnqVDYoY1hA2kxl8P9iR/EfH6r57qzsqs0pdZLT+Ix32GtfqjUUWfC
 yVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=LYTPu7psuc85Dpnmvnd3GNUHtSt1nCg5qgokDKUHd0w=;
 b=EmsTteQ1ypypjfdemPOf9elrEP0YnsoHbyKVT0C1Je6yP28KZs7uWZNtpT+jpBJr/y
 Tw4tO0xAFNaduLIXTaK9IcLUw4Au9sFc7/Ac2lXHbFSvdJcHas46yXWIr2Ys+ypgZi9N
 OhflAB/aRTXp8FCKWZLQLIW+1B+ztYUNcFe8XdRGIG6ZjGynug3x1tHzyQMHPY9T44x3
 1D6smPfsVRRvxrGQ2ijSP4UXZwVaNAICdnNWzIF9aeNr0oonhL97SqsdRWZmH92cV36Y
 PNmK2VK+R/iFigWTiOmVPzZ3rE0v6ct41GSJqxw+LQf5eSWkdptQ/6SPm2WPTp+TNiOU
 TQNA==
X-Gm-Message-State: APjAAAXTtgo+KUNKtVNnbyUYaOfQT9As+2Vd43DaWojewC/1OqhFoG1Z
 /ghSzCHwdzUvbxa2HvPmTCLZFZ1DO+g=
X-Google-Smtp-Source: APXvYqx+emaMxBnLfy5JGSCS+C7DEBwdtW9UJYGl48s6Om1ouENMcjf1wl4eXhwSJi72v34wFbOvjA==
X-Received: by 2002:a1c:9e90:: with SMTP id h138mr30270024wme.67.1563264681704; 
 Tue, 16 Jul 2019 01:11:21 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:00 +0200
Message-Id: <1563264677-39718-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 02/19] scsi: explicitly list guest-recoverable
 sense codes
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

It's not really possible to fit all sense codes into errno codes,
especially in such a way that sense codes can be properly categorized as
either guest-recoverable or host-handled.  Create a new function that
checks for guest recoverable sense, then scsi_sense_buf_to_errno only
needs to be called for host handled sense codes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c  |  5 ++---
 include/scsi/utils.h |  1 +
 scsi/utils.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5d3fb3c..8e95e3e 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -454,14 +454,13 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
              * pause the host.
              */
             assert(r->status && *r->status);
-            error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
-            if (error == ECANCELED || error == EAGAIN || error == ENOTCONN ||
-                error == 0)  {
+            if (scsi_sense_buf_is_guest_recoverable(r->req.sense, sizeof(r->req.sense))) {
                 /* These errors are handled by guest. */
                 sdc->update_sense(&r->req);
                 scsi_req_complete(&r->req, *r->status);
                 return true;
             }
+            error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
             break;
         case ENOMEDIUM:
             scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index 9351b21..fbc5588 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -106,6 +106,7 @@ extern const struct SCSISense sense_code_SPACE_ALLOC_FAILED;
 
 int scsi_sense_to_errno(int key, int asc, int ascq);
 int scsi_sense_buf_to_errno(const uint8_t *sense, size_t sense_size);
+bool scsi_sense_buf_is_guest_recoverable(const uint8_t *sense, size_t sense_size);
 
 int scsi_convert_sense(uint8_t *in_buf, int in_len,
                        uint8_t *buf, int len, bool fixed);
diff --git a/scsi/utils.c b/scsi/utils.c
index 8738522..ad243a9 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -336,6 +336,38 @@ int scsi_convert_sense(uint8_t *in_buf, int in_len,
     }
 }
 
+static bool scsi_sense_is_guest_recoverable(int key, int asc, int ascq)
+{
+    switch (key) {
+    case NO_SENSE:
+    case RECOVERED_ERROR:
+    case UNIT_ATTENTION:
+    case ABORTED_COMMAND:
+        return true;
+    case NOT_READY:
+    case ILLEGAL_REQUEST:
+    case DATA_PROTECT:
+        /* Parse ASCQ */
+        break;
+    default:
+        return false;
+    }
+
+    switch ((asc << 8) | ascq) {
+    case 0x1a00: /* PARAMETER LIST LENGTH ERROR */
+    case 0x2000: /* INVALID OPERATION CODE */
+    case 0x2400: /* INVALID FIELD IN CDB */
+    case 0x2500: /* LOGICAL UNIT NOT SUPPORTED */
+    case 0x2600: /* INVALID FIELD IN PARAMETER LIST */
+
+    case 0x0401: /* NOT READY, IN PROGRESS OF BECOMING READY */
+    case 0x0402: /* NOT READY, INITIALIZING COMMAND REQUIRED */
+        return true;
+    default:
+        return false;
+    }
+}
+
 int scsi_sense_to_errno(int key, int asc, int ascq)
 {
     switch (key) {
@@ -391,6 +423,17 @@ int scsi_sense_buf_to_errno(const uint8_t *in_buf, size_t in_len)
     return scsi_sense_to_errno(sense.key, sense.asc, sense.ascq);
 }
 
+bool scsi_sense_buf_is_guest_recoverable(const uint8_t *in_buf, size_t in_len)
+{
+    SCSISense sense;
+    if (in_len < 1) {
+        return false;
+    }
+
+    sense = scsi_parse_sense_buf(in_buf, in_len);
+    return scsi_sense_is_guest_recoverable(sense.key, sense.asc, sense.ascq);
+}
+
 const char *scsi_command_name(uint8_t cmd)
 {
     static const char *names[] = {
-- 
1.8.3.1



