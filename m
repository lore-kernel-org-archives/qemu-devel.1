Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0202FC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3CB20830
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJeYotOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3CB20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG02z-0001wx-UQ
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iG01X-0001Ub-FH
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iG01U-0008F5-3i
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:15:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iG01T-0008ES-AA
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:15:56 -0400
Received: by mail-wr1-x442.google.com with SMTP id y19so2686626wrd.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FzacPTlNUKnQ43tm7EzyKmuGlJNT1pooGj2dsuQ39pw=;
 b=oJeYotOZ1UzvleQWhszkAyIkJPhKs5qAMr6JOyrtGbygYrJcdlKsGsyAzt9rJz/FfD
 e7vf50UlsZ6N3ch1fT3EN+Rfsop0TwQO67KwiMMFG8JazsjZbtYs1v5zIQ2Rcs1RL8Ms
 kvEfUQSj5tdD1EcdKK5QJ9qAzT5hJif+Zxt8T+4OgCGVGW2rYfR0XBa7hXF2R0V50LnK
 i2ewCGySu1TDtYCRnAjoa5aNsy4oDAR6/Cs3r+Q6NinbMx/IQUmt6WQkuXiTwKuS73Mu
 mDmKwDYkY99FlX7nNY1ydo/P5N2ldp7DVfeO6Dbh8wiI8V3Dx3rdQ53vD+Kzvp+MlZfJ
 Z2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FzacPTlNUKnQ43tm7EzyKmuGlJNT1pooGj2dsuQ39pw=;
 b=OcBhOYcSOZS31KfEgMuR/xRBDpASmMlyXK+h61psm3I4TMXzbTYiy5Gjm71brOAb7h
 eeZlYuvba3DjJ7Zt85Wzy1TvLZeSrEekGIkkocjdHJwgIvlVkGrhNbLHFrK1wD9CU7Pk
 mn7stfggzLmROk6YPrEcbpDOHidDntfIXA00ZHUjQ6qg+Gb19IUtVjdZQZBoF8vX1Jns
 f1xH5LXJNePdKEsxP8+V/CPTUWAqxKq/Pe5bLKNfctzTGrcNQqcd4sGq9OmAMQjf+E1+
 vhu0v5wSjL8+WwgCr8Z0ZzrmEgkgRHDJurOIXk3orAdp28Y0cwYKB00fQQ58pZgbOHfj
 nshg==
X-Gm-Message-State: APjAAAWpnrswGZfoQuPw61bDX6X0XWi223K9rGDp8i8IwMIVbVrKePV1
 V1HoK80cD8zBC8t+tXrom4g0rEuE+o0=
X-Google-Smtp-Source: APXvYqz6rb7lG0LDt/54GH/jok0jKcNhwWSfXupI21g4plWQlcz86hc0mG1FRlSJMcAkobpAhb0FMQ==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr6565642wrv.327.1570104952445; 
 Thu, 03 Oct 2019 05:15:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h14sm2337574wro.44.2019.10.03.05.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 05:15:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 39E881FF87;
 Thu,  3 Oct 2019 13:15:50 +0100 (BST)
References: <20191002102212.6100-1-alex.bennee@linaro.org>
 <05d59eb3-1693-d5f4-0f6d-9642fd46c32a@redhat.com>
 <20191003092213.etjzlwgd7nlnzqay@steredhat>
 <e85b2eaa-1190-c372-5875-6a024ae3a9cd@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] accel/kvm: ensure ret always set
In-reply-to: <e85b2eaa-1190-c372-5875-6a024ae3a9cd@redhat.com>
Date: Thu, 03 Oct 2019 13:15:50 +0100
Message-ID: <87sgoaja89.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "open list:Overall KVM CPUs" <kvm@vger.kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 10/3/19 11:22 AM, Stefano Garzarella wrote:
>> On Wed, Oct 02, 2019 at 01:08:40PM +0200, Paolo Bonzini wrote:
>>> On 02/10/19 12:22, Alex Benn=C3=A9e wrote:
>>>> Some of the cross compilers rightly complain there are cases where ret
>>>> may not be set. 0 seems to be the reasonable default unless particular
>>>> slot explicitly returns -1.
>>>>
>> Even Coverity reported it (CID 1405857).
>
> And GCC ;)

So my normal gcc didn't catch that - which is odd as I didn't expect the
shippable gcc's to be ahead of my local buster install.

>
> /home/phil/source/qemu/accel/kvm/kvm-all.c: In function =E2=80=98kvm_log_=
clear=E2=80=99:
> /home/phil/source/qemu/accel/kvm/kvm-all.c:1121:8: error: =E2=80=98ret=E2=
=80=99 may be
> used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>      if (r < 0) {
>         ^
> cc1: all warnings being treated as errors
> make[1]: *** [/home/phil/source/qemu/rules.mak:69:
> accel/kvm/kvm-all.o] Error 1
>
> Fixes: 4222147dfb7
>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>   accel/kvm/kvm-all.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>> index aabe097c41..d2d96d73e8 100644
>>>> --- a/accel/kvm/kvm-all.c
>>>> +++ b/accel/kvm/kvm-all.c
>>>> @@ -712,11 +712,11 @@ static int kvm_physical_log_clear(KVMMemoryListe=
ner *kml,
>>>>       KVMState *s =3D kvm_state;
>>>>       uint64_t start, size, offset, count;
>>>>       KVMSlot *mem;
>>>> -    int ret, i;
>>>> +    int ret =3D 0, i;
>>>>         if (!s->manual_dirty_log_protect) {
>>>>           /* No need to do explicit clear */
>>>> -        return 0;
>>>> +        return ret;
>>>>       }
>>>>         start =3D section->offset_within_address_space;
>>>> @@ -724,7 +724,7 @@ static int kvm_physical_log_clear(KVMMemoryListene=
r *kml,
>>>>         if (!size) {
>>>>           /* Nothing more we can do... */
>>>> -        return 0;
>>>> +        return ret;
>>>>       }
>>>>         kvm_slots_lock(kml);
>>>>
>>>
>>> Queued, thanks.
>>>
>>> Paolo
>>>
>>


--
Alex Benn=C3=A9e

