Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987D1C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6170E20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2XonldY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6170E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDeOb-0000UV-0S
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdMW-0008Vw-MD
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdMU-00076q-Kp
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:12:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49759
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdMU-00073q-Gl
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AG7xT/wVAX7aViJSX1jQiw6M2Yh1RcrmKc+SLXD1328=;
 b=P2XonldYISNMWioJkBdeB+uwjigkyE5hryZXFXKp1E50qV7X88elEfLVB7KrQMWmTEKm4o
 dsLxYruBpj8X78U1UxOQ6JjSKWvjtisfrRmSP8E3S4TDlieMcLqlB+66mtUlPbhW4Qf32n
 vH2MlHRD4wV2em52h64wFwnI8hcgvRY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-nXHkbFu1Nt-6kvTdH7f6PA-1; Sun, 15 Mar 2020 20:12:04 -0400
X-MC-Unique: nXHkbFu1Nt-6kvTdH7f6PA-1
Received: by mail-wr1-f69.google.com with SMTP id 94so3461764wrr.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/ikMSJm+InHRPdirtpMpOowiTQs5ep3wPdoGDAQJ/Ms=;
 b=NsAbWyBkHhth4dIDhV8lLl59H8NmI/8Q7RKWOEp+SL5CSdEDUTr0jLG0ikfzvAxWXS
 RjsKk0vKUspzDADGxqhON+EPtFBB68uNiLJesg+dWolHjvMtapWSWI+cxNBteCKg+FWK
 TGN2iaUq3RNcV7i7CQwuBRJxL7GpRMger+WX3azNm05EZBGzAJHRfSa0Mx6agRf7iKX0
 +TZ/o89WgMEOYRFiP8isKhJxX4Hla5WNbk4ICwrzZpGqLM5tFnsIJQ0Q5jErlgWghw6C
 kBjUA64bJPxzNmyo0J8KLFsfJqTpDcQaLo6w8/5SEaNssW/0V09DsR6/OjGgUZ8wedwK
 BOQA==
X-Gm-Message-State: ANhLgQ1HSjemyvFyTve/bns71r+1KTx2a0YI8//NUn7UCRcf1WBZI+Tb
 r02e1Y4tWWMTAt6fK3w7vJz19WQRcVwIDN8yJLUwi3JMt7Rn0O82YyXwcBnKHdGqj7d+wNtpMqw
 UmONd3CjLFV2M0Ic=
X-Received: by 2002:a7b:c770:: with SMTP id x16mr23458687wmk.159.1584317522952; 
 Sun, 15 Mar 2020 17:12:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvnj6xW6vb6brKPhIa8AlrJj2sqhezWiHrANLxLe5QFJH/2/zBhrD0wJnuBae7rbxCOigC7gA==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr23458669wmk.159.1584317522784; 
 Sun, 15 Mar 2020 17:12:02 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id y11sm5812733wrd.65.2020.03.15.17.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:12:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] qapi: Restrict code generated for user-mode
Date: Mon, 16 Mar 2020 01:11:11 +0100
Message-Id: <20200316001111.31004-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316001111.31004-1-philmd@redhat.com>
References: <20200316001111.31004-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A lot of QAPI generated code is never used by user-mode.

Rewrite the QAPI_COMMON_MODULES variable one entry per line,
and split it in 3 groups:
- always used
- use by system-mode or tools
- only used by system-mode

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qapi/Makefile.objs | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 4673ab7490..18435db426 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -5,11 +5,40 @@ util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
 util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
=20
-QAPI_COMMON_MODULES =3D audio authz block-core block char common control c=
rypto
-QAPI_COMMON_MODULES +=3D dump error introspect job machine migration misc
-QAPI_COMMON_MODULES +=3D net pragma qdev qom rdma rocker run-state sockets=
 tpm
-QAPI_COMMON_MODULES +=3D trace transaction ui
+QAPI_COMMON_MODULES =3D common
+QAPI_COMMON_MODULES +=3D introspect
+QAPI_COMMON_MODULES +=3D misc
+
+ifeq ($(CONFIG_SOFTMMU),y)
+QAPI_COMMON_MODULES +=3D audio
+QAPI_COMMON_MODULES +=3D dump
+QAPI_COMMON_MODULES +=3D machine
+QAPI_COMMON_MODULES +=3D migration
+QAPI_COMMON_MODULES +=3D net rocker
+QAPI_COMMON_MODULES +=3D qdev
+QAPI_COMMON_MODULES +=3D rdma
+QAPI_COMMON_MODULES +=3D tpm
+QAPI_COMMON_MODULES +=3D trace
+QAPI_COMMON_MODULES +=3D ui
 QAPI_TARGET_MODULES =3D machine-target misc-target
+endif # CONFIG_SOFTMMU
+
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
+QAPI_COMMON_MODULES +=3D authz
+QAPI_COMMON_MODULES +=3D block
+QAPI_COMMON_MODULES +=3D block-core
+QAPI_COMMON_MODULES +=3D char
+QAPI_COMMON_MODULES +=3D control
+QAPI_COMMON_MODULES +=3D crypto
+QAPI_COMMON_MODULES +=3D error
+QAPI_COMMON_MODULES +=3D job
+QAPI_COMMON_MODULES +=3D pragma
+QAPI_COMMON_MODULES +=3D qom
+QAPI_COMMON_MODULES +=3D run-state
+QAPI_COMMON_MODULES +=3D sockets
+QAPI_COMMON_MODULES +=3D transaction
+endif # CONFIG_SOFTMMU || CONFIG_TOOLS
+
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
=20
 util-obj-y +=3D qapi-builtin-types.o
--=20
2.21.1


