Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7865EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3442522D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="KA34+g8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3442522D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0TnE-000443-UA
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0TZe-0006sy-70
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0TZc-0005dE-2W
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:02 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i0TZb-0005cG-QP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:00 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 81F2D96F53;
 Wed, 21 Aug 2019 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1566405298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5s3g+eOtJnwndxxC6fRoKzELDl+Nr+QvbKDkRFoK0lY=;
 b=KA34+g8+D/lNpDybKrqki0WeQbTgsEc785IbxS4FjTxSty6pPi47bamytRWGQnEouhZ9k/
 y1hNN3wmcSTLrShIUDOvmlpMm1jfnyx6TFqxlv5jugsio4ypMNyJD184YuIwowskIeALxH
 uoKc/gG+KqclQ/YkTQh3xP5NU2KjRZU=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:33:35 +0200
Message-Id: <20190821163341.16309-5-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821163341.16309-1-damien.hedde@greensocs.com>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1566405298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5s3g+eOtJnwndxxC6fRoKzELDl+Nr+QvbKDkRFoK0lY=;
 b=cHMrXL3oSWGuYmRkZrUWJ7rOVUguSLrNJrAYvPUjWNIpet4oOX4EQdEe7jd7GuxjVLMiuF
 YCgwurv0LllmyECsuh+LRGcpiNHlkxEMRM3RhhqQ42EgbDCu54AJacgLt3ddmz2LMcKuwr
 hmxufvyvzubTjd53NSevZtF+30Fzh6Q=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1566405299; a=rsa-sha256; cv=none;
 b=2Ar5XziUDI9kXbdIS3NcX6aKYGudLi+ShHtLpoyT79VYH+AACYUj/5kCd4ssmAAzRSLNXY
 XjZO2hOnElN8kTSflSFVwPhNlZIRHTciFCOSQIftsiy3Hv9f/GiIfR5Zt7nBO6hNtVL8CQ
 faaiS8XejOadW+wJ4S+ziGSlU+RXrz8=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v4 04/10] docs/devel/reset.txt: create doc
 about Resettable interface
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 edgar.iglesias@xilinx.com, berrange@redhat.com, ehabkost@redhat.com,
 mark.burton@greensocs.com, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It documents only the multi-phase mechanism with one reset possible type
(cold). Other features will be documented by further commits.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 docs/devel/reset.txt | 237 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)
 create mode 100644 docs/devel/reset.txt

diff --git a/docs/devel/reset.txt b/docs/devel/reset.txt
new file mode 100644
index 0000000000..77ff29b3d7
--- /dev/null
+++ b/docs/devel/reset.txt
@@ -0,0 +1,237 @@
+
+=3D=3D=3D=3D=3D
+Reset
+=3D=3D=3D=3D=3D
+
+The reset of qemu objects is handled using the Resettable interface decl=
ared
+in *include/hw/resettable.h*.
+
+This interface allows to group objects (on a tree basis) and to reset th=
e
+whole group consistently. Each individual member object does not have to=
 care
+about others; in particular problems of order (which object is reset fir=
st)
+are addressed.
+
+As of now DeviceClass and BusClass implement this interface.
+
+
+Reset types
+-----------
+
+There are several kinds of reset. The most obvious one is the "cold" res=
et: a
+"cold" reset is the operation resulting of a power cycle (when we apply =
the
+power).
+
+By opposition, we call a "warm" reset, a reset operation not resulting o=
f a
+power cycle; it can be triggered by a gpio or a software operation.
+
+Some buses also define specific kinds of reset.
+
+What does a reset is device-dependent. For most devices, cold or warm re=
set
+makes no difference. But there can be some; some configuration may be ke=
pt when
+applying a warm reset for example.
+
+The Resettable interface handles reset kinds with an enum. For now only =
cold
+reset is defined, others may be added later.
+```
+typedef enum ResetType {
+    RESET_TYPE_COLD,
+} ResetType;
+```
+
+In qemu, RESET_TYPE_COLD means we reset to the initial state correspondi=
ng to
+the start of qemu; this might differs from what is a read hardware cold =
reset.
+
+
+Triggering reset
+----------------
+
+This section documents the APIs which "users" of a resettable object sho=
uld use
+to control it. All resettable control functions must be called while hol=
ding
+the iothread lock.
+
+You can trigger a reset event on a resettable object with resettable_res=
et().
+The object will be instantly reset.
+
+```void resettable_reset(Object *obj, ResetType type);```
+The parameter "obj" is an object implementing the Resettable interface.
+The parameter "type" gives the type of reset you want to trigger.
+
+It is possible to interleave multiple calls to
+ - resettable_reset().
+
+There may be several reset sources/controllers of a given object. The in=
terface
+handles everything and the different reset controllers do not need to kn=
ow
+anything about each others. The object will leave reset state only when =
each
+other controllers end their reset operation. This point is handled by
+maintaining a count of reset.
+
+Note that it is a programming error to call a resettable function on a
+non-Resettable object and it will trigger a run time assert error. Since=
 most
+call to Resettable interface are done through base class functions, such=
 an
