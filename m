Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D94C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC8321D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhHUbdhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC8321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j74ny-00036s-8K
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j74mw-0002HQ-2i
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j74mt-00014E-G5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:04:17 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:41374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j74mt-00013J-32; Wed, 26 Feb 2020 17:04:15 -0500
Received: by mail-lf1-x141.google.com with SMTP id y17so480583lfe.8;
 Wed, 26 Feb 2020 14:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1HYW/pv97PxvhdVIRVxTMcH+Z79rJFhSr0wA3xZRSZo=;
 b=DhHUbdhPf6ULww4Ek+tIeUfF93fgf2b8gLv75hj9+fZ6Q1nUV6kfLGjBryXRsZBd7C
 0woDCRnkJjAR4lgUoj9PTZjhDX/uC4AmZWMAiAw5N/O1ZusoG3zLNG/djmvlaJeWLglE
 /rLnIulSlWvPHi8hZIXuGhTmsXmXvKVmGH66AHZkCL873BKBHNiqZzeXuTIElYF6MTm1
 qPEkXhy3/My1XWz9jAX+a6Fv8fRrQzrjtpoceiLCBHNniK5JDBOYn1RTCefcjp/8nsAs
 eJXxuynQTB0Npb6QykU+KM2eCkqM06Dc35d9U6CcbYXl3p82JvdsMvi08Z/KfXB8OzHS
 RuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1HYW/pv97PxvhdVIRVxTMcH+Z79rJFhSr0wA3xZRSZo=;
 b=gSnWGiTPyZdNITfJ1VLSIAUn3VIN8VRD7cqmf+dOpiOhqYjkKZ9fTm8nnYulQYkJ4v
 NRjJCmI1NA7gKeXC16W1mHDdRuQotx1zUk0cNGQvSNB7ciVXChx2QnY+/dKjIuv+mK4z
 q8smO9Gz8hc207evQJi/7kk7w3wSoQUGHFXBd9zS7dVoq8gZZRm6I2aQD/eY6m+UgVtV
 LbQP++UNHOtxpY0JbqYhwAWiUKRr8HcvVF+qFvEPr7ZRIX1XeL26Uj+yoZ/yZJkfKC70
 CER+Byh5nqY7Im48Bb6cyMJjbEdx7fedRjaeju+OYpMEDAfGS3oqV/qMXQGGhSNhJ5C2
 IgKw==
X-Gm-Message-State: ANhLgQ297qfOF8JMgr/I278Z4kfX1yy+9wGPFBA3jKajYpvtG+r924ey
 b+5qXKsUd3/PQWdwiHQmPbAtEEVJWtuKKh/2AmI=
X-Google-Smtp-Source: ADFU+vuKeldykvD/AtynCOL0h1ZFLP/KWOm6vqJUB9PfUVxyaFtARl2AhHDXSKLNJ1nvP+m3cp9/Zja6deQ8avBBVGA=
X-Received: by 2002:a05:6512:31d3:: with SMTP id
 j19mr379829lfe.178.1582754652405; 
 Wed, 26 Feb 2020 14:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
 <20200225131422.53368-6-damien.hedde@greensocs.com>
