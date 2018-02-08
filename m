Received: from eggs.gnu.org ([2001:4830:134:3::10]:43491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ejjuE-0004VA-Ab
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ejjuA-0005hl-CH
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:58:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52080
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ejjuA-0005ex-7A
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:58:14 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w18AuSHD170781
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 05:58:10 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g0jg6019e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 05:58:09 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 03:58:09 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu,  8 Feb 2018 08:57:54 -0200
Message-Id: <20180208105754.19924-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] hw/audio/sb16.c: missing break statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

This patch adds a break in the switch() statement of complete(),
value 0x42:

    case 0x42:              /* FT2 sets output freq with this, go figure */
        qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
                      " should\n");
        break; <-------
    case 0x41:

The issue was found by Coverity (#1385841):

    CID 1385841:  Control flow issues  (MISSING_BREAK)
    The case for value "66" is not terminated by a 'break' statement.

Fixes: 8ec660b80e ("hw/audio/sb16.c: change dolog() to qemu_log_mask()")
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
CC: John Arbuckle <programmingkidx@gmail.com>
CC: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/sb16.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 31de264ab7..b2fdcd8437 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -744,6 +744,7 @@ static void complete (SB16State *s)
         case 0x42:              /* FT2 sets output freq with this, go figure */
             qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
                           " should\n");
+            break;
         case 0x41:
             s->freq = dsp_get_hilo (s);
             ldebug ("set freq %d\n", s->freq);
-- 
2.14.3
