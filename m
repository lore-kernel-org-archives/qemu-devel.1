Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4C3C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6531B2077C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="XOdUEz8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6531B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSoq-00011r-7O
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1itSlv-0000Ok-05
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1itSlq-0001yQ-QW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:50:58 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:33714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1itSlq-0001wx-76; Mon, 20 Jan 2020 03:50:54 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id EAC2A96EF0;
 Mon, 20 Jan 2020 08:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579510251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZXrvwLB9b2or1FVMCFvqUGEDESlZQBMmMhpAJhOTHw=;
 b=XOdUEz8OZ3bKhVMOfUaifHBE+nQj8jRb9CQz+eWVel8irTmFgD+PwXI/pSNVOp3Yd6UscX
 ZZGKe/D2jaFx+e0BGYhGceYeMqnjXjl5h5cTV8rqk56SYYQfUPo8K03cnX5c/E7BsZulb2
 hveTCBiUzctmuev9g8ieyyZlr9V2e9E=
Subject: Re: [PATCH v7 03/11] hw/core: create Resettable QOM interface
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-4-damien.hedde@greensocs.com>
 <ec4b4661-cfd3-90bf-a9dc-00a4b966b1b3@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <76b615e4-fa14-915d-b36d-df06addee0c9@greensocs.com>
Date: Mon, 20 Jan 2020 09:50:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ec4b4661-cfd3-90bf-a9dc-00a4b966b1b3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579510251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZXrvwLB9b2or1FVMCFvqUGEDESlZQBMmMhpAJhOTHw=;
 b=EyD0yk8QcuTDiKGUK+AHpJXhAHG01Rwl11cyl/vz/HYN6/gFLTqAsuPOk1+1yAjb2u5akT
 C8V4wnFg6Es7/qHwc4ctcTWUg+GNhgPZ3de0VM9zSFiFJ+u/S2QhW/of0BUM8cO6p9Prv6
 IVa5mvCfX3U4m44LUXTQE8KBvcehIXc=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579510251; a=rsa-sha256; cv=none;
 b=FJtwWKHiWfd9hPrjcDVrHWxmDKTEOaFJklGGIR3FoKAXfPT7LXqjcXR+4UvTqCS6nWIQzz
 1QmEqJ0odS6WEytZmX8x8PNv2SCcNc2qtfXvMHs61cI1ZHde3ryEKfXpQGlLmPJs3FDxkj
 TUW++tuqqD9edCsyznPqGgh2yRGWVsw=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/18/20 7:35 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/15/20 1:36 PM, Damien Hedde wrote:
