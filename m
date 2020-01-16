Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26316C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52DC2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSezW/3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52DC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iruUS-0004sQ-12
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 21:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iruTH-0003mp-In
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iruTD-0006W5-HR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:01:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58315
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iruTD-0006TG-CA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579140074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0O9QjusSXnCYP1fBLH0HRnwjWaPAUzBFXsbqxqduxo=;
 b=eSezW/3eIE9IOWEDhEG38Etwq4zF68vESTkKxhSEZXm5cYNodt6vOydbdYVH3nY4yYzi5+
 WCV483Q9KcVVRvH/qQkeCn30wuMwyXbIlWLrsVoN21x5Ww3tITQqOTzwrTvt/sg8QGqtK0
 6Tojhj6AWdCdjbVox+U2N7IHTwxIIwU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-s8Zs7LNCMq-u8hfekBcbhA-1; Wed, 15 Jan 2020 21:01:09 -0500
Received: by mail-wr1-f71.google.com with SMTP id r2so8666676wrp.7
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 18:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HcUXIm+JVUzSBSz5BATW3FaoS+pCFl78Z+vlLstCaGg=;
 b=mDUSb1PQNEPkHCB8BwKXbA9fXwnUSKqDNhxI4+6hrVTZ4Sw1Vn+pBNoxVvhV7zxcWb
 Nupn7rUckk9AC1LDTqDxzBlJwGFR1xcr5fbfvH2OwZ6NRIkJ6iOEsBqNbI1H56UAFxtw
 vuR1Ua1+fOoSGRcRPGMoPl1jyUDbYUnlWo28q7vc2pkBSPKsvdCRSh9BawwMI9XoLBjU
 JwLhEXk53fzrYFwkp8tATBkQhG8dmiB6ITzDsTycIvxUZM1PrxDZ/iQdO0qpi8JjjfTg
 dGTm5tIT5mxESPWPTEN/3XVpk1/5UifasXIilg6dL6hu4z1Xs0EfpvBDAZVSKFeEZEfq
 FkLg==
X-Gm-Message-State: APjAAAWIx4iFLMdOzrC/gJU+bftlSN8Zk53n1UZ6jt85iBIeTSopCynW
 myknP0HUnH64kdQBcvuM5QThJsnseg5pCjVw7KrIukFgymuQlHVHc1mxkZrB0HM45sIbmruRyJq
 +KLMLYfJKEW+UQiw=
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr307590wrs.159.1579140065953;
 Wed, 15 Jan 2020 18:01:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOLSEOal02h8HfhyDC3NVo0KlJmFMkjSGy5t237F1bQVntjUF+FZCLLoJiCkJlnLn2qMTsRw==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr307521wrs.159.1579140065267;
 Wed, 15 Jan 2020 18:01:05 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id c5sm2453760wmb.9.2020.01.15.17.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 18:01:04 -0800 (PST)
Subject: Re: [PATCH v7 03/11] hw/core: create Resettable QOM interface
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-4-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <656ee01a-54ad-273f-e71e-873328428565@redhat.com>
Date: Thu, 16 Jan 2020 02:59:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115123620.250132-4-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: s8Zs7LNCMq-u8hfekBcbhA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 Paolo Bonzini <pbonzini@redhat.com>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 1:36 PM, Damien Hedde wrote:
> This commit defines an interface allowing multi-phase reset. This aims
> to solve a problem of the actual single-phase reset (built in
> DeviceClass and BusClass): reset behavior is dependent on the order
> in which reset handlers are called. In particular doing external
> side-effect (like setting an qemu_irq) is problematic because receiving
> object may not be reset yet.
>=20
> The Resettable interface divides the reset in 3 well defined phases.
> To reset an object tree, all 1st phases are executed then all 2nd then
> all 3rd. See the comments in include/hw/resettable.h for a more complete
> description. The interface defines 3 phases to let the future
> possibility of holding an object into reset for some time.
>=20
> The qdev/qbus reset in DeviceClass and BusClass will be modified in
> following commits to use this interface. A mechanism is provided
> to allow executing a transitional reset handler in place of the 2nd
> phase which is executed in children-then-parent order inside a tree.
> This will allow to transition devices and buses smoothly while
> keeping the exact current qdev/qbus reset behavior for now.
>=20
> Documentation will be added in a following commit.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>=20
> v7 update: un-nest struct ResettablePhases
> ---
>   Makefile.objs           |   1 +
>   include/hw/resettable.h | 211 +++++++++++++++++++++++++++++++++++
>   hw/core/resettable.c    | 238 ++++++++++++++++++++++++++++++++++++++++
>   hw/core/Makefile.objs   |   1 +
>   hw/core/trace-events    |  17 +++
>   5 files changed, 468 insertions(+)
>   create mode 100644 include/hw/resettable.h
>   create mode 100644 hw/core/resettable.c
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index 7c1e50f9d6..9752d549b4 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -191,6 +191,7 @@ trace-events-subdirs +=3D migration
>   trace-events-subdirs +=3D net
>   trace-events-subdirs +=3D ui
>   endif
> +trace-events-subdirs +=3D hw/core

