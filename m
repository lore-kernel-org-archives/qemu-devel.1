Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C5C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA91020866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA91020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZYr-0004Ls-Il
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1k6ZXY-0003GA-AV
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 09:14:36 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:48798)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1k6ZXW-0007tf-6S
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 09:14:36 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id B1084106E0D;
 Fri, 14 Aug 2020 22:14:28 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id 164661C0BF9;
 Fri, 14 Aug 2020 22:14:28 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH] loader.c: Add support Motrola S-record format.
Date: Fri, 14 Aug 2020 22:14:21 +0900
Message-Id: <20200814131421.28336-1-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.13;
 envelope-from=ysato@users.sourceforge.jp; helo=mail01.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 09:14:29
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the Renesas development environment may use the S-Record format,
it is convenient to handle this as well as the HEX format.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/loader.h |  14 +++
 hw/core/loader.c    | 212 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 226 insertions(+)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index a9eeea3952..b6590f53b1 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -55,6 +55,20 @@ int load_image_targphys_as(const char *filename,
  */
 int load_targphys_hex_as(const char *filename, hwaddr *entry, AddressSpace *as);
 
+/**
+ * load_targphys_srec_as:
+ * @filename: Path to the .hex file
+ * @entry: Store the entry point given by the .hex file
+ * @as: The AddressSpace to load the .hex file to. The value of
+ *      address_space_memory is used if nothing is supplied here.
+ *
+ * Load a fixed .srec file into memory.
+ *
+ * Returns the size of the loaded .hex file on success, -1 otherwise.
+ */
+int load_targphys_srec_as(const char *filename,
+                          hwaddr *entry, AddressSpace *as);
+
 /** load_image_targphys:
  * Same as load_image_targphys_as(), but doesn't allow the caller to specify
  * an AddressSpace.
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8bbb1797a4..cfb328bd68 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1618,3 +1618,215 @@ int load_targphys_hex_as(const char *filename, hwaddr *entry, AddressSpace *as)
     g_free(hex_blob);
     return total_size;
 }
+
+typedef enum {
+    SREC_SOH,
+    SREC_TYPE,
+    SREC_LEN,
+    SREC_ADDR,
+    SREC_DATA,
+    SREC_SKIP,
+    SREC_SUM,
+} srec_state;
+
+typedef struct {
+    srec_state state;
+    int nibble;
+    int total_size;
+    uint32_t address;
+    uint32_t topaddr;
+    uint32_t bufremain;
+    int length;
+    int addr_len;
+    int record_type;
+    uint8_t byte;
+    uint8_t data[DATA_FIELD_MAX_LEN];
+    uint8_t *datap;
+    uint8_t *bufptr;
+    uint8_t sum;
+} SrecLine;
+
+static bool parse_srec_line(SrecLine *line, char c)
+{
+    if (!g_ascii_isxdigit(c)) {
+        return false;
+    }
+    line->byte <<= 4;
+    line->byte |= g_ascii_xdigit_value(c);
+    line->nibble++;
+    if (line->nibble == 2) {
+        line->nibble = 0;
+        line->length--;
+        line->sum += line->byte;
+        switch (line->state) {
+        case SREC_SOH:
+        case SREC_TYPE:
+            /* first 2chars ignore parse */
+            break;
+        case SREC_LEN:
+            line->sum = line->length = line->byte;
+            if (line->addr_len > 0) {
+                line->state = SREC_ADDR;
+                line->address = 0;
+            } else {
+                line->state = SREC_SKIP;
+            }
+            break;
+        case SREC_ADDR:
+            line->address <<= 8;
+            line->address |= line->byte;
+            if (--line->addr_len == 0) {
+                if (line->length > 1) {
+                    if (line->record_type != 0) {
+                        line->state = SREC_DATA;
+                    } else {
+                        line->state = SREC_SKIP;
+                    }
+                    line->datap = line->data;
+                } else {
+                    line->state = SREC_SUM;
+                }
+            }
+            break;
+        case SREC_DATA:
+            *line->datap++ = line->byte;
+            /* fail through */
+        case SREC_SKIP:
+            if (line->length == 1) {
+                line->state = SREC_SUM;
+            }
+            break;
+        case SREC_SUM:
+            if ((line->sum & 0xff) != 0xff) {
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
+#define SRECBUFSIZE 0x40000
+
+/* return size or -1 if error */
+static int parse_srec_blob(const char *filename, hwaddr *addr,
+                           uint8_t *hex_blob, size_t hex_blob_size,
+                           AddressSpace *as)
+{
+    SrecLine line;
+    size_t len;
+    int total_len = 0;
+    uint8_t *end = hex_blob + hex_blob_size;
+    rom_transaction_begin();
+    line.state = SREC_SOH;
+    line.bufptr = g_malloc(SRECBUFSIZE);
+    line.bufremain = SRECBUFSIZE;
+    line.topaddr = UINT32_MAX;
+    for (; hex_blob < end; ++hex_blob) {
+        switch (*hex_blob) {
+        case '\r':
+        case '\n':
+            if (line.state == SREC_SUM) {
+                switch (line.record_type) {
+                case 1:
+                case 2:
+                case 3:
+                    len = line.datap - line.data;
+                    if (line.topaddr == UINT32_MAX) {
+                        line.topaddr = line.address;
+                    }
+                    /* If the buffer overflows, write to rom */
+                    if (line.bufremain < len ||
+                        line.address < line.topaddr ||
+                        (line.address - line.topaddr + len) > SRECBUFSIZE) {
+                        rom_add_blob_fixed_as(filename, line.bufptr,
+                                              SRECBUFSIZE - line.bufremain,
+                                              line.topaddr, as);
+                        line.topaddr = line.address;
+                        line.bufremain = SRECBUFSIZE;
+                    }
+                    memcpy(line.bufptr + (line.address  - line.topaddr),
+                           line.data, len);
+                    line.bufremain -= len;
+                    total_len += len;
+                    break;
+                case 7:
+                case 8:
+                case 9:
+                    *addr = line.address;
+                    break;
+                }
+                line.state = SREC_SOH;
+            }
+            break;
+        /* start of a new record. */
+        case 'S':
+            if (line.state != SREC_SOH) {
+                total_len = -1;
+                goto out;
+            }
+            line.state = SREC_TYPE;
+            break;
+        /* decoding lines */
+        default:
+            if (line.state == SREC_TYPE) {
+                if (g_ascii_isdigit(*hex_blob)) {
+                    line.record_type = g_ascii_digit_value(*hex_blob);
+                    switch (line.record_type) {
+                    case 1:
+                    case 2:
+                    case 3:
+                        line.addr_len = 1 + line.record_type;
+                        break;
+                    case 0:
+                    case 5:
+                        line.addr_len = 2;
+                        break;
+                    case 7:
+                    case 8:
+                    case 9:
+                        line.addr_len = 11 - line.record_type;
+                        break;
+                    default:
+                        line.addr_len = 0;
+                    }
+                }
+                line.state = SREC_LEN;
+                line.nibble = 0;
+            } else {
+                if (!parse_srec_line(&line, *hex_blob)) {
+                    total_len = -1;
+                    goto out;
+                }
+            }
+            break;
+        }
+    }
+    /* Write unwritten binary to rom */
+    if (line.bufremain < SRECBUFSIZE) {
+        rom_add_blob_fixed_as(filename, line.bufptr,
+                              SRECBUFSIZE - line.bufremain,
+                              line.topaddr, as);
+    }
+out:
+    rom_transaction_end(total_len != -1);
+    g_free(line.bufptr);
+    return total_len;
+}
+
+/* return size or -1 if error */
+int load_targphys_srec_as(const char *filename, hwaddr *entry, AddressSpace *as)
+{
+    gsize hex_blob_size;
+    gchar *hex_blob;
+    int total_size = 0;
+
+    if (!g_file_get_contents(filename, &hex_blob, &hex_blob_size, NULL)) {
+        return -1;
+    }
+
+    total_size = parse_srec_blob(filename, entry, (uint8_t *)hex_blob,
+                                 hex_blob_size, as);
+
+    g_free(hex_blob);
+    return total_size;
+}
-- 
2.20.1


