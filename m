Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E14CC4332B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 23:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2945120768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 23:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWU4tyzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2945120768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEiFA-0002T6-BL
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 19:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEiER-00021W-LP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEiEQ-0006b2-Gb
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:36:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEiEQ-0006ZW-Da
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584574574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JqeJV6ZBB1y7AvzEjwvYrxx2ENDsJ9EmmSpOqC6+J6c=;
 b=eWU4tyzYFXkk8YwrXM7vJBQ2xNF+mDPid7tXCS50NKD+fsQsZLe0HSjSk3caTz3figXWxC
 xUQonjX/U/m7rTz9sdvvSYOj05RoF5NCjN0dUgbVaqKKNWP+4mN7P33vDwz21hmCrmKlU0
 Es2lO56xWrSqbO0Um7aW7CA4+ptAltA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-yTznYQSjOvy8HNw14ThYOA-1; Wed, 18 Mar 2020 19:36:10 -0400
X-MC-Unique: yTznYQSjOvy8HNw14ThYOA-1
Received: by mail-wm1-f69.google.com with SMTP id s15so256552wmc.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 16:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a/ce65HuK5Va/fXZDv78iB3miS0aXLw/3AF48gSxWI8=;
 b=dgnl/50QD/XmmqOdg4PQ1Gi4cYndO+lonYV4vLAbdzqpqXnQd3P6JKB3t4ufiuRtWn
 6r8vooX5goaKBtK7hgMrKjlZfcaE2Mzu3U4EtwzPEM46sczcJxfEgyjEuUx1aF1EFO0V
 54ehaHY7oDkLGV+6iq1pW8Uc5j7am0UNPoOPm7kvPhQhwlTDN6HxZm5OIZIUXlMs9/pm
 2REp200q0h+N5B6xm9XlraC+J+8fLy0RzIv2qVBWxQU7HnkqgfkrMFJKZADCW/NgcuWZ
 8LckxlmSF/Grd/n8ct//+fD7WIcHKmfXUGf1umbonq3eICCj2GldmoVpCx39Q7iVyzc5
 4hkg==
X-Gm-Message-State: ANhLgQ32bwzlj+7h3oWcFPkSek8YmGy9bNucBC0NI2zUPSrU5q8ex8yY
 vrYm5/TecraJKFlzAg4D8OCaEhsU0VsEtUtD3aR/poqv1SA3UXctd+89r0x0YC/8vcnzvG9PdfM
 ubpQl8kfQPuvjSWo=
X-Received: by 2002:adf:e345:: with SMTP id n5mr405630wrj.220.1584574568850;
 Wed, 18 Mar 2020 16:36:08 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuEK/qGf1vD3nw1jRdwmNbNPr89m/jCp/eUI99GUJo0I3w34zx7ipwYiH0L3lmFxzTBQnHtjA==
X-Received: by 2002:adf:e345:: with SMTP id n5mr405611wrj.220.1584574568667;
 Wed, 18 Mar 2020 16:36:08 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id q13sm537504wrs.91.2020.03.18.16.36.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 16:36:08 -0700 (PDT)
Subject: Re: [PATCH v9 2/4] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, laurent@vivier.eu
References: <cover.1584571250.git.alistair.francis@wdc.com>
 <56b8fd28a0faca77ee8adfc90e4eb2bc3750edf5.1584571250.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c956f99f-0412-d0c9-c489-bf904b6d7bea@redhat.com>
Date: Thu, 19 Mar 2020 00:36:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <56b8fd28a0faca77ee8adfc90e4eb2bc3750edf5.1584571250.git.alistair.francis@wdc.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 11:46 PM, Alistair Francis wrote:
> Add support for the clock_gettime64/clock_settime64 syscalls.
>=20
> If your host is 64-bit or is 32-bit with the *_time64 syscall then the
> timespec will correctly be a 64-bit time_t. Otherwise the host will
> return a 32-bit time_t which will be rounded to 64-bits. This will be
> incorrect after y2038.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/syscall.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 909bec94a5..60fd775d9c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1229,6 +1229,22 @@ static inline abi_long target_to_host_timespec(str=
uct timespec *host_ts,
>   }
>   #endif
>  =20
> +#if defined(TARGET_NR_clock_settime64)
> +static inline abi_long target_to_host_timespec64(struct timespec *host_t=
s,
> +                                                 abi_ulong target_addr)
> +{
> +    struct target__kernel_timespec *target_ts;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_ts, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(host_ts->tv_sec, &target_ts->tv_sec);
> +    __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
> +    unlock_user_struct(target_ts, target_addr, 0);
> +    return 0;
> +}
> +#endif
> +
>   static inline abi_long host_to_target_timespec(abi_ulong target_addr,
>                                                  struct timespec *host_ts=
)
>   {
> @@ -11458,6 +11474,18 @@ static abi_long do_syscall1(void *cpu_env, int n=
um, abi_long arg1,
>           return ret;
>       }
>   #endif
> +#ifdef TARGET_NR_clock_settime64
> +    case TARGET_NR_clock_settime64:
> +    {
> +        struct timespec ts;
> +
> +        ret =3D target_to_host_timespec64(&ts, arg2);
> +        if (!is_error(ret)) {
> +            ret =3D get_errno(clock_settime(arg1, &ts));
> +        }
> +        return ret;
> +    }
> +#endif
>   #ifdef TARGET_NR_clock_gettime
>       case TARGET_NR_clock_gettime:
>       {
> @@ -11469,6 +11497,17 @@ static abi_long do_syscall1(void *cpu_env, int n=
um, abi_long arg1,
>           return ret;
>       }
>   #endif
> +#ifdef TARGET_NR_clock_gettime64
> +    case TARGET_NR_clock_gettime64:
> +    {
> +        struct timespec ts;
> +        ret =3D get_errno(clock_gettime(arg1, &ts));
> +        if (!is_error(ret)) {
> +            ret =3D host_to_target_timespec64(arg2, &ts);
> +        }
> +        return ret;
> +    }
> +#endif
>   #ifdef TARGET_NR_clock_getres
>       case TARGET_NR_clock_getres:
>       {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


