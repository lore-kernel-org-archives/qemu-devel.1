Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA00C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19D822277
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iXQ2lwcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19D822277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpnZ-0000VG-FK
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVb-0005PI-6P
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:19 -0400
Received: from ozlabs.org ([203.11.71.1]:56515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVY-0001oa-6L
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wf0Hs3z9sWb; Fri,  9 Oct 2020 21:20:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238802;
 bh=1oXAw8PspGm9Vod9cA6WVUuerAjUn2rjUVHV5ferf6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iXQ2lwcBVj0nQWtamA8FSqLtcaYBfzFBpziw+IHnuPeun03mbiyx+sZJdjZ/AlY21
 2oKm72JxJ45KPvhrarwmCI3NaFnL6eaNt4kcUKWWlLFQvVITeuDCajmv/UQW0VP7bV
 g5aa/Iy14DhewCuMDzVgZ7iCGp0m+Ya6Ar2MfKZ8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 20/20] specs/ppc-spapr-numa: update with new NUMA support
Date: Fri,  9 Oct 2020 21:19:51 +1100
Message-Id: <20201009101951.1569252-21-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
References: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 06:19:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: dbarboza@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nonngu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

This update provides more in depth information about the
choices and drawbacks of the new NUMA support for the
spapr machine.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20201007172849.302240-6-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 docs/specs/ppc-spapr-numa.rst | 235 ++++++++++++++++++++++++++++++++--
 1 file changed, 227 insertions(+), 8 deletions(-)

diff --git a/docs/specs/ppc-spapr-numa.rst b/docs/specs/ppc-spapr-numa.rst
index e762038022..5fca2bdd8e 100644
--- a/docs/specs/ppc-spapr-numa.rst
+++ b/docs/specs/ppc-spapr-numa.rst
@@ -158,9 +158,235 @@ kernel tree). This results in the following distances:
 * resources four NUMA levels apart: 160
 
 
-Consequences for QEMU NUMA tuning
+pseries NUMA mechanics
+======================
+
+Starting in QEMU 5.2, the pseries machine considers user input when setting NUMA
+topology of the guest. The overall design is:
+
+* ibm,associativity-reference-points is set to {0x4, 0x3, 0x2, 0x1}, allowing
+  for 4 distinct NUMA distance values based on the NUMA levels
+
+* ibm,max-associativity-domains supports multiple associativity domains in all
+  NUMA levels, granting user flexibility
+
+* ibm,associativity for all resources varies with user input
+
+These changes are only effective for pseries-5.2 and newer machines that are
+created with more than one NUMA node (disconsidering NUMA nodes created by
+the machine itself, e.g. NVLink 2 GPUs). The now legacy support has been
+around for such a long time, with users seeing NUMA distances 10 and 40
+(and 80 if using NVLink2 GPUs), and there is no need to disrupt the
+existing experience of those guests.
+
+To bring the user experience x86 users have when tuning up NUMA, we had
+to operate under the current pseries Linux kernel logic described in
+`How the pseries Linux guest calculates NUMA distances`_. The result
+is that we needed to translate NUMA distance user input to pseries
+Linux kernel input.
+
+Translating user distance to kernel distance
+--------------------------------------------
+
+User input for NUMA distance can vary from 10 to 254. We need to translate
+that to the values that the Linux kernel operates on (10, 20, 40, 80, 160).
+This is how it is being done:
+
+* user distance 11 to 30 will be interpreted as 20
+* user distance 31 to 60 will be interpreted as 40
+* user distance 61 to 120 will be interpreted as 80
+* user distance 121 and beyond will be interpreted as 160
+* user distance 10 stays 10
+
+The reasoning behind this aproximation is to avoid any round up to the local
+distance (10), keeping it exclusive to the 4th NUMA level (which is still
+exclusive to the node_id). All other ranges were chosen under the developer
+discretion of what would be (somewhat) sensible considering the user input.
+Any other strategy can be used here, but in the end the reality is that we'll
+have to accept that a large array of values will be translated to the same
+NUMA topology in the guest, e.g. this user input:
+
+::
+
+      0   1   2
+  0  10  31 120
+  1  31  10  30
+  2 120  30  10
+
+And this other user input:
+
+::
+
+      0   1   2
+  0  10  60  61
+  1  60  10  11
+  2  61  11  10
+
+Will both be translated to the same values internally:
+
+::
+
+      0   1   2
+  0  10  40  80
+  1  40  10  20
+  2  80  20  10
+
+Users are encouraged to use only the kernel values in the NUMA definition to
+avoid being taken by surprise with that the guest is actually seeing in the
+topology. There are enough potential surprises that are inherent to the
+associativity domain assignment process, discussed below.
+
+
+How associativity domains are assigned
+--------------------------------------
+
+LOPAPR allows more than one associativity array (or 'string') per allocated
+resource. This would be used to represent that the resource has multiple
+connections with the board, and then the operational system, when deciding
+NUMA distancing, should consider the associativity information that provides
+the shortest distance.
+
+The spapr implementation does not support multiple associativity arrays per
+resource, neither does the pseries Linux kernel. We'll have to represent the
+NUMA topology using one associativity per resource, which means that choices
+and compromises are going to be made.
+
+Consider the following NUMA topology entered by user input:
+
+::
+
+      0   1   2   3
+  0  10  40  20  40
+  1  40  10  80  40
+  2  20  80  10  20
+  3  40  40  20  10
+
+All the associativity arrays are initialized with NUMA id in all associativity
+domains:
+
+* node 0: 0 0 0 0
+* node 1: 1 1 1 1
+* node 2: 2 2 2 2
+* node 3: 3 3 3 3
+
+
+Honoring just the relative distances of node 0 to every other node, we find the
+NUMA level matches (considering the reference points {0x4, 0x3, 0x2, 0x1}) for
+each distance:
+
+* distance from 0 to 1 is 40 (no match at 0x4 and 0x3, will match
+  at 0x2)
+* distance from 0 to 2 is 20 (no match at 0x4, will match at 0x3)
+* distance from 0 to 3 is 40 (no match at 0x4 and 0x3, will match
+  at 0x2)
+
+We'll copy the associativity domains of node 0 to all other nodes, based on
+the NUMA level matches. Between 0 and 1, a match in 0x2, we'll also copy
+the domains 0x2 and 0x1 from 0 to 1 as well. This will give us:
+
+* node 0: 0 0 0 0
+* node 1: 0 0 1 1
+
+Doing the same to node 2 and node 3, these are the associativity arrays
+after considering all matches with node 0:
+
+* node 0: 0 0 0 0
+* node 1: 0 0 1 1
+* node 2: 0 0 0 2
+* node 3: 0 0 3 3
+
+The distances related to node 0 are accounted for. For node 1, and keeping
+in mind that we don't need to revisit node 0 again, the distance from
+node 1 to 2 is 80, matching at 0x1, and distance from 1 to 3 is 40,
+match in 0x2. Repeating the same logic of copying all domains up to
+the NUMA level match:
+
+* node 0: 0 0 0 0
+* node 1: 1 0 1 1
+* node 2: 1 0 0 2
+* node 3: 1 0 3 3
+
+In the last step we will analyze just nodes 2 and 3. The desired distance
+between 2 and 3 is 20, i.e. a match in 0x3:
+
+* node 0: 0 0 0 0
+* node 1: 1 0 1 1
+* node 2: 1 0 0 2
+* node 3: 1 0 0 3
+
+
+The kernel will read these arrays and will calculate the following NUMA topology for
+the guest:
+
+::
+
+      0   1   2   3
+  0  10  40  20  20
+  1  40  10  40  40
+  2  20  40  10  20
+  3  20  40  20  10
+
+Note that this is not what the user wanted - the desired distance between
+0 and 3 is 40, we calculated it as 20. This is what the current logic and
+implementation constraints of the kernel and QEMU will provide inside the
+LOPAPR specification.
+
+Users are welcome to use this knowledge and experiment with the input to get
+the NUMA topology they want, or as closer as they want. The important thing
+is to keep expectations up to par with what we are capable of provide at this
+moment: an approximation.
+
+Limitations of the implementation
 ---------------------------------
 
