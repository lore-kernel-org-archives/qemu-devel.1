Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFADC47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4154B207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJLsA+nP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4154B207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkoR-00073O-C6
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWknX-0006O6-PG
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:59:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47177
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWknW-0004e3-2R
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588874340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9idwHiBArQkLPMIH6vJnkIjBfE8aaAJo82fuR0CNHc=;
 b=YJLsA+nP78c6Cjb7Hy9+rivPOCSxlox2hqJM21eJ//GPumKtZkJ1/0mig21OnN3k27F03u
 FRgN3cmXQJfzdxkc8pMCdc30YTU8rdye7yZwulYvj9GC0V8w5sndi6bth2YBCw29BW8AO7
 K+acgG5b5GmkB27AlNN+VizH+cAsg/k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-m40DmFRiOqe4Ne58-wQrBw-1; Thu, 07 May 2020 13:58:58 -0400
X-MC-Unique: m40DmFRiOqe4Ne58-wQrBw-1
Received: by mail-wr1-f69.google.com with SMTP id s11so3892339wru.6
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t5Sc/vQ9jeFnB2EJSOWHM4JNfRsE1IUjBYJIm5G9RZ4=;
 b=IPG9p1llmsszrdi6ad33S3NUxesJLeKNtZSLNkViXRwUYJ/6Xbda5aBwLj3r195A5J
 oG92zAfRBXKtaUQscR6HB5QF+/dq8Gs9CGzIyHnTMFY5oBRRZxwwNNT0hNAHMRlcMpWJ
 D71XCTIUJx2WXQV3C8eYARp80mQEeyjlAxGtYGvO1m5ar3h7SQsKuhNRaDCjPGzYls2H
 lzliNIa90lfXAk0LCUphY/umo+X583p4S3NUg0CtaqkTEp3FyXaPxStW6AqO5dDFfcHu
 s7V4lAGpym5WgoEDUSljgsP3og/sfiQyiGVkuy+EIuZWzExZ35yqnM6fQfpb59OKmnua
 hODA==
X-Gm-Message-State: AGi0PuY94xcqRSE1oMw+jikhltpI1kiRj3FLgaQPzCWkhmQGtnZnDDmk
 AxoJbSPUH6jnR3ro7by/r9hBPFl94fs3wECG/iXTkKZB35CjDrsGilPAZqdpT0ACoIidJdQ5/Nu
 a24C5jgIaEeFCBMo=
X-Received: by 2002:a05:600c:d8:: with SMTP id
 u24mr4864910wmm.19.1588874336899; 
 Thu, 07 May 2020 10:58:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypIwdl3FihCjCYzUR1fytfOJ63O/rJPns4uLKaG2H5OFDYmw4gsNSixxs7qfQnP4OQh24LiKFw==
X-Received: by 2002:a05:600c:d8:: with SMTP id
 u24mr4864891wmm.19.1588874336641; 
 Thu, 07 May 2020 10:58:56 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id o2sm2286688wmc.21.2020.05.07.10.58.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 10:58:56 -0700 (PDT)
Subject: Re: [PATCH] target/ppc: Untabify excp_helper.c
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <158886788307.1560068.14096740175576278978.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fe5d9b00-0ac5-b92c-fe12-eb22d2b439c1@redhat.com>
Date: Thu, 7 May 2020 19:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158886788307.1560068.14096740175576278978.stgit@bahia.lan>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 6:11 PM, Greg Kurz wrote:
> Some tabs crept in with a recent change.
>=20
> Fixes: 6dc6b557913f "target/ppc: Improve syscall exception logging"
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
using `git-diff --ignore-space-change`.

> ---
>   target/ppc/excp_helper.c |   16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 639cac38f9c3..4db3d9ed9af5 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -70,16 +70,16 @@ static inline void dump_syscall(CPUPPCState *env)
>   static inline void dump_hcall(CPUPPCState *env)
>   {
>       qemu_log_mask(CPU_LOG_INT, "hypercall r3=3D%016" PRIx64
> -=09=09  " r4=3D%016" PRIx64 " r5=3D%016" PRIx64 " r6=3D%016" PRIx64
> -=09=09  " r7=3D%016" PRIx64 " r8=3D%016" PRIx64 " r9=3D%016" PRIx64
> -=09=09  " r10=3D%016" PRIx64 " r11=3D%016" PRIx64 " r12=3D%016" PRIx64
> +                  " r4=3D%016" PRIx64 " r5=3D%016" PRIx64 " r6=3D%016" P=
RIx64
> +                  " r7=3D%016" PRIx64 " r8=3D%016" PRIx64 " r9=3D%016" P=
RIx64
> +                  " r10=3D%016" PRIx64 " r11=3D%016" PRIx64 " r12=3D%016=
" PRIx64
>                     " nip=3D" TARGET_FMT_lx "\n",
>                     ppc_dump_gpr(env, 3), ppc_dump_gpr(env, 4),
> -=09=09  ppc_dump_gpr(env, 5), ppc_dump_gpr(env, 6),
> -=09=09  ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
> -=09=09  ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
> -=09=09  ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
> -=09=09  env->nip);
> +                  ppc_dump_gpr(env, 5), ppc_dump_gpr(env, 6),
> +                  ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
> +                  ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
> +                  ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
> +                  env->nip);
>   }
>  =20
>   static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int exc=
p,
>=20
>=20


