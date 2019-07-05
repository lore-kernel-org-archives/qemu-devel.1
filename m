Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D1CC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088DA20989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088DA20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjRkn-0004AO-VJ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 13:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjRhA-0003Pw-RE
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjRh8-0007Ab-Cg
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:08:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjRh7-00077s-5Y
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:08:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so4201891wme.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 10:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=et+2Ji5OJc+DfnAsJcnGgxS9OgTkERVhP6Jdr1JO6ZY=;
 b=P/QNb/H/1TTPF81WdPMqsWqcQAuNw/TcVsqj8YcG7vaqfpEWwtBZBHANr0M+2qVMCd
 QIqe/LP4tATXquRjdbLgqccjRQ7thVo4LPLM07Hw3WaxLLLHiHr7mCcJkAjFdN2Mi6D5
 401kX1Oqs97VVOIJ4ydYFyJjh4YSH1WKMC4+rUZyF9hXpB72KZaBk6GiVUJHahX/6q/w
 B98Whqo9BQpC/+gNnT1GCct8y9Wc+hKO1Mk3eawnMwvDa8+Myfi8Ttwddy+fc1c5hgqd
 EA051ibNsfAthauT77CtCH9+6CQOjchVZ4U7DKUsoMZhZOsOVQMVD8kZpuTepgWI9hAI
 AEqQ==
X-Gm-Message-State: APjAAAWJwXPMsxT6/cnj5bBC/1ky+fVLIQhFHzGoAX4bU3PLlifP7Cw1
 TNPu/h2QkOG+vtOUbsrkvKQ0Te56P20=
X-Google-Smtp-Source: APXvYqwtQ919c24oes/0jeW6navGlC36A8jNa5XhO9A+4CXgmecI6RWOFbFgsdHEn+VU44Ie9CS/GA==
X-Received: by 2002:a1c:7a15:: with SMTP id v21mr4182654wmc.176.1562346499998; 
 Fri, 05 Jul 2019 10:08:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a?
 ([2001:b07:6468:f312:e943:5a4e:e068:244a])
 by smtp.gmail.com with ESMTPSA id r12sm13873172wrt.95.2019.07.05.10.08.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 10:08:18 -0700 (PDT)
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Alistair Francis <alistair23@gmail.com>
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
 <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
 <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
 <4428dc80-9ace-3bb0-a497-e3d416199bfd@redhat.com>
 <CAKmqyKMRSJTMxZ5c-yyuownYF8vJLYrzr92cE4rkiTdP7tmUzg@mail.gmail.com>
 <CY1PR04MB22682B84C1ABA7FB10752465EDF90@CY1PR04MB2268.namprd04.prod.outlook.com>
 <79c9e21f-06b1-6255-97af-95c08b354c8a@redhat.com>
 <CY1PR04MB22683409CB203BF5042697FBEDF80@CY1PR04MB2268.namprd04.prod.outlook.com>
 <5a741004-fc88-f31a-2abf-70f4a9b0d5a9@redhat.com>
 <BN3PR04MB22577C778C58BC5E2C8DD61FEDF50@BN3PR04MB2257.namprd04.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a5bd434-4c4c-f5ae-cae4-a23f6463a05c@redhat.com>
Date: Fri, 5 Jul 2019 19:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <BN3PR04MB22577C778C58BC5E2C8DD61FEDF50@BN3PR04MB2257.namprd04.prod.outlook.com>
Content-Type: multipart/mixed; boundary="------------8EC73DB6AA75C7B92F98E351"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw/scsi: Report errors and sense to
 guests through scsi-block
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------8EC73DB6AA75C7B92F98E351
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 05/07/19 12:31, Shinichiro Kawasaki wrote:
>> This way there's generally no need to shoehorn ASC codes into errno.  I
>> still have to test my changes, but I hope to send something within a
>> couple of days.
> 
> Thanks for sharing your thoughts. Now I understand your idea.
> 
> I'm awaiting your patch. In case you want me to create the patch based on your 
> idea, please let me know. I can afford some time next week to work on it.

