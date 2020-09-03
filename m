Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F38AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C3A2071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PeM/hy23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C3A2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDiUV-00018T-A2
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDiQe-0007ka-Uf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:09:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:55887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDiQc-0001Dv-JO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599113336;
 bh=rjk5yVSQnnKzSV23OvxjrhMa+XjBRpGrB7EeXPRvWR0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PeM/hy23Am9/C0sYDAql90VBN6xjblYm8pC6E5SwMo2+nM40OYwk/H4jm9flVt4UN
 tk6QNxCdPvv7dIIwZ6UPT43V4IkGUDf6CnTPjKn3AULrjzdKFpmH5LLOSxuDMQMS9r
 IDDSkAxqJHxvnVH54Mn262RuBw83L1FBY85pAUbQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1kDBG213ny-008Loq; Thu, 03
 Sep 2020 08:08:56 +0200
Date: Thu, 3 Sep 2020 08:08:54 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 6/7] hw/display/artist: Fix artist screen resolution
Message-ID: <20200903060854.GB8548@ls3530.fritz.box>
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-7-deller@gmx.de>
 <65284ae3-f0fe-336e-a205-0494abb20f08@linaro.org>
 <20200902214819.GA2424@ls3530.fritz.box>
 <45bf91fd-4e7f-7379-18a2-cdada67a3f6d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45bf91fd-4e7f-7379-18a2-cdada67a3f6d@linaro.org>
X-Provags-ID: V03:K1:UALrQjjsY69U1upA4UW7RAiTsN55GezInhElPMsK13yys8z8g7K
 PUQsF8sT8L/QDeKx4+PKDvsAt30wAGJtTIXayA5XdLmdXEUhJhFXfjFi+2ZK+am2X6IIGHU
 QCn7d3V38wQje6phE+s9ttzb8nQivxfcQyWEeePn2qfYNTnQogC4+W2dwiITNCSsgPJuiA+
 FKk8xJY1HgKsEpRIWItHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ApLV8WZ2Gkw=:PFtAyY4mGJ2TLFju1cAKPG
 Sp4K2XGJBQdL5E0K4DpD19Zi4ICxLhT7sw4Em541zKWZ50FLvP8lWWtwakbVcXVwUbHvIgr3F
 75rNkYqJfG/tKj7bUqiWLrouG3h6l1kj19SFJmlZ5O8GMk1FgSwfH7nHAQ79Ly8sPP/U6+hBN
 iRnQryZMWwZkQNU9PGUOLdZjL2ySKOl5wzdvZbx0VZd1p9jX1wv1HpL6l2I3Os3RczSmcwl8h
 gylVivJtC014hNAFEvSlYgYjQrH+NTV79TVdM17xyjgm4jasH9eVWMVviG06vG4MMyy3kbSdv
 CGWzy+B5xpybQNN1mq2PDF2ZOjgsk35cOo26P+kMT+6XKBCGG1/IQ/IyFB4UV+KZqb5jHvPej
 /iHubeVdP7hX8wo5Psgu/biAx0Xco9YHw80xJ2ORLSPEZaDuW+6/iYjFktKqwjCOe3hYrSIlg
 qQOPSa0uPC6K086IJjZSRUIfOShyymXWDUri28sskGDUE7b4IB+H9i2XBseu1w3NngP2l5/b6
 /QUBAl8XVM8rREPCuZc/Xh/HE/m6VSZdX94nXBFxEwF8PTnWAVb4ZL1J1pc4X/SMTDaeZV1Ru
 +7zDWOaCYpZa+RN/haRR1mfANUkXbtn4LMOldADW3FEydOW5aTLYx/EtYwfP61grVrtZmvSyi
 9i6So7qbYSLEKVWGcqWPJCUkhFSbE5FzhKlxkhP+SqWqi5JvLS/YWsnwzS7Le55ubtjC0UPRe
 t+3rRzOOxg4cOhleyo9fzDoPAruTixhUcbGYgNzN/ZUYrjNAKaDKsO+f6C26Xd6afq+lHbcT/
 tpERqVtRLZy2x/jvYg8cax72Lx/FtnygObAhq+SRh5klVfYALFfWu5jAxdF6TkmcP5BokrRjt
 CamLSUi/y81LR+zOAAHwxpoZmXu++iotcsL08CfH0jjV4pzqe1El2CgrJXRsG23v09ahyypdx
 IWP7+bYKR+Z6EUSUHBQYX+8Th3pMDpGoflwX2/LpHkL2HUvPt6zA2QIcrTAd/3e98/2Il+i0X
 Vaf6QmstF4m746/JydvzlGihxXVM7smq5KDu5BKIpkWEZigjQEy95wb8Utz9M6bdegRdDjU6P
 KE+l8Dq6uRr4XGIbsIQFJSTiMepezBfKkIlXwfiXHijhjFg14oFSIC8r+1+HxikjObl+yacuF
 vROY4T2bH3qlcVkUmQaSYyNbWoAK3QJHABpf6sX+pwKDBmgzJ/3ZDYUHrQc2z5H/q2O+ZUZpG
 Yow1/Utp8wgvBmObw
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 02:08:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New patch #2:

