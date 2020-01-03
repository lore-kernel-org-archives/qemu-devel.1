Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12770C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 10:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18D82253D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 10:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkFcpaaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18D82253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inKVx-00019x-C9
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 05:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inKVE-0000iS-Ld
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inKVC-0003nv-AM
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:48:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inKVB-0003hv-Vq
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578048500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XhzGI4C37/Ef0AsVJaaO0k0ikydgbDK0HKwZBh3bNSs=;
 b=TkFcpaaJxzCRPvYhw7vgRfrDAkWjUO/o4j7SWmjC+7EyCfbP8S+u2ayx/FA1PTbNQAh6+0
 pOceYcJDCx21FCN+b6sCWE+IOsGV2FX4Jej0ME1DI1au5QKnh/JFcSAocI0OjH2t460aZi
 MT4HFZcexfZszo08TUP+oDm9BwlNB+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-acZ3pHM1P02igsw9A5Hpgg-1; Fri, 03 Jan 2020 05:48:15 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so21294166wrm.17
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 02:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J3pN62T46n1mzvCm0p/WcivZWD10DPDcRZJ2oCidIO8=;
 b=N0fnZxpp1CWNmuIHx6L2inwDiT3kTEJLuhsHdi5dNJhWQFsPQJwrLg2sdemusQiXmp
 m4hrfAZHssL5A3MqXAO8uyisEP4fUF4ahoF+Y9ouznBCqAE6KmH7fPGWN4+Vz730Eh08
 5HjDfedkiPnDadUfsewFVKIkjFpQHhXOY7bnDQtlq/iIi4JAIA0ypSN4ROUEwu/Ik34n
 V/GLpNLite2Kq/XXKNhAbPYtUwBgLzuQzOUeH85gKg5RnE73LKxc165SwsZVoSTKe8pt
 +p/aWqv3zj+MvuqpkQbWsUtRDccLxKvT8nHdER+/JGA5+17H6F58tXHAshA44oETTmXp
 jR1g==
X-Gm-Message-State: APjAAAUHMKTR+55yZmPKMGiyLFjID+BEocIVoyrq5Mk0HDSMPtfCBGce
 2Sz6clpY24KyJBVPgZutZ68RCANdYc6I1fVdDCefCNMouR8ANdEhquHS3YXzw4wXko/wKC4zhe0
 XVKCe/erNFXsiP6Y=
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr19436246wmj.48.1578048494627; 
 Fri, 03 Jan 2020 02:48:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRM108Iu4nwl8jqx7cYwHeu+u1OUmVGkUg41Q6Bw5GPMFMhgxxbddYGSyTFyCaitjtcRXKcQ==
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr19436233wmj.48.1578048494410; 
 Fri, 03 Jan 2020 02:48:14 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id z187sm11618374wme.16.2020.01.03.02.48.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 02:48:13 -0800 (PST)
Subject: Re: [PATCH 032/132] meson: uncompress edk2 bios
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
 <1576155176-2464-33-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <15178264-c74b-6531-7faa-2edfaa755416@redhat.com>
Date: Fri, 3 Jan 2020 11:48:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576155176-2464-33-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: acZ3pHM1P02igsw9A5Hpgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On 12/12/19 1:51 PM, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   Makefile            |  4 ----
>   meson.build         |  2 ++
>   pc-bios/meson.build | 21 +++++++++++++++++++++
>   3 files changed, 23 insertions(+), 4 deletions(-)
>   create mode 100644 pc-bios/meson.build
>=20
> diff --git a/Makefile b/Makefile
> index 0a6615c..b880265 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -103,9 +103,6 @@ generated-files-y +=3D module_block.h
>   generated-files-y +=3D .git-submodule-status
>  =20
>   edk2-decompressed =3D $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
> -pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
> -=09$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
> -
>   # Don't try to regenerate Makefile or configure
>   # We don't generate any of them
>   Makefile: ;
> @@ -226,7 +223,6 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
>   $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
>   $(SOFTMMU_ALL_RULES): $(io-obj-y)
>   $(SOFTMMU_ALL_RULES): config-all-devices.mak
> -$(SOFTMMU_ALL_RULES): $(edk2-decompressed)
>  =20
>   .PHONY: $(TARGET_DIRS_RULES)
>   # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
> diff --git a/meson.build b/meson.build
> index de5a26e..00c0767 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -312,3 +312,5 @@ if have_tools
>       subdir('contrib/ivshmem-server')
>     endif
>   endif
> +
> +subdir('pc-bios')
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> new file mode 100644
> index 0000000..5524b95
> --- /dev/null
> +++ b/pc-bios/meson.build
> @@ -0,0 +1,21 @@
> +bzip2 =3D find_program('bzip2')
> +
> +fds =3D [
> +  'edk2-aarch64-code.fd',
> +  'edk2-arm-code.fd',
> +  'edk2-arm-vars.fd',

Can we split this in 2 arrays ...

> +  'edk2-i386-code.fd',
> +  'edk2-i386-secure-code.fd',
> +  'edk2-i386-vars.fd',
> +  'edk2-x86_64-code.fd',
> +  'edk2-x86_64-secure-code.fd',
> +]
> +

... then for each array ...

> +foreach f : fds
> +  custom_target(f,
> +                output: f,
> +                input: '@0@.bz2'.format(f),
> +                capture: true,
> +                build_by_default: true,

... use:

   build_by_default: if 'i386' in target_arch
                     or if 'x86_64' in target_arch,

Ah, different that this patch intent, so for later.

> +                command: [ bzip2, '-dc', '@INPUT0@' ])
> +endforeach
>=20