I didn't have time to finish, but since I will be out for part of next
week, here is what I currently have (untested, somewhat uncompiled).
It's a bugfix so it can be included after hard freeze.

Thanks!

Paolo

--------------8EC73DB6AA75C7B92F98E351
Content-Type: text/x-patch;
 name="scsi-sense.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="scsi-sense.patch"

From fdccbd77192ca4450f6e8900bef392fa36242200 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Jul 2019 19:07:17 +0200
Subject: [PATCH 0/5] *** SUBJECT HERE ***

*** BLURB HERE ***

Paolo Bonzini (4):
  scsi: explicitly list guest-recoverable sense codes
  scsi: add guest-recoverable ZBC errors
  iscsi: fix busy/timeout/task set full
  iscsi: base all handling of check condition on scsi_sense_to_errno

Shinichiro Kawasaki (1):
  scsi-disk: pass sense correctly for guest-recoverable errors

 block/iscsi.c        | 28 +++++++++++------------
 hw/scsi/scsi-disk.c  | 15 ++++++++++---
 include/scsi/utils.h |  1 +
 scsi/utils.c         | 53 +++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 77 insertions(+), 20 deletions(-)

-- 
2.21.0

From f8a4b9cd0cd878aacbdf4ad4e7a2451c87339dab Mon Sep 17 00:00:00 2001
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Date: Tue, 2 Jul 2019 10:08:00 +0200
Subject: [PATCH 1/5] scsi-disk: pass sense correctly for guest-recoverable
 errors

When an error was passed down to the guest because it was recoverable,
the sense length was not copied from the SG_IO data.  As a result,
the guest saw the CHECK CONDITION status but not the sense data.

Signed-off-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index ed7295bfd7..5d3fb3c9d5 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -62,6 +62,7 @@ typedef struct SCSIDiskClass {
     DMAIOFunc       *dma_readv;
     DMAIOFunc       *dma_writev;
     bool            (*need_fua_emulation)(SCSICommand *cmd);
+    void            (*update_sense)(SCSIRequest *r);
 } SCSIDiskClass;
 
 typedef struct SCSIDiskReq {
@@ -438,6 +439,7 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
 {
     bool is_read = (r->req.cmd.mode == SCSI_XFER_FROM_DEV);
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+    SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
     BlockErrorAction action = blk_get_error_action(s->qdev.conf.blk,
                                                    is_read, error);
 
@@ -456,6 +458,7 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
             if (error == ECANCELED || error == EAGAIN || error == ENOTCONN ||
                 error == 0)  {
                 /* These errors are handled by guest. */
+                sdc->update_sense(&r->req);
                 scsi_req_complete(&r->req, *r->status);
                 return true;
             }
@@ -2894,6 +2897,12 @@ static int scsi_block_parse_cdb(SCSIDevice *d, SCSICommand *cmd,
     }
 }
 
+static void scsi_block_update_sense(SCSIRequest *req)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIBlockReq *br = DO_UPCAST(SCSIBlockReq, req, r);
+    r->req.sense_len = MIN(br->io_header.sb_len_wr, sizeof(r->req.sense));
+}
 #endif
 
 static
@@ -3059,6 +3068,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
     sc->parse_cdb    = scsi_block_parse_cdb;
     sdc->dma_readv   = scsi_block_dma_readv;
     sdc->dma_writev  = scsi_block_dma_writev;
+    sdc->update_sense = scsi_block_update_sense;
     sdc->need_fua_emulation = scsi_block_no_fua;
     dc->desc = "SCSI block device passthrough";
     dc->props = scsi_block_properties;
-- 
2.21.0


From ab60dfcd4c2bbad79d2bdfae37a88b031917ec99 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jul 2019 10:23:20 +0200
Subject: [PATCH 2/5] scsi: explicitly list guest-recoverable sense codes