>> This commit defines an interface allowing multi-phase reset. This aims
>> to solve a problem of the actual single-phase reset (built in
>> DeviceClass and BusClass): reset behavior is dependent on the order
>> in which reset handlers are called. In particular doing external
>> side-effect (like setting an qemu_irq) is problematic because receivin=
g
>> object may not be reset yet.
>>
>> The Resettable interface divides the reset in 3 well defined phases.
>> To reset an object tree, all 1st phases are executed then all 2nd then
>> all 3rd. See the comments in include/hw/resettable.h for a more comple=
te
>> description. The interface defines 3 phases to let the future
>> possibility of holding an object into reset for some time.
>>
>> The qdev/qbus reset in DeviceClass and BusClass will be modified in
>> following commits to use this interface. A mechanism is provided
>> to allow executing a transitional reset handler in place of the 2nd
>> phase which is executed in children-then-parent order inside a tree.
>> This will allow to transition devices and buses smoothly while
>> keeping the exact current qdev/qbus reset behavior for now.
>>
>> Documentation will be added in a following commit.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> v7 update: un-nest struct ResettablePhases
>> ---
>> =C2=A0 Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 include/hw/resettable.h | 211 +++++++++++++++++++++++++++++++++=
++
>> =C2=A0 hw/core/resettable.c=C2=A0=C2=A0=C2=A0 | 238 ++++++++++++++++++=
++++++++++++++++++++++
>> =C2=A0 hw/core/Makefile.objs=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 hw/core/trace-events=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +++
>> =C2=A0 5 files changed, 468 insertions(+)
>> =C2=A0 create mode 100644 include/hw/resettable.h
>> =C2=A0 create mode 100644 hw/core/resettable.c
>>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 7c1e50f9d6..9752d549b4 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -191,6 +191,7 @@ trace-events-subdirs +=3D migration
>> =C2=A0 trace-events-subdirs +=3D net
>> =C2=A0 trace-events-subdirs +=3D ui
>> =C2=A0 endif
>> +trace-events-subdirs +=3D hw/core
>> =C2=A0 trace-events-subdirs +=3D hw/display
>> =C2=A0 trace-events-subdirs +=3D qapi
>> =C2=A0 trace-events-subdirs +=3D qom
>> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
>> new file mode 100644
>> index 0000000000..58b3df4c22
>> --- /dev/null
>> +++ b/include/hw/resettable.h
>> @@ -0,0 +1,211 @@
>> +/*
>> + * Resettable interface header.
>> + *
>> + * Copyright (c) 2019 GreenSocs SAS
>> + *
>> + * Authors:
>> + *=C2=A0=C2=A0 Damien Hedde
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef HW_RESETTABLE_H
>> +#define HW_RESETTABLE_H
>> +
>> +#include "qom/object.h"
>> +
>> +#define TYPE_RESETTABLE_INTERFACE "resettable"
>> +
>> +#define RESETTABLE_CLASS(class) \
>> +=C2=A0=C2=A0=C2=A0 OBJECT_CLASS_CHECK(ResettableClass, (class),
>> TYPE_RESETTABLE_INTERFACE)
>> +
>> +#define RESETTABLE_GET_CLASS(obj) \
>> +=C2=A0=C2=A0=C2=A0 OBJECT_GET_CLASS(ResettableClass, (obj), TYPE_RESE=
TTABLE_INTERFACE)
>> +
>> +typedef struct ResettableState ResettableState;
>> +
>> +/**
>> + * ResetType:
>> + * Types of reset.
>> + *
>> + * + Cold: reset resulting from a power cycle of the object.
>> + *
>> + * TODO: Support has to be added to handle more types. In particular,
>> + * ResettableState structure needs to be expanded.
>> + */
>> +typedef enum ResetType {
>> +=C2=A0=C2=A0=C2=A0 RESET_TYPE_COLD,
>> +} ResetType;
>> +
>> +/*
>> + * ResettableClass:
>> + * Interface for resettable objects.
>> + *
>> + * See docs/devel/reset.rst for more detailed information about how
>> QEMU models
>> + * reset. This whole API must only be used when holding the iothread
>> mutex.
>> + *
>> + * All objects which can be reset must implement this interface;
>> + * it is usually provided by a base class such as DeviceClass or
>> BusClass.
>> + * Every Resettable object must maintain some state tracking the
>> + * progress of a reset operation by providing a ResettableState
>> structure.
>> + * The functions defined in this module take care of updating the
>> + * state of the reset.
>> + * The base class implementation of the interface provides this
>> + * state and implements the associated method: get_state.
>> + *
>> + * Concrete object implementations (typically specific devices
>> + * such as a UART model) should provide the functions
>> + * for the phases.enter, phases.hold and phases.exit methods, which
>> + * they can set in their class init function, either directly or
>> + * by calling resettable_class_set_parent_phases().
>> + * The phase methods are guaranteed to only only ever be called once
>> + * for any reset event, in the order 'enter', 'hold', 'exit'.
>> + * An object will always move quickly from 'enter' to 'hold'
>> + * but might remain in 'hold' for an arbitrary period of time
>> + * before eventually reset is deasserted and the 'exit' phase is call=
ed.
>> + * Object implementations should be prepared for functions handling
>> + * inbound connections from other devices (such as qemu_irq handler
>> + * functions) to be called at any point during reset after their
>> + * 'enter' method has been called.
>> + *
>> + * Users of a resettable object should not call these methods
>> + * directly, but instead use the function resettable_reset().
>> + *
>> + * @phases.enter: This phase is called when the object enters reset. =
It
>> + * should reset local state of the object, but it must not do
>> anything that
>> + * has a side-effect on other objects, such as raising or lowering a
>> qemu_irq
>> + * line or reading or writing guest memory. It takes the reset's type=
 as
>> + * argument.
>> + *
>> + * @phases.hold: This phase is called for entry into reset, once
>> every object
>> + * in the system which is being reset has had its @phases.enter
>> method called.
>> + * At this point devices can do actions that affect other objects.
>> + *
>> + * @phases.exit: This phase is called when the object leaves the
>> reset state.
>> + * Actions affecting other objects are permitted.
>> + *
>> + * @get_state: Mandatory method which must return a pointer to a
>> + * ResettableState.
>> + *
>> + * @get_transitional_function: transitional method to handle
>> Resettable objects
>> + * not yet fully moved to this interface. It will be removed as soon
>> as it is
>> + * not needed anymore. This method is optional and may return a
>> pointer to a
>> + * function to be used instead of the phases. If the method exists
>> and returns
>> + * a non-NULL function pointer then that function is executed as a
>> replacement
>> + * of the 'hold' phase method taking the object as argument. The two
>> other phase
>> + * methods are not executed.
>> + *
>> + * @child_foreach: Executes a given callback on every Resettable
>> child. Child
>> + * in this context means a child in the qbus tree, so the children of
>> a qbus
>> + * are the devices on it, and the children of a device are all the
>> buses it
>> + * owns. This is not the same as the QOM object hierarchy. The
>> function takes
>> + * additional opaque and ResetType arguments which must be passed
>> unmodified to
>> + * the callback.
>> + */
>> +typedef void (*ResettableEnterPhase)(Object *obj, ResetType type);
>> +typedef void (*ResettableHoldPhase)(Object *obj);
>> +typedef void (*ResettableExitPhase)(Object *obj);
>> +typedef ResettableState * (*ResettableGetState)(Object *obj);
>> +typedef void (*ResettableTrFunction)(Object *obj);
>> +typedef ResettableTrFunction (*ResettableGetTrFunction)(Object *obj);
>> +typedef void (*ResettableChildCallback)(Object *, void *opaque,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ResetType type);
>> +typedef void (*ResettableChildForeach)(Object *obj,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ResettableChildCallback cb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 void *opaque, ResetType type);
>> +typedef struct ResettablePhases {
>> +=C2=A0=C2=A0=C2=A0 ResettableEnterPhase enter;
>> +=C2=A0=C2=A0=C2=A0 ResettableHoldPhase hold;
>> +=C2=A0=C2=A0=C2=A0 ResettableExitPhase exit;
>> +} ResettablePhases;
>> +typedef struct ResettableClass {
>> +=C2=A0=C2=A0=C2=A0 InterfaceClass parent_class;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Phase methods */
>> +=C2=A0=C2=A0=C2=A0 ResettablePhases phases;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* State access method */
>> +=C2=A0=C2=A0=C2=A0 ResettableGetState get_state;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Transitional method for legacy reset compatibil=
ity */
>> +=C2=A0=C2=A0=C2=A0 ResettableGetTrFunction get_transitional_function;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Hierarchy handling method */
>> +=C2=A0=C2=A0=C2=A0 ResettableChildForeach child_foreach;
>> +} ResettableClass;
>> +
>> +/**
>> + * ResettableState:
>> + * Structure holding reset related state. The fields should not be
>> accessed
>> + * directly; the definition is here to allow further inclusion into
>> other
>> + * objects.
>> + *
>> + * @count: Number of reset level the object is into. It is
>> incremented when
>> + * the reset operation starts and decremented when it finishes.
>> + * @hold_phase_pending: flag which indicates that we need to invoke
>> the 'hold'
>> + * phase handler for this object.
>> + * @exit_phase_in_progress: true if we are currently in the exit phas=
e
>> + */
>> +struct ResettableState {
>> +=C2=A0=C2=A0=C2=A0 uint32_t count;
>> +=C2=A0=C2=A0=C2=A0 bool hold_phase_pending;
>> +=C2=A0=C2=A0=C2=A0 bool exit_phase_in_progress;
>> +};
>> +
>> +/**
>> + * resettable_reset:
>> + * Trigger a reset on an object @obj of type @type. @obj must impleme=
nt
>> + * Resettable interface.
>> + *
>> + * Calling this function is equivalent to calling
>> @resettable_assert_reset()
>> + * then @resettable_release_reset().
>> + */
>> +void resettable_reset(Object *obj, ResetType type);
>> +
>> +/**
>> + * resettable_assert_reset:
>> + * Put an object @obj into reset. @obj must implement Resettable
>> interface.
>> + *
>> + * @resettable_release_reset() must eventually be called after this
>> call.
>> + * There must be one call to @resettable_release_reset() per call of
>> + * @resettable_assert_reset(), with the same type argument.
>> + *
>> + * NOTE: Until support for migration is added, the
>> @resettable_release_reset()
>> + * must not be delayed. It must occur just after
>> @resettable_assert_reset() so
>> + * that migration cannot be triggered in between. Prefer using
>> + * @resettable_reset() for now.
>> + */
>> +void resettable_assert_reset(Object *obj, ResetType type);
>> +
>> +/**
>> + * resettable_release_reset:
>> + * Release the object @obj from reset. @obj must implement Resettable
>> interface.
>> + *
>> + * See @resettable_assert_reset() description for details.
>> + */
>> +void resettable_release_reset(Object *obj, ResetType type);
>> +
>> +/**
>> + * resettable_is_in_reset:
>> + * Return true if @obj is under reset.
>> + *
>> + * @obj must implement Resettable interface.
>> + */
>> +bool resettable_is_in_reset(Object *obj);
>> +
>> +/**
>> + * resettable_class_set_parent_phases:
>> + *
>> + * Save @rc current reset phases into @parent_phases and override @rc
>> phases
>> + * by the given new methods (@enter, @hold and @exit).
>> + * Each phase is overridden only if the new one is not NULL allowing =
to
>> + * override a subset of phases.
>> + */
>> +void resettable_class_set_parent_phases(ResettableClass *rc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ResettableEnterPhase enter,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ResettableHoldPhase hold,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ResettableExitPhase exit,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ResettablePhases
>> *parent_phases);
>> +
>> +#endif
>> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
>> new file mode 100644
>> index 0000000000..9133208487
>> --- /dev/null
>> +++ b/hw/core/resettable.c
>> @@ -0,0 +1,238 @@
>> +/*
>> + * Resettable interface.
>> + *
>> + * Copyright (c) 2019 GreenSocs SAS
>> + *
>> + * Authors:
>> + *=C2=A0=C2=A0 Damien Hedde
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/module.h"
>> +#include "hw/resettable.h"
>> +#include "trace.h"
>> +
>> +/**
>> + * resettable_phase_enter/hold/exit:
>> + * Function executing a phase recursively in a resettable object and =
its
>> + * children.
>> + */
>> +static void resettable_phase_enter(Object *obj, void *opaque,
>> ResetType type);
>> +static void resettable_phase_hold(Object *obj, void *opaque,
>> ResetType type);
>> +static void resettable_phase_exit(Object *obj, void *opaque,
>> ResetType type);
>> +
>> +/**
>> + * enter_phase_in_progress:
>> + * True if we are currently in reset enter phase.
>> + *
>> + * Note: This flag is only used to guarantee (using asserts) that the
>> reset
>> + * API is used correctly. We can use a global variable because we
>> rely on the
>> + * iothread mutex to ensure only one reset operation is in a progress
>> at a
>> + * given time.
>> + */
>> +static bool enter_phase_in_progress;
>> +
>> +void resettable_reset(Object *obj, ResetType type)
>> +{
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_reset(obj, type);
>> +=C2=A0=C2=A0=C2=A0 resettable_assert_reset(obj, type);
>> +=C2=A0=C2=A0=C2=A0 resettable_release_reset(obj, type);
>> +}
>> +
>> +void resettable_assert_reset(Object *obj, ResetType type)
>> +{
>> +=C2=A0=C2=A0=C2=A0 /* TODO: change this assert when adding support fo=
r other reset
>> types */
>> +=C2=A0=C2=A0=C2=A0 assert(type =3D=3D RESET_TYPE_COLD);
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_reset_assert_begin(obj, type);
>> +=C2=A0=C2=A0=C2=A0 assert(!enter_phase_in_progress);
>> +
>> +=C2=A0=C2=A0=C2=A0 enter_phase_in_progress =3D true;
>> +=C2=A0=C2=A0=C2=A0 resettable_phase_enter(obj, NULL, type);
>> +=C2=A0=C2=A0=C2=A0 enter_phase_in_progress =3D false;
>> +
>> +=C2=A0=C2=A0=C2=A0 resettable_phase_hold(obj, NULL, type);
>> +
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_reset_assert_end(obj);
>> +}
>> +
>> +void resettable_release_reset(Object *obj, ResetType type)
>> +{
>> +=C2=A0=C2=A0=C2=A0 /* TODO: change this assert when adding support fo=
r other reset
>> types */
>> +=C2=A0=C2=A0=C2=A0 assert(type =3D=3D RESET_TYPE_COLD);
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_reset_release_begin(obj, type);
>> +=C2=A0=C2=A0=C2=A0 assert(!enter_phase_in_progress);
>> +
>> +=C2=A0=C2=A0=C2=A0 resettable_phase_exit(obj, NULL, type);
>> +
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_reset_release_end(obj);
>> +}
>> +
>> +bool resettable_is_in_reset(Object *obj)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
>> +=C2=A0=C2=A0=C2=A0 ResettableState *s =3D rc->get_state(obj);
>> +
>> +=C2=A0=C2=A0=C2=A0 return s->count > 0;
>> +}
>> +
>> +/**
>> + * resettable_child_foreach:
>> + * helper to avoid checking the existence of the method.
>> + */
>> +static void resettable_child_foreach(ResettableClass *rc, Object *obj=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ResettableChildCallback cb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
void *opaque, ResetType type)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (rc->child_foreach) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc->child_foreach(obj, cb,=
 opaque, type);
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +/**
>> + * resettable_get_tr_func:
>> + * helper to fetch transitional reset callback if any.
>> + */
>> +static ResettableTrFunction resettable_get_tr_func(ResettableClass *r=
c,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Object *obj)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ResettableTrFunction tr_func =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 if (rc->get_transitional_function) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tr_func =3D rc->get_transi=
tional_function(obj);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return tr_func;
>> +}
>> +
>> +static void resettable_phase_enter(Object *obj, void *opaque,
>> ResetType type)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
>> +=C2=A0=C2=A0=C2=A0 ResettableState *s =3D rc->get_state(obj);
>> +=C2=A0=C2=A0=C2=A0 const char *obj_typename =3D object_get_typename(o=
bj);
>> +=C2=A0=C2=A0=C2=A0 bool action_needed =3D false;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* exit phase has to finish properly before enteri=
ng back in
>> reset */
>> +=C2=A0=C2=A0=C2=A0 assert(!s->exit_phase_in_progress);
>> +
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_phase_enter_begin(obj, obj_typena=
me, s->count,
>> type);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Only take action if we really enter reset for t=
he 1st time. */
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * TODO: if adding more ResetType support, so=
me additional checks
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * are probably needed here.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (s->count++ =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 action_needed =3D true;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We limit the count to an arbitrary "big" v=
alue. The value is big
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * enough not to be triggered normally.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The assert will stop an infinite loop if t=
here is a cycle in the
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset tree. The loop goes through resettab=
le_foreach_child below
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * which at some point will call us again.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 assert(s->count <=3D 50);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * handle the children even if action_needed =
is at false so that
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * child counts are incremented too
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 resettable_child_foreach(rc, obj, resettable_phase=
_enter, NULL,
>> type);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* execute enter phase for the object if needed */
>> +=C2=A0=C2=A0=C2=A0 if (action_needed) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_resettable_phase_ent=
er_exec(obj, obj_typename, type,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 !!rc->phases.enter);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc->phases.enter && !r=
esettable_get_tr_func(rc, obj)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=
->phases.enter(obj, type);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->hold_phase_pending =3D =
true;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_phase_enter_end(obj, obj_typename=
, s->count);
>> +}
>> +
>> +static void resettable_phase_hold(Object *obj, void *opaque,
>> ResetType type)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
>> +=C2=A0=C2=A0=C2=A0 ResettableState *s =3D rc->get_state(obj);
>> +=C2=A0=C2=A0=C2=A0 const char *obj_typename =3D object_get_typename(o=
bj);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* exit phase has to finish properly before enteri=
ng back in
>> reset */
>> +=C2=A0=C2=A0=C2=A0 assert(!s->exit_phase_in_progress);
>> +
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_phase_hold_begin(obj, obj_typenam=
e, s->count,
>> type);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* handle children first */
>> +=C2=A0=C2=A0=C2=A0 resettable_child_foreach(rc, obj, resettable_phase=
_hold, NULL,
>> type);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* exec hold phase */
>> +=C2=A0=C2=A0=C2=A0 if (s->hold_phase_pending) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->hold_phase_pending =3D =
false;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ResettableTrFunction tr_fu=
nc =3D resettable_get_tr_func(rc, obj);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_resettable_phase_hol=
d_exec(obj, obj_typename,
>> !!rc->phases.hold);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tr_func) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tr=
ace_resettable_transitional_function(obj, obj_typename);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tr=
_func(obj);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (rc->phases.hold=
) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=
->phases.hold(obj);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_phase_hold_end(obj, obj_typename,=
 s->count);
