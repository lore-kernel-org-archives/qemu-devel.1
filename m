Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7B3C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2772B208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X11bSBoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2772B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialct-0000lI-B2
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 14:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ialVX-0005cm-4h
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ialVN-0006NR-Gl
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:00:43 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44399)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ialVN-00069b-8D
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:00:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id d62so1967136oia.11
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 11:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CIEoNqJV3qn2VzH02KCj8cMWQpmQlfYwgG5HwB44BmQ=;
 b=X11bSBoTartwsXefKP8EyCH3OUOkqv3s1ryu8bIDzRw/kjQfhcHayJupzaNG0ox7NI
 yRMy4la6ZZdCquqdM1S8Va0NrfNfnJTnmAZFgowsPZWn5mlYmnlVoUxXLFWbbYZAsBIX
 WU8aQC/BYMbL4JBaL0xscdlA+fHqfl7aKwlCGEwBOgdKJq0AC3c/T5tBZ9DIaAzRKKXj
 2/Bi8mYMdpaShGcV7MSCBre/gRFXOC3fzGIh9cSvfBBUCpu3UZI89ErXGmSubRvRUBKc
 hiZv3n10Hd6gODvqU8PaP6g/8my7890pXAxobO6ikpd23RaZzvL3q6ML/6YgXLG8bExQ
 wDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CIEoNqJV3qn2VzH02KCj8cMWQpmQlfYwgG5HwB44BmQ=;
 b=bQYaIj0BjFMRuA4FJoUlz1m+HlGg+6rYkhwn6ULO37Y650ZjIfw3qaxxISfPAFb8to
 fozyiulRdQ1HLPitROB2NHzsDHXew6OybtuCw6/vsARTF4E2ju+0WdPSAAPhWSzVEmiE
 1nCdHR2rCqVNCuxrIwhF7OS/AdOgCZ3RDZJrrKAxN0GH7z6Cz+Kl5aD53unWb3jtyu7V
 QrF1kKVgxwpQ2i//WNnW1oTACCcc96wGFCGiB1lkTJUM50CFqP2WvT1nEII/xLRhW/er
 D860Wb9EWfs5glz5oKFy0pv/Qxv+NZLdmKwTcgiNEXaXhNinDipIkinn3nPYDbQaCTah
 lVbA==
X-Gm-Message-State: APjAAAWCwMVjZLq3lr2KIkCvE7jyYpb87TCaUaFbvETp9X3Nh7U3B3gE
 RMqBjkNz5q4D299fHWpXXaOh/CmhoHpO85OMqH7J1g==
X-Google-Smtp-Source: APXvYqyUISdUf36Me6/mtwj5EbWccHhk+tOstCW2udN/ddB3NJSfJ3tU7UszcSruX14Y1ZRd50aMUNJRgjLP8rvuFMA=
X-Received: by 2002:aca:1a0a:: with SMTP id a10mr11159264oia.146.1575054032821; 
 Fri, 29 Nov 2019 11:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-10-damien.hedde@greensocs.com>
In-Reply-To: <20191018150630.31099-10-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 19:00:22 +0000
Message-ID: <CAFEAcA_4x+EvDS8Lc0xyPE1GHRh4+7dvJ6sxMPXZjkrZ_CgrHw@mail.gmail.com>
Subject: Re: [PATCH v5 09/13] docs/devel/reset.txt: add doc about Resettable
 interface
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Subject line still says ".txt".

> ---
>
> Should I add an entry into index.rst ?

Yes, please.

I have one substantive comment on this patch: in the
MyDev example of implementing reset, you make the enter/hold/exit
functions do the reset of the subclass and then call the
myclass->parent_phases method. This feels to me like it's the
wrong way round and the parent class should reset first. Does
it make any difference to do it this way round?


Everything below here is just typo/grammar fixes, so
if you correct those then
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


