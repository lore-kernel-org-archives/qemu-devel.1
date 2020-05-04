Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552DCC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E25120735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUUNa7n3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E25120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWs0-0003dN-AR
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVWr7-0002mr-8z
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:53:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVWr5-0005zI-TG
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588582418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiV45Drb4vmdOfyZO+CBNsIVr4o8z1r0gqK1jwwJD3A=;
 b=bUUNa7n3A3vdEDkJb8OEWqti7FJjK2G4Pe7qSGSd4wvwRuA5z3BCg7RRlvkZPfx0pJHtvN
 hX8yPYUGTqbXb8ygQJvrBE65Bc+KwODfCKxCj7BCLdOvMV46UhcxNJJyN7iIg2nxWMRKQN
 Du/9vqSeZeDYYLovuI7IGoOipfSDFQ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-7OEJE8ppPzOjX4GIQxayOg-1; Mon, 04 May 2020 04:53:36 -0400
X-MC-Unique: 7OEJE8ppPzOjX4GIQxayOg-1
Received: by mail-wm1-f69.google.com with SMTP id n17so3157503wmi.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 01:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZTIWm+4rGoQj9HloUe/4gXvUmWQl/GhrBvhEeMdtrKA=;
 b=UkcOctZOyawtpnZG6QH/ZjZGEvcM5J88EwARylNw6mY3MBhMooykT+byezJofRQl8a
 jwZn3zxAx/Iv9xNOb6vdUgZe9/ErvhNBAy7HKMWx/l6j3XIKJP9MVXuwjykZeNYe0Woi
 C2NgzYIqqg8vFW0MJJGZOOWOCE4JgtQeAdmBDFeNs9nh93baqf7sgO8pCKI52/+jYZFz
 MA18vPGzy19xjkQktx8JitaUK8CtzPOmFE7YvlQ/0Jt+SZ5byKxs5aKMA5s9RM1OEaiI
 CGGzVrolUOdcHjQ3z8VrcsU6w1Ome9EsXAZeWEbzvJYFqVZGliEhzqoTvzs99jOpt92H
 a5HQ==
X-Gm-Message-State: AGi0PubgJTMg5S4pczGtVM40vkf79PBmabyaiAAF5mM1658MhupSR4gN
 CdxOd9d9JaYtbhlGVAt7iMjdpfm0FskL6BWqnHcNrrzeMSn/hSYH9uCr6lm4jQcJ257w1xYnivS
 gsdgDt7r3U39wBf0=
X-Received: by 2002:adf:bb4e:: with SMTP id x14mr17608047wrg.63.1588582415621; 
 Mon, 04 May 2020 01:53:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypKenlG4d6hygxmXmx0dGjck2qMd6hulX2xnqmb+X6P3xT56biw35tddc683PJorYjQSZoZzHg==
X-Received: by 2002:adf:bb4e:: with SMTP id x14mr17608029wrg.63.1588582415382; 
 Mon, 04 May 2020 01:53:35 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id y70sm13102943wmc.36.2020.05.04.01.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 01:53:34 -0700 (PDT)
Subject: Re: [PATCH] Makefile: Let the 'help' target list the helper targets
To: qemu-devel@nongnu.org
References: <20200423104345.5092-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <62f0ddc4-cd26-91e2-e588-20a4b9813e0f@redhat.com>
Date: Mon, 4 May 2020 10:53:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200423104345.5092-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping?

On 4/23/20 12:43 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> List the name of the helper targets when calling 'make help',
> along with the tool targets:
>=20
>    $ make help
>    [...]
>=20
>    Helper targets:
>      fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper
>      scsi/qemu-pr-helper            - Build qemu-pr-helper
>      qemu-bridge-helper             - Build qemu-bridge-helper
>      vhost-user-gpu                 - Build vhost-user-gpu
>      virtiofsd                      - Build virtiofsd
>=20
>    Tools targets:
>      qemu-ga                        - Build qemu-ga tool
>      qemu-keymap                    - Build qemu-keymap tool
>      elf2dmp                        - Build elf2dmp tool
>      ivshmem-client                 - Build ivshmem-client tool
>      ivshmem-server                 - Build ivshmem-server tool
>      qemu-nbd                       - Build qemu-nbd tool
>      qemu-storage-daemon            - Build qemu-storage-daemon tool
>      qemu-img                       - Build qemu-img tool
>      qemu-io                        - Build qemu-io tool
>      qemu-edid                      - Build qemu-edid tool
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   configure | 5 +++--
>   Makefile  | 9 +++++++--
>   2 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/configure b/configure
> index 23b5e93752..caf880c38e 100755
> --- a/configure
> +++ b/configure
> @@ -6374,7 +6374,7 @@ if test "$softmmu" =3D yes ; then
>     if test "$linux" =3D yes; then
>       if test "$virtfs" !=3D no && test "$cap_ng" =3D yes && test "$attr"=
 =3D yes ; then
>         virtfs=3Dyes
> -      tools=3D"$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
> +      helpers=3D"$helpers fsdev/virtfs-proxy-helper\$(EXESUF)"
>       else
>         if test "$virtfs" =3D yes; then
>           error_exit "VirtFS requires libcap-ng devel and libattr devel"
> @@ -6389,7 +6389,7 @@ if test "$softmmu" =3D yes ; then
>         fi
>         mpath=3Dno
>       fi
> -    tools=3D"$tools scsi/qemu-pr-helper\$(EXESUF)"
> +    helpers=3D"$helpers scsi/qemu-pr-helper\$(EXESUF)"
>     else
>       if test "$virtfs" =3D yes; then
>         error_exit "VirtFS is supported only on Linux"
> @@ -7630,6 +7630,7 @@ else
>     QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
>   fi
>  =20
> +echo "HELPERS=3D$helpers" >> $config_host_mak
>   echo "TOOLS=3D$tools" >> $config_host_mak
>   echo "ROMS=3D$roms" >> $config_host_mak
>   echo "MAKE=3D$make" >> $config_host_mak
> diff --git a/Makefile b/Makefile
> index 8a9113e666..021a0cd491 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -336,9 +336,9 @@ $(call set-vpath, $(SRC_PATH))
>   LIBS+=3D-lz $(LIBS_TOOLS)
>  =20
>   vhost-user-json-y =3D
> -HELPERS-y =3D
> +HELPERS-y =3D $(HELPERS)
>  =20
> -HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D qemu-bridge-h=
elper$(EXESUF)
> +HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) +=3D qemu-bridge-=
helper$(EXESUF)
>  =20
>   ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
>   HELPERS-y +=3D vhost-user-gpu$(EXESUF)
> @@ -1255,6 +1255,11 @@ endif
>   =09=09$(foreach t, $(TARGET_DIRS), \
>   =09=09$(call print-help-run,$(t)/all,Build for $(t));) \
>   =09=09echo '')
> +=09@$(if $(HELPERS-y), \
> +=09=09echo 'Helper targets:'; \
> +=09=09$(foreach t, $(HELPERS-y), \
> +=09=09$(call print-help-run,$(t),Build $(shell basename $(t)));) \
> +=09=09echo '')
>   =09@$(if $(TOOLS), \
>   =09=09echo 'Tools targets:'; \
>   =09=09$(foreach t, $(TOOLS), \
>=20


