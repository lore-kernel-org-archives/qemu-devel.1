Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784EBC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 10:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4451C206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 10:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxLe5W9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4451C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inKZN-0002oE-7K
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 05:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inKYV-0002BY-Im
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inKYU-0004rs-A9
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:51:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inKYU-0004oA-59
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578048705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uRvO3wfYz59Vw1XJCh9pE26o21dJKdFS2reE4ffWa0=;
 b=IxLe5W9fvAUjuUkpko3QBHpLlD2ExsStrwilUA8nBTUgMaogCZoC+jTtZsANLGvPtFv6e0
 IQ1Rv6Z3DITEL7Q33uR5DxCpcpP0HsXO0vP2PjL334n9oTzB+rck133jHOZoAY+Hx640QZ
 ge3sQxaGhAM46T8jCkwSD0XrxbaZyG4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-_2coT_cNM7OsNBSMKhwIBQ-1; Fri, 03 Jan 2020 05:51:43 -0500
Received: by mail-wr1-f69.google.com with SMTP id z10so18699011wrt.21
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 02:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w5D3hNithGllU5+ym6ld2VlzHg/aYEyKm00Sx8Qka74=;
 b=BpbENEj8pcj+rzZdIxw3bhR5kXHqQ7RlRaq8ZWzKFXDJVp8d0DBn5Qlo+tF3iu9Nun
 Axb4+4HdIBBtY1KfzQ0wr0U49XOLRmVatOBk4HqJ33VMEd7tf7oziwONiKQD28knqopQ
 HkBbIShl6nTs4q9GEccIWhWgLc6YdWCpjRNCFVpZCieVsxHQXz7qFhIKj/UugrJYJw2D
 J77DvfnO8iXr11sdQyvGYRGR6upLo3VOmfBSMx49J+NhjMkaPEhUcFHr15O1arw5mjh/
 eGGr1HARFzrR2vBfAcKkVGfu2HZ8MVC/FwdqxnWj7/UcrAANbGbvDkbCmvx50X88Pl80
 QGdg==
X-Gm-Message-State: APjAAAV6TxiqMq8c48RoyDSpzJdEdvCFTchw4iZJKcM10KWGMgeFiYPQ
 1+ajPiN88bPMglePXdy6GrIxIgsNMUD4BUxHRXmZTbYWjQnf1VSB8ArUOX+7Tik8xfvin6zESXW
 MzirB3K8+gkNv52o=
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr86181746wrq.396.1578048702840; 
 Fri, 03 Jan 2020 02:51:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+pfHXH6LTv2YCCFye+/YhXcchcRCQKVZCtGtp+1fir3BSfeZ0BtVoRysENLmCM8GSfzONvw==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr86181721wrq.396.1578048702611; 
 Fri, 03 Jan 2020 02:51:42 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t5sm58685738wrr.35.2020.01.03.02.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 02:51:42 -0800 (PST)
Subject: Re: [PATCH 121/132] meson: install edk2
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
 <1576758232-12439-30-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7923ebc-2196-1bba-7c37-0d136bf35852@redhat.com>
Date: Fri, 3 Jan 2020 11:51:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576758232-12439-30-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: _2coT_cNM7OsNBSMKhwIBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 1:23 PM, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   Makefile            | 7 -------
>   pc-bios/meson.build | 8 ++++++--
>   2 files changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index d64e481..e961286 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -99,7 +99,6 @@ generated-files-y =3D config-host.h
>  =20
>   generated-files-y +=3D .git-submodule-status
>  =20
> -edk2-decompressed =3D $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
>   # Don't try to regenerate Makefile or configure
>   # We don't generate any of them
>   Makefile: ;
> @@ -267,7 +266,6 @@ endif
>   ICON_SIZES=3D16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
>  =20
>   install: all install-datadir install-localstatedir \
> -=09$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
>   =09recurse-install
>   ifneq ($(vhost-user-json-y),)
>   =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/vhost-user/"
> @@ -280,11 +278,6 @@ ifneq ($(BLOBS),)
>   =09=09$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir=
)"; \
>   =09done
>   endif
> -ifdef INSTALL_BLOBS
> -=09set -e; for x in $(edk2-decompressed); do \
> -=09=09$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)"; \
> -=09done
> -endif
>   ifneq ($(DESCS),)
>   =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
>   =09set -e; tmpf=3D$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index 5524b95..18201b0 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -11,11 +11,15 @@ fds =3D [
>     'edk2-x86_64-secure-code.fd',
>   ]
>  =20
> -foreach f : fds
> +install_blobs =3D 'INSTALL_BLOBS' in config_host
> +
> +foreach f: fds
>     custom_target(f,
>                   output: f,
>                   input: '@0@.bz2'.format(f),
>                   capture: true,
>                   build_by_default: true,
> -                command: [ bzip2, '-dc', '@INPUT0@' ])
> +                command: [ bzip2, '-dc', '@INPUT0@' ],
> +                install: install_blobs,
> +                install_dir: config_host['qemu_datadir'])
>   endforeach
>=20


