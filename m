Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C9FC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC62F206C3
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BSB8G/z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC62F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4e4Y-0000r2-Sv
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dp8-0006PJ-85
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:40435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dp5-0002rD-5E
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950646;
 bh=2t00/wToPXdci/sCMNt4gNmLdt2OOd+Fs0qy1+SNfwk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BSB8G/z/Jyk59uRXVzVYr2i0wlXbY6TpTj6l2NBNO/N1UoNJwoQV2QqtJxf1xlUno
 nxWKHFncwiEae2VVs5qvaxYBrFvQoV+uodig1LO0gw0SO8+Bti2MhyObt97rpkxdQd
 AdHatyAb7cq8BRhJ9ek2UM75cdA+WDGnRfwfU2GA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.185.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRMi-1kAEtW0JPI-00TkCm; Sun, 09
 Aug 2020 07:24:06 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 05/12] hw/hppa/lasi: Don't abort on invalid IMR value
Date: Sun,  9 Aug 2020 07:23:55 +0200
Message-Id: <20200809052402.31641-6-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200809052402.31641-1-deller@gmx.de>
References: <20200809052402.31641-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1f4mREGQJzFnsweYCdJUtIhp+z88//EiEh5YcunsZvgXbs08MqA
 ZQPr1HDlK+hJgFetcoTempCJE2Nd4xobArRJ+1GK/So2NkhOkLwH48fQawaMj9uaj8Z9xVV
 BN5oJD92U3E6gGVMLahPwToqqsprSqlQcFPzmfpdNCFUH+87KWJ0/aV499i3SFMfGswnkro
 cjqgkxXRBN/FIt8O6Wchg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OJjUGp33ZuY=:To3mD++8nFaebKmfyGPD7f
 iAqThi82VDzE8L3L+WCKYATAZil7mhlt/ENMIWaVGpf0b9Q86bmyIQ53hqCAdSbGvrShrhP4E
 sXmbSJJKfokmVTikOYMt01ih2JyvGDszQfLWKU3FNs/8iIC9IHwrfyudkvXAhqXLzh0xbTLDT
 nRHbwbWIdJfpWe9NDDmRx6yKv/HD14YEeHY/Qm/XJ5bt8Oc7uk5k9fAm3Sj1lWgjaTBiBcOca
 9TUL+HCpS15ImRUXfeflFGvE5f940kbCGrRCnJIN0hYujrUoK5jStXwuTG/E3NSKX3EQtj3Rk
 x2toCiIB02TiREyVijgbmY1MSTCpxjKgiLGKU8q4mGKnP8l0zDzEjhs9m8f+j8LI+D4RVCmX8
 U/DAKDmFoyPE6OrApoC+ZOZHJc8Ju9pwUEijnIOqSK0sK78e94sRYmZ8HEVqmh8510QZjJIub
 f0VkDFfCNQqnhPjADVxxQaQF/jlfAogwt9Va/ybA4znRZ8jCcg96L8vDDWmyXwRu7sxkxTHaF
 +zy4sOqnC6UVnIrAcF7MHp+1q8neYK6V0bM6hxgjLIXs4eHPnwsoDF/Otdc9Ygwn0dra0ItOR
 ZTae9iVdsyoNkIwvxCbyS7zNbKvRP6u3bQuMIHoZMw1acmwWyKDaZcirb4QXKD12P+JxG7vdS
 D9pMEMqfk6tgiRkAxRz1oWLhVPgcg0RWEiTbJJXUVMBoljYlOZtKpyFeg9xHWWogsYuHWeHxc
 HFn7CmIU6EYhviMwq4dIF1rmGpxxrc+9g3Zx6jfXg3hoF2PwGWixEqbV0fC1wcYw55rvynxb8
 aJKCNUq/DIpJFXbNW40WWMmQEX4JNVMxEFsiZJdZd8SPKlQwY0bZQzmFt++rDpvn/h38h4uDD
 lK3vCfqRk27k3uWsDlM9gk4ii4fU3tWmbIuu5dj7BbLj4puVkqRTsrHJy8CNhaRYHUnkN3tmk
 sWlOmTV4OlmnG4vk4IcgTCcaYTIKkTN+a6xR4+9lPSqw7QZ98uikpXW3NIzIzFrc7CbcD8TP0
 KRNBt+msH6FEIRDcTe8Qhv5fHltAhgs7JwjR8jPilFr0zxZBWazNAj51OPU1q6Ofyl2J7i8gE
 ZNctNCKmJ+oxS2qlcFzpcNqiKujPyVZgv2xX4Ds6Qi8TNmHfcKmcXhyLBBQ5KgETyGGo2uvZw
 ljdOAS1b9oB/qyYqgoEL9/LsZLYoZKSubUvmN9vZPVIy74zl0aXnjAuxRxrp0AR1xvhAkiKHp
 Rlmu32z0F3zcjsTsS
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:24:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NetBSD initializes the LASI IMR value with 0xffffffff to disable all LASI
interrupts. This triggered an assert() and stopped the emulation.  By repl=
acing
the check with a warning in the guest log we now allow NetBSD to boot agai=
n.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/lasi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
index ffcbb988b8..7b4a168468 100644
=2D-- a/hw/hppa/lasi.c
+++ b/hw/hppa/lasi.c
@@ -11,6 +11,7 @@

 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "trace.h"
@@ -170,8 +171,10 @@ static MemTxResult lasi_chip_write_with_attrs(void *o=
paque, hwaddr addr,
         /* read-only.  */
         break;
     case LASI_IMR:
-        s->imr =3D val;  /* 0x20 ?? */
-        assert((val & LASI_IRQ_BITS) =3D=3D val);
+        s->imr =3D val;
+        if (((val & LASI_IRQ_BITS) !=3D val) && (val !=3D 0xffffffff))
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "LASI: tried to set invalid %lx IMR value.\n", val);
         break;
     case LASI_IPR:
         /* Any write to IPR clears the register. */
=2D-
2.21.3


