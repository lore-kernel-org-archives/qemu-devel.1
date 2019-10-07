Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A41BC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB682133F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SW2myWjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB682133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHOVO-0002HV-A7
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 04:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHOUW-0001kP-1T
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHOUU-0001Tk-QS
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:35:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHOUU-0001T7-Hi
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:35:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id b9so14177347wrs.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=e36vx9BToZ9Dyu8TCTwUtoyCICJ1SNfGmKrG/1vaxjk=;
 b=SW2myWjbGRJ3n7ZCL6NRU0MF/vj6L2Ksa4XHbo6OvDg80VA7ikxcgjd5Tm8PuwMxhP
 cYp+wHr3+D7AiF7Fi7um9hbbWejk550t80MNHVFAXREh2qL9D5FT+VCLXIEEL7igXNdN
 i4Z+hXoBR6x2XvNQ7LVVlhVfMcSLUJWYHreNO0CBaSsd0wbpV9aCIdMpvJgBvXng1KKN
 yM+XZvyX3TFLU0RoHT3iUt8a1DuFcYxrBEFjjPv59IXD0NboHUjYOdEPu2xkM+PmPhAP
 O9qH/dpO8hLP3EX/4YnVIMByZZFlQ1slSAbAw/bqlCWG8N9uqt9r2/Zo+hInrXLuqhor
 P/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=e36vx9BToZ9Dyu8TCTwUtoyCICJ1SNfGmKrG/1vaxjk=;
 b=QZ+ESssFE28RXRl1SP6H+LXw5Zy0738tiM6OuhHYjmnuJMhkZw+bTFY2S+aItnv06Y
 Oy+e6mAuOAh9uCZ4qPEEkfdS7Z9hRdbTGXVCuTb86KVn0Ua9dY7shqKSHcxLCK7+XVn6
 DbNYDHKsQ6d25t9Z0svWm0d+B+LXi0gulNol1/EpBAKvB5IVtK8P1OLhMqpqb2JMUUP0
 P8i6ZJiA7fDD6V+75ge1mSrLkyFNutF6MoZWpgzz/IbMRgcJlBZGZebBWuLzE6Ro2oTH
 xU2f4VbvBAE/0Z5+RKMk+tRtQZPfqOIxDkifXKpG577sCobsKh3L46fobjXtkyQBAi6t
 i/ZQ==
X-Gm-Message-State: APjAAAVHDbspVV/EXZAKgvkYehgqlm0U9vmqiaRRr4adwb8i7Tap815m
 347mXy8rJhs7CrydupdMCkoHNA==
X-Google-Smtp-Source: APXvYqx2gELxpTSKDNvcU+IIVQe4jqR2Qh/oopbyBRkXOUmL70XR0Mu04t6Wq3mBS28l8oT1s2nGkw==
X-Received: by 2002:a5d:45c7:: with SMTP id b7mr12595680wrs.356.1570437336473; 
 Mon, 07 Oct 2019 01:35:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm38308974wrf.73.2019.10.07.01.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 01:35:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B0A81FF87;
 Mon,  7 Oct 2019 09:35:35 +0100 (BST)
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-5-drjones@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v5 4/9] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
In-reply-to: <20191001125845.8793-5-drjones@redhat.com>
Date: Mon, 07 Oct 2019 09:35:35 +0100
Message-ID: <87d0f9j6lk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Andrew Jones <drjones@redhat.com> writes:

> Introduce cpu properties to give fine control over SVE vector lengths.
> We introduce a property for each valid length up to the current
> maximum supported, which is 2048-bits. The properties are named, e.g.
> sve128, sve256, sve384, sve512, ..., where the number is the number of
> bits. See the updates to docs/arm-cpu-features.rst for a description
> of the semantics and for example uses.
>
> Note, as sve-max-vq is still present and we'd like to be able to
> support qmp_query_cpu_model_expansion with guests launched with e.g.
> -cpu max,sve-max-vq=3D8 on their command lines, then we do allow
> sve-max-vq and sve<N> properties to be provided at the same time, but
> this is not recommended, and is why sve-max-vq is not mentioned in the
> document.  If sve-max-vq is provided then it enables all lengths smaller
> than and including the max and disables all lengths larger. It also has
> the side-effect that no larger lengths may be enabled and that the max
> itself cannot be disabled. Smaller non-power-of-two lengths may,
> however, be disabled, e.g. -cpu max,sve-max-vq=3D4,sve384=3Doff provides a
> guest the vector lengths 128, 256, and 512 bits.
>
> This patch has been co-authored with Richard Henderson, who reworked
> the target/arm/cpu64.c changes in order to push all the validation and
> auto-enabling/disabling steps into the finalizer, resulting in a nice
> LOC reduction.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  docs/arm-cpu-features.rst | 168 +++++++++++++++++++++++++++++++--
>  include/qemu/bitops.h     |   1 +
>  target/arm/cpu.c          |  19 ++++
>  target/arm/cpu.h          |  19 ++++
>  target/arm/cpu64.c        | 192 ++++++++++++++++++++++++++++++++++++-
>  target/arm/helper.c       |  10 +-
>  target/arm/monitor.c      |  12 +++
>  tests/arm-cpu-features.c  | 194 ++++++++++++++++++++++++++++++++++++++
>  8 files changed, 606 insertions(+), 9 deletions(-)
>
> diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
> index c79dcffb5556..2ea4d6e90c02 100644
> --- a/docs/arm-cpu-features.rst
> +++ b/docs/arm-cpu-features.rst
> @@ -48,18 +48,31 @@ block in the script for usage) is used to issue the Q=
MP commands.
>        (QEMU) query-cpu-model-expansion type=3Dfull model=3D{"name":"max"}
>        { "return": {
>          "model": { "name": "max", "props": {
> -        "pmu": true, "aarch64": true
> +        "sve1664": true, "pmu": true, "sve1792": true, "sve1920": true,
> +        "sve128": true, "aarch64": true, "sve1024": true, "sve": true,
> +        "sve640": true, "sve768": true, "sve1408": true, "sve256": true,
> +        "sve1152": true, "sve512": true, "sve384": true, "sve1536": true,
> +        "sve896": true, "sve1280": true, "sve2048": true

Does having a list of VL's not have implications for the versioning of
the API? Do we need to tick a version each time a new vector length is
added?

--
Alex Benn=C3=A9e

