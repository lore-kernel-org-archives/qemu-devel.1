Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1799BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE17F2534C
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4LyJepe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE17F2534C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvst-0001Xf-2D
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvoS-0005QX-KH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:35:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57539
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvoM-0003Yi-RQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593444908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=681I8VmMUlnuJ+fksy8LNGKwD/DhS3xs6UGiJrm3TEw=;
 b=h4LyJepeP7JTftA0qBilZm0pmgXy11/rXzH3Sm2SQJhqr95SJoYbmG5ODyzSjmEs7TXFx6
 rXGt+OEDPSzyJOMR17ga7GTODFLMS1sdHt7U+fDLHz1l2F0gWWO3bJ6aEI+SgzJwKSAq+w
 HQpQIeAuBvwOD4KhFi3VxYDaOgKFN8M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-PiIxYU9gO4eSoWMNN8hSCQ-1; Mon, 29 Jun 2020 11:34:54 -0400
X-MC-Unique: PiIxYU9gO4eSoWMNN8hSCQ-1
Received: by mail-wm1-f69.google.com with SMTP id s134so18556429wme.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=681I8VmMUlnuJ+fksy8LNGKwD/DhS3xs6UGiJrm3TEw=;
 b=NyoF/8BFA02U4GK7aut2ak9vNVgoVcLeIHp4xndnf+c8MumjFnUXFdtvc4peIYboGN
 dpyF9R/geKRslgLgNFlLzsE+Mk84M1XP4zXuK8wayK10bHGZ5SvMxbzfF2KJQZ7z+Dzy
 0cu79ZtlZipBLcI4SgU8pU0lJ4cBf8mNwwO8nxFjhGFwj/mTFqv8rVZWSiad/YhzfgB1
 lSTlr8+wMEw3R/haxR8MvDOH9zw2p1SoJ4mWR4dQXE8aG2dyrylCGwLFKwK5Xr3MGdWY
 axGLZX8MgC7uVqll3Y0K25zEgIDDplaN0EfIbTDIiGRM3NHgeafLamc0MZuObftyls5E
 PG7A==
X-Gm-Message-State: AOAM533KRRHIB5JDE9UANwct+a2vX/caGEud9VIndduCyliOAg4UNG+j
 hgpfTVmK9BUYX8Gz6jxVLHnqAmIPWPViY6CHhCckWf85O9EtJqKjLIwTNzG7EdSGQEcSstrTTOU
 OjppwkVyZgsbTHvk=
X-Received: by 2002:a1c:bb43:: with SMTP id l64mr17660461wmf.151.1593444893430; 
 Mon, 29 Jun 2020 08:34:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAVfnTvo3fdRMKc+fpARQsAK/ZE5hfpTrlOnLOVATp84oBxVnzHpWmiaJXxji0csQUtBlgwA==
X-Received: by 2002:a1c:bb43:: with SMTP id l64mr17660433wmf.151.1593444893168; 
 Mon, 29 Jun 2020 08:34:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id a2sm72651wrn.68.2020.06.29.08.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 08:34:52 -0700 (PDT)
Subject: Re: [PATCH] hw/core/null-machine: Do not initialize unused chardev
 backends
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200624105611.1049-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c811d5b-a97b-07f3-599e-4e5905203942@redhat.com>
Date: Mon, 29 Jun 2020 17:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200624105611.1049-1-f4bug@amsat.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/20 12:56, Philippe Mathieu-Daudé wrote:
> The MachineClass uses an inverted logic (inherited from the
> PC machines [*]) to create the chardev backends for the default
> devices (see commits 998bbd74b9d..aa40fc9c964 and ac33f8fad14).
> 
> As the none-machine doesn't have any hardware device, it is
> pointless to initialize chardev backends. Fix by setting the
> 'no_defaults' bits in its MachineClass.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/core/null-machine.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index cb47d9d4f8..7e693523d7 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -50,6 +50,11 @@ static void machine_none_machine_init(MachineClass *mc)
>      mc->max_cpus = 1;
>      mc->default_ram_size = 0;
>      mc->default_ram_id = "ram";
> +    mc->no_serial = 1;
> +    mc->no_parallel = 1;
> +    mc->no_floppy = 1;
> +    mc->no_cdrom = 1;
> +    mc->no_sdcard = 1;
>  }
>  
>  DEFINE_MACHINE("none", machine_none_machine_init)
> 

Queued, thanks.

Paolo


