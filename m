Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA68CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B876A2082C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fiwI0jDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B876A2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUeS-00027v-OJ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iLUaO-0005zg-1d
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iLUaM-0007vR-DD
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:54:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iLUaL-0007uC-51
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:54:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id z9so6796139wrl.11
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EsxKVD/646QdrOyId90stplzTbEBMqQ5c3CQ4aWyxr8=;
 b=fiwI0jDIW3gcOZyas8BQ5j2p84VMLn6X4bIMNdCbVbxv7Gg2aVBbcWZ2zYA8C6xHC3
 xGLpD1gnmO4R6piM3q1FTwvXMRXjKA0Pj0vM5MdkBJy7XzU3I5oRdXQu6wO3RU1I8GMQ
 8oyhjLTPgcp29hfxIzUG86lZe6Thc7GIRbDbQo992XAuVrD0dZzPEnjGm1mAZutsb0lk
 fOiq4CJcUmQg7lDW+tW/604adu3Z1Z/itOb9ewbfP/MiyHAcx8y2XDugW7R+wNhmKC1V
 d+bOKsjze6hl6sw9fW83mnqdB94+gGY9dIuqfHVYQ7t8OF18bVYDu1F0/NX7Ct9mILTR
 YbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EsxKVD/646QdrOyId90stplzTbEBMqQ5c3CQ4aWyxr8=;
 b=f6iIldvB57jmVxDpjVNGVBe1vCPRLDmPdyZlT0pO6i6qWr+dF1a0TGoAAD+RapqzQh
 +S7r/h4GWlUotrWharX0dQqPtB9d0evlr4rz9MrfUtFHICTB+BnP8Ponhyw0ez8BsEmy
 8JX0MAd+cu6q3z4k3bFkspd1QlGHlWFQg3KyuXG0CpP/4+w1YZgc6avnSYSuI44eo47v
 6qTYzo0aesSE30+wZNSoPv5Vu/uEP16NhX9Oi5do+AJlVS/LEdUV3hlOjW9IzpxiNLpN
 JpGmmq5xr+9vx7l53PKlw/ueVz2r2reomRgIfxlVugUNIxHLROMMxkECWpSTi/HuBWUm
 9cjg==
X-Gm-Message-State: APjAAAXIOs8YApbGClsTCWo4RJKrG7hw1h735vLR5A6nvK+Ww3yhKmOD
 aiWFDYWyEXYo8DDb5TiUxHNOgw==
X-Google-Smtp-Source: APXvYqzEqIA87lmOYdg55cw071pPNmI9tuxuXp+jL5s+kF8j5ue1unSYTSpxirzmeF6S2KcHSWlqsw==
X-Received: by 2002:adf:a516:: with SMTP id i22mr9137412wrb.273.1571414075363; 
 Fri, 18 Oct 2019 08:54:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q22sm5197506wmj.31.2019.10.18.08.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 08:54:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C4AF1FF87;
 Fri, 18 Oct 2019 16:54:34 +0100 (BST)
References: <20191017131615.19660-1-alex.bennee@linaro.org>
 <20191017131615.19660-38-alex.bennee@linaro.org>
 <20191018153214.GE42857@RDU-FVFX20TUHV2H>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Subject: Re: [PATCH  v6 37/54] plugin: expand the plugin_init function to
 include an info block
In-reply-to: <20191018153214.GE42857@RDU-FVFX20TUHV2H>
Date: Fri, 18 Oct 2019 16:54:34 +0100
Message-ID: <87wod2nj5x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: "robert.foley@futurewei.com" <robert.foley@futurewei.com>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.puhov@futurewei.com" <peter.puhov@futurewei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:

> On Oct 17 14:15, Alex Benn=C3=A9e wrote:
>> This provides a limited amount of info to plugins about the guest
>> system that will allow them to make some additional decisions on
>> setup.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> v6
>>   - split and move to pre example plugins
>>   - checkpatch fixes
>> ---
>>  include/qemu/qemu-plugin.h | 26 ++++++++++++++++++++++++--
>>  plugins/loader.c           | 23 +++++++++++++++++++----
>>  2 files changed, 43 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index c213d1dd19..784f1dfc3d 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -38,9 +38,27 @@
>>
>>  typedef uint64_t qemu_plugin_id_t;
>>
>> +typedef struct {
>> +    /* string describing architecture */
>
> Might be worth noting that this is set to the value of TARGET_NAME qemu
> was built with, and pointing to documentation about the possible values
> it may hold.

OK.

>> +    const char *target_name;
>> +    /* is this a full system emulation? */
>> +    bool system_emulation;
>
> It seems that 'system_emulation' is meant primarily in opposition to
> user-mode. I'm wondering if this could/should this be an enum of the
> execution mode being used to allow for future expansion? Or, if your
> intention here is mostly to allow the user to detect when the *_vcpus
> variables are valid, could it be renamed or commented differently to
> make that link more clear?

The only other operating mode that's ever been mooted is softmmu-user
(and no implementation has been done so far). Even then I don't think
that is a distinction that should be reported to the plugin as we are
trying not to leak implementation details.

But yes the practical upshot is for system emulation you at least have
sort of bounded size for how many threads you may have running.

>
>> +    union {
>> +        /*
>> +         * smp_vcpus may change if vCPUs can be hot-plugged, max_vcpus
>> +         * is the system-wide limit.
>> +         */
>> +        struct {
>> +            int smp_vcpus;
>> +            int max_vcpus;
>> +        } system;
>> +    };
>> +} qemu_info_t;
>
> [...]
>
>> @@ -241,11 +245,22 @@ static void plugin_desc_free(struct qemu_plugin_de=
sc *desc)
>>  int qemu_plugin_load_list(QemuPluginList *head)
>>  {
>>      struct qemu_plugin_desc *desc, *next;
>> +    g_autofree qemu_info_t *info =3D g_new0(qemu_info_t, 1);
>> +
>> +    info->target_name =3D TARGET_NAME;
>> +#ifndef CONFIG_USER_ONLY
>> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>> +    info->system_emulation =3D true;
>> +    info->system.smp_vcpus =3D ms->smp.cpus;
>> +    info->system.max_vcpus =3D ms->smp.max_cpus;
>> +#else
>> +    info->system_emulation =3D false;
>
> Thinking "out loud" here - I wonder if it would be helpful to set the
> *_vcpus variables even for user mode here. It might allow unconditional
> allocation of "per-cpu" structures that the plugin might need - without
> first needing to check whether the *_vcpus variables were valid.

but what too? It would certainly be wrong because any user-space process
could create (and destroy) thousands of threads.

We could consider just asking plugins to deal with threads with their
own __thread variables but in that case we'd need to expose some sort of
thread exit/cleanup method so they can collect data from threads and
safely place it somewhere else - but I suspect that is a hairy
programming model to impose on plugins.

So far all the example plugins have just used locks to serialise things
and it's not been too bad. I guess we could do with an example that
tries to use this information to get an idea of how grungy the interface
is. Perhaps exposing the vCPUs at this point is pointless and we should
just stick to TARGET_NAME for now?

>
> -Aaron


--
Alex Benn=C3=A9e

