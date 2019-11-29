Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A421C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D4F216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+u+WTUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D4F216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialDn-0004xO-8i
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ialA8-0002fb-9T
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ialA5-0002ld-QC
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:38:39 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ialA4-0002ZH-JF
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:38:37 -0500
Received: by mail-ot1-x342.google.com with SMTP id k14so9856470otn.4
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 10:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AoRC13LxaciIpGwZKrhX4vtH1RaBRf3f97suTSxHaCE=;
 b=C+u+WTUf4gti9mrjw7y8laZ/jaS3wg+y7SusXBLrrhBJtvMiTuC5zIh/DgmgN8+Oo3
 EeyJLaKGH7U5o+hKmN7+NyEovHdNkTrR1z0W4Ls6QVblbWO7TYSYYOfJCDJgw9/kNuli
 ahXa+Qdf4l0CE76f/5Y6LzspBL1jbPANNqZoAHufm6HPE7MvbEs8g0ELjaVJ7loqpR0Z
 oYVIvneU/XcpqEIMeirtREp362ZpcsmqsK4bWRERrcsKj3L/nIMTn/R5t4m4X9owPPth
 bAZrQa6F648a8/21eUQ1zx971SB9HsHwaQd8jRyC8CpvPs68bQAopDLRX5M/ddnGuLxd
 afsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AoRC13LxaciIpGwZKrhX4vtH1RaBRf3f97suTSxHaCE=;
 b=iynPFDP9XE78k4pdoTMjiTN8upa7eC44SVAvvTJ1yA6iROg8LR1UIA7MKZkDeU5iGq
 o0KqDP4qvI88+AuT/Qo+WJ/OryZH2DcNORhZcnFj3d7Azlg3+TjwMlbaPKf4QPtN2T4t
 z2AjL9yhbJsMKqsPBCbdbo3w4Kg1P0EMiKYxAn49gK0ngw3TY8E1ehLQbegxh9WDlCy7
 MSHpC2nbhLE3RLJAA+FYvGAM1+b7mDhK4zp8mPkpEWvyy90u46u98pBlaHjDh6uEsfYY
 2SZzYG/HitrtOu53g5vXVjT6I53AUbb3NN1ayGlXRTbU0AUXGcr2R4NpcZ7iXDS/Z8we
 jkBQ==
X-Gm-Message-State: APjAAAXu/d7sjHp2gwA/tSRjkkI6jR2Xv1LJcNjZo5JM+emfs7bT2QWO
 xP5cwfZDEqKazn7/wDFSP42guKx7sHVaFHUb4mEKZw==
X-Google-Smtp-Source: APXvYqy6pQ5muZED0tqeUGyCM5DZOTw7N55UHBM0jLxBNyqT3n08wYKbOGLHSW9wm6xAdknUIO7gpJGMRPv1/4Olpjs=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr12303607otk.91.1575052712763; 
 Fri, 29 Nov 2019 10:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-6-damien.hedde@greensocs.com>
In-Reply-To: <20191018150630.31099-6-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 18:38:22 +0000
Message-ID: <CAFEAcA-UV7rSL1mPD=NLyLtan60WNsc+MDjR6p2aDoz34bq8dg@mail.gmail.com>
Subject: Re: [PATCH v5 05/13] hw/core/resettable: add support for changing
 parent
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
> Add a function resettable_change_parent() to do the required
> plumbing when changing the parent a of Resettable object.
>
> We need to make sure that the reset state of the object remains
> coherent with the reset state of the new parent.
>
> We make the 2 following hypothesis:
> + when an object is put in a parent under reset, the object goes in
> reset.
> + when an object is removed from a parent under reset, the object
> leaves reset.
>
> The added function avoid any glitch if both old and new parent are
> already in reset.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/core/resettable.c    | 54 +++++++++++++++++++++++++++++++++++++++++
>  hw/core/trace-events    |  1 +
>  include/hw/resettable.h | 16 ++++++++++++
>  3 files changed, 71 insertions(+)
>
> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
> index c5e11cff4f..60d4285fcc 100644
> --- a/hw/core/resettable.c
> +++ b/hw/core/resettable.c
> @@ -32,6 +32,14 @@ static void resettable_phase_exit(Object *obj, void *opaque, ResetType type);
>   */
>  static bool enter_phase_in_progress;
>
> +/**
> + * exit_phase_in_progress:
> + * Flag telling whether we are currently in an enter phase where side
> + * effects are forbidden. This flag allows us to catch if
> + * resettable_change_parent() is called during exit phase.
> + */
> +static unsigned exit_phase_in_progress;

This is another global that I don't think we should have.
Is it also just for asserts ?