It's not really possible to fit all sense codes into errno codes, especially
in such a way that sense codes can be properly categorized as either.
guest-recoverable and host-handled.  Just create a new function that
checks for guest recoverable sense, then scsi_sense_buf_to_errno only
needs to be called for host handled sense codes.
---
 hw/scsi/scsi-disk.c  |  5 ++---
 include/scsi/utils.h |  1 +
 scsi/utils.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5d3fb3c9d5..8e95e3e38d 100644
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
index 9351b21ead..fee6212e85 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -106,6 +106,7 @@ extern const struct SCSISense sense_code_SPACE_ALLOC_FAILED;
 
 int scsi_sense_to_errno(int key, int asc, int ascq);
 int scsi_sense_buf_to_errno(const uint8_t *sense, size_t sense_size);
+int scsi_sense_buf_is_guest_recoverable(const uint8_t *sense, size_t sense_size);
 
 int scsi_convert_sense(uint8_t *in_buf, int in_len,
                        uint8_t *buf, int len, bool fixed);
diff --git a/scsi/utils.c b/scsi/utils.c
index 8738522955..3ad28face1 100644
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
+    return scsi_sense_to_errno(sense.key, sense.asc, sense.ascq);
+}
+
 const char *scsi_command_name(uint8_t cmd)
 {
     static const char *names[] = {
-- 
2.21.0


From eca5917fcdf3ea690ee80d6f073d3b915691a499 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jul 2019 10:01:03 +0200
Subject: [PATCH 3/5] scsi: add guest-recoverable ZBC errors

When I ran basic operations to the zoned storage from the guest via
scsi-block the following ASCs are reported for write or read commands
due to unexpected zone status or write pointer status:

     21h 04h: UNALIGNED WRITE COMMAND
     21h 05h: WRITE BOUNDARY VIOLATION
     21h 06h: ATTEMPT TO READ INVALID DATA
     55h 0Eh: INSUFFICIENT ZONE RESOURCES

Reporting these ASCs to the guest, the user applications can handle
them to manage zone/write pointer status, or help the user application
developers to understand the failure reason and fix bugs.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scsi/utils.c b/scsi/utils.c
index 3ad28face1..53274f62d7 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -360,6 +360,11 @@ static bool scsi_sense_is_guest_recoverable(int key, int asc, int ascq)
     case 0x2500: /* LOGICAL UNIT NOT SUPPORTED */
     case 0x2600: /* INVALID FIELD IN PARAMETER LIST */
 
+    case 0x2104: /* UNALIGNED WRITE COMMAND */
+    case 0x2105: /* WRITE BOUNDARY VIOLATION */
+    case 0x2106: /* ATTEMPT TO READ INVALID DATA */
+    case 0x550e: /* INSUFFICIENT ZONE RESOURCES */
+
     case 0x0401: /* NOT READY, IN PROGRESS OF BECOMING READY */
     case 0x0402: /* NOT READY, INITIALIZING COMMAND REQUIRED */
         return true;
-- 
2.21.0


From 594c17e8f6d617d5f234e1d3701cfc54e6804d1a Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jul 2019 10:45:54 +0200
Subject: [PATCH 4/5] iscsi: fix busy/timeout/task set full

In this case, do_retry was set without calling aio_co_wake, thus never
waking up the coroutine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 267f160bf6..6e238bf0ad 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -272,7 +272,7 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                 timer_mod(&iTask->retry_timer,
                           qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + retry_time);
                 iTask->do_retry = 1;
-                return;
+                goto out;
             }
         }
         iTask->err_code = iscsi_translate_sense(&task->sense);
-- 
2.21.0


From fdccbd77192ca4450f6e8900bef392fa36242200 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jul 2019 11:40:41 +0200
Subject: [PATCH 5/5] iscsi: base all handling of check condition on
 scsi_sense_to_errno