TL;DR Duplicating this line breaks using the LTTng Userspace Tracer=20
library (UST backend).

Probably because you started this series before commit 26b8e6dc42b got=20
merged, Jun 13 2019!

Indeed Oct 02 2018...
https://www.mail-archive.com/qemu-devel@nongnu.org/msg564153.html

The problem is you (correctly) sorted alphabetically while Alexey=20
appended at the end.

>   trace-events-subdirs +=3D hw/display
>   trace-events-subdirs +=3D qapi
>   trace-events-subdirs +=3D qom
> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
> new file mode 100644
> index 0000000000..58b3df4c22
> --- /dev/null
> +++ b/include/hw/resettable.h
> @@ -0,0 +1,211 @@
> +/*
> + * Resettable interface header.
> + *
> + * Copyright (c) 2019 GreenSocs SAS
> + *
> + * Authors:
> + *   Damien Hedde
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_RESETTABLE_H
> +#define HW_RESETTABLE_H
> +
> +#include "qom/object.h"
> +
> +#define TYPE_RESETTABLE_INTERFACE "resettable"
> +
> +#define RESETTABLE_CLASS(class) \
> +    OBJECT_CLASS_CHECK(ResettableClass, (class), TYPE_RESETTABLE_INTERFA=
CE)
> +
> +#define RESETTABLE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(ResettableClass, (obj), TYPE_RESETTABLE_INTERFACE)
> +
> +typedef struct ResettableState ResettableState;
> +
> +/**
> + * ResetType:
> + * Types of reset.
> + *
> + * + Cold: reset resulting from a power cycle of the object.
> + *
> + * TODO: Support has to be added to handle more types. In particular,
> + * ResettableState structure needs to be expanded.
> + */
> +typedef enum ResetType {
> +    RESET_TYPE_COLD,
> +} ResetType;
> +
> +/*
> + * ResettableClass:
> + * Interface for resettable objects.
> + *
> + * See docs/devel/reset.rst for more detailed information about how QEMU=
 models
> + * reset. This whole API must only be used when holding the iothread mut=
ex.
> + *
> + * All objects which can be reset must implement this interface;
> + * it is usually provided by a base class such as DeviceClass or BusClas=
s.
> + * Every Resettable object must maintain some state tracking the
> + * progress of a reset operation by providing a ResettableState structur=
e.
> + * The functions defined in this module take care of updating the
> + * state of the reset.
> + * The base class implementation of the interface provides this
> + * state and implements the associated method: get_state.
> + *
> + * Concrete object implementations (typically specific devices
> + * such as a UART model) should provide the functions
> + * for the phases.enter, phases.hold and phases.exit methods, which
> + * they can set in their class init function, either directly or
> + * by calling resettable_class_set_parent_phases().
> + * The phase methods are guaranteed to only only ever be called once
> + * for any reset event, in the order 'enter', 'hold', 'exit'.
> + * An object will always move quickly from 'enter' to 'hold'
> + * but might remain in 'hold' for an arbitrary period of time
> + * before eventually reset is deasserted and the 'exit' phase is called.
> + * Object implementations should be prepared for functions handling
> + * inbound connections from other devices (such as qemu_irq handler
> + * functions) to be called at any point during reset after their
> + * 'enter' method has been called.
> + *
> + * Users of a resettable object should not call these methods
> + * directly, but instead use the function resettable_reset().
> + *
> + * @phases.enter: This phase is called when the object enters reset. It
> + * should reset local state of the object, but it must not do anything t=
hat
> + * has a side-effect on other objects, such as raising or lowering a qem=
u_irq
> + * line or reading or writing guest memory. It takes the reset's type as
> + * argument.
> + *
> + * @phases.hold: This phase is called for entry into reset, once every o=
bject
> + * in the system which is being reset has had its @phases.enter method c=
alled.
> + * At this point devices can do actions that affect other objects.
> + *
> + * @phases.exit: This phase is called when the object leaves the reset s=
tate.
> + * Actions affecting other objects are permitted.
> + *
> + * @get_state: Mandatory method which must return a pointer to a
> + * ResettableState.
> + *
> + * @get_transitional_function: transitional method to handle Resettable =
objects
> + * not yet fully moved to this interface. It will be removed as soon as =
it is
> + * not needed anymore. This method is optional and may return a pointer =
to a
> + * function to be used instead of the phases. If the method exists and r=
eturns
> + * a non-NULL function pointer then that function is executed as a repla=
cement
> + * of the 'hold' phase method taking the object as argument. The two oth=
er phase
> + * methods are not executed.
> + *
> + * @child_foreach: Executes a given callback on every Resettable child. =
Child
> + * in this context means a child in the qbus tree, so the children of a =
qbus
> + * are the devices on it, and the children of a device are all the buses=
 it
> + * owns. This is not the same as the QOM object hierarchy. The function =
takes
> + * additional opaque and ResetType arguments which must be passed unmodi=
fied to
> + * the callback.
> + */
> +typedef void (*ResettableEnterPhase)(Object *obj, ResetType type);
> +typedef void (*ResettableHoldPhase)(Object *obj);
> +typedef void (*ResettableExitPhase)(Object *obj);
> +typedef ResettableState * (*ResettableGetState)(Object *obj);
> +typedef void (*ResettableTrFunction)(Object *obj);
> +typedef ResettableTrFunction (*ResettableGetTrFunction)(Object *obj);
> +typedef void (*ResettableChildCallback)(Object *, void *opaque,
> +                                        ResetType type);
> +typedef void (*ResettableChildForeach)(Object *obj,
> +                                       ResettableChildCallback cb,
> +                                       void *opaque, ResetType type);
> +typedef struct ResettablePhases {
> +    ResettableEnterPhase enter;
> +    ResettableHoldPhase hold;
> +    ResettableExitPhase exit;
> +} ResettablePhases;
> +typedef struct ResettableClass {
> +    InterfaceClass parent_class;
> +
> +    /* Phase methods */
> +    ResettablePhases phases;
> +
> +    /* State access method */
> +    ResettableGetState get_state;
> +
> +    /* Transitional method for legacy reset compatibility */
> +    ResettableGetTrFunction get_transitional_function;
> +
> +    /* Hierarchy handling method */
> +    ResettableChildForeach child_foreach;
> +} ResettableClass;
> +
> +/**
> + * ResettableState:
> + * Structure holding reset related state. The fields should not be acces=
sed
> + * directly; the definition is here to allow further inclusion into othe=
r
> + * objects.
> + *
> + * @count: Number of reset level the object is into. It is incremented w=
hen
> + * the reset operation starts and decremented when it finishes.
> + * @hold_phase_pending: flag which indicates that we need to invoke the =
'hold'
> + * phase handler for this object.
> + * @exit_phase_in_progress: true if we are currently in the exit phase
> + */
> +struct ResettableState {
> +    uint32_t count;
> +    bool hold_phase_pending;
> +    bool exit_phase_in_progress;
> +};
> +
> +/**
> + * resettable_reset:
> + * Trigger a reset on an object @obj of type @type. @obj must implement
> + * Resettable interface.
> + *
> + * Calling this function is equivalent to calling @resettable_assert_res=
et()
> + * then @resettable_release_reset().
> + */
> +void resettable_reset(Object *obj, ResetType type);
> +
> +/**
> + * resettable_assert_reset:
> + * Put an object @obj into reset. @obj must implement Resettable interfa=
ce.
> + *
> + * @resettable_release_reset() must eventually be called after this call=
.
> + * There must be one call to @resettable_release_reset() per call of
> + * @resettable_assert_reset(), with the same type argument.
> + *
> + * NOTE: Until support for migration is added, the @resettable_release_r=
eset()
> + * must not be delayed. It must occur just after @resettable_assert_rese=
t() so
> + * that migration cannot be triggered in between. Prefer using
> + * @resettable_reset() for now.
> + */
> +void resettable_assert_reset(Object *obj, ResetType type);
> +
> +/**
> + * resettable_release_reset:
> + * Release the object @obj from reset. @obj must implement Resettable in=
terface.
> + *
> + * See @resettable_assert_reset() description for details.
> + */
> +void resettable_release_reset(Object *obj, ResetType type);
> +
> +/**
> + * resettable_is_in_reset:
> + * Return true if @obj is under reset.
> + *
> + * @obj must implement Resettable interface.
> + */
> +bool resettable_is_in_reset(Object *obj);
> +
> +/**
> + * resettable_class_set_parent_phases:
> + *
> + * Save @rc current reset phases into @parent_phases and override @rc ph=
ases
> + * by the given new methods (@enter, @hold and @exit).
> + * Each phase is overridden only if the new one is not NULL allowing to
> + * override a subset of phases.
> + */
> +void resettable_class_set_parent_phases(ResettableClass *rc,
> +                                        ResettableEnterPhase enter,
> +                                        ResettableHoldPhase hold,
> +                                        ResettableExitPhase exit,
> +                                        ResettablePhases *parent_phases)=
;
> +
> +#endif
> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
> new file mode 100644
> index 0000000000..9133208487
> --- /dev/null
> +++ b/hw/core/resettable.c
> @@ -0,0 +1,238 @@
> +/*
> + * Resettable interface.
> + *
> + * Copyright (c) 2019 GreenSocs SAS
> + *
> + * Authors:
> + *   Damien Hedde
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "hw/resettable.h"
> +#include "trace.h"
> +
> +/**
> + * resettable_phase_enter/hold/exit:
> + * Function executing a phase recursively in a resettable object and its
> + * children.
> + */
> +static void resettable_phase_enter(Object *obj, void *opaque, ResetType =
type);
> +static void resettable_phase_hold(Object *obj, void *opaque, ResetType t=
ype);
> +static void resettable_phase_exit(Object *obj, void *opaque, ResetType t=
ype);
> +
> +/**
> + * enter_phase_in_progress:
> + * True if we are currently in reset enter phase.
> + *
> + * Note: This flag is only used to guarantee (using asserts) that the re=
set
> + * API is used correctly. We can use a global variable because we rely o=
n the
> + * iothread mutex to ensure only one reset operation is in a progress at=
 a
> + * given time.
> + */
> +static bool enter_phase_in_progress;
> +
> +void resettable_reset(Object *obj, ResetType type)
> +{
> +    trace_resettable_reset(obj, type);
> +    resettable_assert_reset(obj, type);
> +    resettable_release_reset(obj, type);
> +}
> +
> +void resettable_assert_reset(Object *obj, ResetType type)
> +{
> +    /* TODO: change this assert when adding support for other reset type=
s */
> +    assert(type =3D=3D RESET_TYPE_COLD);
> +    trace_resettable_reset_assert_begin(obj, type);
> +    assert(!enter_phase_in_progress);
> +
> +    enter_phase_in_progress =3D true;
> +    resettable_phase_enter(obj, NULL, type);
> +    enter_phase_in_progress =3D false;
> +
> +    resettable_phase_hold(obj, NULL, type);
> +
> +    trace_resettable_reset_assert_end(obj);
> +}
> +
> +void resettable_release_reset(Object *obj, ResetType type)
> +{
> +    /* TODO: change this assert when adding support for other reset type=
s */
> +    assert(type =3D=3D RESET_TYPE_COLD);
> +    trace_resettable_reset_release_begin(obj, type);
> +    assert(!enter_phase_in_progress);
> +
> +    resettable_phase_exit(obj, NULL, type);
> +
> +    trace_resettable_reset_release_end(obj);
> +}
> +
> +bool resettable_is_in_reset(Object *obj)
> +{
> +    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
> +    ResettableState *s =3D rc->get_state(obj);
> +
> +    return s->count > 0;
> +}
> +
> +/**
> + * resettable_child_foreach:
> + * helper to avoid checking the existence of the method.
> + */
> +static void resettable_child_foreach(ResettableClass *rc, Object *obj,
> +                                     ResettableChildCallback cb,
> +                                     void *opaque, ResetType type)
> +{
> +    if (rc->child_foreach) {
> +        rc->child_foreach(obj, cb, opaque, type);
> +    }
> +}
> +
> +/**
> + * resettable_get_tr_func:
> + * helper to fetch transitional reset callback if any.
> + */
> +static ResettableTrFunction resettable_get_tr_func(ResettableClass *rc,
> +                                                   Object *obj)
> +{
> +    ResettableTrFunction tr_func =3D NULL;
> +    if (rc->get_transitional_function) {
> +        tr_func =3D rc->get_transitional_function(obj);
> +    }
> +    return tr_func;
> +}
> +
> +static void resettable_phase_enter(Object *obj, void *opaque, ResetType =
type)
> +{
> +    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
> +    ResettableState *s =3D rc->get_state(obj);
> +    const char *obj_typename =3D object_get_typename(obj);
> +    bool action_needed =3D false;
> +
> +    /* exit phase has to finish properly before entering back in reset *=
/
> +    assert(!s->exit_phase_in_progress);
> +
> +    trace_resettable_phase_enter_begin(obj, obj_typename, s->count, type=
);
> +
> +    /* Only take action if we really enter reset for the 1st time. */
> +    /*
> +     * TODO: if adding more ResetType support, some additional checks
> +     * are probably needed here.
> +     */
> +    if (s->count++ =3D=3D 0) {
> +        action_needed =3D true;
> +    }
> +    /*
> +     * We limit the count to an arbitrary "big" value. The value is big
> +     * enough not to be triggered normally.
> +     * The assert will stop an infinite loop if there is a cycle in the
> +     * reset tree. The loop goes through resettable_foreach_child below
> +     * which at some point will call us again.
> +     */
> +    assert(s->count <=3D 50);
> +
> +    /*
> +     * handle the children even if action_needed is at false so that
> +     * child counts are incremented too
> +     */
> +    resettable_child_foreach(rc, obj, resettable_phase_enter, NULL, type=
);
> +
> +    /* execute enter phase for the object if needed */
> +    if (action_needed) {
> +        trace_resettable_phase_enter_exec(obj, obj_typename, type,
> +                                          !!rc->phases.enter);
> +        if (rc->phases.enter && !resettable_get_tr_func(rc, obj)) {
> +            rc->phases.enter(obj, type);
> +        }
> +        s->hold_phase_pending =3D true;
> +    }
> +    trace_resettable_phase_enter_end(obj, obj_typename, s->count);
> +}
> +
> +static void resettable_phase_hold(Object *obj, void *opaque, ResetType t=
ype)
> +{
> +    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
> +    ResettableState *s =3D rc->get_state(obj);
> +    const char *obj_typename =3D object_get_typename(obj);
> +
> +    /* exit phase has to finish properly before entering back in reset *=
/
> +    assert(!s->exit_phase_in_progress);
> +
> +    trace_resettable_phase_hold_begin(obj, obj_typename, s->count, type)=
;
> +
> +    /* handle children first */
> +    resettable_child_foreach(rc, obj, resettable_phase_hold, NULL, type)=
;
> +
> +    /* exec hold phase */
> +    if (s->hold_phase_pending) {
> +        s->hold_phase_pending =3D false;
> +        ResettableTrFunction tr_func =3D resettable_get_tr_func(rc, obj)=
;
> +        trace_resettable_phase_hold_exec(obj, obj_typename, !!rc->phases=
.hold);
> +        if (tr_func) {
> +            trace_resettable_transitional_function(obj, obj_typename);
> +            tr_func(obj);
> +        } else if (rc->phases.hold) {
> +            rc->phases.hold(obj);
> +        }
> +    }
> +    trace_resettable_phase_hold_end(obj, obj_typename, s->count);
> +}
> +
> +static void resettable_phase_exit(Object *obj, void *opaque, ResetType t=
ype)
> +{
> +    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
> +    ResettableState *s =3D rc->get_state(obj);
> +    const char *obj_typename =3D object_get_typename(obj);
> +
> +    assert(!s->exit_phase_in_progress);
> +    trace_resettable_phase_exit_begin(obj, obj_typename, s->count, type)=
;
> +
> +    /* exit_phase_in_progress ensures this phase is 'atomic' */
> +    s->exit_phase_in_progress =3D true;
> +    resettable_child_foreach(rc, obj, resettable_phase_exit, NULL, type)=
;
> +
> +    assert(s->count > 0);
> +    if (s->count =3D=3D 1) {
> +        trace_resettable_phase_exit_exec(obj, obj_typename, !!rc->phases=
.exit);
> +        if (rc->phases.exit && !resettable_get_tr_func(rc, obj)) {
> +            rc->phases.exit(obj);
> +        }
> +        s->count =3D 0;
> +    }
> +    s->exit_phase_in_progress =3D false;
> +    trace_resettable_phase_exit_end(obj, obj_typename, s->count);
> +}
> +
> +void resettable_class_set_parent_phases(ResettableClass *rc,
> +                                        ResettableEnterPhase enter,
> +                                        ResettableHoldPhase hold,
> +                                        ResettableExitPhase exit,
> +                                        ResettablePhases *parent_phases)
> +{
> +    *parent_phases =3D rc->phases;
> +    if (enter) {
> +        rc->phases.enter =3D enter;
> +    }
> +    if (hold) {
> +        rc->phases.hold =3D hold;
> +    }
> +    if (exit) {
> +        rc->phases.exit =3D exit;
> +    }
> +}
> +
> +static const TypeInfo resettable_interface_info =3D {
> +    .name       =3D TYPE_RESETTABLE_INTERFACE,
> +    .parent     =3D TYPE_INTERFACE,
> +    .class_size =3D sizeof(ResettableClass),
> +};
> +
> +static void reset_register_types(void)
> +{
> +    type_register_static(&resettable_interface_info);
> +}
> +
> +type_init(reset_register_types)
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 0edd9e635d..1709a122d4 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -1,6 +1,7 @@
>   # core qdev-related obj files, also used by *-user:
>   common-obj-y +=3D qdev.o qdev-properties.o
>   common-obj-y +=3D bus.o reset.o
> +common-obj-y +=3D resettable.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
>   # irq.o needed for qdev GPIO handling:
> diff --git a/hw/core/trace-events b/hw/core/trace-events
> index a375aa88a4..a2e43f1120 100644
> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -9,3 +9,20 @@ qbus_reset(void *obj, const char *objtype) "obj=3D%p(%s)=
"
>   qbus_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
>   qbus_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
>   qdev_update_parent_bus(void *obj, const char *objtype, void *oldp, cons=
t char *oldptype, void *newp, const char *newptype) "obj=3D%p(%s) old_paren=
t=3D%p(%s) new_parent=3D%p(%s)"
> +
> +# resettable.c
> +resettable_reset(void *obj, int cold) "obj=3D%p cold=3D%d"
> +resettable_reset_assert_begin(void *obj, int cold) "obj=3D%p cold=3D%d"
> +resettable_reset_assert_end(void *obj) "obj=3D%p"
> +resettable_reset_release_begin(void *obj, int cold) "obj=3D%p cold=3D%d"
> +resettable_reset_release_end(void *obj) "obj=3D%p"
> +resettable_phase_enter_begin(void *obj, const char *objtype, uint32_t co=
unt, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
> +resettable_phase_enter_exec(void *obj, const char *objtype, int type, in=
t has_method) "obj=3D%p(%s) type=3D%d method=3D%d"
> +resettable_phase_enter_end(void *obj, const char *objtype, uint32_t coun=
t) "obj=3D%p(%s) count=3D%" PRIu32
> +resettable_phase_hold_begin(void *obj, const char *objtype, uint32_t cou=
nt, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
> +resettable_phase_hold_exec(void *obj, const char *objtype, int has_metho=
d) "obj=3D%p(%s) method=3D%d"
> +resettable_phase_hold_end(void *obj, const char *objtype, uint32_t count=
) "obj=3D%p(%s) count=3D%" PRIu32
> +resettable_phase_exit_begin(void *obj, const char *objtype, uint32_t cou=
nt, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
> +resettable_phase_exit_exec(void *obj, const char *objtype, int has_metho=
d) "obj=3D%p(%s) method=3D%d"
> +resettable_phase_exit_end(void *obj, const char *objtype, uint32_t count=
) "obj=3D%p(%s) count=3D%" PRIu32
> +resettable_transitional_function(void *obj, const char *objtype) "obj=3D=
%p(%s)"

Something here breaks ./configure --enable-trace-backends=3Dust:

   CC      trace-ust-all.o
In file included from trace-ust-all.h:13,
                  from trace-ust-all.c:13:
trace-ust-all.h:35151:1: error: redefinition of=20
=E2=80=98__tracepoint_cb_qemu___loader_write_rom=E2=80=99
35151 | TRACEPOINT_EVENT(
       | ^~~~~~~~~~~~~~~~
trace-ust-all.h:31791:1: note: previous definition of=20
=E2=80=98__tracepoint_cb_qemu___loader_write_rom=E2=80=99 was here
31791 | TRACEPOINT_EVENT(
       | ^~~~~~~~~~~~~~~~
...
./trace-ust-all.h:35388:1: error: redefinition of=20
=E2=80=98__tp_event_signature___qemu___resettable_transitional_function=E2=
=80=99
35388 | TRACEPOINT_EVENT(
       | ^~~~~~~~~~~~~~~~
./trace-ust-all.h:32028:1: note: previous definition of=20
=E2=80=98__tp_event_signature___qemu___resettable_transitional_function=E2=
=80=99 was here
32028 | TRACEPOINT_EVENT(
       | ^~~~~~~~~~~~~~~~
In file included from /usr/include/lttng/tracepoint-event.h:58,
                  from trace-ust-all.h:35401,
                  from trace-ust-all.c:13:

Indeed:

32028 TRACEPOINT_EVENT(
32029    qemu,
32030    resettable_transitional_function,
32031    TP_ARGS(void *, obj, const char *, objtype),
32032    TP_FIELDS(
32033        ctf_integer_hex(void *, obj, obj)
32034        ctf_string(objtype, objtype)
32035    )
32036 )
32037
...
35388 TRACEPOINT_EVENT(
35389    qemu,
35390    resettable_transitional_function,
35391    TP_ARGS(void *, obj, const char *, objtype),
35392    TP_FIELDS(
35393        ctf_integer_hex(void *, obj, obj)
35394        ctf_string(objtype, objtype)
35395    )
35396 )
35397
35398 #endif /* TRACE_ALL_GENERATED_UST_H */

Ah! I was going to say "no clue what could be wrong, so Cc'ing Stefan"=20
but got it:

$ git grep hw/core Makefile.objs
Makefile.objs:194:trace-events-subdirs +=3D hw/core
Makefile.objs:207:trace-events-subdirs +=3D hw/core

We might already have a 'uniq' makefile function to do:

trace-events-subdirs =3D $(call uniq $(trace-events-subdirs))

or maybe was it with $filter? I can't find it/remember, too tired.

So the fix is:

-- >8 --
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -191,7 +191,6 @@ trace-events-subdirs +=3D migration
  trace-events-subdirs +=3D net
  trace-events-subdirs +=3D ui
  endif
-trace-events-subdirs +=3D hw/core
  trace-events-subdirs +=3D hw/display
  trace-events-subdirs +=3D qapi
  trace-events-subdirs +=3D qom
---


