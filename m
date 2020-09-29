Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1347C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAC12083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCrc2EAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAC12083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNABu-0005ji-W9
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xw-0004Ac-LW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xu-0001kx-9g
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:24 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSxMXzNX3S9fhMB/ZxOtFmJyYfynnqlA4EJjVlHl23s=;
 b=PCrc2EAiz04N8/HSwZp0316RJ4VF4qcXZHKHTuEm3HI2HPSTabHP/jaeHgEFHbiU3vUjVH
 z/HWzEwrCdfI7bCWeunVhyfuCdbaEsmMjeX3WiPP6doKwqNq41VHsg3VAnDOCwqCV+/HiT
 1wZvFzpQ4wgnFEdl5DotQzczpIKcyMU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-LnH4FjoYOAGmVuyrv-jBCw-1; Tue, 29 Sep 2020 03:22:19 -0400
X-MC-Unique: LnH4FjoYOAGmVuyrv-jBCw-1
Received: by mail-wr1-f72.google.com with SMTP id w7so1375770wrp.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xSxMXzNX3S9fhMB/ZxOtFmJyYfynnqlA4EJjVlHl23s=;
 b=Es3X0Kd3KhDOG97x5Qp9t+VugKPVJ7lrBUqGvkAzI69CQwFyxUZ1KlL3E0LphqZsFe
 LhvyMxjHYaxCw1MylmB/fy8aesRRlKD77Fm5H7G8PhYYSTdIi0ULaK9/qT9rrVWIuQI5
 5OOd+TRq+l0T7OdCFk/zfgZoeuMaWE4EktwQlRvPUHV9gRz4GeypDJK7s5avlkUQHFhQ
 ijdYXuPPFY7Mwy9nXmuwxdoD7r+EPiV70s/SpKxXc8AX4Dj73llHoFw2wz2Qz4RsesVJ
 BkiulF1046oF3Eha4yC2yCUO52W1rTNAb9pRPtZ/fB6uaamIxF+NpTIhGs0+YTT43A1r
 gpJQ==
X-Gm-Message-State: AOAM533M4Dcaq7wADiseDNyjzNryQraS7TKYLk4zkZkBii6+3sck1Lj1
 8zhJ5D/rBNnsAnHFVYecXCQYsvuvne/J1d0t5tNI3Avv+UJtYtDIiWzTjmSMRIzQn/q6yvSexVh
 4qESDZ9rBftEsFRE=
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr2432024wrp.13.1601364138145; 
 Tue, 29 Sep 2020 00:22:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXXePR+4x4z89DZa12KGo00Ugf91GiMQtubJGwWqqoekrPp2m52itphSXnv9SRapq93Ur8kg==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr2431996wrp.13.1601364137969; 
 Tue, 29 Sep 2020 00:22:17 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id v4sm3930341wml.46.2020.09.29.00.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:17 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 31/48] hw/smbios: support loading OEM strings values from a
 file
Message-ID: <20200929071948.281157-32-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

Some applications want to pass quite large values for the OEM strings
entries. Rather than having huge strings on the command line, it would
be better to load them from a file, as supported with -fw_cfg.

This introduces the "path" parameter allowing for:

  $ echo -n "thisthing" > mydata.txt
  $ qemu-system-x86_64 \
    -smbios type=11,value=something \
    -smbios type=11,path=mydata.txt \
    -smbios type=11,value=somemore \
    ...other args...

Now in the guest

$ dmidecode -t 11
Getting SMBIOS data from sysfs.
SMBIOS 2.8 present.