In-Reply-To: <20200225131422.53368-6-damien.hedde@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 13:56:34 -0800
Message-ID: <CAKmqyKN03vtaxAttdxO7VVCa+Y3B1t8VPujt8H+qzFWtm6m8sw@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] docs/clocks: add device's clock documentation
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 6:01 AM Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Add the documentation about the clock inputs and outputs in devices.
>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>
> v8:
>  + fix list indentation
>  + reduce title size
>
> v7:
>  + update ClockIn/Out types
>  + switch to rst format
> ---
>  docs/devel/clocks.rst | 360 ++++++++++++++++++++++++++++++++++++++++++
>  docs/devel/index.rst  |   1 +
>  2 files changed, 361 insertions(+)
>  create mode 100644 docs/devel/clocks.rst
>
> diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
> new file mode 100644
> index 0000000000..d3c0146bd2
> --- /dev/null
> +++ b/docs/devel/clocks.rst
> @@ -0,0 +1,360 @@
> +Modeling a clock tree in QEMU
> +=============================
> +
> +What are clocks
> +---------------
> +
> +Clocks are QOM objects developed for the purpose of modeling the
> +distribution of clocks in QEMU.
> +
> +They allow us to model the clock distribution of a platform and detect
> +configuration errors in the clock tree such as badly configured PLL, clock
> +source selection or disabled clock.
> +
> +The object is *Clock* and its QOM name is ``CLOCK``.
> +
> +Clocks are typically used with devices where they are used to model inputs
> +and outputs. They are created in a similar way as gpios. Inputs and outputs
> +of different devices can be connect together.
> +
> +In these cases a Clock object is a child of a Device object but this is not
> +a requirement. Clocks can be independent of devices. For example it is possible
> +to create a clock outside of any device to model the main clock source of a
> +machine.
> +
> +Here is an example of clocks::
> +
> +    +---------+      +----------------------+   +--------------+
> +    | Clock 1 |      |       Device B       |   |   Device C   |
> +    |         |      | +-------+  +-------+ |   | +-------+    |
> +    |         |>>-+-->>|Clock 2|  |Clock 3|>>--->>|Clock 6|    |
> +    +---------+   |  | | (in)  |  | (out) | |   | | (in)  |    |
> +                  |  | +-------+  +-------+ |   | +-------+    |
> +                  |  |            +-------+ |   +--------------+
> +                  |  |            |Clock 4|>>
> +                  |  |            | (out) | |   +--------------+
> +                  |  |            +-------+ |   |   Device D   |
> +                  |  |            +-------+ |   | +-------+    |
> +                  |  |            |Clock 5|>>--->>|Clock 7|    |
> +                  |  |            | (out) | |   | | (in)  |    |
> +                  |  |            +-------+ |   | +-------+    |
> +                  |  +----------------------+   |              |
> +                  |                             | +-------+    |
> +                  +----------------------------->>|Clock 8|    |
> +                                                | | (in)  |    |
> +                                                | +-------+    |
> +                                                +--------------+
> +
> +Clocks are defined in include/hw/clock.h header and device related functions
> +are defined in include/hw/qdev-clock.h header.
> +
> +The clock state
> +---------------
> +
> +The state of a clock is its period; it is stored as an integer representing
> +it in 2^-32ns unit. The special value of 0 is used to represent the clock being
> +inactive or gated. The clocks do not model the signal itself (pin toggling)
> +or other properties such as the duty cycle.
> +
> +All clocks contain this state: outputs as well as inputs. It allows to fetch
> +the current period of a clock at any time. When a clock is updated, the
> +value is immediately propagated to all connected clocks in the tree.
> +
> +To ease interaction with clocks. Helpers with a unit suffix are defined for
> +every clock state setter or getter. They are:
> +
> +- ``_ns`` for handling periods in nanosecond,
> +- ``_hz`` for handling frequencies in hertz.
> +
> +The 0 period value is converted to 0 in hertz and vice versa. 0 always means
> +that the clock is disabled.
> +
> +Adding a new a clock
> +--------------------
> +
> +Adding clocks to a device must be done during the init method of the Device
> +instance.
> +
> +To add an input clock to a device, the function qdev_init_clock_in must be used.
> +It takes the name, a callback and an opaque parameter for the callback (this will
> +be explained in a following section below).
> +Output is more simple, only the name is required. Typically::
> +
> +    qdev_init_clock_in(DEVICE(dev), "clk_in", clk_in_callback, dev);
> +    qdev_init_clock_out(DEVICE(dev), "clk_out");
> +
> +Both functions return the created Clock pointer, which should be saved in the
> +device's state structure for further use.
> +
> +These objects will be automatically deleted by the QOM reference mechanism.
> +
> +Note that it is possible to create a static array describing clock inputs and
> +outputs. The function ``qdev_init_clocks()`` must be called with the array as
> +parameter to initialize the clocks: it has the same behaviour as calling the
> +``qdev_init_clock_in/out()`` for each clock in the array. To ease the array
> +construction, some macros are defined in include/hw/qdev-clock.h.
> +As an example, the following creates 2 clocks to a device: one input and one
> +output.
> +
> +::
> +
> +    /* device structure containing pointer to the clock objects */
> +    typedef struct MyDeviceState {
> +        DeviceState parent_obj;
> +        Clock *clk_in;
> +        Clock *clk_out;
> +    } MyDeviceState;
> +
> +    /*
> +     * callback for the input clock (see "Callback on input clock
> +     * change" section below for more information).
> +     */
> +    static void clk_in_callback(void *opaque);
> +
> +    /*
> +     * static array describing clocks:
> +     * + a clock input named "clk_in", whose pointer is stored in
> +     *   clk_in field of a MyDeviceState structure with callback
> +     *   clk_in_callback.
> +     * + a clock output named "clk_out" whose pointer is stored in
> +     *   clk_out field of a MyDeviceState structure.
> +     */
> +    static const ClockPortInitArray mydev_clocks = {
> +        QDEV_CLOCK_IN(MyDeviceState, clk_in, clk_in_callback),
> +        QDEV_CLOCK_OUT(MyDeviceState, clk_out),
> +        QDEV_CLOCK_END
> +    };
> +
> +    /* device initialization function */
> +    static void mydev_init(Object *obj)
> +    {
> +        /* cast to MyDeviceState */
> +        MyDeviceState *mydev = MYDEVICE(obj);
> +        /* create and fill the pointer fields in the MyDeviceState */
> +        qdev_init_clocks(mydev, mydev_clocks);
> +        [...]
> +    }
> +
> +An alternative way to create a clock is to simply call
> +``object_new(TYPE_CLOCK)``. In that case the clock will neither be an input nor
> +an output of a device. After the whole QOM hieracrhy of the clock has been set
> +``clock_setup_canonical_path()`` should be called.
> +
> +At creation, the period of the clock is 0: the clock is disabled. You can
> +change it using ``clock_set[_ns|_hz]()``.
> +
> +Note that if you are creating a clock with a fixed period which will never
> +change (for example the main clock source of a board), then you'll have
> +nothing else to do. This value will be propagated to other clocks when
> +connecting the clocks together and devices will fetch the right value during
> +the first reset.
> +
> +Retrieving clocks from a device
> +-------------------------------
> +
> +``qdev_get_clock_in()`` and ``dev_get_clock_out()`` are available to get the clock inputs or outputs of a device. For example::
> +
> +    Clock *clk = qdev_get_clock_in(DEVICE(mydev), "clk_in");
> +
> +or::
> +
> +    Clock *clk = qdev_get_clock_out(DEVICE(mydev), "clk_out");
> +
> +Connecting two clocks together
> +------------------------------
> +
> +To connect two clocks together, use the ``clock_set_source()`` function.
> +Given two clocks ``clk1``, and ``clk2``, ``clock_set_source(clk2, clk1);``
> +configure ``clk2`` to follow the ``clk1`` period changes. Every time ``clk1``
> +is updated, ``clk2`` will be updated too.
> +
> +When connecting clock between devices, prefer using the
> +``qdev_connect_clock_in()`` function set the source of an input device clock.
> +For example, to connect the input clock ``clk2`` of ``devB`` to the output
> +clock ``clk1`` of ``devA``, do::
> +
> +    qdev_connect_clock_in(devB, "clk2", qdev_get_clock_out(devA, "clk1"))
> +
> +We used ``qdev_get_clock_out()`` above, but any clock can drive an input clock,
> +even another input clock. The following diagram shows some
> +examples of connections. Note also that a clock can drive several other clocks.
> +
> +::
> +
> +  +------------+  +--------------------------------------------------+
> +  |  Device A  |  |                   Device B                       |
> +  |            |  |               +---------------------+            |
> +  |            |  |               |       Device C      |            |
> +  |  +-------+ |  | +-------+     | +-------+ +-------+ |  +-------+ |
> +  |  |Clock 1|>>-->>|Clock 2|>>+-->>|Clock 3| |Clock 5|>>>>|Clock 6|>>
> +  |  | (out) | |  | | (in)  |  |  | | (in)  | | (out) | |  | (out) | |
> +  |  +-------+ |  | +-------+  |  | +-------+ +-------+ |  +-------+ |
> +  +------------+  |            |  +---------------------+            |
> +                  |            |                                     |
> +                  |            |  +--------------+                   |
> +                  |            |  |   Device D   |                   |
> +                  |            |  | +-------+    |                   |
> +                  |            +-->>|Clock 4|    |                   |
> +                  |               | | (in)  |    |                   |
> +                  |               | +-------+    |                   |
> +                  |               +--------------+                   |
> +                  +--------------------------------------------------+
> +
> +In the above example, when *Clock 1* is updated by *Device A*, three clocks gets the new clock period value: *Clock 2*, Clock 3* and *Clock 4*.
> +
> +It is not possible to disconnect a clock or to change the clock connection
> +after it is done.
> +
> +Unconnected input clocks
> +------------------------
> +
> +A newly created input clock is disabled (period of 0). It means the clock will
> +be considered as disabled until the period is updated. If the clock remains
> +unconnected it will always keep its initial value of 0. If this is not the
> +wanted behaviour, ``clock_set()``, ``clock_set_ns()`` or ``clock_set_hz()``
> +should be called on the Clock object during device instance init. For example::
> +
> +    clk = qdev_init_clock_in(DEVICE(dev), "clk-in", clk_in_callback,
> +                             dev);
> +    /* set initial value to 10ns / 100MHz */
> +    clock_set_ns(clk, 10);
> +
> +Fetching clock frequency/period
> +-------------------------------
> +
> +To get the current state of a clock, the function ``clock_get()``,
> +``clock_get_ns()`` or ``clock_get_hz()`` must be used.
> +
> +It is also possible to register a callback on clock frequency changes.
> +Here is an example::
> +
> +    void clock_callback(void *opaque) {
> +        MyDeviceState *s = (MyDeviceState *) opaque;
> +        /*
> +         * opaque may not be the device state pointer, but most
> +         * probably it is. (It depends on what is given to the
> +         * qdev_init_clock_in function)
> +         */
> +
> +        /* do something with the new period */
> +        fprintf(stdout, "device new period is %" PRIu64 "ns\n",
> +                        clock_get_ns(dev->my_clk_input));
> +    }
> +
> +Changing a clock period
> +-----------------------
> +
> +A device can change its outputs using the ``clock_update()``,
> +``clock_update_ns()`` or ``clock_update_hz()`` function. It will trigger
> +updates on every connected input.
> +
> +For example, let's say that we have an output clock *clkout* and we have a
> +pointer to it in the device state because we did the following in init phase::
> +
> +    dev->clkout = qdev_init_clock_out(DEVICE(dev), "clkout");
> +
> +Then at any time (apart from the cases listed below), it is possible to
> +change the clock value by doing::
> +
> +    clock_update_hz(dev->clkout, 1000 * 1000 * 1000); /* 1Ghz */
> +
> +Because updating a clock may trigger any side effects through connected clocks
> +and their callbacks, this operation must be done while holding the qemu io lock.
> +
> +For the same reason, one can updates clocks only when it is allowed to have

