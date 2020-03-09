Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BEBC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4BF2067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4BF2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKKn-0002HS-NP
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK39-0000et-Qq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK38-0008E2-LD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45825)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK30-00086s-Eu; Mon, 09 Mar 2020 11:10:26 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MTRIg-1ilycF3xAi-00TixO; Mon, 09 Mar 2020 16:09:44 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 26/33] core/qdev: fix memleak in qdev_get_gpio_out_connector()
Date: Mon,  9 Mar 2020 16:08:30 +0100
Message-Id: <20200309150837.3193387-27-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JrwU5Vff2nH36QqBO4SokSEF69SyLDUjmJiemvsl2Y5FiFoopSF
 qM3/d1v+H+NTqckOknHbdzV3hqYgy0asz4jG+GbS+v2s8EiozVN64Npe2GPZZlCKe5Ou7RS
 caFVun3IuIaz8shA19ArETShfKh5J3hSTou1IF2yjuQiXHQJ7fREbNp0mugBgvBqVpNlXKe
 Y+J7A87RduBOMkp2iHrfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ibjFkJcPduc=:CiTMwqX4N2Li33mxCvemy8
 ywpgPkYjXqxkZ9eNYfnNzECgJ2yDysKNRe+CsM0yWU2UncSG/e4n5ciycjGBOAyiWthdNszZ6
 5W2SuLjK0Kxe9iPAvaEu9Phl21aKVSkqMorRfd1asAlkVAnN+nfD/DFPQTMQFBalDfAHazamh
 Wbo8OscT6mWPmj9XIT71oS16QI24wFhdLhwHvN8iVw82cekuBxAU6rFxnD7ncue/BfGP7x4rh
 b1qnw9GDVxKM6FkRrjeV++rGPMLFmRj6NkxU28JV0xGg+iqj4LK9R9aUWXRnmlbBPdS54y+F6
 Pz2KrblG+WSY09IjG99DYvSv07uZrfygxaakv+/I+qh4546AerUXAgp6h0dSjrsL3M5y0/o9w
 5KMiggQJVRFNmVp+nV4olWup9nsms2DuToJMA85MPKcbWg7zaSlnIG/WOSE0B2jBvLZdEqCeI
 RVEWQXu4Rrj98u5HsrBTLmhhVjk+Gb95F6WQaIBbINJ2+0APEMVURYWL5yMseYmLXur6S3YFI
 gVZ+xFQc+DTXvSn1qaDf8j37ck5mH6UojnrRbylRck2/23tnEmP1GCg/n6h9nUi9yot6HJP0q
 BR7eW9XKSeGz31y6I7cdCQHalbe/e9tBXy6X9GznZyj86HgCB2Thdry9/q5FtJsCcrkQO6wgf
 fh0We9FTtZdV7DR9WbHCpYMfhO31OC63dfgM57Qz7htfvehHu+GevgOD2mJxYit5hCnt66F7i
 EFb6BmmHtf0FWg45i0v1u3JdLvJSpni36jnKG6vBGbkgve2jo0BlykgiM4oHXbMH97y5fMg5f
 4zKaPMFTrienIGq3OUL1XfWXpC3HLwsVO2Phtljc8tCoEcuvrjGpuqYX9fyUpTPCn2tQc8R
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Euler Robot <euler.robot@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Fix a memory leak in qdev_get_gpio_out_connector().

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200307030756.5913-1-pannengyuan@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/core/qdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 3937d1eb1a5f..85f062def72b 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -557,7 +557,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
 
 qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n)
 {
-    char *propname = g_strdup_printf("%s[%d]",
+    g_autofree char *propname = g_strdup_printf("%s[%d]",
                                      name ? name : "unnamed-gpio-out", n);
 
     qemu_irq ret = (qemu_irq)object_property_get_link(OBJECT(dev), propname,
-- 
2.24.1


