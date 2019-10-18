Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F591CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC51F222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="27URdIHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC51F222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLU3M-00075E-0o
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrN-0006rc-GS
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrL-0000NJ-7Z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:09 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:38732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iLTr9-0000Gh-SQ; Fri, 18 Oct 2019 11:07:56 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 468AE96F58;
 Fri, 18 Oct 2019 15:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1571411274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFxNQUn0McvG51PcnwkNfFvA5jqi890S+3wkjQHe+/8=;
 b=27URdIHB6TSPjT8Qy6JOi2I08BboVxzVYJGprrFePLapYv9BFMvkWojvhWdBJ2T6o3WFUp
 +7Q/DRvHThrctze5Y7aGbRb6pQkAzNdljCUNzqsCKTkKPB2VSCDkEZ9VxIsdH3y7G7PKXw
 BNf/naAJjj9Gozu8eeqPbu3Vp4wlmbk=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/13] docs/devel/reset.txt: add doc about Resettable
 interface
Date: Fri, 18 Oct 2019 17:06:26 +0200
Message-Id: <20191018150630.31099-10-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1571411274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFxNQUn0McvG51PcnwkNfFvA5jqi890S+3wkjQHe+/8=;
 b=RaebG4Im9q8cYBr+akqghOzWHOoPMhiP2DUHcU8XcD+j4V2X+rng0SRKk13Yfc37Pn/2z/
 R2P/GGqEPlKCyxHXeRCjJHR2gtY3OhgiIGFgkSJ8Kfs8HYbcsJdtwfSo5ADf+uK4AY8tsd
 MM3EjqavCq7NvZK9erXyndS3dJ46yNE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1571411274; a=rsa-sha256; cv=none;
 b=UW9bKS3pFbvSHy+154rpVSeiLl53JB22b+rRTaCk/4Km7/0NI8v1JHofsPpbWqSqSBJ9ZG
 hUIZeDIPwGlvyqyaKk5eFQN3tHlFiVhuACWAwMl38a0+oUheOeovmICerqWP4MDyqraBST
 MEaYJ1eOZErPHC9i1Ay2kwDEtJCCUG8=
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
 berrange@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---

Should I add an entry into index.rst ?
---
 docs/devel/reset.rst | 282 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)
 create mode 100644 docs/devel/reset.rst

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
new file mode 100644
index 0000000000..a562720f55
--- /dev/null
+++ b/docs/devel/reset.rst
@@ -0,0 +1,282 @@
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
+``resettable_reset()``. These functions function takes two parameters: a=
 pointer
+to the object to reset and a reset type.
+
+Several types of reset will be supported. For now only cold reset is def=
ined,
+others may be added later. The Resettable interface handles reset types =
with an
+enum:
+
+``RESET_TYPE_COLD``
+  Cold reset is supported by every resettable object. In QEMU, it means =
we reset
+  to the initial state corresponding to the start of QEMU; this might di=
ffers
+  from what is a read hardware cold reset. It differs from other reset (=
like
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
+maintaining a count of reset; it is crucial to call
+``resettable_release_reset()`` one time and only one time per
+``resettable_assert_reset()`` call.
+
+For now migration of a device or bus in reset is not supported. Care mus=
t be
+taken not to delayed ``resettable_release_reset()`` from its
+``resettable_assert_reset()`` counterpart.
+
+Note that, since resettable is an interface, the API takes simple Object=
 as
+parameter. Still, it is a programming error to call a resettable functio=
n on a
+non-resettable object and it will trigger a run time assert error. Since=
 most
+call to resettable interface are done through base class functions, such=
 an
+error is not likely to happen.
+
+For Devices and Buses, the following helper functions exists:
+
+- ``device_cold_reset()``
+- ``bus_cold_reset()``
+
+These are simple wrappers around resettable_reset() function; they only =
cast the
+Device or Bus into an Object and pass the cold reset type. When possible
+prefer to use these functions instead ``resettable_reset()``.
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
+When resetting a several objects (for example the whole machine at simul=
ation
+startup), all first phases of all objects are executed, then all second =
phases
+and then all third phases.
+
+The three phases are:
+
+1. The **enter** phase is executed when the object enters reset. It rese=
t only
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
+the object has not to care how many reset controllers it has and how man=
y of
+them have started a reset.
+
+
+Handling reset in a resettable object
+-----------------------------------------
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
+backup mother class methods.
+
+Here follows an example to implement reset for a Device which set an IO =
while
+in reset.
+
+::
+
+    static void mydev_reset_enter(Object *obj, ResetType type)
+    {
+        MyDevClass *myclass =3D MYDEV_GET_CLASS(obj);
+        MyDevState *mydev =3D MYDEV(obj);
+        /* initialize local state only */
+        mydev->var =3D 0;
+        /* call mother class enter phase */
+        if (myclass->parent_phases.enter) {
+            myclass->parent_phases.enter(obj, type);
+        }
+    }
+
+    static void mydev_reset_hold(Object *obj)
+    {
+        MyDevClass *myclass =3D MYDEV_GET_CLASS(obj);
+        MyDevState *mydev =3D MYDEV(obj);
+        /* set an IO */
+        qemu_set_irq(mydev->irq, 1);
+        /* call mother class hold phase */
+        if (myclass->parent_phases.hold) {
+            myclass->parent_phases.hold(obj);
+        }
+    }
+
+    static void mydev_reset_exit(Object *obj)
+    {
+        MyDevClass *myclass =3D MYDEV_GET_CLASS(obj);
+        MyDevState *mydev =3D MYDEV(obj);
+        /* clear an IO */
+        qemu_set_irq(mydev->irq, 0);
+        /* call mother class exit phase */
+        if (myclass->parent_phases.exit) {
+            myclass->parent_phases.exit(obj);
+        }
+    }
+
+    typedef struct MyDevClass {
+        MyMotherClass mother_class;
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
+In the above example, we override the three phases. It is possible to ov=
erride
+only part of them by passing NULL instead of a function pointer to
+``resettable_class_set_parent_reset_phases()``. For example, the followi=
ng will
+only override the *enter* phase and leave *hold* and *exit* untouched::
+
+    resettable_class_set_parent_reset_phases(rc, mydev_reset_enter,
+                                             NULL, NULL,
+                                             &myclass->parent_phases);
+
+
+Polling the reset state
+.......................
+
+Resettable interface provide the ``resettable_is_in_reset()`` function.
+This function tells if the object parameter is currently under reset.
+
+An object is under reset from the beginning of the *init* phase to the e=
nd of
+*exit* phase. During all three phases, the function will return that the=
 object
+is in reset.
+
+This function may be used if behavior has to be adapted when receiving e=
xternal
+interaction while in reset state. Note that until migration of the reset=
 state
+is supported, an object should not be left in reset. So apart from being
+currently executing one of a reset phase, the only cases when this
+function should return true is if an external interaction is made during=
 *hold*
+or *exit* phase of another object in the same reset group.
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
+One thing so should be taken care of by the base class is handling reset
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
+This function can be used at anytime when not in a reset operation. Duri=
ng
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
+   removed in the bus hiearchy. At the moment, it occurs only in the ras=
pi
+   machines for chaning the sdbus used by sd card.
--=20
2.23.0