s/updates/update/g

> +side effects on other objects. In consequence, it is forbidden:
> ++ during migration,
> ++ and in the enter phase of reset.
> +
> +Note that calling ``clock_update[_ns|_hz]()`` is equivalent to call

s/call/calling/g

> +``clock_set[_ns|_hz]()`` (with the same arguments) then ``clock_propagate()`` on
> +the clock. Thus, setting the clock value can separated from triggering the

can be separated

> +side-effects. This is often required to factorize code to handle reset and
> +migration in devices.
> +
> +Aliasing clocks
> +---------------
> +
> +Sometimes, one needs to forward, or inherit, a clock from another device.
> +Typically, when doing device composition, a device might expose a sub-device's
> +clock without interfering with it.
> +The function ``qdev_alias_clock()`` can be used to achieve this behaviour. Note
> +that it is possible to expose the clock under a different name. This works for
> +both inputs and outputs.
> +
> +For example, if device B is a child of device A, ``device_a_instance_init()``
> +may do something like this::
> +
> +    void device_a_instance_init(Object *obj)
> +    {
> +        AState *A = DEVICE_A(obj);
> +        BState *B;
> +        /* create B object as child of A */
> +        [...]
> +        qdev_alias_clock(B, "clk", A, "b_clk");
> +        /*
> +         * Now A has a clock "b_clk" which is an alias to
> +         * the clock "clk" of its child B.
> +         */
> +    }
> +
> +This function does not return any clock object. The new clock has the same
> +direction (input or output) as the original one. This function only adds a link
> +to the existing clock. In the above example, B object remains the only object
> +allowed to use the clock and device A must not try to change the clock period
> +or set a callback to the clock. Here follows a diagram describing the example
> +with an input clock::
> +
> +    +--------------------------+
> +    |        Device A          |
> +    |         +--------------+ |
> +    |         |   Device B   | |
> +    |         | +-------+    | |
> +    >>"b_clk">>>| "clk" |    | |
> +    |  (in)   | |  (in) |    | |
> +    |         | +-------+    | |
> +    |         +--------------+ |
> +    +--------------------------+
> +
> +Migration
> +---------
> +
> +Clock state are not migrated automatically. Every device must handle its

