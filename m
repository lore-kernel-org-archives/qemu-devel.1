Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84067C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D98A20684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="6FiTQPDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D98A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itT6p-000322-49
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1itT3N-0000Lu-Ik
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1itT3J-0001xi-2m
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:09:01 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:34502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1itT3I-0001wZ-G9; Mon, 20 Jan 2020 04:08:57 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 035B096EF0;
 Mon, 20 Jan 2020 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579511334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8/LnW0bwcpK++QSmBYAdkhPwZFClrcBc3HzopR/Zbg=;
 b=6FiTQPDU7uS6rjJCQovnKCgg6ZcfTcG96wIaoZIaZxQWPrKhA1xiekFr4EhMnUhX87nmYP
 5jl68JCcumyqBaYDfcCvL5ZGbSWUKFps0aMv3vhT4Gq4sEdCKen3dMw1RMJ4P9c1vE0S9g
 uSn7IAxQPP68DM4qNJw8lsTZF365G5I=
Subject: Re: [PATCH v7 03/11] hw/core: create Resettable QOM interface
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-4-damien.hedde@greensocs.com>
 <b527f52b-a632-2044-4813-c06751b663ce@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <19a6a511-a259-8d25-cba6-7059fbe4fe6f@greensocs.com>
Date: Mon, 20 Jan 2020 10:08:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b527f52b-a632-2044-4813-c06751b663ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579511334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8/LnW0bwcpK++QSmBYAdkhPwZFClrcBc3HzopR/Zbg=;
 b=0FPAGVbyYVHn+L9zOmbWQriRxki49n2Fx2g/F1XOpVfkeFq0PXquBlNHQBjWceZ8/R3c7m
 FGU4XpWR5A/4glUea9zwQWnChe5adbQHEmoXVnqmOUntVeOhkU1sDrPbkIVXaEkSM4b3jf
 ifWxOwZCjCdlAzDweDuJLND9d3QwTz0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579511334; a=rsa-sha256; cv=none;
 b=2Hufd2y1MawrpmWxuBpOs5xvvWKBC/WUZYo11e6bo+ECzv9CMEtQWUQWbxfBIZO8k8xyCH
 OUmThrmfXSWUeFWmDFwBCpGr9HmdFHHqHiEbVtDRnxnZhUhphD68KySeFxoAR56Ht45Q0J
 1sKICZimXUCtRWcae364HbP0s/uT0f0=
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



On 1/18/20 7:42 AM, Philippe Mathieu-Daud=C3=A9 wrote:
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
>=20
> Maybe you can add this comment and the variable in patch 5/11, that
> would make patch 5 easier to review.

The variable is used in this patch so I cannot do that.

>=20
>> + * @hold_phase_pending: flag which indicates that we need to invoke
>> the 'hold'
>> + * phase handler for this object.
>> + * @exit_phase_in_progress: true if we are currently in the exit phas=
e
>> + */
>> +struct ResettableState {
>> +=C2=A0=C2=A0=C2=A0 uint32_t count;
>=20
> Maybe simply 'unsigned'?
>=20

Ok.

--
Damien





