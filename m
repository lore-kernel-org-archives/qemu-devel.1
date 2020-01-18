Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E245BC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE8D2051A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGykD//Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE8D2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ishs3-0000ac-SY
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 01:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ishrL-0008Pz-IS
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ishrJ-0007jO-0d
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:45:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41070
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ishrI-0007j2-Tp
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579329924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWgm9O1yAF5K4VAs6tWRxSh04UwXRHHbhXVr/dO6QVM=;
 b=FGykD//YgDLxXhe5+iokNl3wa0E5QRnm59Laix8uDF5yZ+4CqG+zn0+/yLJXHyCpDqwwwS
 QD+YOheDrmalSAIIeRohFPGwLeLBgnLemssgvinsRyfScMvQO4FBf6F894xKlauSJGA8xO
 8cSmjwehHzWrwkmNyMRuyR+AIGkc8D0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-v91oRpvOO6eiWxPry-PHxg-1; Sat, 18 Jan 2020 01:45:21 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so11386053wrm.18
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 22:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hPA7HD43xi7iO7xUuS6Hnqct9ddKVmXtBJLlkqOi7Qo=;
 b=quAQu2ZAJzHDiyyDkkB5o1ex9Kc44kcwU7q/utdICOzm0cML7y11euWPNxDot89uwX
 ix44rylwanGcrJtXwSUDp39Nw8CoFP6F3A/IHFF0uDmzLOSRz/3xqKhEJktll4IwLt/g
 CizlR1yi0c04ceCawuF/WDnoFnfWCAiDwX9IX06eDeDcyUdRTIActM095K9aQKH8lLfS
 4EW/N3a6UhasngTmkbKBolK5YkFVedWodnDRW2nKWgL5wcqEI+TX+HNZCfktJ/+yleSi
 QgBUiKYBhi5tMNwyvkZdrJ4vuugrRKaJfkIl6F3G3XWHJKhkN4tuRPaX/181yTIS5VXr
 dmlA==
X-Gm-Message-State: APjAAAUVur2stYSRykitewQOTHIhaNsSEhMjLiIH0YTkppZ7NCTen33p
 ZHU3bex8RIj2P+8U/73grbqRAIrPZJdBC0eApFihfYH3F5oTcGd3N/L6R0wZCq2Oo05vJmgu9zr
 Qb11TEf97+uR0ukc=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr6832114wrp.236.1579329918259; 
 Fri, 17 Jan 2020 22:45:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwtpQLXfaiaTE7wpf7xW8oAdcGq8KoASLHIHrCQ4UdFtciwp3LLtY/04TxOijL01P3uJwlXoA==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr6832082wrp.236.1579329917846; 
 Fri, 17 Jan 2020 22:45:17 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q68sm14432468wme.14.2020.01.17.22.45.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 22:45:17 -0800 (PST)
Subject: Re: [PATCH v7 05/11] hw/core/resettable: add support for changing
 parent
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-6-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c4ef366-46df-311b-6361-fbc8c2e0eb87@redhat.com>
Date: Sat, 18 Jan 2020 07:45:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115123620.250132-6-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: v91oRpvOO6eiWxPry-PHxg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 1/15/20 1:36 PM, Damien Hedde wrote:
> Add a function resettable_change_parent() to do the required
> plumbing when changing the parent a of Resettable object.
>=20
> We need to make sure that the reset state of the object remains
> coherent with the reset state of the new parent.
>=20
> We make the 2 following hypothesis:
> + when an object is put in a parent under reset, the object goes in
> reset.
> + when an object is removed from a parent under reset, the object
> leaves reset.
>=20
> The added function avoids any glitch if both old and new parent are
> already in reset.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/resettable.h | 16 +++++++++++
>   hw/core/resettable.c    | 62 +++++++++++++++++++++++++++++++++++++++--
>   hw/core/trace-events    |  1 +
>   3 files changed, 77 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
> index 58b3df4c22..3c87ab86c7 100644
> --- a/include/hw/resettable.h
> +++ b/include/hw/resettable.h
> @@ -194,6 +194,22 @@ void resettable_release_reset(Object *obj, ResetType=
 type);