> ---
>  docs/devel/reset.rst | 282 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 282 insertions(+)
>  create mode 100644 docs/devel/reset.rst
>
> diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> new file mode 100644
> index 0000000000..a562720f55
> --- /dev/null
> +++ b/docs/devel/reset.rst
> @@ -0,0 +1,282 @@
> +
> +=======================================
> +Reset in QEMU: the Resettable interface
> +=======================================
> +
> +The reset of qemu objects is handled using the resettable interface declared
> +in ``include/hw/resettable.h``.
> +
> +This interface allows to group objects (on a tree basis) and to reset the

"allows objects to be grouped"; "so that the whole group can be
reset consistently".

> +whole group consistently. Each individual member object does not have to care
> +about others; in particular problems of order (which object is reset first)
> +are addressed.
> +
> +As of now DeviceClass and BusClass implement this interface.
> +
> +
> +Triggering reset
> +----------------
> +
> +This section documents the APIs which "users" of a resettable object should use
> +to control it. All resettable control functions must be called while holding
> +the iothread lock.
> +
> +You can apply a reset to an object using ``resettable_assert_reset()``. You need
> +to call ``resettable_release_reset()`` to release the object from reset. To
> +instantly reset an object, without keeping it in reset state, just call
> +``resettable_reset()``. These functions function takes two parameters: a pointer

"These functions take two parameters"

> +to the object to reset and a reset type.
> +
> +Several types of reset will be supported. For now only cold reset is defined,

"defined;"

> +others may be added later. The Resettable interface handles reset types with an
> +enum:
> +
> +``RESET_TYPE_COLD``
> +  Cold reset is supported by every resettable object. In QEMU, it means we reset
> +  to the initial state corresponding to the start of QEMU; this might differs

"differ"

> +  from what is a read hardware cold reset. It differs from other reset (like

"real"; "other resets"

> +  warm or bus resets) which may keep certain parts untouched.
> +
> +Calling ``resettable_reset()`` is equivalent to calling
> +``resettable_assert_reset()`` then ``resettable_release_reset()``. It is
> +possible to interleave multiple calls to these three functions. There may
> +be several reset sources/controllers of a given object. The interface handles
> +everything and the different reset controllers do not need to know anything
> +about each others. The object will leave reset state only when each other

"each other". "when all controllers end"

> +controllers end their reset operation. This point is handled internally by
> +maintaining a count of reset; it is crucial to call

"of in-progress resets"

> +``resettable_release_reset()`` one time and only one time per
> +``resettable_assert_reset()`` call.
> +
> +For now migration of a device or bus in reset is not supported. Care must be
> +taken not to delayed ``resettable_release_reset()`` from its

"delay"; "after its"

> +``resettable_assert_reset()`` counterpart.

"in a way that would allow migration to happen between the two".

> +
> +Note that, since resettable is an interface, the API takes simple Object as

"a simple"

> +parameter. Still, it is a programming error to call a resettable function on a
> +non-resettable object and it will trigger a run time assert error. Since most
> +call to resettable interface are done through base class functions, such an

"calls"

> +error is not likely to happen.
> +
> +For Devices and Buses, the following helper functions exists:

"exist"

> +
> +- ``device_cold_reset()``
> +- ``bus_cold_reset()``
> +
> +These are simple wrappers around resettable_reset() function; they only cast the
> +Device or Bus into an Object and pass the cold reset type. When possible
> +prefer to use these functions instead ``resettable_reset()``.

"instead of"


> +
> +Device and bus functions co-exist because there can be semantic differences
> +between resetting a bus and resetting the controller bridge which owns it.
> +For example, considering a SCSI controller. Resetting the controller puts all

"consider"

> +its registers back to what reset state was as well as reset everything on the

"to their reset state, as well as resetting everything"

> +SCSI bus. Whereas resetting just the SCSI bus only resets everything that's on

"bus, whereas"

> +it but not the controller.
> +
> +
> +Multi-phase mechanism
> +---------------------
> +
> +This section documents the internals of the resettable interface.
> +
> +The resettable interface uses a multi-phase system to relieve objects and
> +machines from reset ordering problems. To address this, the reset operation
> +of an object is split into three well defined phases.
> +
> +When resetting a several objects (for example the whole machine at simulation

"resetting several"

> +startup), all first phases of all objects are executed, then all second phases
> +and then all third phases.
> +
> +The three phases are:
> +
> +1. The **enter** phase is executed when the object enters reset. It reset only

