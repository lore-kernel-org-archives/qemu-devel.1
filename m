Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A21FC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F282072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pap2WNtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F282072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGIKl-00072A-Cm
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jGIK9-0006cC-0O
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jGIK7-0001Uw-AH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:20:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51707)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jGIK7-0001U6-69
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584951638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nSOgZEp4bCAdBZiHo1R57ysRAlRlHzbuwPhGxzEfpM4=;
 b=Pap2WNtBVSbbx2xARkq3Oj9YWuZ4uXQlHX+8BMkbwLrP7toQbBfKS7j8P2vQPt3dVeyCmK
 dsLgsXKqSZP3y/HqLQcNr4E0FqfWOxfCiaMeAFoOKzA2NKuAPHB3NeOD2Mtncilzzgo6IB
 kd3tWxr2y5+RK9PwIHi/oE+UmYCv2pU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-EgJJeQ6vNmmK6qk3q1arFA-1; Mon, 23 Mar 2020 04:20:35 -0400
X-MC-Unique: EgJJeQ6vNmmK6qk3q1arFA-1
Received: by mail-wr1-f72.google.com with SMTP id q18so6982109wrw.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 01:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6SYB+i3se6qE7NCAetul4wVyuuVt4AgvuKGVZBeGbvU=;
 b=t5TxfITmBSnYKDMP6DZKiaD1XSY6rumbzTOtObziW5uwOkkSwOX/3E3LeWcVOM8Voq
 ED7T7nOUQC659nuFW4YVeHQ45UlrhAl7XilWoSLgnNuMrhXLjjvldgQRtezOzmPx0NLt
 bCzLqUV4QxU6/K7IaEwTIXUhUsYclM+NgYYmrtN5kKAEdgwYxpgk162boyk89JzkZBjH
 x2KRLZTiliHoNOwGWQM6QgBBWr12Ya8drmMlaG1lz07V9Cx78d2GOMHMEbIpPda6ugYP
 lc5RXyRjYhJtwB7LpQ2X/rvtHuJ090rQOplMooVr7KdHc078rS6bP4RfSeTGr3rHNsEl
 xBAA==
X-Gm-Message-State: ANhLgQ3JmgkP8ZpzuE6xhZzp02c2Xz+fgEhRJ7r3mqHIeXrVkKzYrpYc
 rHNr5Dp/Z3tav+kB7DFQfS8+qb7qetJOm4oa6iypGTxx5oK19/6qtW2anOxHi1Fhy8yw2xjt6lB
 yaErwHDCu4nfnbf8=
X-Received: by 2002:adf:efc2:: with SMTP id i2mr26512235wrp.420.1584951634705; 
 Mon, 23 Mar 2020 01:20:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtkFCmP6XKyaP/GynKQLgKnlkbLRWyVymeCqyZezPVG14bwFBRtMzh3f38yc3eh+Vfe8KrMtA==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr26512208wrp.420.1584951634445; 
 Mon, 23 Mar 2020 01:20:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01?
 ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
 by smtp.gmail.com with ESMTPSA id 98sm22579633wrk.52.2020.03.23.01.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 01:20:34 -0700 (PDT)
Subject: Re: [PATCH] hax: Windows doesn't like posix device names
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Wenchao Wang <wenchao.wang@intel.com>, Colin Xu <colin.xu@intel.com>
References: <20200322210211.29603-1-vr_qemu@t-online.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e38bcea7-4fce-724f-d154-d3ffc3d3d33f@redhat.com>
Date: Mon, 23 Mar 2020 09:20:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200322210211.29603-1-vr_qemu@t-online.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Julio Faracco <jcfaracco@gmail.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/03/20 22:02, Volker R=C3=BCmelin wrote:
> Patch acb9f95a7c "i386: Fix GCC warning with snprintf when HAX
> is enabled" replaced Windows device names with posix device
> names. Revert this.
>=20
> Fixes: acb9f95a7c "i386: Fix GCC warning with snprintf when HAX is enable=
d"
>=20
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  target/i386/hax-windows.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
> index 0ba488c468..863c2bcc19 100644
> --- a/target/i386/hax-windows.c
> +++ b/target/i386/hax-windows.c
> @@ -185,12 +185,12 @@ int hax_mod_version(struct hax_state *hax, struct h=
ax_module_version *version)
> =20
>  static char *hax_vm_devfs_string(int vm_id)
>  {
> -    return g_strdup_printf("/dev/hax_vm/vm%02d", vm_id);
> +    return g_strdup_printf("\\\\.\\hax_vm%02d", vm_id);
>  }
> =20
>  static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
>  {
> -    return g_strdup_printf("/dev/hax_vm%02d/vcpu%02d", vm_id, vcpu_id);
> +    return g_strdup_printf("\\\\.\\hax_vm%02d_vcpu%02d", vm_id, vcpu_id)=
;
>  }
> =20
>  int hax_host_create_vm(struct hax_state *hax, int *vmid)
>=20

Queued, thanks.

Paolo