Now that scsi-disk is not using scsi_sense_to_errno to separate guest-recoverable
sense codes, we can modify it to simplify iscsi's own sense handling.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 28 ++++++++++++++--------------
 scsi/utils.c  |  5 ++---
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 6e238bf0ad..5817967205 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -225,9 +225,9 @@ static inline unsigned exp_random(double mean)
 
 static int iscsi_translate_sense(struct scsi_sense *sense)
 {
-    return - scsi_sense_to_errno(sense->key,
-                                 (sense->ascq & 0xFF00) >> 8,
-                                 sense->ascq & 0xFF);
+    return scsi_sense_to_errno(sense->key,
+                               (sense->ascq & 0xFF00) >> 8,
+                               sense->ascq & 0xFF);
 }
 
 /* Called (via iscsi_service) with QemuMutex held.  */
@@ -244,13 +244,6 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
 
     if (status != SCSI_STATUS_GOOD) {
         if (iTask->retries++ < ISCSI_CMD_RETRIES) {
-            if (status == SCSI_STATUS_CHECK_CONDITION
-                && task->sense.key == SCSI_SENSE_UNIT_ATTENTION) {
-                error_report("iSCSI CheckCondition: %s",
-                             iscsi_get_error(iscsi));
-                iTask->do_retry = 1;
-                goto out;
-            }
             if (status == SCSI_STATUS_BUSY ||
                 status == SCSI_STATUS_TIMEOUT ||
                 status == SCSI_STATUS_TASK_SET_FULL) {
@@ -272,11 +265,18 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                 timer_mod(&iTask->retry_timer,
                           qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + retry_time);
                 iTask->do_retry = 1;
-                goto out;
+            }
+        } else if (status == SCSI_STATUS_CHECK_CONDITION) {
+            int error = iscsi_translate_sense(&task->sense);
+            if (error == EAGAIN) {
+                error_report("iSCSI CheckCondition: %s",
+                             iscsi_get_error(iscsi));
+                iTask->do_retry = 1;
+            } else {
+                iTask->err_code = -error;
+                iTask->err_str = g_strdup(iscsi_get_error(iscsi));
             }
         }
-        iTask->err_code = iscsi_translate_sense(&task->sense);
-        iTask->err_str = g_strdup(iscsi_get_error(iscsi));
     }
 
 out:
@@ -974,7 +974,7 @@ iscsi_aio_ioctl_cb(struct iscsi_context *iscsi, int status,
     if (status < 0) {
         error_report("Failed to ioctl(SG_IO) to iSCSI lun. %s",
                      iscsi_get_error(iscsi));
-        acb->status = iscsi_translate_sense(&acb->task->sense);
+        acb->status = -iscsi_translate_sense(&acb->task->sense);
     }
 
     acb->ioh->driver_status = 0;
diff --git a/scsi/utils.c b/scsi/utils.c
index 53274f62d7..7f332ebf1f 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -379,8 +379,7 @@ int scsi_sense_to_errno(int key, int asc, int ascq)
     case NO_SENSE:
     case RECOVERED_ERROR:
     case UNIT_ATTENTION:
-        /* These sense keys are not errors */
-        return 0;
+        return EAGAIN;
     case ABORTED_COMMAND: /* COMMAND ABORTED */
         return ECANCELED;
     case NOT_READY:
@@ -409,7 +408,7 @@ int scsi_sense_to_errno(int key, int asc, int ascq)
     case 0x2700: /* WRITE PROTECTED */
         return EACCES;
     case 0x0401: /* NOT READY, IN PROGRESS OF BECOMING READY */
-        return EAGAIN;
+        return EINPROGRESS;
     case 0x0402: /* NOT READY, INITIALIZING COMMAND REQUIRED */
         return ENOTCONN;
     default:
-- 
2.21.0


--------------8EC73DB6AA75C7B92F98E351--

