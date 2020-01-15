Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B00C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD85D2073A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="XEY0LYNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD85D2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iriKK-0004un-Lz
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1irhul-0002OQ-NC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1irhuj-00038j-BA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:36:51 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:53614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1irhuj-00037H-1o; Wed, 15 Jan 2020 07:36:49 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 7C42396F58;
 Wed, 15 Jan 2020 12:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579091808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UABU9vf9nTWDxAMmzQJR2hWfoLnQjqdoMOxfTfB4I0M=;
 b=XEY0LYNJO6WN4s6Xgp3SlNlct1tgBDo3ecHjmCCnw4VkW1qwyY5GWdxDQpkLduKk3S9paq
 pfzPR7PDm5G0yRqUgxTLngbV4uzMVofRvlq1JGuaQ/j9cp8v4Pw7j/loNZRzNyo0PjGfyk
 Q5cM9Tt2p0G2RnJMnOIN+Q+HtK+6AXY=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/11] docs/devel/reset.rst: add doc about Resettable
 interface
Date: Wed, 15 Jan 2020 13:36:18 +0100
Message-Id: <20200115123620.250132-10-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115123620.250132-1-damien.hedde@greensocs.com>
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579091808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UABU9vf9nTWDxAMmzQJR2hWfoLnQjqdoMOxfTfB4I0M=;
 b=O1RYK25j2egifdUV3bLd8yqJOw3vYcXD18tGrbG7zR/UniL5lPaZNQDPhgIlzu3r3UEuEq
 qBS9aqmppgX6OhpqQHGnfyIjYnAXEiXQl4eeJp99V0CHE9PDYIqpLU+EalpBtLrUdG9jFc
 PmdWR1n/YAQPP76V7wt7D4YBKNZ5dGg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579091808; a=rsa-sha256; cv=none;
 b=Tumyld/yySA1rhZTFcPvJ+hWxiI74taMeA9mmHkM23t3CwwLxu25GOIYhi5wAzI5Rmf1VY
 Lr6Hzbuxqig3WIbUMwtStCeB18x2WkWMzVzRXoGNwAESZpRnCz78qBHAbu5cGW8b7Ca1+C
 olGAmL9qhtVA5NX+hjhZTwxJN87Fsno=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
 berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/index.rst |   1 +
 docs/devel/reset.rst | 289 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 290 insertions(+)
 create mode 100644 docs/devel/reset.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index ac862152dc..4dc2ca8d71 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -24,3 +24,4 @@ Contents:
    tcg
    tcg-plugins
    bitops
+   reset
diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
new file mode 100644
index 0000000000..abea1102dc
--- /dev/null
+++ b/docs/devel/reset.rst
@@ -0,0 +1,289 @@
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Reset in QEMU: the Resettable interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The reset of qemu objects is handled using the resettable interface decl=
ared
+in ``include/hw/resettable.h``.
+
+This interface allows objects to be grouped (on a tree basis); so that t=
he
+whole group can be reset consistently. Each individual member object doe=
s not
+have to care about others; in particular, problems of order (which objec=
t is
+reset first) are addressed.
+
+As of now DeviceClass and BusClass implement this interface.
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
+You can apply a reset to an object using ``resettable_assert_reset()``. =
You need
+to call ``resettable_release_reset()`` to release the object from reset.=
 To
+instantly reset an object, without keeping it in reset state, just call
+``resettable_reset()``. These functions take two parameters: a pointer t=
o the
+object to reset and a reset type.
+
+Several types of reset will be supported. For now only cold reset is def=
ined;
+others may be added later. The Resettable interface handles reset types =
with an
+enum:
+
+``RESET_TYPE_COLD``
+  Cold reset is supported by every resettable object. In QEMU, it means =
we reset
+  to the initial state corresponding to the start of QEMU; this might di=
ffer
+  from what is a real hardware cold reset. It differs from other resets =
(like
+  warm or bus resets) which may keep certain parts untouched.
+
+Calling ``resettable_reset()`` is equivalent to calling
+``resettable_assert_reset()`` then ``resettable_release_reset()``. It is
+possible to interleave multiple calls to these three functions. There ma=
y
+be several reset sources/controllers of a given object. The interface ha=
ndles
+everything and the different reset controllers do not need to know anyth=
ing
+about each others. The object will leave reset state only when each othe=
r
+controllers end their reset operation. This point is handled internally =
by
+maintaining a count of in-progress resets; it is crucial to call
+``resettable_release_reset()`` one time and only one time per
+``resettable_assert_reset()`` call.
+
+For now migration of a device or bus in reset is not supported. Care mus=
t be
+taken not to delay ``resettable_release_reset()`` after its
+``resettable_assert_reset()`` counterpart.
+
+Note that, since resettable is an interface, the API takes a simple Obje=
ct as
+parameter. Still, it is a programming error to call a resettable functio=
n on a
+non-resettable object and it will trigger a run time assert error. Since=
 most