+As mentioned above, the pSeries NUMA distance logic is, in fact, a way to approximate
+user choice. The Linux kernel, and PAPR itself, does not provide QEMU with the ways
+to fully map user input to actual NUMA distance the guest will use. These limitations
+creates two notable limitations in our support:
+
+* Asymmetrical topologies aren't supported. We only support NUMA topologies where
+  the distance from node A to B is always the same as B to A. We do not support
+  any A-B pair where the distance back and forth is asymmetric. For example, the
+  following topology isn't supported and the pSeries guest will not boot with this
+  user input:
+
+::
+
+      0   1
+  0  10  40
+  1  20  10
+
+
+* 'non-transitive' topologies will be poorly translated to the guest. This is the
+  kind of topology where the distance from a node A to B is X, B to C is X, but
+  the distance A to C is not X. E.g.:
+
+::
+
+      0   1   2   3
+  0  10  20  20  40
+  1  20  10  80  40
+  2  20  80  10  20
+  3  40  40  20  10
+
+  In the example above, distance 0 to 2 is 20, 2 to 3 is 20, but 0 to 3 is 40.
+  The kernel will always match with the shortest associativity domain possible,
+  and we're attempting to retain the previous established relations between the
+  nodes. This means that a distance equal to 20 between nodes 0 and 2 and the
+  same distance 20 between nodes 2 and 3 will cause the distance between 0 and 3
+  to also be 20.
+
+
+Legacy (5.1 and older) pseries NUMA mechanics
+=============================================
+
+In short, we can summarize the NUMA distances seem in pseries Linux guests, using
+QEMU up to 5.1, as follows:
+
+* local distance, i.e. the distance of the resource to its own NUMA node: 10
+* if it's a NVLink GPU device, distance: 80
+* every other resource, distance: 40
+
 The way the pseries Linux guest calculates NUMA distances has a direct effect
 on what QEMU users can expect when doing NUMA tuning. As of QEMU 5.1, this is
 the default ibm,associativity-reference-points being used in the pseries
@@ -180,12 +406,5 @@ as far as NUMA distance goes:
   to the same third NUMA level, having distance = 40
 * for NVLink GPUs, distance = 80 from everything else
 
-In short, we can summarize the NUMA distances seem in pseries Linux guests, using
-QEMU up to 5.1, as follows:
-
-* local distance, i.e. the distance of the resource to its own NUMA node: 10
-* if it's a NVLink GPU device, distance: 80
-* every other resource, distance: 40
-
 This also means that user input in QEMU command line does not change the
 NUMA distancing inside the guest for the pseries machine.
-- 
2.26.2


