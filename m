Received: from eggs.gnu.org ([2001:4830:134:3::10]:34738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1v-0001Uc-Q7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1s-0004br-Hh
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1s-0004aA-BV
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BF504ACB6
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:18:01 +0200
Message-Id: <20170504071811.3547-21-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 20/30] audio: remove GUSchar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-17-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/gusemu.h       | 2 --
 hw/audio/gusemu_mixer.c | 8 ++++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/audio/gusemu.h b/hw/audio/gusemu.h
index 3a69222281..1c1a63cc0f 100644
--- a/hw/audio/gusemu.h
+++ b/hw/audio/gusemu.h
@@ -30,10 +30,8 @@
 #if defined _WIN32 && defined _MSC_VER /* doesn't support other win32 compilers yet, do it yourself... */
  typedef unsigned short GUSword;
  typedef unsigned int GUSdword;
- typedef signed char GUSchar;
  typedef signed short GUSsample;
 #else
- typedef int8_t GUSchar;
  typedef uint16_t GUSword;
  typedef uint32_t GUSdword;
  typedef int16_t GUSsample;
diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
index d255ac821d..b189db990c 100644
--- a/hw/audio/gusemu_mixer.c
+++ b/hw/audio/gusemu_mixer.c
@@ -85,16 +85,16 @@ void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int
                 if (GUSvoice(wVSRControl) & 0x400)      /* 16bit */
                 {
                     int offset = ((CurrPos >> 9) & 0xc0000) + (((CurrPos >> 9) & 0x1ffff) << 1);
-                    GUSchar *adr;
-                    adr = (GUSchar *) state->himemaddr + offset;
+                    int8_t *adr;
+                    adr = (int8_t *) state->himemaddr + offset;
                     sample1 = (*adr & 0xff) + (*(adr + 1) * 256);
                     sample2 = (*(adr + 2) & 0xff) + (*(adr + 2 + 1) * 256);
                 }
                 else            /* 8bit */
                 {
                     int offset = (CurrPos >> 9) & 0xfffff;
-                    GUSchar *adr;
-                    adr = (GUSchar *) state->himemaddr + offset;
+                    int8_t *adr;
+                    adr = (int8_t *) state->himemaddr + offset;
                     sample1 = (*adr) * 256;
                     sample2 = (*(adr + 1)) * 256;
                 }
-- 
2.9.3
