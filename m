Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543DFC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A852223C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/Y2B4Zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A852223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTIr-0002oh-8f
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 11:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPTI3-0002G8-Vx
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPTI0-0002Y8-Rc
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:52:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPTI0-0002Xi-II
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:52:24 -0400
Received: by mail-oi1-x241.google.com with SMTP id 8so2450674oiy.6
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ke5CrWpmx7T7ACjOHpwUtx7SqOrvA4Sg0rRieSMQTwY=;
 b=q/Y2B4Zorip5j6i9FpLcZ1bA7SCB39/t+RWEXAwn13ERMRQZl9bWNNFBfhYuaf4R/N
 avt3zCTDoowPpdUM5cgO9kGM7GPcshcCkGiPXzniWHLWEtha/2X2FOrRvKSyTVFfY+2+
 HvFGfsOgEF8a9ev1hSNu6KZQdxlLIWjBOfM/XoT82qK0clh0agwNjHKdcrKdNPOUjQPz
 Pp2utLV9sraPoX9L5coa2z0qxxBADZivJN9NX6yno5RaL7VzQZ2LhQs2pybum/4sjyia
 5xD7lQnSkjXD8DFYTTlpMtMRoEDIFVjf0hvJ3bMpU0XIpg4JdNrq48xy3N5OoacLSw+j
 fsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ke5CrWpmx7T7ACjOHpwUtx7SqOrvA4Sg0rRieSMQTwY=;
 b=hIpN7k6Q8plO08n2J6e1jIfBgfnIJAFD1YIx/tEi/3VLK8Y6AcNsmjBuful2hCNShy
 FLGn7OiJDZ0YFtL1bsh0SCDZ6x/59U8avPeAjKz/KqDSeUcFxDq5nWWxp8Meea2teN9S
 sFOlrs6910/ZVgLxs5yttDcFo7pNIvCvGxKkx8D0cdidEThuzASVKWdaQWJmt8CZ6pKT
 KFbLV2lHGpsf/TiVQcM9TMQqerXowmvxXTutX99e7dx2WNeUR+klXkdIUvFxRw0C08fN
 jXHtnzMTHDRueRkycapPZEu6ZvXDVSxprzUWfyCjbtgWozWjP10Zp8mTldy/D1SRUZby
 EZyg==
X-Gm-Message-State: AGi0PuY5IazOvwxPjdvtZYsGUfFqS0GrL3dNlPBkNhTrqut8CT85Kjjs
 Ht3dDCViFLc8yAuAYetyHWkO9ky7RFFhhcjrVmeszA==
X-Google-Smtp-Source: APiQypLY7TMOcjLoX8O93w9YxEjRsOAohDgcJgZxCn9KdNBce0TGWJjjN+Vc5msqUzZMs6uDEo9aerHiQbmYG4Xkc7c=
X-Received: by 2002:aca:c751:: with SMTP id x78mr1559284oif.163.1587138743434; 
 Fri, 17 Apr 2020 08:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200406135251.157596-1-damien.hedde@greensocs.com>
 <20200406135251.157596-6-damien.hedde@greensocs.com>
In-Reply-To: <20200406135251.157596-6-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 16:52:11 +0100
Message-ID: <CAFEAcA_NVJg9KS-yrYDKe0GbAC7xah6mH1SmkjLmyr-BNPF8WQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] docs/clocks: add device's clock documentation
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Apr 2020 at 14:53, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Add the documentation about the clock inputs and outputs in devices.
>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

I did an edit pass on this to address minor grammar/style
issues and some Sphinx syntax stuff (notably, using
"code-block:: c" renders nicer than a plain literal block).
Diff against this patch is below; it looks bigger than
you might expect because one of the changes was that I
rewrapped some of the paragraphs that were close to or
over 80 chars per line. Changes include the tweak Markus
asked for.


From 995ea4cf6b815e3efe2dff93723d69b08418ff9b Mon Sep 17 00:00:00 2001
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 15:26:59 +0100
Subject: [PATCH] !fixup docs edit

---
 docs/devel/clocks.rst | 241 ++++++++++++++++++++++++------------------
 1 file changed, 136 insertions(+), 105 deletions(-)

diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index ead9f55561c..e5da28e2111 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -1,26 +1,27 @@
-Modeling a clock tree in QEMU
-=============================
+Modelling a clock tree in QEMU
+==============================

-What are clocks
----------------
+What are clocks?
+----------------

-Clocks are QOM objects developed for the purpose of modeling the
+Clocks are QOM objects developed for the purpose of modelling the
 distribution of clocks in QEMU.

 They allow us to model the clock distribution of a platform and detect
 configuration errors in the clock tree such as badly configured PLL, clock
 source selection or disabled clock.

-The object is *Clock* and its QOM name is ``CLOCK``.
+The object is *Clock* and its QOM name is ``clock`` (in C code, the macro
+``TYPE_CLOCK``).

 Clocks are typically used with devices where they are used to model inputs
-and outputs. They are created in a similar way as gpios. Inputs and outputs
-of different devices can be connect together.
+and outputs. They are created in a similar way to GPIOs. Inputs and outputs
+of different devices can be connected together.

-In these cases a Clock object is a child of a Device object but this is not
-a requirement. Clocks can be independent of devices. For example it is possible
-to create a clock outside of any device to model the main clock source of a
-machine.
+In these cases a Clock object is a child of a Device object, but this
+is not a requirement. Clocks can be independent of devices. For
+example it is possible to create a clock outside of any device to
+model the main clock source of a machine.

 Here is an example of clocks::

@@ -45,40 +46,43 @@ Here is an example of clocks::
                                                 | +-------+    |
                                                 +--------------+

-Clocks are defined in include/hw/clock.h header and device related functions
-are defined in include/hw/qdev-clock.h header.
+Clocks are defined in the ``include/hw/clock.h`` header and device
+related functions are defined in the ``include/hw/qdev-clock.h``
+header.

 The clock state
 ---------------

-The state of a clock is its period; it is stored as an integer representing
-it in 2^-32ns unit. The special value of 0 is used to represent the clock being
-inactive or gated. The clocks do not model the signal itself (pin toggling)
-or other properties such as the duty cycle.
+The state of a clock is its period; it is stored as an integer
+representing it in units of 2 :sup:`-32` ns. The special value of 0 is used to
+represent the clock being inactive or gated. The clocks do not model
+the signal itself (pin toggling) or other properties such as the duty
+cycle.

-All clocks contain this state: outputs as well as inputs. It allows to fetch
-the current period of a clock at any time. When a clock is updated, the
-value is immediately propagated to all connected clocks in the tree.
+All clocks contain this state: outputs as well as inputs. This allows
+the current period of a clock to be fetched at any time. When a clock
+is updated, the value is immediately propagated to all connected
+clocks in the tree.

-To ease interaction with clocks. Helpers with a unit suffix are defined for
-every clock state setter or getter. They are:
+To ease interaction with clocks, helpers with a unit suffix are defined for
+every clock state setter or getter. The suffixes are:

-- ``_ns`` for handling periods in nanosecond,
-- ``_hz`` for handling frequencies in hertz.
+- ``_ns`` for handling periods in nanoseconds
+- ``_hz`` for handling frequencies in hertz

 The 0 period value is converted to 0 in hertz and vice versa. 0 always means
 that the clock is disabled.

-Adding a new a clock
---------------------
+Adding a new clock
+------------------

 Adding clocks to a device must be done during the init method of the Device
 instance.

-To add an input clock to a device, the function qdev_init_clock_in
must be used.
-It takes the name, a callback and an opaque parameter for the
callback (this will
-be explained in a following section below).
-Output is more simple, only the name is required. Typically::
+To add an input clock to a device, the function ``qdev_init_clock_in()``
+must be used.  It takes the name, a callback and an opaque parameter
+for the callback (this will be explained in a following section).
+Output is simpler; only the name is required. Typically::

     qdev_init_clock_in(DEVICE(dev), "clk_in", clk_in_callback, dev);
     qdev_init_clock_out(DEVICE(dev), "clk_out");
@@ -92,13 +96,13 @@ Note that it is possible to create a static array
describing clock inputs and
 outputs. The function ``qdev_init_clocks()`` must be called with the array as
 parameter to initialize the clocks: it has the same behaviour as calling the
 ``qdev_init_clock_in/out()`` for each clock in the array. To ease the array
