Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE2BC28CC3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED52823CCB
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="43MGdX14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED52823CCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCP6-00080l-7a
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:35:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCG1-0000dA-Qh
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFy-0003gU-Tc
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:52 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hYCFu-0003Xk-61; Tue, 04 Jun 2019 12:25:46 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.17.10.6])
	by beetle.greensocs.com (Postfix) with ESMTPSA id A3A9C96F62;
	Tue,  4 Jun 2019 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1559665545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=uEF2McHRjJAqSo5QcKbdG0zwjTeD+AMnzAukkEqETLw=;
	b=43MGdX14BxD16FUKTvZJ7yI+l/WUtXXPHuHI6naj/Ujy6TqVc+MUt1jyt5aPTiHQxXmVZJ
	KzPJ6FWTR8kHxG9gVhxff4fenUTy5cStzcyZ1DRozsSfi//KTnJo5tpd5jouro3koxnOdk
	WScFg/Z/y7Pf1nzlEW/yjpk8CMl4KJo=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 18:25:21 +0200
Message-Id: <20190604162526.10655-8-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604162526.10655-1-damien.hedde@greensocs.com>
References: <20190604162526.10655-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1559665545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=uEF2McHRjJAqSo5QcKbdG0zwjTeD+AMnzAukkEqETLw=;
	b=6wdXnTdvGspYn3s+hUmdSEIpGspL1tZkdxPe32kaZDDgWJimGMJJHedqKasFlSbgDLU1bh
	XrzBfrMvQH/4173HASA9qXjQtpGinQLvhPP9rYphNIIgoOtvYQBOitJfD6Eo3Q7vqVjCgC
	ref3jwKR+ySNJDqNZq3pmTMgGe4SHoA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1559665545; a=rsa-sha256; cv=none;
	b=PjdtQBxCQ2hT4Yq4GvYBuTt64xpttCGCfvcdcbgekpIZ3VYn/tH8VN8Jvcnti3teKu7b1W
	g20RU1zcxX/1s0PRWeClPH1llf6RO3wMZsev8AEKPkAFfnY9DSLgBIyhjScqmJcHE73hZE
	rPoAigC7pQK3bqsltJVA7quOGssSAtc=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH v2 07/12] add doc about Resettable interface
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org,
	marc.burton@greensocs.com, alistair@alistair23.me,
	qemu-arm@nongnu.org, Damien Hedde <damien.hedde@greensocs.com>,
	marcandre.lureau@redhat.com, pbonzini@redhat.com,
	philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 docs/devel/reset.txt | 151 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 docs/devel/reset.txt

diff --git a/docs/devel/reset.txt b/docs/devel/reset.txt
new file mode 100644
index 0000000000..32c211d8ca
--- /dev/null
+++ b/docs/devel/reset.txt
@@ -0,0 +1,151 @@
+
+=3D=3D=3D=3D=3D
+Reset
+=3D=3D=3D=3D=3D
+
+The reset of qemu objects is handled using the Resettable interface decl=
ared
+in *include/hw/resettable.h*.
+As of now DeviceClass and BusClass implement this interface.
+
+
+Triggering reset
+----------------
+
+The function *resettable_reset* must be used to trigger a reset on a giv=
en
+object.
+void resettable_reset(Object *obj, bool cold)
+
+The parameter *obj* must implement the Resettable interface.
+The parameter *cold* is a boolean specifying whether to do a cold or war=
m
+reset
+
+For Devices and Buses there is also the corresponding helpers:
+void device_reset(Device *dev, bool cold)
+void bus_reset(Device *dev, bool cold)
+
+If one wants to put an object into a reset state. There is the
+*resettable_assert_reset* function.
+void resettable_assert_reset(Object *obj, bool cold)
+
+One must eventually call the function *resettable_deassert_reset* to end=
 the
