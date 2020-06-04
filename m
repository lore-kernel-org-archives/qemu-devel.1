Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B64C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB6B206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BI1UJDUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB6B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoNr-0007HX-Rm
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgoNC-0006jH-Eo
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:49:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgoN8-0005f0-5L
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:49:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so4923497wmh.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eWK2chz0WmAxCaSMc+5F4+nAL3q+XGqzQz5okdK6lJg=;
 b=BI1UJDUUu8HyE6sIjqtfwJgBr0DjDY84SjzBi2pigJs/5cF18yK0X7T4U+X5KzLTv/
 tGkd2BeRq3TvZ5G/gBNA7LkvK0EcjD+t0IJwRkHQTPZteRtdhidVV2ErmmgwdZI49PfX
 1J1Wrz/ixGawZBbE5eydEX90mP26op93BhUP7QmLS0i0dycZYwovWjXXxk4rZy4O5Fgw
 E2EjmW4k9eSIhzV39u3bXWDdbwmCN6wuqwIq/VYEcG79HYt9KvLFWan80Ax3BtlJIA9L
 9Wp0VJR6i5UFTjRozVnRBCnpmM6NKiiRqyczYUo2a3k3Yrbandvw7a9kmuLjyxjzmYB7
 7JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eWK2chz0WmAxCaSMc+5F4+nAL3q+XGqzQz5okdK6lJg=;
 b=aD/KKWwzixjeESHit/O6+ZhLd8kAzbO6qL7BxkOlMNHA/99Wt2jh29NlJjd2JGJEiR
 QsWfTkj45A3v6B9fwSY4wruLuWMYaojh5OGGMzgNuneeaGsPc//n0TQ29CNgMz/2inqe
 tZw9xClJbPlXTNdyY/uK0Fr+fbiagC7L+6OMOIw7bxSNx+OvDEdPgfSzXg8Qfbem1GVd
 BHCJacjp6gtEfBywC4YY6/zA3w+4F+qguvsCtLeB4psxnLlDDy2xJKTQhY9TrI8x3jWQ
 r6wlA4bMemg+C0HYsm+FKVwd7WKp6C0NaCPfWfMmUCNRLa14OFLf7P1yGTegv7vtPXnk
 mLig==
X-Gm-Message-State: AOAM532spclEaM2crJczyw0AMpVxI2o/S4fDvkjRco0Ij2kNhTQXSIa/
 WHYWMRyTu8xdO0jm/cZHDGAmN4f7vd4=
X-Google-Smtp-Source: ABdhPJz4uvYGZp/nF3jqQPAC3YUvAy9joOgSnA4VWfYy4JLld2xBQiPebJipl2BQ8K+NtdU06+jZGw==
X-Received: by 2002:a05:600c:10cf:: with SMTP id
 l15mr3691807wmd.10.1591271359515; 
 Thu, 04 Jun 2020 04:49:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g3sm8611829wrb.46.2020.06.04.04.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 04:49:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5AF2E1FF7E;
 Thu,  4 Jun 2020 12:49:17 +0100 (BST)
References: <20200604111323.7458-1-alex.bennee@linaro.org>
 <20200604071504-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
In-reply-to: <20200604071504-mutt-send-email-mst@kernel.org>
Date: Thu, 04 Jun 2020 12:49:17 +0100
Message-ID: <87ftbb59vm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Michael S. Tsirkin <mst@redhat.com> writes:

> On Thu, Jun 04, 2020 at 12:13:23PM +0100, Alex Benn=C3=83=C2=A9e wrote:
>> The purpose of vhost_section is to identify RAM regions that need to
>> be made available to a vhost client. However when running under TCG
>> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
>> down the line. The original comment implies VGA regions are a problem
>> but doesn't explain why vhost has a problem with it.
>>=20
>> Re-factor the code so:
>>=20
>>   - steps are clearer to follow
>>   - reason for rejection is recorded in the trace point
>>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
>>=20
>> Signed-off-by: Alex Benn=C3=83=C2=A9e <alex.bennee@linaro.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  hw/virtio/vhost.c | 46 ++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 32 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index aff98a0ede5..f81fc87e74c 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -27,6 +27,7 @@
>>  #include "migration/blocker.h"
>>  #include "migration/qemu-file-types.h"
>>  #include "sysemu/dma.h"
>> +#include "sysemu/tcg.h"
>>  #include "trace.h"
>>=20=20
>>  /* enabled until disconnected backend stabilizes */
>> @@ -403,26 +404,43 @@ static int vhost_verify_ring_mappings(struct vhost=
_dev *dev,
>>      return r;
>>  }
>>=20=20
>> +/*
>> + * vhost_section: identify sections needed for vhost access
>> + *
>> + * We only care about RAM sections here (where virtqueue can live). If
>> + * we find one we still allow the backend to potentially filter it out
>> + * of our list.
>> + */
>>  static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *s=
ection)
>>  {
>> -    bool result;
>> -    bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr) &
>> -                     ~(1 << DIRTY_MEMORY_MIGRATION);
>> -    result =3D memory_region_is_ram(section->mr) &&
>> -        !memory_region_is_rom(section->mr);
>> -
>> -    /* Vhost doesn't handle any block which is doing dirty-tracking oth=
er
>> -     * than migration; this typically fires on VGA areas.
>> -     */
>> -    result &=3D !log_dirty;
>> +    enum { OK =3D 0, NOT_RAM, DIRTY, FILTERED } result =3D NOT_RAM;
>
> I'm not sure what does this enum buy us as compared to bool.

The only real point of the enum is to give a little more detailed
information to the trace point to expose why a section wasn't included.
In a previous iteration I just had the tracepoint at the bottom before a
return true where all other legs had returned false. We could switch to
just having the tracepoint hit for explicit inclusions?

> Also why force OK to 0?

Personal preference where 0 indicates success and !0 indicates failure
of various kinds. Again we can drop if we don't want the information in
the tracepoint.

> And I prefer an explicit "else result =3D NOT_RAM" below
> instead of initializing it here.

Ok.

>
>> +
>> +    if (memory_region_is_ram(section->mr) && !memory_region_is_rom(sect=
ion->mr)) {
>> +        uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(section=
->mr);
>> +        uint8_t handled_dirty;
>>=20=20
>> -    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
>> -        result &=3D
>> -            dev->vhost_ops->vhost_backend_mem_section_filter(dev, secti=
on);
>> +        /*
>> +         * Vhost doesn't handle any block which is doing dirty-tracking=
 other
>> +         * than migration; this typically fires on VGA areas. However
>> +         * for TCG we also do dirty code page tracking which shouldn't
>> +         * get in the way.
>> +         */
>> +        handled_dirty =3D (1 << DIRTY_MEMORY_MIGRATION);
>> +        if (tcg_enabled()) {
>> +            handled_dirty |=3D (1 << DIRTY_MEMORY_CODE);
>> +        }
>
> So DIRTY_MEMORY_CODE is only set by TCG right? Thus I'm guessing
> we can just allow this unconditionally.

Which actually makes the test:

  if (dirty_mask & DIRTY_MEMORY_VGA) {
     .. fail ..
  }

which is more in line with the comment although wouldn't fail if we
added additional DIRTY_MEMORY flags. This leads to the question what
exactly is it about DIRTY tracking that vhost doesn't like. Is it really
only avoiding having virtqueue in video RAM? Does this ever actually
happen?

I assume boards with unified memory models where video ram is shared
with system ram just end up partitioning the memory regions?

--=20
Alex Benn=C3=A9e