-construction, some macros are defined in include/hw/qdev-clock.h.
+construction, some macros are defined in ``include/hw/qdev-clock.h``.
 As an example, the following creates 2 clocks to a device: one input and one
 output.

-::
+.. code-block:: c

-    /* device structure containing pointer to the clock objects */
+    /* device structure containing pointers to the clock objects */
     typedef struct MyDeviceState {
         DeviceState parent_obj;
         Clock *clk_in;
@@ -114,10 +118,10 @@ output.
     /*
      * static array describing clocks:
      * + a clock input named "clk_in", whose pointer is stored in
-     *   clk_in field of a MyDeviceState structure with callback
+     *   the clk_in field of a MyDeviceState structure with callback
      *   clk_in_callback.
      * + a clock output named "clk_out" whose pointer is stored in
-     *   clk_out field of a MyDeviceState structure.
+     *   the clk_out field of a MyDeviceState structure.
      */
     static const ClockPortInitArray mydev_clocks = {
         QDEV_CLOCK_IN(MyDeviceState, clk_in, clk_in_callback),
@@ -136,12 +140,12 @@ output.
     }

 An alternative way to create a clock is to simply call
-``object_new(TYPE_CLOCK)``. In that case the clock will neither be an input nor
-an output of a device. After the whole QOM hieracrhy of the clock has been set
-``clock_setup_canonical_path()`` should be called.
+``object_new(TYPE_CLOCK)``. In that case the clock will neither be an
+input nor an output of a device. After the whole QOM hierarchy of the
+clock has been set ``clock_setup_canonical_path()`` should be called.

 At creation, the period of the clock is 0: the clock is disabled. You can
-change it using ``clock_set[_ns|_hz]()``.
+change it using ``clock_set_ns()`` or ``clock_set_hz()``.

 Note that if you are creating a clock with a fixed period which will never
 change (for example the main clock source of a board), then you'll have
@@ -152,32 +156,40 @@ the first reset.
 Retrieving clocks from a device
 -------------------------------

-``qdev_get_clock_in()`` and ``dev_get_clock_out()`` are available to
get the clock inputs or outputs of a device. For example::
+``qdev_get_clock_in()`` and ``dev_get_clock_out()`` are available to
+get the clock inputs or outputs of a device. For example:

-    Clock *clk = qdev_get_clock_in(DEVICE(mydev), "clk_in");
+.. code-block:: c

-or::
+   Clock *clk = qdev_get_clock_in(DEVICE(mydev), "clk_in");

-    Clock *clk = qdev_get_clock_out(DEVICE(mydev), "clk_out");
+or:
+
+.. code-block:: c
+
+   Clock *clk = qdev_get_clock_out(DEVICE(mydev), "clk_out");

 Connecting two clocks together
 ------------------------------

 To connect two clocks together, use the ``clock_set_source()`` function.
 Given two clocks ``clk1``, and ``clk2``, ``clock_set_source(clk2, clk1);``
-configure ``clk2`` to follow the ``clk1`` period changes. Every time ``clk1``
+configures ``clk2`` to follow the ``clk1`` period changes. Every time ``clk1``
 is updated, ``clk2`` will be updated too.

 When connecting clock between devices, prefer using the
-``qdev_connect_clock_in()`` function set the source of an input device clock.
-For example, to connect the input clock ``clk2`` of ``devB`` to the output
-clock ``clk1`` of ``devA``, do::
+``qdev_connect_clock_in()`` function to set the source of an input
+device clock.  For example, to connect the input clock ``clk2`` of
+``devB`` to the output clock ``clk1`` of ``devA``, do:
+
+.. code-block:: c

     qdev_connect_clock_in(devB, "clk2", qdev_get_clock_out(devA, "clk1"))

-We used ``qdev_get_clock_out()`` above, but any clock can drive an input clock,
-even another input clock. The following diagram shows some
-examples of connections. Note also that a clock can drive several other clocks.
+We used ``qdev_get_clock_out()`` above, but any clock can drive an
+input clock, even another input clock. The following diagram shows
+some examples of connections. Note also that a clock can drive several
+other clocks.

 ::

@@ -200,19 +212,23 @@ examples of connections. Note also that a clock
can drive several other clocks.
                   |               +--------------+                   |
                   +--------------------------------------------------+

-In the above example, when *Clock 1* is updated by *Device A*, three
clocks gets the new clock period value: *Clock 2*, Clock 3* and *Clock
4*.
+In the above example, when *Clock 1* is updated by *Device A*, three
+clocks get the new clock period value: *Clock 2*, *Clock 3* and *Clock 4*.

 It is not possible to disconnect a clock or to change the clock connection
-after it is done.
+after it is connected.

 Unconnected input clocks
 ------------------------

-A newly created input clock is disabled (period of 0). It means the clock will
-be considered as disabled until the period is updated. If the clock remains
-unconnected it will always keep its initial value of 0. If this is not the
-wanted behaviour, ``clock_set()``, ``clock_set_ns()`` or ``clock_set_hz()``
-should be called on the Clock object during device instance init. For example::
+A newly created input clock is disabled (period of 0). This means the
+clock will be considered as disabled until the period is updated. If
+the clock remains unconnected it will always keep its initial value
+of 0. If this is not the desired behaviour, ``clock_set()``,
+``clock_set_ns()`` or ``clock_set_hz()`` should be called on the Clock
+object during device instance init. For example:
+
+.. code-block:: c

     clk = qdev_init_clock_in(DEVICE(dev), "clk-in", clk_in_callback,
                              dev);
@@ -222,18 +238,19 @@ should be called on the Clock object during
device instance init. For example::
 Fetching clock frequency/period
 -------------------------------

-To get the current state of a clock, the function ``clock_get()``,
-``clock_get_ns()`` or ``clock_get_hz()`` must be used.
+To get the current state of a clock, use the functions ``clock_get()``,
+``clock_get_ns()`` or ``clock_get_hz()``.

 It is also possible to register a callback on clock frequency changes.
-Here is an example::
+Here is an example:
+
+.. code-block:: c

     void clock_callback(void *opaque) {
         MyDeviceState *s = (MyDeviceState *) opaque;
         /*
-         * opaque may not be the device state pointer, but most
-         * probably it is. (It depends on what is given to the
-         * qdev_init_clock_in function)
+         * 'opaque' is the argument passed to qdev_init_clock_in();
+         * usually this will be the device state pointer.
          */

         /* do something with the new period */
@@ -248,48 +265,57 @@ A device can change its outputs using the
``clock_update()``,
 ``clock_update_ns()`` or ``clock_update_hz()`` function. It will trigger
 updates on every connected input.

-For example, let's say that we have an output clock *clkout* and we have a
-pointer to it in the device state because we did the following in init phase::
+For example, let's say that we have an output clock *clkout* and we
+have a pointer to it in the device state because we did the following
+in init phase:

-    dev->clkout = qdev_init_clock_out(DEVICE(dev), "clkout");
+.. code-block:: c
+
+   dev->clkout = qdev_init_clock_out(DEVICE(dev), "clkout");

 Then at any time (apart from the cases listed below), it is possible to
-change the clock value by doing::
+change the clock value by doing:

-    clock_update_hz(dev->clkout, 1000 * 1000 * 1000); /* 1Ghz */
+.. code-block:: c

-Because updating a clock may trigger any side effects through connected clocks
-and their callbacks, this operation must be done while holding the
qemu io lock.
+   clock_update_hz(dev->clkout, 1000 * 1000 * 1000); /* 1GHz */
+
+Because updating a clock may trigger any side effects through
+connected clocks and their callbacks, this operation must be done
+while holding the qemu io lock.

 For the same reason, one can update clocks only when it is allowed to have
 side effects on other objects. In consequence, it is forbidden:
-+ during migration,
-+ and in the enter phase of reset.
+
+* during migration,
+* and in the enter phase of reset.

 Note that calling ``clock_update[_ns|_hz]()`` is equivalent to calling
-``clock_set[_ns|_hz]()`` (with the same arguments) then
``clock_propagate()`` on
-the clock. Thus, setting the clock value can be separated from triggering the
-side-effects. This is often required to factorize code to handle reset and
-migration in devices.
+``clock_set[_ns|_hz]()`` (with the same arguments) then
+``clock_propagate()`` on the clock. Thus, setting the clock value can
+be separated from triggering the side-effects. This is often required
+to factorize code to handle reset and migration in devices.

 Aliasing clocks
 ---------------

-Sometimes, one needs to forward, or inherit, a clock from another device.
-Typically, when doing device composition, a device might expose a sub-device's
-clock without interfering with it.
-The function ``qdev_alias_clock()`` can be used to achieve this behaviour. Note
-that it is possible to expose the clock under a different name. This works for
-both inputs and outputs.
+Sometimes, one needs to forward, or inherit, a clock from another
+device.  Typically, when doing device composition, a device might
+expose a sub-device's clock without interfering with it.  The function
+``qdev_alias_clock()`` can be used to achieve this behaviour. Note
+that it is possible to expose the clock under a different name.
+``qdev_alias_clock()`` works for both input and output clocks.

-For example, if device B is a child of device A, ``device_a_instance_init()``
-may do something like this::
+For example, if device B is a child of device A,
+``device_a_instance_init()`` may do something like this:
+
+.. code-block:: c

     void device_a_instance_init(Object *obj)
     {
         AState *A = DEVICE_A(obj);
         BState *B;
-        /* create B object as child of A */
+        /* create object B as child of A */
         [...]
         qdev_alias_clock(B, "clk", A, "b_clk");
         /*
@@ -298,12 +324,12 @@ may do something like this::
          */
     }

-This function does not return any clock object. The new clock has the same
-direction (input or output) as the original one. This function only adds a link
-to the existing clock. In the above example, B object remains the only object
-allowed to use the clock and device A must not try to change the clock period
-or set a callback to the clock. Here follows a diagram describing the example
-with an input clock::
+This function does not return any clock object. The new clock has the
+same direction (input or output) as the original one. This function
+only adds a link to the existing clock. In the above example, object B
+remains the only object allowed to use the clock and device A must not
+try to change the clock period or set a callback to the clock. This
+diagram describes the example with an input clock::

     +--------------------------+
     |        Device A          |
@@ -322,13 +348,14 @@ Migration
 Clock state is not migrated automatically. Every device must handle its
 clock migration. Alias clocks must not be migrated.

-To ensure clock states are restored correctly during migration, there is two
-solutions.
+To ensure clock states are restored correctly during migration, there
+are two solutions.

-Clocks states can be migrated by adding an entry into the device
-vmstate description. To this purpose, the ``VMSTATE_CLOCK`` macro defines
-such an entry and should be used. This is typically used to migrate an input
-clock state. The following example describes it::
+Clock states can be migrated by adding an entry into the device
+vmstate description. You should use the ``VMSTATE_CLOCK`` macro for this.
+This is typically used to migrate an input clock state. For example:
+
+.. code-block:: c

     MyDeviceState {
         DeviceState parent_obj;
@@ -346,15 +373,19 @@ clock state. The following example describes it::
     };

 The second solution is to restore the clock state using information already
-at our disposal. This can be used to restore output clocks states using the
+at our disposal. This can be used to restore output clock states using the
 device state. The functions ``clock_set[_ns|_hz]()`` can be used during the
 ``post_load()`` migration callback.

-When adding a clock support to an existing device, if you care about migration
-compatibility. To this end, you can use ``clock_set()`` in a ``pre_load()``
-function to setup a default value in case the source virtual machine does not
-send the clock state. You may also need to use a vmstate subsection.
+When adding clock support to an existing device, if you care about
+migration compatibility you will need to be careful, as simply adding
+a ``VMSTATE_CLOCK()`` line will break compatibility. Instead, you can
+put the ``VMSTATE_CLOCK()`` line into a vmstate subsection with a
+suitable ``needed`` function, and use ``clock_set()`` in a
+``pre_load()`` function to set the default value that will be used if
+the source virtual machine in the migration does not send the clock
+state.

 Care should be taken not to use ``clock_update[_ns|_hz]()`` or
-``clock_propagate()`` during the whole migration procedure because it will
-trigger side effects to other devices in an unknown state.
+``clock_propagate()`` during the whole migration procedure because it
+will trigger side effects to other devices in an unknown state.
-- 
2.20.1



thanks
-- PMM