s/are/is/g

> +clock migration. Alias clocks must not be migrated.
> +
> +To ensure clock states are restored correctly during migration, there is two
> +solutions.
> +
> +Clocks states can be migrated by adding an entry into the device
> +vmstate description. To this purpose, the ``VMSTATE_CLOCK`` macro defines
> +such an entry and should be used. This is typically used to migrate an input
> +clock state. The following example describes it::
> +
> +    MyDeviceState {
> +        DeviceState parent_obj;
> +        [...] /* some fields */
> +        Clock *clk;
> +    };
> +
> +    VMStateDescription my_device_vmstate = {
> +        .name = "my_device",
> +        .fields = (VMStateField[]) {
> +            [...], /* other migrated fields */
> +            VMSTATE_CLOCK(clk, MyDeviceState),
> +            VMSTATE_END_OF_LIST()
> +        }
> +    };
> +
> +The second solution is to restore the clock state using information already
> +at our disposal. This can be used to restore output clocks states using the
> +device state. The functions ``clock_set[_ns|_hz]()`` can be used during
> +``post_load()`` migration callback.

during the ``post_load()`` migration callback.

Besides the small typos:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +
> +When adding a clock support to an existing device, if you care about migration
> +compatibility. To this end, you can use ``clock_set()`` in a ``pre_load()``
> +function to setup a default value in case the source virtual machine does not
> +send the clock state. You may also need to use a vmstate subsection.
> +
> +Care should be taken not to use ``clock_update[_ns|_hz]()`` or
> +``clock_propagate()`` during the whole migration procedure because it will
> +trigger side effects to other devices in an unknown state.
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 4dc2ca8d71..f9c8c668ee 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -25,3 +25,4 @@ Contents:
>     tcg-plugins
>     bitops
>     reset
> +   clocks
> --
> 2.25.1
>
>