+error is not likely to happen.
+
+For Devices and Buses, the following helper functions exists:
+```
+void device_cold_reset(Device *dev);
+void bus_cold_reset(Bus *bus);
+```
+
+These are simple wrappers around resettable_reset() function; they only =
cast the
+Device or Bus into an Object and add the corresponding reset type.
+
+Device and bus functions co-exist because there can be semantic differen=
ces
+between resetting a bus and resetting the controller bridge which owns i=
t.
+For example, considering a SCSI controller. Resetting the controller put=
s all
+its registers back to what reset state was as well as reset everything o=
n the
+SCSI bus. Whereas resetting just the SCSI bus only resets everything tha=
t's on
+it but not the controller.
+
+
+How it works: multi-phase reset
+-------------------------------
+
+This section documents the internals of the resettable interface.
+
+The resettable interface uses a multi-phase system to relieve objects an=
d
+machines from reset ordering problems. To address this, the reset operat=
ion
+of an object is split into 3 well defined phases.
+
+When resetting a several objects (for example the whole machine at simul=
ation
+startup), all 1st phases of all objects are executed, then all 2nd phase=
s and
+then all 3rd phases.
+
+The 3 phases are:
+
+  1. INIT: This phase is executed when the object enters reset. It shoul=
d reset
+  local state of the object, but it must not do anything that has a side=
-effect
+  on other objects, such as raising or lowering a qemu_irq line or readi=
ng or
+  writing guest memory.
+
+  2. HOLD: This phase is executed for entry into reset, once every objec=
t in the
+  system which is being reset has had its init phase executed. At this p=
oint
+  devices can do actions that affect other objects.
+
+  3. EXIT: This phase is executed when the object leaves the reset state=
.
+  Actions affecting other objects are permitted.
+
+As said in previous section, the interface maintains a count of reset. T=
his
+count is used to ensure phases are executed only when required.
+init and hold phases are executed only when entering reset for the first=
 time
+(if an object is already in reset state when calling resettable_assert_r=
eset()
+or resettable_reset(), they are not executed).
+The exit phase is executed only when the last reset operation ends. Ther=
efore
+the object has not to care how many reset controllers it has and how man=
y of
+them have started a reset.
+
+
+Handling reset in a new resettable object
+-----------------------------------------
+
+This section documents the APIs that an implementation of a resettable o=
bject
+must provide and what functions it has access to.
+
+There are three methods in the interface that must be implemented in an
+resettable object.
+The methods correspond to the three phases described in the previous sec=
tion:
+```
+typedef void (*ResettableInitPhase)(Object *obj, ResetType type);
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
+All phases takes a pointer to the object as first argument. The init pha=
se also
+takes the reset type.
+
+These methods should be updated when specializing an object. For this th=
e
+helper function resettable_class_set_parent_phases() can be used to "bac=
kup"
+parent methods while changing the specialized ones:
+
+
+```
+void resettable_class_set_parent_reset_phases(ResettableClass *rc,
+                                              ResettableInitPhase init,
+                                              ResettableHoldPhase hold,
+                                              ResettableExitPhase exit,
+                                              ResettablePhases *parent_p=
hases);
+```
+"rc" argument is the interface class structure; "init", "hold" and "exit=
" are
+the specialized phase methods for the object; and "parent_phases" is an
+allocated space (typically in the specialized object class) to backup th=
e
+parent phases. This function only do the backup and update operation for=
 phase
+arguments that are non-NULL; you can use it to specialize only the init =
method
+for example. When you specialize a method, it's on you to call or not th=
e parent
+method inside the specialized one.
+
+If for some operation in the object, you need to know the reset state, t=
here is
+a function to access that:
+```
+bool resettable_is_resetting(Object *obj);
+```
+
+resettable_is_resetting() tells if the resettable object is currently un=
der
+reset.
+
+Helpers are defined for devices and buses that wrap resettable_is_resett=
ing():
+```
+bool device_is_resetting(DeviceState *dev);
+bool bus_is_resetting(BusState *bus);
+```
+
+
+Base class handling of reset
+----------------------------
+
+This section documents parts of the reset mechanism that you only need t=
o know
+about if you are extending it to work with a new base class other than
+DeviceClass or BusClass, or maintaining the existing code in those class=
es. Most
+people can ignore it.
+
+There are two other methods that need to exist in a class implementing t=
he
+interface.
+
+```
+typedef struct ResetState {
+    uint32_t count;
+    bool hold_phase_needed;
+} ResetState;
+
+typedef ResetState *(*ResettableGetState)(Object *obj);
+typedef void (*ResettableForeachChild)(Object *obj,
+                                       void (*visitor)(Object *, ResetTy=
pe),
+                                       ResetType type);
+typedef struct ResettableClass {
+    InterfaceClass parent_class;
+
+    [...]
+
+    ResettableGetState get_state;
+    ResettableForeachChild foreach_child;
+} ResettableClass;
+```
+
+get_state() must return a pointer to an allocated ResetState structure.
+This structure is used by the interface to store the information require=
d
+to handle reset properly. This structure must not be modified by the obj=
ect
+directly. The object must handle eventual allocation/deallocation of thi=
s
+structure during its creation and deletion. Typically it is located in t=
he
+object state structure.
+
+The reset hierarchy is handled by means of the foreach_child() method. T=
his
+method executes a given function on all reset children. An additional ty=
pe
+argument is given to foreach_child() and must be passed to the function.
+
+In DeviceClass and BusClass the ResetState structure is located
+DeviceState/BusState structure. foreach_child() is implemented to follow=
 the bus
+hierarchy; for a bus, it calls the function on every child device; for a=
 device,
+it calls the function on every bus child. So when we reset the main syst=
em bus,
+we reset the whole machine bus tree.
--=20
2.22.0


