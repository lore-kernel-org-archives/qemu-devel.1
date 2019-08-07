Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3226DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0ADE21BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="M633u7g6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0ADE21BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNUP-0006RC-6Z
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48155)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hvNTi-0005De-Q4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hvNTe-0007eZ-Ox
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:03:50 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hvNTS-0007Xy-8v; Wed, 07 Aug 2019 11:03:34 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 6FA5096F50;
 Wed,  7 Aug 2019 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1565190210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGgPSo8OASV2B9s03xYYtNSRmIW0lRXCTKHtweM9hEk=;
 b=M633u7g6RN3t9GiF8KkzPZ7zr64M1AulCQl8u8lBBwU4nr9/uIqJCwRbIQEW+KwEIbQxlQ
 x+USxArCaW1ngiNxbCPpUkQr4buPP6VKkVVuqIFkXhyI6yK1undMMdNkmYHDO8ijxrEo2+
 I8LvsRFQfcIptM4g++1OZtS5JV3obuY=
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-2-damien.hedde@greensocs.com>
 <CAFEAcA8y0+shxbRD0Fp4LF4+yeLvr02zpBT2anyhj+i_EhfmiQ@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <2467a694-08cc-f260-5fbb-b7cbcbd4ceee@greensocs.com>
Date: Wed, 7 Aug 2019 17:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8y0+shxbRD0Fp4LF4+yeLvr02zpBT2anyhj+i_EhfmiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1565190210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGgPSo8OASV2B9s03xYYtNSRmIW0lRXCTKHtweM9hEk=;
 b=n3VkgNmUwi8CH+ziTNdjZvjhpyxAclrxTQTf/G7c+rXm42F1Q4zLavBCjQ3HaAs/DARS/R
 1FaFjuDlXJ1mMZ8/1krAShdJ9pjeZCWV69GiQ09YScReIIS+FgvOIBzGzuVd0uz4NlmUcj
 XW7Z6/kILdHCvtY3D8HBK1NNC7Rwg5g=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1565190210; a=rsa-sha256; cv=none;
 b=DnGFX9uDUuAfyJdS4R1mbEeVIxP1ZPxOjmfhQEkPcunffLHVzD+iTSpEYi8b4fOpZKzEWt
 Z8OLZ9JhKZ9RUSpZgwMMHiooA7aUWUSB1A7+kzI9KbCUiYFMTnKKqvo6zhFCkYXmdkXEjf
 9d80fniGf1ywIkq1MLJ8TBk5d0dFqIA=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 01/33] Create Resettable QOM interface
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/7/19 4:20 PM, Peter Maydell wrote:
> On Mon, 29 Jul 2019 at 15:58, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> This commit defines an interface allowing multi-phase reset.
>> The phases are INIT, HOLD and EXIT. Each phase has an associated method
>> in the class.
>>
>> The reset of a Resettable is controlled with 2 functions:
>>   - resettable_assert_reset which starts the reset operation.
>>   - resettable_deassert_reset which ends the reset operation.
>>
>> There is also a `resettable_reset` helper function which does assert then
>> deassert allowing to do a proper reset in one call.
>>
>> In addition, two functions, *resettable_reset_cold_fn* and
>> *resettable_reset_warm_fn*, are defined. They take only an opaque argument
>> (for the Resettable object) and can be used as callbacks.
>>
>> The Resettable interface is "reentrant", _assert_ can be called several
>> times and _deasert_ must be called the same number of times so that the
> 
> deassert
> 
>> Resettable leave reset state. It is supported by keeping a counter of
>> the current number of _assert_ calls. The counter maintainance is done
>> though 3 methods get/increment/decrement_count. A method set_cold is used
>> to set the cold flag of the reset. Another method set_host_needed is used
>> to ensure hold phase is executed only if required.
>>
>> Reset hierarchy is also supported. Each Resettable may have
>> sub-Resettable objects. When resetting a Resettable, it is propagated to
>> its children using the foreach_child method.
>>
>> When entering reset, init phases are executed parent-to-child order then
>> hold phases are executed child-parent order.
> 
> Why do we execute the hold phase in child-to-parent order? I would
> have expected this to follow the same order as the init phase.

No particular reason, I just thought it was better that way. But I don't
have a use case where it matters.

