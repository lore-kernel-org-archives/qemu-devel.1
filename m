Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49028C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BA12190F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYjKuQmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BA12190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFE8T-0006af-Uz
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFE6m-00051i-Jv
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFE6l-000807-GO
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:06:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFE6l-0007zj-6Q
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569920770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7P1ZktAolcjho5DdBW/TZGwCndMvQnzW2x3dOf4l240=;
 b=JYjKuQmokFuqfQIi2dAmc0ZOOJeGqjZDW/mT7x53+zv/nh4Bl2eQuSctAZ4MrEYR9XX/Vt
 Hh7y8KOOG0CETMhYT984ZmI99R6UDXmPbjDhNoPEoIFOdRl4OVgng5iy3cPcxovMcLYCso
 X+Pan4uTGGJRjy0weRFJGMtQXdxT06M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-1y-U84kfO6iY_wOVySwOSg-1; Tue, 01 Oct 2019 05:06:07 -0400
Received: by mail-wr1-f69.google.com with SMTP id t11so5711781wrq.19
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 02:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ShRVkeeNm8ND09rw/w0sONyhcVtOOoQpe2MMGCyi/2I=;
 b=Eo1FTQn7R6Z1/YBp5jbAhTIy0HvgUYJg/6Pp8ry5phfmpcc2cEH9PiMdwTcpqIvCKz
 N9sg68yJRAtQog389rhg+RV/hsv4IuvfR958U7qmS5KWM2xiAAYrIHylhiJAS/mmMpeH
 W5nLDF7+Mh/2W3Tm1IneEsAlA3nk1L9tWrjA5bkJU0UU+X7OxnV/l0d0JgNZJMZ5Ycp0
 iBw9hA0GgTUCFke1uIlTLM3nDHhEYKMY6QtalG4i0AGvfrPAsa9KkQg1THQ0tCJVCDyM
 70sLL5LfM3Iy6/XWVaw8vvI7PcUZZjZQSG+p6OSkdOnjCk9WDKOAsy9NOP01rxdbf8FQ
 LU0w==
X-Gm-Message-State: APjAAAUAdGV+KLtIXVaQWkfHu30LXXbnDCOO38VaqC5ywPjMJYR8Jbrb
 z3BTkWfN8xhLd4vCE4LPcGWzd0pZB7Vxv4RmWsVMSCQ5ScAMB35AaMpm8zHMu0AQ3Vmwr3FyXH/
 A7FHiVAGfKJhscvM=
X-Received: by 2002:a5d:5642:: with SMTP id j2mr14086712wrw.345.1569920765446; 
 Tue, 01 Oct 2019 02:06:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwB2GHltk4wE42LWLy6JO1T6bdZGHtQs1Ot0otkYzbz4RKeRqjHIN6EYatH2Ua3msW1UhkBzg==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr14086699wrw.345.1569920765291; 
 Tue, 01 Oct 2019 02:06:05 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id l11sm2526703wmh.34.2019.10.01.02.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 02:06:04 -0700 (PDT)
Subject: Re: [PATCH] linux-user: add strace for dup3
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvmsgoe17l5.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5bc7982a-e036-bfef-93c6-7c5643526789@redhat.com>
Date: Tue, 1 Oct 2019 11:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <mvmsgoe17l5.fsf@suse.de>
Content-Language: en-US
X-MC-Unique: 1y-U84kfO6iY_wOVySwOSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/19 11:01 AM, Andreas Schwab wrote:
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/strace.list | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 63a946642d..863283418e 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -121,6 +121,9 @@
>   #ifdef TARGET_NR_dup2
>   { TARGET_NR_dup2, "dup2" , NULL, NULL, NULL },
>   #endif
> +#ifdef TARGET_NR_dup3
> +{ TARGET_NR_dup3, "dup3" , NULL, NULL, NULL },
> +#endif
>   #ifdef TARGET_NR_epoll_create
>   { TARGET_NR_epoll_create, "epoll_create" , NULL, NULL, NULL },
>   #endif
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