>    */
>   bool resettable_is_in_reset(Object *obj);
>  =20
> +/**
> + * resettable_change_parent:
> + * Indicate that the parent of Ressettable @obj is changing from @oldp t=
o @newp.
> + * All 3 objects must implement resettable interface. @oldp or @newp may=
 be
> + * NULL.
> + *
> + * This function will adapt the reset state of @obj so that it is cohere=
nt
> + * with the reset state of @newp. It may trigger @resettable_assert_rese=
t()
> + * or @resettable_release_reset(). It will do such things only if the re=
set
> + * state of @newp and @oldp are different.
> + *
> + * When using this function during reset, it must only be called during
> + * a hold phase method. Calling this during enter or exit phase is an er=
ror.
> + */
> +void resettable_change_parent(Object *obj, Object *newp, Object *oldp);
> +
>   /**
>    * resettable_class_set_parent_phases:
>    *
> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
> index 9133208487..e99bb30058 100644
> --- a/hw/core/resettable.c
> +++ b/hw/core/resettable.c
> @@ -28,12 +28,16 @@ static void resettable_phase_exit(Object *obj, void *=
opaque, ResetType type);
>    * enter_phase_in_progress:
>    * True if we are currently in reset enter phase.
>    *
> - * Note: This flag is only used to guarantee (using asserts) that the re=
set
> - * API is used correctly. We can use a global variable because we rely o=
n the
> + * exit_phase_in_progress:
> + * count the number of exit phase we are in.
> + *
> + * Note: These flags are only used to guarantee (using asserts) that the=
 reset
> + * API is used correctly. We can use global variables because we rely on=
 the
>    * iothread mutex to ensure only one reset operation is in a progress a=
t a
>    * given time.
>    */
>   static bool enter_phase_in_progress;
> +static unsigned exit_phase_in_progress;
>  =20
>   void resettable_reset(Object *obj, ResetType type)
>   {
> @@ -65,7 +69,9 @@ void resettable_release_reset(Object *obj, ResetType ty=
pe)
>       trace_resettable_reset_release_begin(obj, type);
>       assert(!enter_phase_in_progress);
>  =20
> +    exit_phase_in_progress +=3D 1;
>       resettable_phase_exit(obj, NULL, type);
> +    exit_phase_in_progress -=3D 1;
>  =20
>       trace_resettable_reset_release_end(obj);
>   }
> @@ -206,6 +212,58 @@ static void resettable_phase_exit(Object *obj, void =
*opaque, ResetType type)
>       trace_resettable_phase_exit_end(obj, obj_typename, s->count);
>   }
>  =20
> +/*
> + * resettable_get_count:
> + * Get the count of the Resettable object @obj. Return 0 if @obj is NULL=
.
> + */
> +static uint32_t resettable_get_count(Object *obj)

In patch #3 I suggested to use 'unsigned' instead (and add the new=20
ResettableState::count field here with the rest of this current patch).

Using 'unsigned' imply trivial format string update in trace events, so=20
regardless:

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +{
> +    if (obj) {
> +        ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
> +        return rc->get_state(obj)->count;
> +    }
> +    return 0;
> +}
> +
> +void resettable_change_parent(Object *obj, Object *newp, Object *oldp)
> +{
> +    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
> +    ResettableState *s =3D rc->get_state(obj);
> +    uint32_t newp_count =3D resettable_get_count(newp);
> +    uint32_t oldp_count =3D resettable_get_count(oldp);
> +
> +    /*
> +     * Ensure we do not change parent when in enter or exit phase.
> +     * During these phases, the reset subtree being updated is partly in=
 reset
> +     * and partly not in reset (it depends on the actual position in
> +     * resettable_child_foreach()s). We are not able to tell in which pa=
rt is a
> +     * leaving or arriving device. Thus we cannot set the reset count of=
 the
> +     * moving device to the proper value.
> +     */
> +    assert(!enter_phase_in_progress && !exit_phase_in_progress);
> +    trace_resettable_change_parent(obj, oldp, oldp_count, newp, newp_cou=
nt);
> +
> +    /*
> +     * At most one of the two 'for' loops will be executed below
> +     * in order to cope with the difference between the two counts.
> +     */
> +    /* if newp is more reset than oldp */
> +    for (uint32_t i =3D oldp_count; i < newp_count; i++) {
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
> +    for (uint32_t i =3D newp_count; i < oldp_count; i++) {
> +        resettable_release_reset(obj, RESET_TYPE_COLD);
> +    }
> +}
> +
>   void resettable_class_set_parent_phases(ResettableClass *rc,
>                                           ResettableEnterPhase enter,
>                                           ResettableHoldPhase hold,
> diff --git a/hw/core/trace-events b/hw/core/trace-events
> index a2e43f1120..80e6325ab0 100644
> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -16,6 +16,7 @@ resettable_reset_assert_begin(void *obj, int cold) "obj=
=3D%p cold=3D%d"
>   resettable_reset_assert_end(void *obj) "obj=3D%p"
>   resettable_reset_release_begin(void *obj, int cold) "obj=3D%p cold=3D%d=
"
>   resettable_reset_release_end(void *obj) "obj=3D%p"
> +resettable_change_parent(void *obj, void *o, uint32_t oc, void *n, uint3=
2_t nc) "obj=3D%p from=3D%p(%" PRIu32 ") to=3D%p(%" PRIu32 ")"
>   resettable_phase_enter_begin(void *obj, const char *objtype, uint32_t c=
ount, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
>   resettable_phase_enter_exec(void *obj, const char *objtype, int type, i=
nt has_method) "obj=3D%p(%s) type=3D%d method=3D%d"
>   resettable_phase_enter_end(void *obj, const char *objtype, uint32_t cou=
nt) "obj=3D%p(%s) count=3D%" PRIu32
>=20