If we do only an assert_reset, then top-level phases are
called first and last:
parent's init
  child A's init
  child_B's init
  child_A's hold
  child_B's hold
parent's hold

I can switch it.

> 
>> When leaving reset, exit phases are executed in child-to-parent order.
>> This will allow to replace current qdev_reset mechanism by this interface
>> without side-effects on reset order.
> 
> It makes sense that the exit phase is child-to-parent.
> 
>> Note: I used an uint32 for the count. This match the type already used
>> in the existing resetting counter in hw/scsi/vmw_pvscsi.c for the
>> PVSCSIState.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  Makefile.objs           |   1 +
>>  hw/core/Makefile.objs   |   1 +
>>  hw/core/resettable.c    | 220 ++++++++++++++++++++++++++++++++++++++++
>>  hw/core/trace-events    |  39 +++++++
>>  include/hw/resettable.h | 126 +++++++++++++++++++++++
>>  5 files changed, 387 insertions(+)
>>  create mode 100644 hw/core/resettable.c
>>  create mode 100644 hw/core/trace-events
>>  create mode 100644 include/hw/resettable.h
>>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 6a143dcd57..a723a47e14 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -191,6 +191,7 @@ trace-events-subdirs += migration
>>  trace-events-subdirs += net
>>  trace-events-subdirs += ui
>>  endif
>> +trace-events-subdirs += hw/core
>>  trace-events-subdirs += hw/display
>>  trace-events-subdirs += qapi
>>  trace-events-subdirs += qom
>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>> index f8481d959f..d9234aa98a 100644
>> --- a/hw/core/Makefile.objs
>> +++ b/hw/core/Makefile.objs
>> @@ -1,6 +1,7 @@
>>  # core qdev-related obj files, also used by *-user:
>>  common-obj-y += qdev.o qdev-properties.o
>>  common-obj-y += bus.o reset.o
>> +common-obj-y += resettable.o
>>  common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
>>  common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
>>  # irq.o needed for qdev GPIO handling:
>> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
>> new file mode 100644
>> index 0000000000..d7d631ce8b
>> --- /dev/null
>> +++ b/hw/core/resettable.c
>> @@ -0,0 +1,220 @@
>> +/*
>> + * Resettable interface.
>> + *
>> + * Copyright (c) 2019 GreenSocs SAS
>> + *
>> + * Authors:
>> + *   Damien Hedde
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/module.h"
>> +#include "hw/resettable.h"
>> +#include "trace.h"
>> +
>> +#define RESETTABLE_MAX_COUNT 50
>> +
>> +#define RESETTABLE_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(ResettableClass, (obj), TYPE_RESETTABLE)
> 
> Since this is an interface and not a complete class,
> we should name it TYPE_RESETTABLE_INTERFACE. We're rather
> inconsistent about naming of interfaces (in the codebase you
> can find "_INTERFACE suffix", "_IF suffix" and "no suffix").
> I think _INTERFACE suffix is best of these.
> (There's some discussion of this in this mailing list thread:
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg03840.html
>  -- the idea is that it avoids confusion between whether an
> implementation of the type needs to be a subclass of it or
> if it has to be added as an interface to some other type.)
> 
>> +
>> +static void resettable_init_reset(Object *obj, bool cold);
>> +
>> +static bool resettable_class_check(ResettableClass *rc)
>> +{
>> +    if (!rc->set_cold) {
>> +        return false;
>> +    }
>> +    if (!rc->set_hold_needed) {
>> +        return false;
>> +    }
>> +    if (!rc->increment_count) {
>> +        return false;
>> +    }
>> +    if (!rc->decrement_count) {
>> +        return false;
>> +    }
>> +    if (!rc->get_count) {
>> +        return false;
>> +    }
>> +    return true;
>> +}
> 
> I don't think we really need to do this -- this is only used
> as an assert(), and the code is in any case going to exercise
> all the methods. Plus we only implement these methods in a couple
> of classes and we don't expect a lot of new implementations of them.
> 
>> +
>> +static void resettable_foreach_child(ResettableClass *rc,
>> +                                     Object *obj,
>> +                                     void (*func)(Object *))
>> +{
>> +    if (rc->foreach_child) {
>> +        rc->foreach_child(obj, func);
>> +    }
>> +}
>> +
>> +static void resettable_init_cold_reset(Object *obj)
>> +{
>> +    resettable_init_reset(obj, true);
>> +}
>> +
>> +static void resettable_init_warm_reset(Object *obj)
>> +{
>> +    resettable_init_reset(obj, false);
>> +}
>> +
>> +static void resettable_init_reset(Object *obj, bool cold)
>> +{
>> +    void (*func)(Object *);
>> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
>> +    uint32_t count;
>> +    bool action_needed = false;
>> +    bool prev_cold;
>> +
>> +    assert(resettable_class_check(rc));
>> +
>> +    count = rc->increment_count(obj);
>> +    /* this assert is here to catch an eventual reset loop */
>> +    assert(count <= RESETTABLE_MAX_COUNT);
> 
> I think I understand what this assert is for, but a slightly
> expanded comment would help.

