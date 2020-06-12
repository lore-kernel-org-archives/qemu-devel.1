Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E46C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADED12067B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5UOCnd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADED12067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl50-0003TN-Uo
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1v-00061O-NX
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32849
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1u-0001Ox-4B
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZsBbdZ3FM++Eh4KOihw4hI5M2LDwhoU63KzZvHgyWU=;
 b=D5UOCnd5KDF5UFYQcOf9a0JxrRa3+TF4vRAwL/U2QxhezZdMNeEQfsZfA4Tj+1JiveLLxg
 p/2UqpK3Mf3a31Rrc2S+b8zL7UN3vEgayE/vxR0hcqcPk4ddDaKJcQTX87ZpDDxHq8uTIe
 AUAkxYwa33DTWZGUSF8RHKrfz8WgQ+E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-RTP9jgd4MaSBaAgGJ5f84w-1; Fri, 12 Jun 2020 10:51:33 -0400
X-MC-Unique: RTP9jgd4MaSBaAgGJ5f84w-1
Received: by mail-wm1-f70.google.com with SMTP id c4so2548715wmd.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=LZsBbdZ3FM++Eh4KOihw4hI5M2LDwhoU63KzZvHgyWU=;
 b=Ahs+1lncXupVYb4g2IQd8LfQKByYQeV8JNSsvPu/9OpozCuCJsWCkKAjcXEjJxCw3d
 4h0VwLs7d1eiVEWtnCuBE95jUci4Q8akTnXEiq1bo2qsxXHd35VnGmWc49ox3GfUl4un
 uh7WP59mnOMwXzJODbdeviAbWOo9H+m/mWKQ3oDnGMxwnzjb6jfkqA4Sk/TKo/UnM4n5
 GmNaeiTlrAXowoINhslPT1nZgWImlmQdeJ+26diYBJ8JBXSTsPaaYLMtOtw3JL3mjDJJ
 sr33iXZ40U/aX53Zd4TbblDu43dqHK/OnoRqBnzw2GOAA6bmKj+IzUmz5Yv7JVHPW1h5
 oaLA==
X-Gm-Message-State: AOAM53392tMh5d0p7K3j/bSTz6IkBmvMs67zTZF4kJep5ZrK3sJOz+0V
 nuMZSRnFe4B9GGxiq/i61M9mGw0cqKMPz3BxmcS+g03oFCfVrJtjmvR1SRbU3d2DvMzF/ijyjaN
 6kPpvlGvmZaJCYCE=
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr15425455wrw.91.1591973492609; 
 Fri, 12 Jun 2020 07:51:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhpm394v3qWQw4mdSZH0or5bYqEM71sOnl57tqiKvKkSzAP209Eca/wNAzDdljcLABG6TH9A==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr15425433wrw.91.1591973492392; 
 Fri, 12 Jun 2020 07:51:32 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id 5sm14505674wrr.5.2020.06.12.07.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:31 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/58] acpi: tpm: Do not build TCPA table for TPM 2
Message-ID: <20200612141917.9446-14-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.ibm.com>

Do not build a TCPA table for TPM 2 anymore but create the log area when
building the TPM2 table. The TCPA table is only needed for TPM 1.2.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 58fe505fb6..d05d010f77 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2216,6 +2216,10 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
     tpm2_ptr->log_area_minimum_length =
         cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
 
+    acpi_data_push(tcpalog, le32_to_cpu(tpm2_ptr->log_area_minimum_length));
+    bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
+                             false);
+
     /* log area start address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
                                    log_addr_offset, log_addr_size,
@@ -2752,10 +2756,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
         build_hpet(tables_blob, tables->linker);
     }
     if (misc.tpm_version != TPM_VERSION_UNSPEC) {
-        acpi_add_table(table_offsets, tables_blob);
-        build_tpm_tcpa(tables_blob, tables->linker, tables->tcpalog);
-
-        if (misc.tpm_version == TPM_VERSION_2_0) {
+        if (misc.tpm_version == TPM_VERSION_1_2) {
+            acpi_add_table(table_offsets, tables_blob);
+            build_tpm_tcpa(tables_blob, tables->linker, tables->tcpalog);
+        } else { /* TPM_VERSION_2_0 */
             acpi_add_table(table_offsets, tables_blob);
             build_tpm2(tables_blob, tables->linker, tables->tcpalog);
         }
-- 
MST


