Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E2EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8472465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF+TJmcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8472465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irmBv-0003SY-LT
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 12:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irmB4-00021i-Sv
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irmB3-0004H0-Tl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:09:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20790
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irmB3-0004GQ-Q1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579108197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTkXJAUnQL/jvs51eomerAiw5qMWqfjpUWDhT+YNduM=;
 b=QF+TJmcvf3UVyj0p/ieIeiMKs0TcWwIbcXKz2Yo3TB9UK1L7txD/3hNQF+ncJuSWl+J+BJ
 559mk+4T4wN5SrDp/ccri3KLM2ghg3TDbiMcdqHSJIW1UGyz8/Jt1WYSMJN3f3URV8zX9C
 A8SK1WZVVlYQ5bLZsdVtMMrzdmnjynA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-ebXOtqYvPbmPVsnPWlay7w-1; Wed, 15 Jan 2020 12:09:55 -0500
Received: by mail-wr1-f70.google.com with SMTP id v17so8185170wrm.17
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 09:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y12vCnN0meY+521q4c73xnZiMKn+CQzu3YNqi5SanZw=;
 b=G2QwseJ3JFM48R36pptjg77iTIPXWZoLTSuwAMDo9WOjTfgfmj5f1l8usjXf2XGpSk
 D2h0hlBO0jdtxK4uCQZpXQeWbUykTbZTsQWhY/wSQsZybfE5HqU20VC1qduBgvHt2Lfz
 SinJlMJLssHB8+UmwFcjidR4sSZ3YT2ApK49Ct+2YNsr4MSFkfX9nwxmPOvNYdH7e/iB
 /mkH9UW1XyADr5CglMfzcGmXV1hkfl8s6gIEI7mjdUCSvhqlibXZbRy84kGSnpaJQxVu
 GbjwJ3HLW+eoaFccppYxx57rixZww4/rYt9h6dCHLMxVrhcUwcH5Hpq5d8mH1rPfcWHh
 /D7Q==
X-Gm-Message-State: APjAAAXfFCO4q7FvR4NbMQoSCbuckM8p5X/k9InYsp54p8EhPHkPijAt
 V8YIGbBfHysc+oEgiQp6KEIWNn5lU4kl8Z6gpPYtOftobC279cL6UzIQrfEN2umWsq6hj6U3VlY
 as8uuZa1y4npH5tA=
X-Received: by 2002:a05:6000:118d:: with SMTP id
 g13mr34164611wrx.141.1579108194315; 
 Wed, 15 Jan 2020 09:09:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7eUBgv0XOqDMlSGlnu/Iyy++XNunlqIkOCJSOyoDN2nBlSxZVX/OMO/poq/rM9lcDOEg0mA==
X-Received: by 2002:a05:6000:118d:: with SMTP id
 g13mr34164586wrx.141.1579108194039; 
 Wed, 15 Jan 2020 09:09:54 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id h2sm25777087wrv.66.2020.01.15.09.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 09:09:53 -0800 (PST)
Subject: Re: [PATCH 054/104] virtiofsd: set maximum RLIMIT_NOFILE limit
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-55-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <774ea513-c0ea-4dec-fcec-e867dec2f06f@redhat.com>
Date: Wed, 15 Jan 2020 18:09:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-55-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: ebXOtqYvPbmPVsnPWlay7w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 12/12/19 5:38 PM, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> virtiofsd can exceed the default open file descriptor limit easily on
> most systems.  Take advantage of the fact that it runs as root to raise
> the limit.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tools/virtiofsd/passthrough_ll.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index ab318a6f36..139bf08f4c 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -52,6 +52,7 @@
>   #include <sys/file.h>
>   #include <sys/mount.h>
>   #include <sys/prctl.h>
> +#include <sys/resource.h>
>   #include <sys/syscall.h>
>   #include <sys/types.h>
>   #include <sys/wait.h>
> @@ -2250,6 +2251,35 @@ static void setup_sandbox(struct lo_data *lo, stru=
ct fuse_session *se)
>       setup_seccomp();
>   }
>  =20
> +/* Raise the maximum number of open file descriptors */
> +static void setup_nofile_rlimit(void)
> +{
> +    const rlim_t max_fds =3D 1000000;

'static const'?

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    struct rlimit rlim;
> +
> +    if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
> +        fuse_log(FUSE_LOG_ERR, "getrlimit(RLIMIT_NOFILE): %m\n");
> +        exit(1);
> +    }
> +
> +    if (rlim.rlim_cur >=3D max_fds) {
> +        return; /* nothing to do */
> +    }
> +
> +    rlim.rlim_cur =3D max_fds;
> +    rlim.rlim_max =3D max_fds;
> +
> +    if (setrlimit(RLIMIT_NOFILE, &rlim) < 0) {
> +        /* Ignore SELinux denials */
> +        if (errno =3D=3D EPERM) {
> +            return;
> +        }
> +
> +        fuse_log(FUSE_LOG_ERR, "setrlimit(RLIMIT_NOFILE): %m\n");
> +        exit(1);
> +    }
> +}
> +
>   int main(int argc, char *argv[])
>   {
>       struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
> @@ -2371,6 +2401,8 @@ int main(int argc, char *argv[])
>  =20
>       fuse_daemonize(opts.foreground);
>  =20
> +    setup_nofile_rlimit();
> +
>       /* Must be before sandbox since it wants /proc */
>       setup_capng();
>  =20
>=20


