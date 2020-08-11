Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89CBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821292075D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCfFUZHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821292075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Sno-0002GA-Qd
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 07:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5Slq-00083v-Eh
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:48:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5Slo-0000Ti-6U
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:48:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so11205700wrw.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Z1nOz+t1GQIh1GsapZwTPmgP/ZenjM+deAv+BSaYEHI=;
 b=bCfFUZHF2LUhTRj5uBwT5nPsP7Lq/b8m/mkA+RTUqKwQhN32a5oUba7QcE54f/Cl7V
 txe0Yl6WnnowjIc9rFQHgoOoNGu0vd3L93NJl92N7V+8zTs7qSlXxUnHqDs/Z1hpHZOb
 AZrpEjd9PWoGoqbg2ZCgmGoKWYM+VruntW2K6307NpIy3c2wAIlY66Gg7UWvQJSd+ClA
 uNt9D+nXJrOqqIGAf3Ky4d+c5AU1Lq00a6dPGEpHcONtChyjFoB0tcckqHixUOi3HVSJ
 DxWjp047I3oP8DicbZBIAen19iq6Yxz01QJNzgcZKRHRcpLPa+XJO3mG90yGuq+pBnGd
 LCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Z1nOz+t1GQIh1GsapZwTPmgP/ZenjM+deAv+BSaYEHI=;
 b=MKTzkxorC5bx7pRMnrJbV7U1MJDnjIJmS62SMmfMSsfyrjr84CH/d2DIMuepgPXrSR
 OPUlSM6TIMfLBq4EbtSB5x3Zxdu0+f/g5sGS8cfMOD+5GD5QTJJjteNWcReN2b15417S
 IqpKU46KH/NB1/iKvC8xvrFhiA2PltRPD5dnF4pGsu98DcKZ9ZQFgUCz/fCsPCmdCSY4
 09lO/9W6xP6TlRmo0f9Gm8ucyuiZRBxV7qjkmNDNZ7trOOmUbyojHXtIzGRyqa3aRkhe
 MT3Vy4ioMJmfIJVTEJ6wXWXAnnAj5oghEW0V0yafzA144jSx2b+Flo8OKR16NOZQ1t5R
 k7Dw==
X-Gm-Message-State: AOAM5303dI9XRBln2T14Je/Zcp5Pp8W0GZpI8bUEOI5VZi2ub5FkWLOe
 uYK34grVjrgiHBsYTEPERXrvWFs/vps=
X-Google-Smtp-Source: ABdhPJyFkNLxv2OMaiDUqfUBlv4ECNX27G1VZaVZ3l8xIsPw7Yyi6QTOpFhgYX1xfKaA6erWSIq/vw==
X-Received: by 2002:adf:94c5:: with SMTP id 63mr28840122wrr.34.1597146520880; 
 Tue, 11 Aug 2020 04:48:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n12sm4143091wrq.63.2020.08.11.04.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 04:48:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B8D41FF7E;
 Tue, 11 Aug 2020 12:48:38 +0100 (BST)
References: <20200810105147.10670-1-alex.bennee@linaro.org>
 <20200811090828.12307821.cohuck@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] CODING_STYLE.rst: flesh out our naming conventions.
In-reply-to: <20200811090828.12307821.cohuck@redhat.com>
Date: Tue, 11 Aug 2020 12:48:38 +0100
Message-ID: <87zh711jzd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cornelia Huck <cohuck@redhat.com> writes:

> On Mon, 10 Aug 2020 11:51:47 +0100
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Mention a few of the more common naming conventions we follow in the
>> code base including common variable names and function prefix and
>> suffix examples.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> v2
>>   - punctuation fixes suggested by Cornelia
>>   - re-worded section on qemu_ prefix
>>   - expanded on _locked suffix
>> ---
>>  CODING_STYLE.rst | 30 ++++++++++++++++++++++++++++--
>>  1 file changed, 28 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
>> index 427699e0e42..e7ae44aed7f 100644
>> --- a/CODING_STYLE.rst
>> +++ b/CODING_STYLE.rst
>> @@ -109,8 +109,34 @@ names are lower_case_with_underscores_ending_with_a=
_t, like the POSIX
>>  uint64_t and family.  Note that this last convention contradicts POSIX
>>  and is therefore likely to be changed.
>>=20=20
>> -When wrapping standard library functions, use the prefix ``qemu_`` to a=
lert
>> -readers that they are seeing a wrapped version; otherwise avoid this pr=
efix.
>> +Variable Naming Conventions
>> +---------------------------
>> +
>> +A number of short naming conventions exist for variables that use
>> +common QEMU types. For example, the architecture independent CPUState
>> +this is often held as a ``cs`` pointer variable, whereas the concrete
>
> s/this//
>
>> +CPUArchState us usually held in a pointer called ``env``.
>
> s/us/is/
>
>> +
>> +Likewise, in device emulation code the common DeviceState is usually
>> +called ``dev`` with the actual status structure often uses the terse
>
> s/with/while/

Oops sorry about those - serves me right for trying to re-spin too quickly.

>
>> +``s`` or maybe ``foodev``.
>> +
>> +Function Naming Conventions
>> +---------------------------
>> +
>> +The ``qemu_`` prefix is used for utility functions that are widely
>> +called from across the code-base. This includes wrapped versions of
>> +standard library functions (e.g. qemu_strtol) where the prefix is
>> +added to the function name to alert readers that they are seeing a
>> +wrapped version; otherwise avoid this prefix.
>
> Hm... not so sure about "otherwise avoid this prefix". It sounds a bit
> like you should avoid it for anything but wrappers, but I think what we
> want to say is that qemu_ should be used for anything that is
> potentially useful in many places, but probably not if there is a
> better prefix?

Yeah it's a hangover from the previous phrasing. Our current usage
certainly isn't just for wrapped functions - qemu_mutex_lock_iothread and
friends for example are very specifically qemu utility functions rather
than wrapped functions.

We also have a bunch of static functions that should really not have the
prefix - qemu_kvm_start_vcpu for example looses nothing by just being
kvm_start_vcpu.

We also have functions that could arguably just use a subsystem prefix -
for example qemu_chr_fe_accept_input is very much a thing you only call
when dealing with chardev frontends (chr_fe).

I'm certainly not proposing mass renames but it's clear our usage is
wider than just wrapped functions.

If I re-arrange slightly we can roll from qemu_ to public functions:

  Function Naming Conventions
  ---------------------------

  The ``qemu_`` prefix is used for utility functions that are widely
  called from across the code-base. This includes wrapped versions of
  standard library functions (e.g. ``qemu_strtol``) where the prefix is
  added to the library function name to alert readers that they are
  seeing a wrapped version.

  Public functions from a file or subsystem (declared in headers) tend
  to have a consistent prefix to show where they came from. For example,
  ``tlb_`` for functions from ``cputlb.c`` or ``cpu_`` for functions
  from cpus.c.

  If there are two versions of a function to be called with or without a
  lock held, the function that expects the lock to be already held
  usually uses the suffix ``_locked``.

What do you think?

(note to self, _impl seems like another convention we should document at
some point).

--=20
Alex Benn=C3=A9e

