Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4D9C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E4021848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E4021848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oRi-0005dE-FN
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0oHc-00041V-Rp
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0oHb-0002lN-9E
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i0oHa-0002jd-UQ; Thu, 22 Aug 2019 10:41:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3011C3082A98;
 Thu, 22 Aug 2019 14:41:46 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EDD15D6A7;
 Thu, 22 Aug 2019 14:41:42 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: slirp@lists.freedesktop.org
Date: Thu, 22 Aug 2019 16:41:33 +0200
Message-Id: <20190822144134.23521-2-philmd@redhat.com>
In-Reply-To: <20190822144134.23521-1-philmd@redhat.com>
References: <20190822144134.23521-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 22 Aug 2019 14:41:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] Do not reassemble fragments pointing
 outside of the original payload
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
Cc: Petr Matousek <pmatouse@redhat.com>, Vishnu Dev TJ <vishnudevtj@gmail.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vulnerability CVE-2019-14378 is well explained in [1]:

  The bug is triggered when large IPv4 fragmented packets are
  reassembled for processing.

  For the NAT translation if the incoming packets are fragmented
  they should be reassembled before they are edited and
  re-transmitted.
  This reassembly is done by the
  ip_reass(Slirp *slirp, struct ip *ip, struct ipq *fp) function.
  ip contains the current IP packet data, fp is a link list
  containing the fragmented packets.

  ip_reass() does the following:

  * If first fragment to arrive (fp=3D=3DNULL), create a reassembly
    queue and insert ip into this queue.
  * Check if the fragment is overlapping with previous received
    fragments, then discard it.
  * If all the fragmented packets are received reassemble it.
    Create header for new ip packet by modifying header of first
    packet.

  The bug is at the calculation of the variable delta. The code
  assumes that the first fragmented packet will not be allocated in
  the external buffer (m_ext). The calculation q - m->dat is valid
  when the packet data is inside mbuf->m_dat (q will be inside m_dat)
  (q is structure containing link list of fragments and packet data).
  Otherwise if m_ext buffer was allocated, then q will be inside the
  external buffer and the calculation of the delta will be wrong.

  Later the newly calculated pointer q is converted into ip structure
  and values are modified, Due to the wrong calculation of the delta,
  ip will be pointing to incorrect location and ip_src and ip_dst can
  be used to write controlled data onto the calculated location. This
  may also crash qemu if the calculated ip is located in unmaped area.

Do not queue fragments pointing out of the original payload to avoid
to calculate the variable delta.

[1] https://vishnudevtj.github.io/notes/qemu-vm-escape-cve-2019-14378

Fixes: CVE-2019-14378
Reported-by: Vishnu Dev TJ <vishnudevtj@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 src/ip_input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/ip_input.c b/src/ip_input.c
index 7364ce0..ee52085 100644
--- a/src/ip_input.c
+++ b/src/ip_input.c
@@ -304,6 +304,19 @@ static struct ip *ip_reass(Slirp *slirp, struct ip *=
ip, struct ipq *fp)
         ip_deq(q->ipf_prev);
     }
=20
+    /*
+     * If we received the first fragment, we know the original
+     * payload size. Verify fragments are within our payload.
+     */
+    for (q =3D fp->frag_link.next; q !=3D (struct ipasfrag*)&fp->frag_li=
nk;
+            q =3D q->ipf_next) {
+        if (!q->ipf_off && q->ipf_len) {
+            if (ip->ip_off + ip->ip_len >=3D q->ipf_len) {
+                goto dropfrag;
+            }
+        }
+    }
+
 insert:
     /*
      * Stick new segment in its place;
--=20
2.20.1