is this better ?
/*
 * We limit the count to an arbitrary "big" value. The value is big
 * enough not to be triggered nominally.
 * The assert will catch a cycle in the reset tree which triggers
 * an infinite loop.
 */

Maybe I should drop the macro here, it will be more explicit.

> 
>> +
>> +    /*
>> +     * only take action if:
>> +     * + we really enter reset for the 1st time
>> +     * + or we are in warm reset and start a cold one
>> +     */
>> +    prev_cold = rc->set_cold(obj, cold);
>> +    if (count == 1) {
>> +        action_needed = true;
>> +    } else if (cold && !prev_cold) {
>> +        action_needed = true;
>> +    }
>> +    trace_resettable_phase_init(obj, object_get_typename(obj), cold, count,
>> +                                action_needed);
>> +
>> +    /* exec init phase */
>> +    if (action_needed) {
>> +        rc->set_hold_needed(obj, true);
>> +        if (rc->phases.init) {
>> +            rc->phases.init(obj);
>> +        }
>> +    }
>> +
>> +    /*
>> +     * handle the children even if action_needed is at false so that
>> +     * children counts are incremented too
>> +     */
>> +    func = cold ? resettable_init_cold_reset : resettable_init_warm_reset;
>> +    resettable_foreach_child(rc, obj, func);
>> +    trace_resettable_phase_init_end(obj);
>> +}
>> +
>> +static void resettable_hold_reset(Object *obj)
>> +{
>> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
>> +    bool hold_needed;
>> +
>> +    assert(resettable_class_check(rc));
>> +    trace_resettable_phase_hold(obj, object_get_typename(obj));
>> +
>> +    /* handle children first */
>> +    resettable_foreach_child(rc, obj, resettable_hold_reset);
>> +
>> +    /* exec hold phase */
>> +    hold_needed = rc->set_hold_needed(obj, false);
>> +    if (hold_needed) {
>> +        if (rc->phases.hold) {
>> +            rc->phases.hold(obj);
>> +        }
>> +    }
>> +    trace_resettable_phase_hold_end(obj, hold_needed);
>> +}
>> +
>> +static void resettable_exit_reset(Object *obj)
>> +{
>> +    uint32_t count;
>> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
>> +
>> +    assert(resettable_class_check(rc));
>> +    trace_resettable_phase_exit(obj, object_get_typename(obj));
>> +
>> +    resettable_foreach_child(rc, obj, resettable_deassert_reset);
>> +
>> +    count = rc->get_count(obj);
>> +    /*
>> +     * we could assert that count > 0 but there are some corner cases
>> +     * where we prefer to let it go as it is probably harmless.
>> +     * For example: if there is reset support addition between
>> +     * hosts when doing a migration. We may do such things as
>> +     * deassert a non-existing reset.
>> +     */
>> +    if (count > 0) {
>> +        count = rc->decrement_count(obj);
>> +    } else {
>> +        trace_resettable_count_underflow(obj);
>> +    }
>> +    if (count == 0) {
>> +        if (rc->phases.exit) {
>> +            rc->phases.exit(obj);
>> +        }
>> +    }
>> +    trace_resettable_phase_exit_end(obj, count);
>> +}
>> +
>> +void resettable_assert_reset(Object *obj, bool cold)
>> +{
>> +    trace_resettable_reset_assert(obj, object_get_typename(obj), cold);
>> +    resettable_init_reset(obj, cold);
>> +    resettable_hold_reset(obj);
>> +}
>> +
>> +void resettable_deassert_reset(Object *obj)
>> +{
>> +    trace_resettable_reset_deassert(obj, object_get_typename(obj));
>> +    resettable_exit_reset(obj);
>> +}
>> +
>> +void resettable_reset(Object *obj, bool cold)
>> +{
>> +    trace_resettable_reset(obj, object_get_typename(obj), cold);
>> +    resettable_assert_reset(obj, cold);
>> +    resettable_deassert_reset(obj);
>> +}
>> +
>> +void resettable_reset_warm_fn(void *opaque)
>> +{
>> +    resettable_reset((Object *) opaque, false);
>> +}
>> +
>> +void resettable_reset_cold_fn(void *opaque)
>> +{
>> +    resettable_reset((Object *) opaque, true);
>> +}
>> +
>> +void resettable_class_set_parent_reset_phases(ResettableClass *rc,
>> +                                              ResettableInitPhase init,
>> +                                              ResettableHoldPhase hold,
>> +                                              ResettableExitPhase exit,
>> +                                              ResettablePhases *parent_phases)
>> +{
>> +    *parent_phases = rc->phases;
>> +    if (init) {
>> +        rc->phases.init = init;
>> +    }
>> +    if (hold) {
>> +        rc->phases.hold = hold;
>> +    }
>> +    if (exit) {
>> +        rc->phases.exit = exit;
>> +    }
>> +}
>> +
>> +static const TypeInfo resettable_interface_info = {
>> +    .name       = TYPE_RESETTABLE,
>> +    .parent     = TYPE_INTERFACE,
>> +    .class_size = sizeof(ResettableClass),
>> +};
>> +
>> +static void reset_register_types(void)
>> +{
>> +    type_register_static(&resettable_interface_info);
>> +}
>> +
>> +type_init(reset_register_types)
>> diff --git a/hw/core/trace-events b/hw/core/trace-events
>> new file mode 100644
>> index 0000000000..489d96d445
>> --- /dev/null
>> +++ b/hw/core/trace-events
>> @@ -0,0 +1,39 @@
>> +# See docs/devel/tracing.txt for syntax documentation.
>> +#
>> +# This file is processed by the tracetool script during the build.
>> +#
>> +# To add a new trace event:
>> +#
>> +# 1. Choose a name for the trace event.  Declare its arguments and format
>> +#    string.
>> +#
>> +# 2. Call the trace event from code using trace_##name, e.g. multiwrite_cb() ->
>> +#    trace_multiwrite_cb().  The source file must #include "trace.h".
>> +#
>> +# Format of a trace event:
>> +#
>> +# [disable] <name>(<type1> <arg1>[, <type2> <arg2>] ...) "<format-string>"
>> +#
>> +# Example: g_malloc(size_t size) "size %zu"
>> +#
>> +# The "disable" keyword will build without the trace event.
>> +#
>> +# The <name> must be a valid as a C function name.
>> +#
>> +# Types should be standard C types.  Use void * for pointers because the trace
>> +# system may not have the necessary headers included.
>> +#
>> +# The <format-string> should be a sprintf()-compatible format string.
>> +
>> +# resettable.c
>> +resettable_reset(void *obj, const char *type, int cold) "obj=%p(%s) cold=%d"
>> +resettable_reset_assert(void *obj, const char *type, int cold) "obj=%p(%s) cold=%d"
>> +resettable_reset_deassert(void *obj, const char *type) "obj=%p(%s)"
>> +resettable_reset_deassert_end(void *obj) "obj=%p"
>> +resettable_phase_init(void *obj, const char *type, int cold, uint32_t count, int needed) "obj=%p(%s) cold=%d count=%" PRIu32 " needed=%d"
>> +resettable_phase_init_end(void *obj) "obj=%p"
>> +resettable_phase_hold(void *obj, const char *type) "obj=%p(%s)"
>> +resettable_phase_hold_end(void *obj, int needed) "obj=%p needed=%d"
>> +resettable_phase_exit(void *obj, const char *type) "obj=%p(%s)"
>> +resettable_phase_exit_end(void *obj, uint32_t count) "obj=%p count=%" PRIu32
>> +resettable_count_underflow(void *obj) "obj=%p"
>> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
>> new file mode 100644
>> index 0000000000..e617a8e875
>> --- /dev/null
>> +++ b/include/hw/resettable.h
>> @@ -0,0 +1,126 @@
>> +#ifndef HW_RESETTABLE_H
>> +#define HW_RESETTABLE_H
>> +
>> +#include "qom/object.h"
>> +
>> +#define TYPE_RESETTABLE "resettable"
>> +
>> +#define RESETTABLE_CLASS(class) \
>> +    OBJECT_CLASS_CHECK(ResettableClass, (class), TYPE_RESETTABLE)
>> +
>> +/*
>> + * ResettableClass:
>> + * Interface for resettable objects.
>> + *
>> + * The reset operation is divided in several phases each represented by a
>> + * method.
>> + *
>> + * Each Ressetable must maintain a reset counter in its state, 3 methods allows
> 
> "resettable"
> 
>> + * to interact with it.
> 
> I think we could improve this comment to be a bit clearer about
> who we expect to implement which methods. Something like:
> 
> /*
>  * ResettableClass:
>  * Interface for resettable objects.
>  *
>  * See docs/devel/reset.rst for more detailed information about
>  * how QEMU models reset.
>  *
>  * All objects which can be reset must implement this interface;
>  * it is usually provided by a base class such as DeviceClass or BusClass.
>  * Every Resettable object must maintain some state tracking the
>  * progress of a reset operation:
>  *  - a reset count, which is incremented when the reset operation
>  *    starts and decremented when it finishes
>  *  - a 'cold' flag, which tracks whether the in-progress reset is
>  *    a warm reset or a cold reset
>  *  - a 'hold_needed' flag, which indicates that we need to
>  *    invoke the 'hold' phase handler for this object
>  * The base class implementation of the interface provides this
>  * state and implements the associated methods: set_cold,
>  * set_hold_needed, get_count, increment_count and decrement_count.
>  *
>  * Concrete object implementations (typically specific devices
>  * such as a UART model) should provide the functions
>  * for the phases.init, phases.hold and phases.exit methods, which
>  * they can set in their class init function, either directly or
>  * by calling resettable_class_set_parent_reset_phases().
>  * The phase methods are guaranteed to only only ever be called once
>  * for any reset event, in the order 'init', 'hold', 'exit'.
>  * An object will always move quickly from 'init' to 'hold'
>  * but might remain in 'hold' for an arbitrary period of time
>  * before eventually reset is deasserted and the 'exit' phase is called.
>  * Object implementations should be prepared for functions handling
>  * inbound connections from other devices (such as qemu_irq handler
>  * functions) to be called at any point during reset after their
>  * 'init' method has been called.
>  *
>  * Users of a resettable object should not call these methods
>  * directly, but instead use the functions resettable_assert_reset(),
>  * resettable_deassert_reset() or resettable_reset().
> 
> 
>> + *
>> + * @phases.init: should reset local state only. Takes a bool @cold argument
>> + * specifying whether the reset is cold or warm. It must not do side-effect
>> + * on others objects.
> 
> This says that phases.init takes a 'cold' argument, but the prototype
> doesn't have one.

I finally removed the argument and forgot to change this bit.

> 
> "This phase is called when the object enters reset. It should reset
> local state of the object, but it must not do anything that has a
> side-effect on other objects, such as raising or lowering a qemu_irq line
> or reading or writing guest memory."
> 
>> + *
>> + * @phases.hold: side-effects action on others objects due to staying in a
>> + * resetting state.
> 
> "This phase is called for entry into reset, once every object in the
> system which is being reset has had its @phases.init method called.
> At this point devices can do actions that affect other objects."
> 
> 
>> + *
>> + * @phases.exit: leave the reset state, may do side-effects action on others
>> + * objects.
> 
> "This phase is called when the object leaves the reset state. Actions
> affecting other objects are permitted."
> 
>> + *
>> + * @set_cold: Set whether the current reset is cold or warm. Return the
>> + * previous flag value. Return value has no meaning if @get_count returns
>> + * a zero value.
>> + *
>> + * @set_hold_needed: Set hold_needed flag. Return the previous flag value.
>> + *
>> + * @get_count: Get the current reset count
>> + * @increment_count: Increment the reset count, returns the new count
>> + * @decrement_count: decrement the reset count, returns the new count
>> + *
>> + * @foreach_child: Executes a given function on every Resettable child.
>> + * A child is not a QOM child, but a child a reset meaning.
> 
> "Child in this context means a child in the qbus tree, so the
> children of a qbus are the devices on it, and the children of
> a device are all the buses it owns. This is not the same as the
> QOM object hierarchy."
> 
>> + */
>> +typedef void (*ResettableInitPhase)(Object *obj);
>> +typedef void (*ResettableHoldPhase)(Object *obj);
>> +typedef void (*ResettableExitPhase)(Object *obj);
>> +typedef bool (*ResettableSetCold)(Object *obj, bool cold);
>> +typedef bool (*ResettableSetHoldNeeded)(Object *obj, bool hold_needed);
>> +typedef uint32_t (*ResettableGetCount)(Object *obj);
>> +typedef uint32_t (*ResettableIncrementCount)(Object *obj);
>> +typedef uint32_t (*ResettableDecrementCount)(Object *obj);
>> +typedef void (*ResettableForeachChild)(Object *obj, void (*visitor)(Object *));
>> +typedef struct ResettableClass {
>> +    InterfaceClass parent_class;
>> +
>> +    struct ResettablePhases {
>> +        ResettableInitPhase init;
>> +        ResettableHoldPhase hold;
>> +        ResettableExitPhase exit;
>> +    } phases;
>> +
>> +    ResettableSetCold set_cold;
>> +    ResettableSetHoldNeeded set_hold_needed;
>> +    ResettableGetCount get_count;
>> +    ResettableIncrementCount increment_count;
>> +    ResettableDecrementCount decrement_count;
>> +    ResettableForeachChild foreach_child;
>> +} ResettableClass;
>> +typedef struct ResettablePhases ResettablePhases;
>> +
>> +/**
>> + * resettable_assert_reset:
> 
> "Put the object into reset, and hold it there until
> the caller later calls resettable_deassert_reset()."
> 
>> + * Increments the reset count and executes the init and hold phases.
>> + * Each time resettable_assert_reset is called, resettable_deassert_reset
>> + * must eventually be called once.
>> + * It will also impact reset children.
> 
> "This will reset the specified object and all of its reset children."
> 
>> + *
>> + * @obj object to reset, must implement Resettable interface.
>> + * @cold boolean indicating the type of reset (cold or warm)
>> + */
>> +void resettable_assert_reset(Object *obj, bool cold);
>> +
>> +/**
>> + * resettable_deassert_reset:
> 
> "Take the object out of reset."
> 
>> + * Decrements the reset count by one and executes the exit phase if it hits
>> + * zero.
>> + * It will also impact reset children.
>> + *
>> + * @obj object to reset, must implement Resettable interface.
>> + */
>> +void resettable_deassert_reset(Object *obj);
>> +
>> +/**
>> + * resettable_reset:
>> + * Calling this function is equivalent to call @assert_reset then
> 
> "to calling"
> 
>> + * @deassert_reset.
>> + */
>> +void resettable_reset(Object *obj, bool cold);
>> +
>> +/**
>> + * resettable_reset_warm_fn:
>> + * Helper to call resettable_reset(opaque, false)
>> + */
>> +void resettable_reset_warm_fn(void *opaque);
>> +
>> +/**
>> + * resettable_reset_cold_fn:
>> + * Helper to call resettable_reset(opaque, true)
>> + */
>> +void resettable_reset_cold_fn(void *opaque);
>> +
>> +/**
>> + * resettable_class_set_parent_reset_phases:
>> + *
>> + * Save @rc current reset phases into @parent_phases and override @rc phases
>> + * by the given new methods (@init, @hold and @exit).
>> + * Each phase is overriden only if the new one is not NULL allowing to
> 
> "overridden"
> 
>> + * override a subset of phases.
>> + */
>> +void resettable_class_set_parent_reset_phases(ResettableClass *rc,
>> +                                              ResettableInitPhase init,
>> +                                              ResettableHoldPhase hold,
>> +                                              ResettableExitPhase exit,
>> +                                              ResettablePhases *parent_phases);
>> +
>> +#endif
> 
> This function name is quite long -- I think we could reasonably
> call it resettable_class_set_parent_phases().
> 
> thanks
> -- PMM
> 

