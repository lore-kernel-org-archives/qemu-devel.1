Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ECEC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D7D20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcqGD5Ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D7D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv3p-0001zo-33
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuBK-0003Su-K2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuBJ-0004uI-ED
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:09:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuBJ-0004sM-9H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584382181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpxvY3ThyZqztPfmjG1WgZp2s8Gh0pJx/1+caEnmG58=;
 b=XcqGD5NgFoPrydfycPef79b9CUGGpWQ9wXUYEH6ITt+A/7qnf3WnENX6uCIqvjW+JIxg2j
 9gnjR7HfFxO5+uyuHa4ezHWJNqh/vtDsoN43oUpMDM6SHlTAhVUDXn6yWjkPkvXH4MYIQP
 rXva68X+zxWPZBz5q8iAJLa1ElTV1gg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-v9HXn0sdMEW5X1-dznxNjA-1; Mon, 16 Mar 2020 14:09:36 -0400
X-MC-Unique: v9HXn0sdMEW5X1-dznxNjA-1
Received: by mail-ed1-f72.google.com with SMTP id o13so15679288edt.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TQv8d8ScNKK9NUVYi/BoZzj0hMagcBF2yzDXzKLkbdY=;
 b=JzmCFVn3nYDckSOMmyn7KdOsIjUtz8cDPsHlgyHW17xr13Wo3g260SVBO1kKkCd43k
 ADIZLVnK1Hbl0tflHX2KikdApkO4kAF9lk28qAopmB+GpNgX80CAVv4pwQGUaGBgNJAS
 swE5P8MJ3uw2U3vIRG4l0IOXhVet/eNmCZ2tqiZcmMmOvW08bo4oR3TLTzDzuYMoQpis
 uR1a6VlEWjzftMJOeuYu5fo43Lp2hzT4uNHCfxRhpNngICVtzVBEaBJDSAlH0Vn03k7K
 hE4QYlVmDPib1u8KShxHRZbUV+K0DmASoqDhVgFVLxDlyiq7AC6z0F7/dxowgRA7TxmH
 rxOQ==
X-Gm-Message-State: ANhLgQ2+G6hJ+LUEf0+jJbS2vzN5lmblXsJpfKDYIaMw6pZi4tbi9cFw
 iWmxOOfBo2qQXxVmcGmeJWMMF85lU+i2ggjGpweuiXR+auLWgh/aAkxl7mJCVCERDDY74ILkVJm
 kmz4VtwjVon2Hk8E=
X-Received: by 2002:a05:6402:22ba:: with SMTP id
 cx26mr1355409edb.24.1584382175739; 
 Mon, 16 Mar 2020 11:09:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs4+matKifEPFFAH5rFh3B6UDGDa0Oksh5UyTIDc8TztLhrIpJcoyoe6eazQtgqbprai47ijg==
X-Received: by 2002:a05:6402:22ba:: with SMTP id
 cx26mr1355376edb.24.1584382175492; 
 Mon, 16 Mar 2020 11:09:35 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id g19sm40917ejr.65.2020.03.16.11.09.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:09:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] migration: avoid suspicious strncpy() use
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200316160702.478964-1-stefanha@redhat.com>
 <20200316160702.478964-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <24d36e90-5880-02ad-fa24-761eb3d9074f@redhat.com>
Date: Mon, 16 Mar 2020 19:09:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316160702.478964-2-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 5:07 PM, Stefan Hajnoczi wrote:
> gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1) with sanitizers enabled
> reports the following error:
>=20
>      CC      migration/global_state.o
>    In file included from /usr/include/string.h:495,
>                     from /home/stefanha/qemu/include/qemu/osdep.h:101,
>                     from migration/global_state.c:13:
>    In function =E2=80=98strncpy=E2=80=99,
>        inlined from =E2=80=98global_state_store_running=E2=80=99 at migra=
tion/global_state.c:47:5:
>    /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin=
_strncpy=E2=80=99 specified bound 100 equals destination size [-Werror=3Dst=
ringop-truncation]
>      106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos =
(__dest));
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>=20
> Use pstrcpy() instead of strncpy().  It is guaranteed to NUL-terminate
> strings.

There was a long discussion 1 year ago with it, and Eric suggested to=20
use strpadcpy after the assert() and I sent this patch:
https://www.mail-archive.com/qemu-block@nongnu.org/msg44925.html
Not sure what's best.

>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   migration/global_state.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 25311479a4..cbe07f21a8 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -44,8 +44,8 @@ void global_state_store_running(void)
>   {
>       const char *state =3D RunState_str(RUN_STATE_RUNNING);
>       assert(strlen(state) < sizeof(global_state.runstate));
> -    strncpy((char *)global_state.runstate,
> -           state, sizeof(global_state.runstate));
> +    pstrcpy((char *)global_state.runstate,
> +            sizeof(global_state.runstate), state);
>   }
>  =20
>   bool global_state_received(void)
>=20