>> +}
>> +
>> +static void resettable_phase_exit(Object *obj, void *opaque,
>> ResetType type)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
>> +=C2=A0=C2=A0=C2=A0 ResettableState *s =3D rc->get_state(obj);
>> +=C2=A0=C2=A0=C2=A0 const char *obj_typename =3D object_get_typename(o=
bj);
>> +
>> +=C2=A0=C2=A0=C2=A0 assert(!s->exit_phase_in_progress);
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_phase_exit_begin(obj, obj_typenam=
e, s->count,
>> type);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* exit_phase_in_progress ensures this phase is 'a=
tomic' */
>> +=C2=A0=C2=A0=C2=A0 s->exit_phase_in_progress =3D true;
>> +=C2=A0=C2=A0=C2=A0 resettable_child_foreach(rc, obj, resettable_phase=
_exit, NULL,
>> type);
>> +
>> +=C2=A0=C2=A0=C2=A0 assert(s->count > 0);
>> +=C2=A0=C2=A0=C2=A0 if (s->count =3D=3D 1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_resettable_phase_exi=
t_exec(obj, obj_typename,
>> !!rc->phases.exit);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc->phases.exit && !re=
settable_get_tr_func(rc, obj)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=
->phases.exit(obj);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->count =3D 0;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 s->exit_phase_in_progress =3D false;
>> +=C2=A0=C2=A0=C2=A0 trace_resettable_phase_exit_end(obj, obj_typename,=
 s->count);
>> +}
>> +
>> +void resettable_class_set_parent_phases(ResettableClass *rc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ResettableEnterPhase enter,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ResettableHoldPhase hold,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ResettableExitPhase exit,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ResettablePhases *parent_phases)
>> +{
>> +=C2=A0=C2=A0=C2=A0 *parent_phases =3D rc->phases;
>> +=C2=A0=C2=A0=C2=A0 if (enter) {
>=20
> Why care about checking if handlers are not NULL? It is not like you ar=
e
> overwriting a pointer previously set.

It may be previously set. You may just want to override one of the 3
phases and inherit the 2 others from the parent class version.

>=20
> Anyway:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc->phases.enter =3D enter=
;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (hold) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc->phases.hold =3D hold;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (exit) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc->phases.exit =3D exit;
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +static const TypeInfo resettable_interface_info =3D {
>> +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D TYPE=
_RESETTABLE_INTERFACE,
>> +=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=A0=C2=A0=C2=A0 =3D TYPE_INTERFACE=
,
>> +=C2=A0=C2=A0=C2=A0 .class_size =3D sizeof(ResettableClass),
>> +};
>> +
>> +static void reset_register_types(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 type_register_static(&resettable_interface_info);
>> +}
>> +
>> +type_init(reset_register_types)
>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>> index 0edd9e635d..1709a122d4 100644
>> --- a/hw/core/Makefile.objs
>> +++ b/hw/core/Makefile.objs
>> @@ -1,6 +1,7 @@
>> =C2=A0 # core qdev-related obj files, also used by *-user:
>> =C2=A0 common-obj-y +=3D qdev.o qdev-properties.o
>> =C2=A0 common-obj-y +=3D bus.o reset.o
>> +common-obj-y +=3D resettable.o
>> =C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
>> =C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
>> =C2=A0 # irq.o needed for qdev GPIO handling:
>> diff --git a/hw/core/trace-events b/hw/core/trace-events
>> index a375aa88a4..a2e43f1120 100644
>> --- a/hw/core/trace-events
>> +++ b/hw/core/trace-events
>> @@ -9,3 +9,20 @@ qbus_reset(void *obj, const char *objtype) "obj=3D%p(=
%s)"
>> =C2=A0 qbus_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
>> =C2=A0 qbus_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
>> =C2=A0 qdev_update_parent_bus(void *obj, const char *objtype, void *ol=
dp,
>> const char *oldptype, void *newp, const char *newptype) "obj=3D%p(%s)
>> old_parent=3D%p(%s) new_parent=3D%p(%s)"
>> +
>> +# resettable.c
>> +resettable_reset(void *obj, int cold) "obj=3D%p cold=3D%d"
>> +resettable_reset_assert_begin(void *obj, int cold) "obj=3D%p cold=3D%=
d"
>> +resettable_reset_assert_end(void *obj) "obj=3D%p"
>> +resettable_reset_release_begin(void *obj, int cold) "obj=3D%p cold=3D=
%d"
>> +resettable_reset_release_end(void *obj) "obj=3D%p"
>> +resettable_phase_enter_begin(void *obj, const char *objtype, uint32_t
>> count, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
>> +resettable_phase_enter_exec(void *obj, const char *objtype, int type,
>> int has_method) "obj=3D%p(%s) type=3D%d method=3D%d"
>> +resettable_phase_enter_end(void *obj, const char *objtype, uint32_t
>> count) "obj=3D%p(%s) count=3D%" PRIu32
>> +resettable_phase_hold_begin(void *obj, const char *objtype, uint32_t
>> count, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
>> +resettable_phase_hold_exec(void *obj, const char *objtype, int
>> has_method) "obj=3D%p(%s) method=3D%d"
>> +resettable_phase_hold_end(void *obj, const char *objtype, uint32_t
>> count) "obj=3D%p(%s) count=3D%" PRIu32
>> +resettable_phase_exit_begin(void *obj, const char *objtype, uint32_t
>> count, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
>> +resettable_phase_exit_exec(void *obj, const char *objtype, int
>> has_method) "obj=3D%p(%s) method=3D%d"
>> +resettable_phase_exit_end(void *obj, const char *objtype, uint32_t
>> count) "obj=3D%p(%s) count=3D%" PRIu32
>> +resettable_transitional_function(void *obj, const char *objtype)
>> "obj=3D%p(%s)"
>>
>=20

