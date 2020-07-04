Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E716C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D787C208D5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZ7x3F0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D787C208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkI5-00036f-1H
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkGA-0000fB-GC
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:39:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47545
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkG8-0007So-UG
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4VxXE4SCiQENXjR0p5gMwHzmkYsDqhVYN6kqXLwme2s=;
 b=OZ7x3F0KfnBBeJLBGBYSuRS4OwXUIkoslH2dy+3a4HMwnQ77x9699ExR1sJz6nY59V/Ot2
 dpArIDx9FLxEgFQq/C5ES7oKzfBaEC94rZ4sRkJTmmv9oR8MUiuEG1FpZjazzoaSy1SEz5
 GmWjp07TcZKqcnxNGwsjtUKMtbGmaW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-gubUxzL4Pa6OyAD0pp2lAA-1; Sat, 04 Jul 2020 11:39:18 -0400
X-MC-Unique: gubUxzL4Pa6OyAD0pp2lAA-1
Received: by mail-wr1-f69.google.com with SMTP id g14so35924862wrp.8
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4VxXE4SCiQENXjR0p5gMwHzmkYsDqhVYN6kqXLwme2s=;
 b=s/K2CZEwcQrCOrd5UXOhQyEpX3akg7DckT9AFWWVUjC8C46RMudjeyagowC6yVhJXI
 fco6ncdgbO8Cq8dVcJiC+/Ef7sa6dmdVNGTnRCLBYZXjRQ+0QAKsIYszcPVlRet2rroP
 VUctE/eh/RsdjOb9aqdITqBmJsYt2uptHlcdraMZmNbS7IHNF09jiwykyPD9GYeVruB6
 wtHGZFs0e+L7H9I2jagjwP3iaukX9XSkzn/d/kJEaB0fh3GRuO0hC+tgSd6u6hDdh/Bm
 fMSqa7CLoVkrZ36UIhj6lPic9QuYYzcjEFzxKM6abFCbUCMhlTGkgyBHgYHjb+Q0ccOY
 NStg==
X-Gm-Message-State: AOAM532NR3+q7S5NO+x8rFx3r7bIkSsnRK9vLBo1JLyc+N+13IkN2SuN
 MMlBTeSPKGEeGwIDEaZ2cY3GwpSsnInfGAX4coXBXzluaoChJmuN7+nqdVN1YTG+nldrDSogNMH
 9bCv9HDzTcPDOjc4=
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr41861939wmg.93.1593877157274; 
 Sat, 04 Jul 2020 08:39:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBJo4FUom82vRU8/5mP45VfvlfhObz1DhaGdrkvZdmWsyz2BGimXVJAaF2JPT0rdOWUhT2Jg==
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr41861890wmg.93.1593877156946; 
 Sat, 04 Jul 2020 08:39:16 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id m10sm17446986wru.4.2020.07.04.08.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:39:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/23] qom/object: Update documentation
Date: Sat,  4 Jul 2020 17:38:46 +0200
Message-Id: <20200704153908.12118-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704153908.12118-1-philmd@redhat.com>
References: <20200704153908.12118-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentation was introduced in 2f28d2ff9dc, then
0d09e41a51 and a27bd6c77 moved the headers around.
Update the comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qom/object.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 94a61ccc3f..03dcd3623e 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -43,7 +43,7 @@ typedef struct InterfaceInfo InterfaceInfo;
  * <example>
  *   <title>Creating a minimal type</title>
  *   <programlisting>
- * #include "qdev.h"
+ * #include "hw/qdev-core.h"
  *
  * #define TYPE_MY_DEVICE "my-device"
  *
@@ -144,7 +144,7 @@ typedef struct InterfaceInfo InterfaceInfo;
  * <example>
  *   <title>Overriding a virtual function</title>
  *   <programlisting>
- * #include "qdev.h"
+ * #include "hw/qdev-core.h"
  *
  * void my_device_class_init(ObjectClass *klass, void *class_data)
  * {
@@ -168,7 +168,7 @@ typedef struct InterfaceInfo InterfaceInfo;
  * <example>
  *   <title>Defining an abstract class</title>
  *   <programlisting>
- * #include "qdev.h"
+ * #include "hw/qdev-core.h"
  *
  * typedef struct MyDeviceClass
  * {
-- 
2.21.3


