Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3B6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C679A22283
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="fbDpXJEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C679A22283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRFR3-0006i0-KS
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 10:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMz-0000wP-2y; Sat, 10 Oct 2020 09:57:09 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMv-0004IK-PC; Sat, 10 Oct 2020 09:57:08 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 572F7C603C2;
 Sat, 10 Oct 2020 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602338223;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FersAzpN8NHvPMLGj5VpCSEmZb4JFczHhL1rgLAgDho=;
 b=fbDpXJEaqsIJf21JdAi/NkwOsOHF1TIapGntPI/IE5Tg4nMOskbhx0EVcLEcA6QZq1v0CF
 X9hqQ7hsLtb7KFwdbuighswrdip3JfguXgKp2bckTgsHN8lTR5DV7TN+pDDGEMpHalIPtT
 afZlGvD+zTYqVA1ygpt7CDZy6CQoHS/5OfVCJXgZhM8has7hpSr7HKvdiC3ACXhmu7YAkt
 9/FBm50pXwk5RV12MEm1WvXbYW95NQvqmA8PMmGIWTmiaRNAukSI/1TVAqvk+Smk4bQKev
 Vg0F50AtNzRAFCExGcir74Vjnt8bDrRSfD6nB6kl47QTyFnOlvfM5QELc9K0Ew==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/15] hw/core/clock: add the clock_new helper function
Date: Sat, 10 Oct 2020 15:57:47 +0200
Message-Id: <20201010135759.437903-4-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010135759.437903-1-luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602338223;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FersAzpN8NHvPMLGj5VpCSEmZb4JFczHhL1rgLAgDho=;
 b=bMKG5cC8WrjVdMI99aUtYoS9y4v9+7v96DyivHHc2HZt4wXeXsiIGeU6QgNyVWJw4S0oRu
 T4olhkWf+DxoJQ8CYYdCDCl1N0rJ756bOnRch2wkX15XY8QDUgor86HyqVNHRuNIYAsvfv
 d07XjlqQdcPhzDwsMbm+0OHYulv5u30KJXD7+06Oqv+9zsGCGiUvcE8d19pECPv9ll6KF4
 VWgBDZA3M8nQSS2Jpe2oyF13XG6xP8JRuT4uat0GemijM+lNV4uWbe3LTNidg/u0cdgiCb
 VCHQoMxq1U1Qik5/0J36eqtBF/mlJmJDW7XD7258v5pk/HJsihn+AoRxu9kjxQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602338223; a=rsa-sha256; cv=none;
 b=QUBy2ev2EDljhCMO8Sisys0aEvOuzndf7Z2T4PYtBW4OzntOWGHQscp/q9X/37wKdyMtzmSt27DGUvYuh115CEIjzCttq7hs4Ex26EpDwBAzTxPZkHoAxwCmDKAazv79TPsdRVfXgKIBNZtYaiqV9+M35ss3pX75V6nTINgxHD10zX0MItGHS/PAAIZXvLskSXn2dFC6KLRTK/ABOryRaRMg2NX0ennymbtlG/sN05C2qJV9I/1W655a7ZSPYU1bzlO/V8C5MZwqR9MZ8hLN82AXAJfzZQTGKvP9D2ftCvKeFRNT5yvFMng8w5BWekKGahhSQlyTmt4LsPXcMqgBpA==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function creates a clock and parents it to another object with a given
name. It calls clock_setup_canonical_path before returning the new
clock.

This function is useful to create clocks in devices when one doesn't
want to expose it at the qdev level (as an input or an output).

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/clock.h | 13 +++++++++++++
 hw/core/clock.c    | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index c93e6113cd..81bcf3e505 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -93,10 +93,23 @@ extern const VMStateDescription vmstate_clock;
  *
  * compute the canonical path of the clock (used by log messages)
  */
 void clock_setup_canonical_path(Clock *clk);
 
+/**
+ * clock_new:
+ * @parent: the clock parent
+ * @name: the clock object name
+ *
+ * Helper function to create a new clock and parent it to @parent. There is no
+ * need to call clock_setup_canonical_path on the returned clock as it is done
+ * by this function.
+ *
+ * @return the newly created clock
+ */
+Clock *clock_new(Object *parent, const char *name);
+
 /**
  * clock_set_callback:
  * @clk: the clock to register the callback into
  * @cb: the callback function
  * @opaque: the argument to the callback
diff --git a/hw/core/clock.c b/hw/core/clock.c
index 81184734e0..8c6af223e7 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -21,10 +21,25 @@ void clock_setup_canonical_path(Clock *clk)
 {
     g_free(clk->canonical_path);
     clk->canonical_path = object_get_canonical_path(OBJECT(clk));
 }
 
+Clock *clock_new(Object *parent, const char *name)
+{
+    Object *obj;
+    Clock *clk;
+
+    obj = object_new(TYPE_CLOCK);
+    object_property_add_child(parent, name, obj);
+    object_unref(obj);
+
+    clk = CLOCK(obj);
+    clock_setup_canonical_path(clk);
+
+    return clk;
+}
+
 void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque)
 {
     clk->callback = cb;
     clk->callback_opaque = opaque;
 }
-- 
2.28.0