> +
>  void resettable_reset(Object *obj, ResetType type)
>  {
>      trace_resettable_reset(obj, type);
> @@ -58,7 +66,9 @@ void resettable_release_reset(Object *obj, ResetType type)
>      /* TODO: change that assert when adding support for other reset types */
>      assert(type == RESET_TYPE_COLD);
>      trace_resettable_reset_release_begin(obj, type);
> +    exit_phase_in_progress += 1;
>      resettable_phase_exit(obj, NULL, type);
> +    exit_phase_in_progress -= 1;
>      trace_resettable_reset_release_end(obj);
>  }
>
> @@ -198,6 +208,50 @@ static void resettable_phase_exit(Object *obj, void *opaque, ResetType type)
>      trace_resettable_phase_exit_end(obj, obj_typename, s->count);
>  }
>
> +/*
> + * resettable_get_count:
> + * Get the count of the Resettable object @obj. Return 0 if @obj is NULL.
> + */
> +static uint32_t resettable_get_count(Object *obj)
> +{
> +    if (obj) {
> +        ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
> +        return rc->get_state(obj)->count;
> +    }
> +    return 0;
> +}
> +
> +void resettable_change_parent(Object *obj, Object *newp, Object *oldp)
> +{
> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
> +    ResettableState *s = rc->get_state(obj);
> +    uint32_t newp_count = resettable_get_count(newp);
> +    uint32_t oldp_count = resettable_get_count(oldp);
> +
> +    assert(!enter_phase_in_progress && !exit_phase_in_progress);
> +    trace_resettable_change_parent(obj, oldp, oldp_count, newp, newp_count);
> +
> +    /*
> +     * At most one of the two 'for' loop will be executed below

"loops"

> +     * in order to cope with the diff between the two count.

"difference". "counts".

> +     */
> +    /* if newp is more reset than oldp */
> +    for (uint32_t i = oldp_count; i < newp_count; i++) {
> +        resettable_assert_reset(obj, RESET_TYPE_COLD);
> +    }
> +    /*
> +     * if obj is leaving a bus under reset, we need to ensure
> +     * hold phase is not pending.
> +     */
> +    if (oldp_count && s->hold_phase_pending) {
> +        resettable_phase_hold(obj, NULL, RESET_TYPE_COLD);
> +    }
> +    /* if oldp is more reset than newp */
> +    for (uint32_t i = newp_count; i < oldp_count; i++) {
> +        resettable_release_reset(obj, RESET_TYPE_COLD);
> +    }
> +}
> +
>  void resettable_class_set_parent_phases(ResettableClass *rc,
>                                          ResettableEnterPhase enter,
>                                          ResettableHoldPhase hold,
> diff --git a/hw/core/trace-events b/hw/core/trace-events
> index 66081d0fb4..6d03ef7ff9 100644
> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -16,6 +16,7 @@ resettable_reset_assert_begin(void *obj, int cold) "obj=%p cold=%d"
>  resettable_reset_assert_end(void *obj) "obj=%p"
>  resettable_reset_release_begin(void *obj, int cold) "obj=%p cold=%d"
>  resettable_reset_release_end(void *obj) "obj=%p"
> +resettable_change_parent(void *obj, void *o, uint32_t oc, void *n, uint32_t nc) "obj=%p from=%p(%" PRIu32 ") to=%p(%" PRIu32 ")"
>  resettable_phase_enter_begin(void *obj, const char *objtype, uint32_t count, int type) "obj=%p(%s) count=%" PRIu32 " type=%d"
>  resettable_phase_enter_exec(void *obj, const char *objtype, int type, int has_method) "obj=%p(%s) type=%d method=%d"
>  resettable_phase_enter_end(void *obj, const char *objtype, uint32_t count) "obj=%p(%s) count=%" PRIu32
> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
> index 6b24e1633b..f6d379669f 100644
> --- a/include/hw/resettable.h
> +++ b/include/hw/resettable.h
> @@ -182,6 +182,22 @@ void resettable_release_reset(Object *obj, ResetType type);
>   */
>  bool resettable_is_in_reset(Object *obj);
>
> +/**
> + * resettable_change_parent:
> + * Indicate that the parent of Ressettable @obj change from @oldp to @newp.

"is changing from"

> + * All 3 objects must implements resettable interface. @oldp or @newp may be

"implement"

> + * NULL.
> + *
> + * This function will adapt the reset state of @obj so that it is coherent
> + * with the reset state of @newp. It may trigger @resettable_assert_reset()
> + * or @resettable_release_reset(). It will do such things only if the reset
> + * state of @newp and @oldp are different.
> + *
> + * When using this function during reset, it must only be called during
> + * an hold phase method. Calling this during enter or exit phase is an error.

"a hold phase"

> + */
> +void resettable_change_parent(Object *obj, Object *newp, Object *oldp);
> +

thanks
-- PMM

