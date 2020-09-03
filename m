Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CA1C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58812065F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CthTq3DK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58812065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoJ2-000420-T5
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDoI8-0002k1-Di
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:24:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDoI6-0007Bi-K0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599135873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xf3gXbWjznWvj5XJZJlE33gUZM7RVJ2VAZKrOizNdWU=;
 b=CthTq3DKhOI5Ms9qfCdbiJE0Si5XSo4+5FX1QsdMV0n+LxGYLAoamxQSiBNV8lFVldl0pj
 2yXtPMOVB+fyBTTyx0MPefSMFdSlqPHfg+Aqb+olfk4zZVPoM9IY6yCwFnxFhN8Y/AQIGj
 wu2Ef6x0LWL7a6m7XhOkK5vg6uROga8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-dRE1FLRxMlKhNJpsK0vSsg-1; Thu, 03 Sep 2020 08:24:32 -0400
X-MC-Unique: dRE1FLRxMlKhNJpsK0vSsg-1
Received: by mail-wr1-f70.google.com with SMTP id x15so194226wrm.7
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xf3gXbWjznWvj5XJZJlE33gUZM7RVJ2VAZKrOizNdWU=;
 b=tiUmX5Oru04QorQ92JBLTwPoYRIawGrjbdSDHdqa/J81aQ2x4YtOX7DfSZRRxQo22i
 5UNG+/WJGPJ+GVRSAas4/EevRtOWqXgbFMz/W/4tFTwgyqff3ABsbxd+f+xEp1bzSCYO
 51/CP0XqRtanV2xZTDSTXVaPgAzTUWBWkWQHBbwFwAOnrgGTtZntOWWKKvBroAnrzbyr
 VRYhVOAVVqFvbPrKJO77J0sA1f/yAmtu70zrdiVUy6aamdDaa46uh7Cloh0JwAW2bDtJ
 nYJLTR84mafv2rx6l4Tk8Af7IFqgnsmRKhrWazNnSEVPqZaQvhauR1vwGUmB2AV5VUHL
 NLsw==
X-Gm-Message-State: AOAM530A8A5I5svpLmawXZOzzjJRUD8ychy5GG6BXH0o01ZU6781jGcL
 neD2ph+WM45yLzQ2J2sQciHvphYkOPotL4yzKHzx7wK0KelVs2taTPzyqmbSvfWqQQO/a9k0u2+
 gbhmFMeOdVvHezPQ=
X-Received: by 2002:adf:f843:: with SMTP id d3mr2399827wrq.226.1599135871054; 
 Thu, 03 Sep 2020 05:24:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzRk81Xx09G7Y0tPHX7OjlE32FPo1JMa3K1u/nRw8a9edOAcdPE6ifHC23fWx72/sCtaI9XQ==
X-Received: by 2002:adf:f843:: with SMTP id d3mr2399800wrq.226.1599135870812; 
 Thu, 03 Sep 2020 05:24:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:197c:daa0:48d1:20b2?
 ([2001:b07:6468:f312:197c:daa0:48d1:20b2])
 by smtp.gmail.com with ESMTPSA id v204sm4160604wmg.20.2020.09.03.05.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:24:30 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] CODING_STYLE.rst: flesh out our naming conventions.
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-2-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2bec34f7-005b-1194-7773-23ccc13645b3@redhat.com>
Date: Thu, 3 Sep 2020 14:24:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903112107.27367-2-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 13:21, Alex Bennée wrote:
> Mention a few of the more common naming conventions we follow in the
> code base including common variable names and function prefix and
> suffix examples.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - punctuation fixes suggested by Cornelia
>   - re-worded section on qemu_ prefix
>   - expanded on _locked suffix
> v3
>   - re-order phrasing around qemu_ prefix
>   - drop "while actual..." shortname examples
> 
> squash! CODING_STYLE.rst: flesh out our naming conventions.
> ---
>  CODING_STYLE.rst | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> index 427699e0e42..fd8ce9ceaba 100644
> --- a/CODING_STYLE.rst
> +++ b/CODING_STYLE.rst
> @@ -109,8 +109,35 @@ names are lower_case_with_underscores_ending_with_a_t, like the POSIX
>  uint64_t and family.  Note that this last convention contradicts POSIX
>  and is therefore likely to be changed.
>  
> -When wrapping standard library functions, use the prefix ``qemu_`` to alert
> -readers that they are seeing a wrapped version; otherwise avoid this prefix.
> +Variable Naming Conventions
> +---------------------------
> +
> +A number of short naming conventions exist for variables that use
> +common QEMU types. For example, the architecture independent CPUState
> +is often held as a ``cs`` pointer variable, whereas the concrete
> +CPUArchState is usually held in a pointer called ``env``.
> +
> +Likewise, in device emulation code the common DeviceState is usually
> +called ``dev``.
> +
> +Function Naming Conventions
> +---------------------------
> +
> +The ``qemu_`` prefix is used for utility functions that are widely
> +called from across the code-base. This includes wrapped versions of
> +standard library functions (e.g. ``qemu_strtol``) where the prefix is
> +added to the library function name to alert readers that they are
> +seeing a wrapped version.

I think we're slowly moving away from "qemu_" except for wrappers, so I
would move this paragraph last, wording it like this:

---
Wrapped version of standard library or GLib functions use a ``qemu_``
prefix to alert readers that they are seeing a wrapped version, for
example ``qemu_strtol`` or ``qemu_mutex_lock``.  Other utility functions
that are widely called from across the codebase should not have any
prefix, for example ``pstrcpy`` or bit manipulation functions such as
``find_first_bit``.

The ``qemu_`` prefix is also used for functions that modify global
emulator state, for example ``qemu_add_vm_change_state_handler``.
However, if there is an obvious subsystem-specific prefix it should be
used instead.
---

Paolo

> +Public functions from a file or subsystem (declared in headers) tend
> +to have a consistent prefix to show where they came from. For example,
> +``tlb_`` for functions from ``cputlb.c`` or ``cpu_`` for functions
> +from cpus.c.
> +
> +If there are two versions of a function to be called with or without a
> +lock held, the function that expects the lock to be already held
> +usually uses the suffix ``_locked``.
> +
>  
>  Block structure
>  ===============
> 