"It resets"

> +   local state of the object; it must not do anything that has a side-effect
> +   on other objects, such as raising or lowering a qemu_irq line or reading or
> +   writing guest memory.
> +
> +2. The **hold** phase is executed for entry into reset, once every object in the
> +   group which is being reset has had its *enter* phase executed. At this point
> +   devices can do actions that affect other objects.
> +
> +3. The **exit** phase is executed when the object leaves the reset state.
> +   Actions affecting other objects are permitted.
> +
> +As said in previous section, the interface maintains a count of reset. This
> +count is used to ensure phases are executed only when required. *enter* and
> +*hold* phases are executed only when asserting reset for the first time
> +(if an object is already in reset state when calling
> +``resettable_assert_reset()`` or ``resettable_reset()``, they are not
> +executed).
> +The *exit* phase is executed only when the last reset operation ends. Therefore
> +the object has not to care how many reset controllers it has and how many of

"does not need to care how many"

> +them have started a reset.
> +
> +
> +Handling reset in a resettable object
> +-----------------------------------------

There seem to be too many '-' in this line.

> +
> +This section documents the APIs that an implementation of a resettable object
> +must provide and what functions it has access to. It is intended for people
> +who want to implement or convert a class which has the resettable interface;
> +for example when specializing an existing device or bus.
> +
> +Methods to implement
> +....................
> +
> +Three methods should be defined or left empty. Each method corresponds to a
> +phase of the reset; they are name ``phases.enter()``, ``phases.hold()`` and
> +``phases.exit()``. They all take the object as parameter. The *enter* method
> +also take the reset type as second parameter.
> +
> +When extending an existing class, these methods may need to be extended too.
> +The ``resettable_class_set_parent_phases()`` class function may be used to
> +backup mother class methods.

"parent class" (the terminology oddity is particularly noticeable here
because the function name uses the usual names).

> +
> +Here follows an example to implement reset for a Device which set an IO while

"sets"

> +in reset.
> +
> +::
> +
> +    static void mydev_reset_enter(Object *obj, ResetType type)
> +    {
> +        MyDevClass *myclass = MYDEV_GET_CLASS(obj);
> +        MyDevState *mydev = MYDEV(obj);
> +        /* initialize local state only */
> +        mydev->var = 0;
> +        /* call mother class enter phase */
> +        if (myclass->parent_phases.enter) {
> +            myclass->parent_phases.enter(obj, type);
> +        }
> +    }
> +
> +    static void mydev_reset_hold(Object *obj)
> +    {
> +        MyDevClass *myclass = MYDEV_GET_CLASS(obj);
> +        MyDevState *mydev = MYDEV(obj);
> +        /* set an IO */
> +        qemu_set_irq(mydev->irq, 1);
> +        /* call mother class hold phase */
> +        if (myclass->parent_phases.hold) {
> +            myclass->parent_phases.hold(obj);
> +        }
> +    }
> +
> +    static void mydev_reset_exit(Object *obj)
> +    {
> +        MyDevClass *myclass = MYDEV_GET_CLASS(obj);
> +        MyDevState *mydev = MYDEV(obj);
> +        /* clear an IO */
> +        qemu_set_irq(mydev->irq, 0);
> +        /* call mother class exit phase */
> +        if (myclass->parent_phases.exit) {
> +            myclass->parent_phases.exit(obj);
> +        }
> +    }
> +
> +    typedef struct MyDevClass {
> +        MyMotherClass mother_class;
> +        /* to store eventual parent reset methods */
> +        ResettablePhases parent_phases;
> +    } MyDevClass;
> +
> +    static void mydev_class_init(ObjectClass *class, void *data)
> +    {
> +        MyDevClass *myclass = MYDEV_CLASS(class);
> +        ResettableClass *rc = RESETTABLE_CLASS(class);
> +        resettable_class_set_parent_reset_phases(rc,
> +                                                 mydev_reset_enter,
> +                                                 mydev_reset_hold,
> +                                                 mydev_reset_exit,
> +                                                 &myclass->parent_phases);
> +    }
> +
> +In the above example, we override the three phases. It is possible to override