+calls to resettable interface are done through base class functions, suc=
h an
+error is not likely to happen.
+
+For Devices and Buses, the following helper functions exist:
+
+- ``device_cold_reset()``
+- ``bus_cold_reset()``
+
+These are simple wrappers around resettable_reset() function; they only =
cast the
+Device or Bus into an Object and pass the cold reset type. When possible
+prefer to use these functions instead of ``resettable_reset()``.
+
+Device and bus functions co-exist because there can be semantic differen=
ces
+between resetting a bus and resetting the controller bridge which owns i=
t.
+For example, consider a SCSI controller. Resetting the controller puts a=
ll
+its registers back to what reset state was as well as reset everything o=
n the
+SCSI bus, whereas resetting just the SCSI bus only resets everything tha=
t's on
+it but not the controller.
+
+
+Multi-phase mechanism
+---------------------
+
+This section documents the internals of the resettable interface.
+
+The resettable interface uses a multi-phase system to relieve objects an=
d
+machines from reset ordering problems. To address this, the reset operat=
ion
+of an object is split into three well defined phases.
+
+When resetting several objects (for example the whole machine at simulat=
ion
+startup), all first phases of all objects are executed, then all second =
phases
+and then all third phases.
+
+The three phases are:
+
+1. The **enter** phase is executed when the object enters reset. It rese=
ts only
+   local state of the object; it must not do anything that has a side-ef=
fect
+   on other objects, such as raising or lowering a qemu_irq line or read=
ing or
+   writing guest memory.
+
+2. The **hold** phase is executed for entry into reset, once every objec=
t in the
+   group which is being reset has had its *enter* phase executed. At thi=
s point
+   devices can do actions that affect other objects.
+
+3. The **exit** phase is executed when the object leaves the reset state=
.
+   Actions affecting other objects are permitted.
+
+As said in previous section, the interface maintains a count of reset. T=
his
+count is used to ensure phases are executed only when required. *enter* =
and
+*hold* phases are executed only when asserting reset for the first time
+(if an object is already in reset state when calling
+``resettable_assert_reset()`` or ``resettable_reset()``, they are not
+executed).
+The *exit* phase is executed only when the last reset operation ends. Th=
erefore
+the object does not need to care how many of reset controllers it has an=
d how
+many of them have started a reset.
+
+
+Handling reset in a resettable object
+-------------------------------------
+
+This section documents the APIs that an implementation of a resettable o=
bject
+must provide and what functions it has access to. It is intended for peo=
ple
+who want to implement or convert a class which has the resettable interf=
ace;
+for example when specializing an existing device or bus.
+
+Methods to implement
+....................
+
+Three methods should be defined or left empty. Each method corresponds t=
o a
+phase of the reset; they are name ``phases.enter()``, ``phases.hold()`` =
and
+``phases.exit()``. They all take the object as parameter. The *enter* me=
thod
+also take the reset type as second parameter.
+
+When extending an existing class, these methods may need to be extended =
too.
+The ``resettable_class_set_parent_phases()`` class function may be used =
to
+backup parent class methods.
+
+Here follows an example to implement reset for a Device which sets an IO=
 while
