Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA47C54EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46B720722
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE7xR7OK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46B720722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFy42-0007e2-3M
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 06:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFy2u-0006kw-Hd
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFy2t-0003Fc-8s
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:41:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFy2r-0003Ei-PE
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584873689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7clF7kFLw2ty4BCEwGO+HQ4q00wPxo/p0mVeqC5GEj0=;
 b=LE7xR7OK4wUNeT+rkoTVsvnKFZ8KjyaBAXGWPXvp7CVEaxqbqa2N4f0mrKrbDCOsypO+Ek
 YZTwf5N3yB8K5zIcphatiVXHntwFSMCbTQ7WtegW4qAWzi/JEdFoZinq+UL8xZhKkARlf8
 Llwoku7WsWV5+IdoZ+bR6vYncEpC2x8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-hJ4sxtd2MpegI8sj69G6Jg-1; Sun, 22 Mar 2020 06:41:27 -0400
X-MC-Unique: hJ4sxtd2MpegI8sj69G6Jg-1
Received: by mail-ed1-f72.google.com with SMTP id g7so2571710edm.20
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 03:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bOmaz92F9D18++4qiKJS07u+hcyjNQVoaTh1tbIn1gs=;
 b=Jb1ctdeFme5oOQ63Y4PrLf57nSXsfbHf3VRVpMdh5HxGwNmc5tk9O+FddCOtlIJX6u
 b8udR3doeO/O+4WWBxk3rJcLf/mhVVYu9F7uEKSCtx92ongMIt2yifGcL8vKUH34hqHt
 Yj+ByAeJDwdAJ6B9T6UJO9Gwz4J+SfMOV39xGdojmtfmBAW2gJthHXRVW5SEPzPxZA8G
 nhD0CCY5mIhiqSHrMecfxRk6HVFMgZ2mdKIvlZI9q2xwcp+NnQY6p01M162oBR+BVQTD
 ftM3+yIeN7/h0CHrQP54pOrARGdzOrI9Ok8GCPBYx0DadQ9XNxyjHQ5rHOsTJhcKb5Ej
 j1rA==
X-Gm-Message-State: ANhLgQ3vmhPsswNAOh/cyQ3FYvbd6TcFTaJM0r0DvtI0/agcs4j3FRdW
 Fc3FniLS/J46xAw16Y/wF5MF+/8Z4JaPqdGzlyJOp/7QcLY+53gI4se8s1Z59l8MZr98i7S7ciF
 VsAC8+MRg9WUm+9o=
X-Received: by 2002:a05:6402:8c3:: with SMTP id
 d3mr16260401edz.31.1584873686438; 
 Sun, 22 Mar 2020 03:41:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv5ZU30XRxR4mIpdgAu6ZNzooRkSxN4fHgsMEh6RNQGhXyxM6mtyyP5VpGIHmBGI5DJSjnO1Q==
X-Received: by 2002:a05:6402:8c3:: with SMTP id
 d3mr16260389edz.31.1584873686257; 
 Sun, 22 Mar 2020 03:41:26 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id x62sm738261ede.55.2020.03.22.03.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Mar 2020 03:41:25 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] thread.h: Remove trailing semicolons from Coverity
 qemu_mutex_lock() etc
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <20200319193323.2038-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1e1e971d-2725-d4d3-d9f3-b4c7ca6d6bc0@redhat.com>
Date: Sun, 22 Mar 2020 11:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319193323.2038-4-peter.maydell@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 8:33 PM, Peter Maydell wrote:
> All the Coverity-specific definitions of qemu_mutex_lock() and friends
> have a trailing semicolon. This works fine almost everywhere because
> of QEMU's mandatory-braces coding style and because most callsites are
> simple, but target/s390x/sigp.c has a use of qemu_mutex_trylock() as
> an if() statement, which makes the ';' a syntax error:
> "../target/s390x/sigp.c", line 461: warning #18: expected a ")"
>        if (qemu_mutex_trylock(&qemu_sigp_mutex)) {
>            ^
>=20
> Remove the bogus semicolons from the macro definitions.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu/thread.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 10262c63f58..d22848138ea 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -57,17 +57,17 @@ extern QemuCondTimedWaitFunc qemu_cond_timedwait_func=
;
>    * hide them.
>    */
>   #define qemu_mutex_lock(m)                                             =
 \
> -            qemu_mutex_lock_impl(m, __FILE__, __LINE__);
> +            qemu_mutex_lock_impl(m, __FILE__, __LINE__)
>   #define qemu_mutex_trylock(m)                                          =
 \
> -            qemu_mutex_trylock_impl(m, __FILE__, __LINE__);
> +            qemu_mutex_trylock_impl(m, __FILE__, __LINE__)
>   #define qemu_rec_mutex_lock(m)                                         =
 \
> -            qemu_rec_mutex_lock_impl(m, __FILE__, __LINE__);
> +            qemu_rec_mutex_lock_impl(m, __FILE__, __LINE__)
>   #define qemu_rec_mutex_trylock(m)                                      =
 \
> -            qemu_rec_mutex_trylock_impl(m, __FILE__, __LINE__);
> +            qemu_rec_mutex_trylock_impl(m, __FILE__, __LINE__)
>   #define qemu_cond_wait(c, m)                                           =
 \
> -            qemu_cond_wait_impl(c, m, __FILE__, __LINE__);
> +            qemu_cond_wait_impl(c, m, __FILE__, __LINE__)
>   #define qemu_cond_timedwait(c, m, ms)                                  =
 \
> -            qemu_cond_timedwait_impl(c, m, ms, __FILE__, __LINE__);
> +            qemu_cond_timedwait_impl(c, m, ms, __FILE__, __LINE__)
>   #else
>   #define qemu_mutex_lock(m) ({                                          =
 \
>               QemuMutexLockFunc _f =3D atomic_read(&qemu_mutex_lock_func)=
;  \
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


