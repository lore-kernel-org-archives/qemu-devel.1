Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A0C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F5B20726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCHQi6C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F5B20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieeB8-0001Et-A2
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieeAE-0000N5-4G
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieeAC-0003cv-FB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:58:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieeAC-0003ca-Bn
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575979127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtmnemzspvA880/uJ4uYYy6Ot+jUqOPqDBKq8m9yed8=;
 b=DCHQi6C2T2JB7/TJhN6bVFtlsnbMhV3WH09VlPZBK6/RgP4p0NRaBnpumK9hX3t5yQUlnG
 qWqWswsQuBRNkk+dHMbAzoRxdr09xRKGQ+Oz1WElGojF356LHMi2+dipYEvNCd0zC7r3oJ
 8EQv6cUx9Ml8ztM2K+2AnzjxK2IwPp0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-ptBMgqOSOKuneyJwPaqEEg-1; Tue, 10 Dec 2019 06:58:45 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so8842411wrx.22
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 03:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VkBE2eJuyiEZoDy96eW94bHVMYYSfMNQcZ10deTrGNk=;
 b=pT14f8K0czLkTXBgRr+d6hfd36t24fRWt2iwopHXtOuafh79laqG9blsxQWEdNbNEF
 LbrK9Ef4bGc1x4ZITabTTsNDWtIUs8E/x+XSM4hSnrhPnC7JeidJCxMPtI6f6I6Zl379
 rwoL3TwOcJOEQuKCGzZkhPSIDQnvAtBSVKRMwOlBlUk2Sc0rgMRcpTgPQnt5ch+HpHwx
 IuSNfkOvvATDSBETOC0qRcrXm1cdmLeXKglyl3TJk2fjqQ8lxYtGJJ6EeYwfUMOcII5u
 mDRDGzInQ7VYEa9rJhDk+fCJ6DP4PzP3LccKG30JjZey9Qd7Z1gWsxAeV2JrgdV5mrqL
 EmpA==
X-Gm-Message-State: APjAAAXTg5fpzBpJ8QddyvrUClB6YmE0oJCNMnTMQH5tlvRGIzLAZYPz
 fgiJoruVdg1+D7v75qoUWPomeL5gaury97mPX0Y2UiS325e80A4ekQfVsoWCiUv3J/qc17hSqoL
 XlFXArEGbxIfgcGs=
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr5007461wmc.158.1575979124884; 
 Tue, 10 Dec 2019 03:58:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkQviLEcYup79scvcQcpeVIq/sjAezK64OJyN8vNDKs1JJqpCoRsnwO2/kBtkUJHnk8PIf5A==
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr5007439wmc.158.1575979124734; 
 Tue, 10 Dec 2019 03:58:44 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id s10sm3050523wrw.12.2019.12.10.03.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 03:58:44 -0800 (PST)
Subject: Re: [PATCH v2 06/18] accel: compile accel/accel.c just once
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-7-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ddf7c90-2123-0e73-6ab1-609e563817e5@redhat.com>
Date: Tue, 10 Dec 2019 12:58:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-7-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: ptBMgqOSOKuneyJwPaqEEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 4:01 PM, Paolo Bonzini wrote:
> Now that accel/accel.c does not use CONFIG_TCG or CONFIG_KVM anymore,
> it need not be compiled once for every softmmu target.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   Makefile.objs       | 1 +
>   accel/Makefile.objs | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index 11ba1a3..b6fcbac 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -55,6 +55,7 @@ common-obj-$(CONFIG_POSIX) +=3D os-posix.o
>  =20
>   common-obj-$(CONFIG_LINUX) +=3D fsdev/
>  =20
> +common-obj-y +=3D accel/
>   common-obj-y +=3D migration/
>  =20
>   common-obj-y +=3D audio/
> diff --git a/accel/Makefile.objs b/accel/Makefile.objs
> index 8b498d3..17e5ac6 100644
> --- a/accel/Makefile.objs
> +++ b/accel/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-$(CONFIG_SOFTMMU) +=3D accel.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D accel.o
>   obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) +=3D qtest.o
>   obj-$(CONFIG_KVM) +=3D kvm/
>   obj-$(CONFIG_TCG) +=3D tcg/
>=20