=46rom b0f0d24563df504b8221fbc934d25c5a896e0a49 Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Subject: [PATCH] hw/display/artist: Refactor x/y coordination extraction

Simplify the code by using new introduced ADDR_TO_Y() and ADDR_TO_X()
macros. Those macros extract the x/y-coordinate from the given uint32.

As further simplification the extraction of the x/y coordinates for
VRAM_WRITE_INCR_Y and VRAM_WRITE_INCR_X can be done centrally in
vram_bit_write(), so move this code up into the function.

ADDR_TO_Y() is still limited to 10 bits which allow to address up to of
1024 lines - this will be increased in a follow-up patch.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/display/artist.c b/hw/display/artist.c
index ff1532fdc1..16d85c65f8 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -192,6 +192,10 @@ static const char *artist_reg_name(uint64_t addr)
 }
 #undef REG_NAME

+/* artist has a fixed line length of 2048 bytes. */
+#define ADDR_TO_Y(addr) extract32(addr, 11, 10)
+#define ADDR_TO_X(addr) extract32(addr, 0, 11)
+
 static int16_t artist_get_x(uint32_t reg)
 {
     return reg >> 16;
@@ -348,13 +352,13 @@ static void artist_invalidate_cursor(ARTISTState *s)
                             y, s->cursor_height);
 }

-static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_=
x,
+static void vram_bit_write(ARTISTState *s, int posy, bool incr_x,
                            int size, uint32_t data)
 {
     struct vram_buffer *buf;
     uint32_t vram_bitmask =3D s->vram_bitmask;
     int mask, i, pix_count, pix_length;
-    unsigned int offset, width;
+    unsigned int posx, offset, width;
     uint8_t *data8, *p;

     pix_count =3D vram_write_pix_per_transfer(s);
@@ -366,6 +370,8 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
     if (s->cmap_bm_access) {
         offset =3D s->vram_pos;
     } else {
+        posx =3D ADDR_TO_X(s->vram_pos >> 2);
+        posy +=3D ADDR_TO_Y(s->vram_pos >> 2);
         offset =3D posy * width + posx;
     }

@@ -858,7 +864,6 @@ static void artist_reg_write(void *opaque, hwaddr addr=
, uint64_t val,
                              unsigned size)
 {
     ARTISTState *s =3D opaque;
-    int posx, posy;
     int width, height;

     trace_artist_reg_write(size, addr, artist_reg_name(addr & ~3ULL), val=
);
@@ -881,16 +886,12 @@ static void artist_reg_write(void *opaque, hwaddr ad=
dr, uint64_t val,
         break;

     case VRAM_WRITE_INCR_Y:
-        posx =3D (s->vram_pos >> 2) & 0x7ff;
-        posy =3D (s->vram_pos >> 13) & 0x3ff;
-        vram_bit_write(s, posx, posy + s->vram_char_y++, false, size, val=
);
+        vram_bit_write(s, s->vram_char_y++, false, size, val);
         break;

     case VRAM_WRITE_INCR_X:
     case VRAM_WRITE_INCR_X2:
-        posx =3D (s->vram_pos >> 2) & 0x7ff;
-        posy =3D (s->vram_pos >> 13) & 0x3ff;
-        vram_bit_write(s, posx, posy + s->vram_char_y, true, size, val);
+        vram_bit_write(s, s->vram_char_y, true, size, val);
         break;

     case VRAM_IDX:
@@ -1156,8 +1157,7 @@ static void artist_vram_write(void *opaque, hwaddr a=
ddr, uint64_t val,
 {
     ARTISTState *s =3D opaque;
     struct vram_buffer *buf;
-    int posy =3D (addr >> 11) & 0x3ff;
-    int posx =3D addr & 0x7ff;
+    unsigned int posy, posx;
     unsigned int offset;
     trace_artist_vram_write(size, addr, val);

@@ -1170,6 +1170,9 @@ static void artist_vram_write(void *opaque, hwaddr a=
ddr, uint64_t val,
     }

     buf =3D vram_write_buffer(s);
+    posy =3D ADDR_TO_Y(addr);
+    posx =3D ADDR_TO_X(addr);
+
     if (!buf->size) {
         return;
     }
@@ -1212,7 +1215,7 @@ static uint64_t artist_vram_read(void *opaque, hwadd=
r addr, unsigned size)
     ARTISTState *s =3D opaque;
     struct vram_buffer *buf;
     uint64_t val;
-    int posy, posx;
+    unsigned int posy, posx;

     if (s->cmap_bm_access) {
         buf =3D &s->vram_buffer[ARTIST_BUFFER_CMAP];
@@ -1229,8 +1232,8 @@ static uint64_t artist_vram_read(void *opaque, hwadd=
r addr, unsigned size)
         return 0;
     }

-    posy =3D (addr >> 13) & 0x3ff;
-    posx =3D (addr >> 2) & 0x7ff;
+    posy =3D ADDR_TO_Y(addr);
+    posx =3D ADDR_TO_X(addr);

     if (posy > buf->height || posx > buf->width) {
         return 0;

