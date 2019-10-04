Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCEEC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4E020862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ28nETV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4E020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGEhp-0002Z5-MI
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 23:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mattkilgore12@gmail.com>) id 1iGEfP-0000Fw-EP
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mattkilgore12@gmail.com>) id 1iGEfO-0005gj-HF
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:54:07 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mattkilgore12@gmail.com>)
 id 1iGEfO-0005g5-CA
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:54:06 -0400
Received: by mail-io1-xd42.google.com with SMTP id q10so10622588iop.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4t7F4icG7FK10qm+njYNIEACzuJH42++WTZ6mU1D06E=;
 b=VJ28nETVahhrF9JTBU9QJrFcsHFrEyCjIefnqXVxBuC+d0FCdHJ4FOf/WdppsEPgbJ
 zpFRIbAkarrfJPx7muOTA0GoFHEt4mSj3UZa2v5rthXnUq3gqxEjN871sBx/hs8OoUDF
 gryv0bQzDJdWS1Qgj3M1LHUg4Mogl+2FR/7WnIjYN9/jVNKiJHLR70/LJrO9NWYO8Jcg
 DLweoXXYSZ45HWBZkS1KJYIHkh+9wBgBoObG/4crOMxaIajEOerr6n0OQSDelhu+5xrG
 xh8S/R4mxVhcZikXIsL6UshIl/xQrbBpULQm3PTLgfijE6UoeOf8VX7S/zuDZkcDo37R
 klHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4t7F4icG7FK10qm+njYNIEACzuJH42++WTZ6mU1D06E=;
 b=aNQsyIHT+bF8UQYI9FwSQ2rhhTfnmjzujnqZVsf1QtWpiNrsb5DnmvzdAAqlMVyWQ+
 2DlncmnBR41hlr+4uVg6BtUGYbWwyD4L4qUOjgIHDpqQV7z/7PtJNHsYYe2RGGCMoGxW
 NWdMjN0J2f7930vOQlb+QyeaeevCVKvQo+GT5Of5/1jeha3DZDydO9lRivYdoHQ+BoHA
 EWkpch7Mc7rndpqEd2WwTghTu0hdLyGuzNbvrfIbdTAsfydAdOk2rJAH3uv0xxIJjA81
 fnDb9ssAzuWQg1sS8I0kM/xF8KRiVBkOyKGFM30QketDXZWWGBYakLVuj4HghRRe5QVg
 z0FQ==
X-Gm-Message-State: APjAAAXF5LEyRCv8vU69ptdVSMTkOGp0QvskOxie1wTxJuU4cQmUYLfz
 FzHwkrRgBLZtiR2ITXjaz/GJ4Xlz
X-Google-Smtp-Source: APXvYqyAsX+XYA1C5VGHcbrEz5ciFMPiK11aVjmeJ4armZym9u7n9ymMqJoAgfj2eE/vOcOFGPNwoA==
X-Received: by 2002:a92:5a10:: with SMTP id o16mr14159987ilb.296.1570161245403; 
 Thu, 03 Oct 2019 20:54:05 -0700 (PDT)
Received: from matt-laptop3.localdomain (d118-75-38-58.col.wideopenwest.com.
 [75.118.58.38])
 by smtp.gmail.com with ESMTPSA id n17sm1570274ioj.73.2019.10.03.20.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 20:54:04 -0700 (PDT)
From: Matthew Kilgore <mattkilgore12@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] curses: correctly pass the color pair to setcchar()
Date: Thu,  3 Oct 2019 23:53:38 -0400
Message-Id: <20191004035338.25601-3-mattkilgore12@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004035338.25601-1-mattkilgore12@gmail.com>
References: <20191004035338.25601-1-mattkilgore12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: samuel.thibault@ens-lyon.org, Matthew Kilgore <mattkilgore12@gmail.com>,
 philmd@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current code does not correctly pass the color pair information to
setcchar(), it instead always passes zero. This results in the curses
output always being in white on black.

This patch fixes this by using PAIR_NUMBER() to retrieve the color pair
number from the chtype value, and then passes that value as an argument
to setcchar().

Signed-off-by: Matthew Kilgore <mattkilgore12@gmail.com>
---
 ui/curses.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/curses.c b/ui/curses.c
index 84003f56a323..3a1b71451c93 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -77,12 +77,14 @@ static void curses_update(DisplayChangeListener *dcl,
         for (x = 0; x < width; x++) {
             chtype ch = line[x] & A_CHARTEXT;
             chtype at = line[x] & A_ATTRIBUTES;
+            short color_pair = PAIR_NUMBER(line[x]);
+
             ret = getcchar(&vga_to_curses[ch], wch, &attrs, &colors, NULL);
             if (ret == ERR || wch[0] == 0) {
                 wch[0] = ch;
                 wch[1] = 0;
             }
-            setcchar(&curses_line[x], wch, at, 0, NULL);
+            setcchar(&curses_line[x], wch, at, color_pair, NULL);
         }
         mvwadd_wchnstr(screenpad, y, 0, curses_line, width);
     }
-- 
2.23.0