+in reset.
+
+::
+
+    static void mydev_reset_enter(Object *obj, ResetType type)
+    {
+        MyDevClass *myclass =3D MYDEV_GET_CLASS(obj);
+        MyDevState *mydev =3D MYDEV(obj);
+        /* call parent class enter phase */
+        if (myclass->parent_phases.enter) {
+            myclass->parent_phases.enter(obj, type);
+        }
+        /* initialize local state only */
+        mydev->var =3D 0;
+    }
+
+    static void mydev_reset_hold(Object *obj)
+    {
+        MyDevClass *myclass =3D MYDEV_GET_CLASS(obj);
+        MyDevState *mydev =3D MYDEV(obj);
+        /* call parent class hold phase */
+        if (myclass->parent_phases.hold) {
+            myclass->parent_phases.hold(obj);
+        }
+        /* set an IO */
+        qemu_set_irq(mydev->irq, 1);
+    }
+
+    static void mydev_reset_exit(Object *obj)
+    {
+        MyDevClass *myclass =3D MYDEV_GET_CLASS(obj);
+        MyDevState *mydev =3D MYDEV(obj);
+        /* call parent class exit phase */
+        if (myclass->parent_phases.exit) {
+            myclass->parent_phases.exit(obj);
+        }
+        /* clear an IO */
+        qemu_set_irq(mydev->irq, 0);
+    }
+
+    typedef struct MyDevClass {
+        MyParentClass parent_class;
+        /* to store eventual parent reset methods */
+        ResettablePhases parent_phases;
+    } MyDevClass;
+
+    static void mydev_class_init(ObjectClass *class, void *data)
+    {
+        MyDevClass *myclass =3D MYDEV_CLASS(class);
+        ResettableClass *rc =3D RESETTABLE_CLASS(class);
+        resettable_class_set_parent_reset_phases(rc,
+                                                 mydev_reset_enter,
+                                                 mydev_reset_hold,
+                                                 mydev_reset_exit,
+                                                 &myclass->parent_phases=
);
+    }
+
+In the above example, we override all three phases. It is possible to ov=
erride
+only some of them by passing NULL instead of a function pointer to
+``resettable_class_set_parent_reset_phases()``. For example, the followi=
ng will
+only override the *enter* phase and leave *hold* and *exit* untouched::
+
+    resettable_class_set_parent_reset_phases(rc, mydev_reset_enter,
+                                             NULL, NULL,
+                                             &myclass->parent_phases);
+
+This is equivalent to providing a trivial implementation of the hold and=
 exit
+phases which does nothing but call the parent class's implementation of =
the
+phase.
+
+Polling the reset state
+.......................
+
+Resettable interface provides the ``resettable_is_in_reset()`` function.
+This function returns true if the object parameter is currently under re=
set.
+
+An object is under reset from the beginning of the *init* phase to the e=
nd of
+the *exit* phase. During all three phases, the function will return that=
 the
+object is in reset.
+
+This function may be used if the object behavior has to be adapted
+while in reset state. For example if a device has an irq input,
+it will probably need to ignore it while in reset; then it can for
+example check the reset state at the beginning of the irq callback.
+
+Note that until migration of the reset state is supported, an object
+should not be left in reset. So apart from being currently executing
+one of the reset phases, the only cases when this function will return
+true is if an external interaction (like changing an io) is made during
+*hold* or *exit* phase of another object in the same reset group.
+
+Helpers ``device_is_in_reset()`` and ``bus_is_in_reset()`` are also prov=
ided
+for devices and buses and should be preferred.
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
+Methods to implement
+....................
+
+There are two other methods that need to exist in a class implementing t=
he
+interface: ``get_state()`` and ``child_foreach()``.
+
+``get_state()`` is simple. *resettable* is an interface and, as a conseq=
uence,
+does not have any class state structure. But in order to factorize the c=
ode, we
+need one. This method must return a pointer to ``ResettableState`` struc=
ture.
+The structure must be allocated by the base class; preferably it should =
be
+located inside the object instance structure.
+
+``child_foreach()`` is more complex. It should execute the given callbac=
k on
+every reset child of the given resettable object. All children must be
+resettable too. Additional parameters (a reset type and an opaque pointe=
r) must
+be passed to the callback too.
+
+In ``DeviceClass`` and ``BusClass`` the ``ResettableState`` is located
+``DeviceState`` and ``BusState`` structure. ``child_foreach()`` is imple=
mented
+to follow the bus hierarchy; for a bus, it calls the function on every c=
hild
+device; for a device, it calls the function on every bus child. When we =
reset
+the main system bus, we reset the whole machine bus tree.
+
+Changing a resettable parent
+............................
+
+One thing which should be taken care of by the base class is handling re=
set
+hierarchy changes.
+
+The reset hierarchy is supposed to be static and built during machine cr=
eation.
+But there are actually some exceptions. To cope with this, the resettabl=
e API
+provides ``resettable_change_parent()``. This function allows to set, up=
date or
+remove the parent of a resettable object after machine creation is done.=
 As
+parameters, it takes the object being moved, the old parent if any and t=
he new
+parent if any.
+
+This function can be used at any time when not in a reset operation. Dur=
ing
+a reset operation it must be used only in *hold* phase. Using it in *ent=
er* or
+*exit* phase is an error.
+Also it should not be used during machine creation, although it is harml=
ess to
+do so: the function is a no-op as long as old and new parent are NULL or=
 not
+in reset.
+
+There is currently 2 cases where this function is used:
+
+1. *device hotplug*; it means a new device is introduced on a live bus.
+
+2. *hot bus change*; it means an existing live device is added, moved or
+   removed in the bus hierarchy. At the moment, it occurs only in the ra=
spi
+   machines for changing the sdbus used by sd card.
--=20
2.24.1