Handle 0x0E00, DMI type 11, 5 bytes
OEM Strings
	String 1: something
	String 2: thisthing
	String 3: somemore

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200923133804.2089190-2-berrange@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 71 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 7cc950b41c..d993448087 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -110,7 +110,7 @@ static struct {
 
 static struct {
     size_t nvalues;
-    const char **values;
+    char **values;
 } type11;
 
 static struct {
@@ -314,6 +314,11 @@ static const QemuOptDesc qemu_smbios_type11_opts[] = {
         .type = QEMU_OPT_STRING,
         .help = "OEM string data",
     },
+    {
+        .name = "path",
+        .type = QEMU_OPT_STRING,
+        .help = "OEM string data from file",
+    },
 };
 
 static const QemuOptDesc qemu_smbios_type17_opts[] = {
@@ -641,6 +646,8 @@ static void smbios_build_type_11_table(void)
 
     for (i = 0; i < type11.nvalues; i++) {
         SMBIOS_TABLE_SET_STR_LIST(11, type11.values[i]);
+        g_free(type11.values[i]);
+        type11.values[i] = NULL;
     }
 
     SMBIOS_BUILD_TABLE_POST;
@@ -940,9 +947,8 @@ static void save_opt(const char **dest, QemuOpts *opts, const char *name)
 
 
 struct opt_list {
-    const char *name;
     size_t *ndest;
-    const char ***dest;
+    char ***dest;
 };
 
 static int save_opt_one(void *opaque,
@@ -951,23 +957,60 @@ static int save_opt_one(void *opaque,
 {
     struct opt_list *opt = opaque;
 
-    if (!g_str_equal(name, opt->name)) {
-        return 0;
+    if (g_str_equal(name, "path")) {
+        g_autoptr(GByteArray) data = g_byte_array_new();
+        g_autofree char *buf = g_new(char, 4096);
+        ssize_t ret;
+        int fd = qemu_open(value, O_RDONLY, errp);
+        if (fd < 0) {
+            return -1;
+        }
+
+        while (1) {
+            ret = read(fd, buf, 4096);
+            if (ret == 0) {
+                break;
+            }
+            if (ret < 0) {
+                error_setg(errp, "Unable to read from %s: %s",
+                           value, strerror(errno));
+                return -1;
+            }
+            if (memchr(buf, '\0', ret)) {
+                error_setg(errp, "NUL in OEM strings value in %s", value);
+                return -1;
+            }
+            g_byte_array_append(data, (guint8 *)buf, ret);
+        }
+
+        close(fd);
+
+        *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
+        (*opt->dest)[*opt->ndest] = (char *)g_byte_array_free(data,  FALSE);
+        (*opt->ndest)++;
+        data = NULL;
+   } else if (g_str_equal(name, "value")) {
+        *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
+        (*opt->dest)[*opt->ndest] = g_strdup(value);
+        (*opt->ndest)++;
+    } else if (!g_str_equal(name, "type")) {
+        error_setg(errp, "Unexpected option %s", name);
+        return -1;
     }
 
-    *opt->dest = g_renew(const char *, *opt->dest, (*opt->ndest) + 1);
-    (*opt->dest)[*opt->ndest] = value;
-    (*opt->ndest)++;
     return 0;
 }
 
-static void save_opt_list(size_t *ndest, const char ***dest,
-                          QemuOpts *opts, const char *name)
+static bool save_opt_list(size_t *ndest, char ***dest, QemuOpts *opts,
+                          Error **errp)
 {
     struct opt_list opt = {
-        name, ndest, dest,
+        ndest, dest,
     };
-    qemu_opt_foreach(opts, save_opt_one, &opt, NULL);
+    if (!qemu_opt_foreach(opts, save_opt_one, &opt, errp)) {
+        return false;
+    }
+    return true;
 }
 
 void smbios_entry_add(QemuOpts *opts, Error **errp)
@@ -1149,7 +1192,9 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             if (!qemu_opts_validate(opts, qemu_smbios_type11_opts, errp)) {
                 return;
             }
-            save_opt_list(&type11.nvalues, &type11.values, opts, "value");
+            if (!save_opt_list(&type11.nvalues, &type11.values, opts, errp)) {
+                return;
+            }
             return;
         case 17:
             if (!qemu_opts_validate(opts, qemu_smbios_type17_opts, errp)) {
-- 
MST


