Received: from eggs.gnu.org ([2001:4830:134:3::10]:36295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396C-0000Od-8K
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396B-0002Wa-BP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d396B-0002WK-5H
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C25F80482
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:29 +0200
Message-Id: <20170425223739.6703-17-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 16/26] audio: remove GUSchar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/audio/gusemu.h       | 2 --
 hw/audio/gusemu_mixer.c | 8 ++++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/audio/gusemu.h b/hw/audio/gusemu.h
index 3a69222..1c1a63c 100644
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
index d255ac8..b189db9 100644
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
