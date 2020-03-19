Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AB3C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417CB20739
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJpNSXJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417CB20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36257 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEt8V-0004s3-Ci
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEt7i-0004S7-Ur
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEt7h-0004C6-ST
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:14:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEt7h-0004AG-OG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584616441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+pVrduBfUztH4rdiP6RlMz6oo9fviverviCp4jzWg0=;
 b=GJpNSXJleLObd0PC3pcumGtH8cnAlMwfansme8ZcPbtBtCxEaYo+mST2u1VLFbOYGGRWJp
 cEiX4qpDOKTM7WVlhLBXSDjk+3zh2Mvh2VKTZACYZoRl+nDmNQ9kmaI7tThnj9iJg6yHcb
 /QVXAT6GwXpBzpMa/cLosD/ptbojmcE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-yq30_iisOTCu7qXNnIcwMw-1; Thu, 19 Mar 2020 07:13:59 -0400
X-MC-Unique: yq30_iisOTCu7qXNnIcwMw-1
Received: by mail-ed1-f71.google.com with SMTP id ce13so1615999edb.11
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 04:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eKrewbTGgjekSuIxFeb8QQMEus3Oh+1ryPF5uEHmE7g=;
 b=gz1T6/fow0OoeWwMUUE5BMC7lGCNRuWdh54Uh0LGlvWU7GS9YZvKioU8vmEQSF7Pwm
 UWe7Swj0k4dfIKDGiyfVte+RIkkIdBWL2p3aEYSmbQfPlIOsJ4PbTTctoHf8IXaNphlT
 35wuqWWSS632gjxpaMW6gknwogvPRCjh0RAmudav2nSX/vbDXJz5FVTmWXj5umZTj//U
 1L1F1sAqucNHlBUwohl+0D8/MJoGktCMJWCD7ve/s7lRbHCFSxVx3wqNHpWehXg8FbOh
 2Hec0Aj9qb+AeYESz+mpvhtHkBjGxUmpbjypNGKli+oFDi1o/1IH+5zJHCWacruoZ3RW
 k7HA==
X-Gm-Message-State: ANhLgQ1ds1mD5tu1k3iXUXy5NWfaFOW87wh3ybtZcqHyHgm2qxfHN8gE
 eYMUF3Oc9mq1ofdqKwU4mE2nOelFDCOtBB1/nsNRRLMbtMSOhHlEMab3W2SmT39s7dXsUR0Dt/x
 Df9Ho258EYjL7El4=
X-Received: by 2002:a50:cfc6:: with SMTP id i6mr2199244edk.314.1584616438113; 
 Thu, 19 Mar 2020 04:13:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvtlo+9VAWsBKr0wjU4B+3iasXYQJxnma/7jW4/umikEb+D/4m4TUjDcrN4/xfmwl/GUpSfSA==
X-Received: by 2002:a50:cfc6:: with SMTP id i6mr2199224edk.314.1584616437873; 
 Thu, 19 Mar 2020 04:13:57 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id d20sm108675edn.12.2020.03.19.04.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 04:13:57 -0700 (PDT)
Subject: Re: [PATCH v2 01/12] Makefile: Only build virtiofsd if system-mode is
 enabled
To: qemu-devel@nongnu.org
References: <20200315235716.28448-1-philmd@redhat.com>
 <20200315235716.28448-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3c0eae94-1d01-b8a4-26cb-ddf6d2f4cb28@redhat.com>
Date: Thu, 19 Mar 2020 12:13:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315235716.28448-2-philmd@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is reviewed, can it get in 5.0 as build fix?

On 3/16/20 12:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Do not build the virtiofsd helper when configured with
> --disable-system.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Use single line with ifeq=3D'yyyy' (lvivier, rth)
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 7df22fcc5d..7d27941803 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -345,7 +345,7 @@ HELPERS-y +=3D vhost-user-gpu$(EXESUF)
>   vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
>   endif
>  =20
> -ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> +ifeq ($(CONFIG_SOFTMMU)$(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_N=
G),yyyy)
>   HELPERS-y +=3D virtiofsd$(EXESUF)
>   vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
>   endif
>=20


