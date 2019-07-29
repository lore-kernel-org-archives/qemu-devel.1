Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800F4C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A832171F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="3kMMFj44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A832171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7BG-0002ug-JN
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38171)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77X-0004Ky-AX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77S-0004pI-E5
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:25 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48150)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs779-0004Vq-SX; Mon, 29 Jul 2019 10:59:04 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id A5B2096F64;
 Mon, 29 Jul 2019 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zjkywh8rTkeW2vYa32FI1FfT0i/dE7XKbukqBz4qSmg=;
 b=3kMMFj44WWkbmqDk9NYg4jeoFrC7lZ0swuZVpb48eXFSM8oQEBe1if94My+cmjLuHMHixc
 I5v81RR1hB/rDBc2c37XdQ32Uky/GePiYRSEZLRO2IfOKh90cpf29HIG+v1xumFIvUcjWY
 8ox/03wBwoRpMkDE0s2RY+N2mGEPh6E=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:30 +0200
Message-Id: <20190729145654.14644-10-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zjkywh8rTkeW2vYa32FI1FfT0i/dE7XKbukqBz4qSmg=;
 b=55WNsGzCgyIe6MFJcmyAcXWHXG5y+h6LLrLAwQUBbv/6Jt/sx+8I4G1UMbI57EE4EoR4Jw
 5IuyySlAcqXzYZuBy97f2obHA4J/LZsWWEVCg2p/M/Qk2Kg8HqtoyZerSjtn0C0U5DT+3P
 h71IjpF2WB7tBRl+TwPc4NVWuE15qEA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412342; a=rsa-sha256; cv=none;
 b=Dvl/ff6nMFcqRQ9xsXaENPa2DsPrwZHTm20wZ9LvU9J8eeXSE841rWNYK080pxBNCAbUee
 gdjoP+BuSkCtnYEiZwNm9+OZLy9PkiXwLyCDZohcsiuL/zcBmDglrWeVcd0rzXy3jVaEme
 dQxRWXpFpvZZzX2r6RwA7WJTJgAzS5M=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 09/33] add doc about Resettable interface
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 docs/devel/reset.txt | 165 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 docs/devel/reset.txt

diff --git a/docs/devel/reset.txt b/docs/devel/reset.txt
new file mode 100644
index 0000000000..c7a1eb068f
--- /dev/null
+++ b/docs/devel/reset.txt
@@ -0,0 +1,165 @@
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
+The function *resettable_reset* is used to trigger a reset on a given
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
+typedef void (*ResettableInitPhase)(Object *obj);
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
+Theses methods should be updated when specializing an object. For this t=
he
+helper function *resettable_class_set_parent_reset_phases* can be used t=
o
+backup parent methods while changing the specialized ones.
+void resettable_class_set_parent_reset_phases(ResettableClass *rc,
+                                              ResettableInitPhase init,
+                                              ResettableHoldPhase hold,
+                                              ResettableExitPhase exit,
+
+For Devices and Buses, some helper exists to know if a device/bus is und=
er
+reset and what type of reset it is:
+```
+bool device_is_resetting(DeviceState *dev);
+bool device_is_reset_cold(DeviceState *dev);
+bool bus_is_resetting(BusState *bus);
+bool bus_is_reset_cold(BusState *bus);
+```
+
+
+Implementing the base Resettable behavior : Re-entrance, Hierarchy and C=
old/Warm
+------------------------------------------------------------------------=
--------
+
+There is five others methods in the interface to handle the base mechani=
cs
+of the Resettable interface. The methods should be implemented in object
+base class. DeviceClass and BusClass implement them.
+
+```
+typedef bool (*ResettableSetCold)(Object *obj, bool cold);
+typedef bool (*ResettableSetHoldNeeded)(Object *obj, bool hold_needed);
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
+    ResettableSetCold set_cold;
+    ResettableSetHoldNeeded set_hold_needed;
+    ResettableGetCount get_count;
+    ResettableIncrementCount increment_count;
+    ResettableDecrementCount decrement_count;
+    ResettableForeachChild foreach_child;
+} ResettableClass;
+```
+
+*set_cold* is used when entering reset, before calling the init phase, t=
o
+indicate the reset type.
+
+*set_hold_needed* is used to set/clear and retrieve an "hold_needed" fla=
g.
+This flag allows to omly execute the hold pahse when required.
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
+typedef enum DeviceResetActiveType {
+    DEVICE_RESET_ACTIVE_LOW,
+    DEVICE_RESET_ACTIVE_HIGH,
+} DeviceResetActiveType;
+void qdev_init_reset_gpio_in_named(DeviceState *dev, const char *name,
+                                   bool cold, DeviceResetActiveType type=
);
+```
--=20
2.22.0


