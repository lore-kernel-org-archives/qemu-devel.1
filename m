Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAF1C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11F420674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPX7e0nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11F420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdlO-0000gT-9s
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd99-0003Yc-Ag
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd98-0001Yv-7C
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24304
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd98-0001XM-33
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlwvTfWdlege7GScVPmVC823d5hwqV7V8ZFGgb3kNWU=;
 b=CPX7e0nw4luZQV3/DU88h2cVhsOhTV8jVYnHc7Gb+QnR6V6VPr7dLRWHZkVoX0nlLHot0U
 RRY0Cskx9I/kNcTEfdLuToqT4xlaF2uRZVyyna0VbtTV5MOKyv02tNzuDVM63fuolrwH0f
 Kw6gDXpwHFLxtq93B5Z879FzbKO2T4E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-FWaZqvtVNQaFWOtcLlxFlA-1; Sun, 15 Mar 2020 19:58:16 -0400
X-MC-Unique: FWaZqvtVNQaFWOtcLlxFlA-1
Received: by mail-wr1-f70.google.com with SMTP id o9so8139312wrw.14
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LM2hbE7ibTJgNB7j2Une2S4sO88fnFzm04CEg7ESeAA=;
 b=RX5mZORo47QZA4GnlwEY4K7ZKPj4aG61+Q1h4Kdbn44MivdPxML/KWessOr/4B1789
 ar9MrN7LhOwLQapHzRzWC6/8bIJof+7c0S3hm3sLkR9yjkj8+c2EbuPleISk6pH8l6Bv
 jshD7PzxbB3Vkoaq8xcUbQ78wN9EfT5Ky0Ld8j3OjP3Fe/1d+cenq+CVNzY1yI2XOr1s
 dIN0O6cax9Tlyaz7CnSwA2xFCisy2EIlbCekv37re7g2AVP3ZdRNhsLhvrS0iN4PbXCd
 mq1qd+SnfnxZC0BS81eRcGlvRVesgPnFwly2J8BmX6rSwVPQwmM50L4fFP9vEZ1h60y/
 cgow==
X-Gm-Message-State: ANhLgQ0lwHshEiKAiMLn0jDRESxsH5XXJ5GFYHmRPpKhsxPESPDrnZya
 5l16p5e5zqN0V6BmRcNK0sZM9B2ppmlVGhpO/ebK7YEezBF3+HT03VFb+cffHI8QNneiOqUMASs
 K6IWuLI/s4bW51Vc=
X-Received: by 2002:a1c:9658:: with SMTP id y85mr15033361wmd.63.1584316694981; 
 Sun, 15 Mar 2020 16:58:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvF+IgZfR7MEY3aZqP73j5Vu/iWzP7jnsDEv7kURy9sfgCgbdaobwONGaF31LtfOgY9OJtv5Q==
X-Received: by 2002:a1c:9658:: with SMTP id y85mr15033342wmd.63.1584316694832; 
 Sun, 15 Mar 2020 16:58:14 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id s7sm16458227wri.61.2020.03.15.16.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:58:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/12] target/i386: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Mon, 16 Mar 2020 00:57:14 +0100
Message-Id: <20200315235716.28448-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315235716.28448-1-philmd@redhat.com>
References: <20200315235716.28448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92fafa2659..a84553e50c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6778,6 +6778,7 @@ static void x86_cpu_register_feature_bit_props(X86CPU=
 *cpu,
     x86_cpu_register_bit_prop(cpu, name, w, bitnr);
 }
=20
+#if !defined(CONFIG_USER_ONLY)
 static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
 {
     X86CPU *cpu =3D X86_CPU(cs);
@@ -6821,6 +6822,7 @@ static void x86_cpu_get_crash_info_qom(Object *obj, V=
isitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
+#endif /* !CONFIG_USER_ONLY */
=20
 static void x86_cpu_initfn(Object *obj)
 {
@@ -6866,8 +6868,10 @@ static void x86_cpu_initfn(Object *obj)
                         x86_cpu_get_unavailable_features,
                         NULL, NULL, NULL, &error_abort);
=20
+#if !defined(CONFIG_USER_ONLY)
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         x86_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL=
);
+#endif
=20
     for (w =3D 0; w < FEATURE_WORDS; w++) {
         int bitnr;
@@ -7180,7 +7184,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc=
, void *data)
     cc->cpu_exec_interrupt =3D x86_cpu_exec_interrupt;
 #endif
     cc->dump_state =3D x86_cpu_dump_state;
-    cc->get_crash_info =3D x86_cpu_get_crash_info;
     cc->set_pc =3D x86_cpu_set_pc;
     cc->synchronize_from_tb =3D x86_cpu_synchronize_from_tb;
     cc->gdb_read_register =3D x86_cpu_gdb_read_register;
@@ -7191,6 +7194,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc=
, void *data)
     cc->asidx_from_attrs =3D x86_asidx_from_attrs;
     cc->get_memory_mapping =3D x86_cpu_get_memory_mapping;
     cc->get_phys_page_attrs_debug =3D x86_cpu_get_phys_page_attrs_debug;
+    cc->get_crash_info =3D x86_cpu_get_crash_info;
     cc->write_elf64_note =3D x86_cpu_write_elf64_note;
     cc->write_elf64_qemunote =3D x86_cpu_write_elf64_qemunote;
     cc->write_elf32_note =3D x86_cpu_write_elf32_note;
--=20
2.21.1