+reset state:
+void resettable_deassert_reset(Object *obj, bool cold)
+
+Calling *resettable_assert_reset* then *resettable_deassert_reset* is th=
e
+same as calling *resettable_reset*.
+
+It is possible to interleave multiple calls to
+ - resettable_reset,
+ - resettable_assert_reset, and
+ - resettable_deassert_reset.
+The only constraint is that *resettable_deassert_reset* must be called o=
nce
+per *resettable_assert_reset* call so that the object leaves the reset s=
tate.
+
+Therefore there may be several reset sources/controllers of a given obje=
ct.
+The interface handle everything and the controllers do not need to know
+anything about each others. The object will leave reset state only when =
all
+controllers released their reset.
+
+All theses functions must called while holding the iothread lock.
+
+
+Implementing reset for a Resettable object : Multi-phase reset
+--------------------------------------------------------------
+
+The Resettable uses a multi-phase mechanism to handle some ordering cons=
traints
+when resetting multiple object at the same time. For a given object the =
reset
+procedure is split into three different phases executed in order:
+ 1 INIT: This phase should set/reset the state of the Resettable it has =
when is
+         in reset state. Side-effects to others object is forbidden (suc=
h as
+         setting IO level).
+ 2 HOLD: This phase corresponds to the external side-effects due to stay=
ing into
+         the reset state.
+ 3 EXIT: This phase corresponds to leaving the reset state. It have both
+         local and external effects.
+
+*resettable_assert_reset* does the INIT and HOLD phases. While
+*resettable_deassert_reset* does the EXIT phase.
+
+When resetting multiple object at the same time. The interface executes =
the
+given phase of the objects before going to the next phase. This guarante=
e that
+all INIT phases are done before any HOLD phase and so on.
+
+There is three methods in the interface so must be implemented in an obj=
ect.
+The methods corresponds to the three phases:
+```
+typedef void (*ResettableInitPhase)(Object *obj, bool cold);
+typedef void (*ResettableHoldPhase)(Object *obj);
+typedef void (*ResettableExitPhase)(Object *obj);
+typedef struct ResettableClass {
+    InterfaceClass parent_class;
+
+    struct ResettablePhases {
+        ResettableInitPhase init;
+        ResettableHoldPhase hold;
+        ResettableExitPhase exit;
+    } phases;
+    [...]
+} ResettableClass;
+```
+
+Note that only the init method takes the bool parameter, if the warm/col=
d
+information is needed by other methods it should be stored somewhere in =
the
+object state.
+
+Theses methods should be updated when specializing an object. For this t=
he
+helper function *resettable_class_set_parent_reset_phases* can be used t=
o
+backup parent methods while changing the specialized ones.
+void resettable_class_set_parent_reset_phases(ResettableClass *rc,
+                                              ResettableInitPhase init,
+                                              ResettableHoldPhase hold,
+                                              ResettableExitPhase exit,
+                                              ResettablePhases *parent_p=
hases);
+
+
+Implementing the base Resettable behavior : Re-entrance and Hierarchy
+---------------------------------------------------------------------
+
+There is four others methods in the interface to handle the base mechani=
cs
+of the Resettable interface. The methods should be implemented in object
+base class. DeviceClass and BusClass implement them.
+
+```
+typedef uint32_t (*ResettableGetCount)(Object *obj);
+typedef uint32_t (*ResettableIncrementCount)(Object *obj);
+typedef uint32_t (*ResettableDecrementCount)(Object *obj);
+typedef void (*ResettableForeachChild)(Object *obj, void (*visitor)(Obje=
ct *));
+typedef struct ResettableClass {
+    InterfaceClass parent_class;
+
+    [...]
+
+    ResettableGetCount get_count;
+    ResettableIncrementCount increment_count;
+    ResettableDecrementCount decrement_count;
+    ResettableForeachChild foreach_child;
+} ResettableClass;
+```
+
+As stated above, several reset procedures can be concurrent on an object=
.
+This is handled with the three methods *get_count*, *increment_count* an=
d
+*decrement_count*. An object is in reset state if the count is non-zero.
+
+The reset hierarchy is handled using the *foreach_child* method. This me=
thod
+executes a given function on every reset "child".
+
+In DeviceClass and BusClass the base behavior is to mimic the legacy qde=
v
+reset. Reset hierarchy follows the qdev/qbus tree.
+
+Reset control through GPIO
+--------------------------
+
+For devices, two reset inputs can be added: one for the cold, one the wa=
rm
+reset. This is done using the following function.
+```
+typedef enum DeviceActiveType {
+    DEVICE_ACTIVE_LOW,
+    DEVICE_ACTIVE_HIGH,
+} DeviceActiveType;
+void qdev_init_reset_gpio_in_named(DeviceState *dev, const char *name,
+                                   bool cold, DeviceActiveType type);
+```
--=20
2.21.0