"all three phases".

> +only part of them by passing NULL instead of a function pointer to

"only some of them"

> +``resettable_class_set_parent_reset_phases()``. For example, the following will
> +only override the *enter* phase and leave *hold* and *exit* untouched::
> +
> +    resettable_class_set_parent_reset_phases(rc, mydev_reset_enter,
> +                                             NULL, NULL,
> +                                             &myclass->parent_phases);

"This is equivalent to providing a trivial implementation of the
hold and exit phases which does nothing but call the parent class's
implementation of the phase."


> +
> +
> +Polling the reset state
> +.......................
> +
> +Resettable interface provide the ``resettable_is_in_reset()`` function.

"The Resettable interface provides"

> +This function tells if the object parameter is currently under reset.

"This function returns true if"

> +
> +An object is under reset from the beginning of the *init* phase to the end of

"end of the"

> +*exit* phase. During all three phases, the function will return that the object
> +is in reset.
> +
> +This function may be used if behavior has to be adapted when receiving external
> +interaction while in reset state. +Note that until migration of the reset state
> +is supported, an object should not be left in reset. So apart from being
> +currently executing one of a reset phase, the only cases when this
> +function should return true is if an external interaction is made during *hold*
> +or *exit* phase of another object in the same reset group.

This paragraph feels a bit unclear to me but I'm not sure how to improve it.

> +
> +Helpers ``device_is_in_reset()`` and ``bus_is_in_reset()`` are also provided
> +for devices and buses and should be preferred.
> +
> +
> +Base class handling of reset
> +----------------------------
> +
> +This section documents parts of the reset mechanism that you only need to know
> +about if you are extending it to work with a new base class other than
> +DeviceClass or BusClass, or maintaining the existing code in those classes. Most
> +people can ignore it.
> +
> +Methods to implement
> +....................
> +
> +There are two other methods that need to exist in a class implementing the
> +interface: ``get_state()`` and ``child_foreach()``.
> +
> +``get_state()`` is simple. *resettable* is an interface and, as a consequence,
> +does not have any class state structure. But in order to factorize the code, we
> +need one. This method must return a pointer to ``ResettableState`` structure.
> +The structure must be allocated by the base class; preferably it should be
> +located inside the object instance structure.
> +
> +``child_foreach()`` is more complex. It should execute the given callback on
> +every reset child of the given resettable object. All children must be
> +resettable too. Additional parameters (a reset type and an opaque pointer) must
> +be passed to the callback too.
> +
> +In ``DeviceClass`` and ``BusClass`` the ``ResettableState`` is located
> +``DeviceState`` and ``BusState`` structure. ``child_foreach()`` is implemented
> +to follow the bus hierarchy; for a bus, it calls the function on every child
> +device; for a device, it calls the function on every bus child. When we reset
> +the main system bus, we reset the whole machine bus tree.
> +
> +Changing a resettable parent
> +............................
> +
> +One thing so should be taken care of by the base class is handling reset

"One thing which"

> +hierarchy changes.
> +
> +The reset hierarchy is supposed to be static and built during machine creation.
> +But there are actually some exceptions. To cope with this, the resettable API
> +provides ``resettable_change_parent()``. This function allows to set, update or
> +remove the parent of a resettable object after machine creation is done. As
> +parameters, it takes the object being moved, the old parent if any and the new
> +parent if any.
> +
> +This function can be used at anytime when not in a reset operation. During

"any time"

> +a reset operation it must be used only in *hold* phase. Using it in *enter* or
> +*exit* phase is an error.
> +Also it should not be used during machine creation, although it is harmless to
> +do so: the function is a no-op as long as old and new parent are NULL or not
> +in reset.
> +
> +There is currently 2 cases where this function is used:
> +
> +1. *device hotplug*; it means a new device is introduced on a live bus.
> +
> +2. *hot bus change*; it means an existing live device is added, moved or
> +   removed in the bus hiearchy. At the moment, it occurs only in the raspi
> +   machines for chaning the sdbus used by sd card.

"changing"

> --
> 2.23.0
>

thanks
-- PMM

