Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34EAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC9920671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOUkO2OD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC9920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmNM-0006yh-Ig
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmM9-0005cU-Sa
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:39:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmM9-00018z-28
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590071972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQvPt0KH/EupV9uXoHLGWw25lMWH0sf72C5amazinwk=;
 b=UOUkO2ODdYp86W/ApSFJM6dDg4LWACG1dKpgJshuD/Z2xZnKi/VOVGahOEvf2dVINx89Qu
 VkzDilPtm0bB6srf8paCFYWTTNNXTzupeh7efdbPjDznZHJZweE9pVLcvrAnjWv4BcDO+g
 XRvVKPk4nh1XdJB2W6gwbcc916ATMiw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-_s57nkseNbmA8xcz4F0N6Q-1; Thu, 21 May 2020 10:39:30 -0400
X-MC-Unique: _s57nkseNbmA8xcz4F0N6Q-1
Received: by mail-wr1-f72.google.com with SMTP id e1so518786wrm.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gQvPt0KH/EupV9uXoHLGWw25lMWH0sf72C5amazinwk=;
 b=HFs3kAIfRzbPFEGB+3muok2aA8jxapkTF4smnUE3JXmwkAnFOy8xwvpM3oNs7cHXcU
 O1wZnxnlEySTSv9WSjlNmYa/7ZWiPfJr6T6V/2eD723CzK0HRZiyYimAfAscidYx5rX5
 iliuV02ZgnhSGgNQU8ijGC+8AkvgOibkQgMtr1Zpw5WA7ep9tPH7vof+gW9Q8DJZ7Zga
 0gadFhVgS8kTanjuOU8hIkOFVMwkeMU7hRZaJy3hIegjU0WwWY320r+ZLYRBNUhI5HxN
 k+CC+9UuzkmMyQ46Mq5Ua43U+P9N8b/bcz3wZShd0PPLFIrJ1bZpNWKAbGzjeRkt6p5+
 DQ7w==
X-Gm-Message-State: AOAM530AsnGzKNL5XtvafRCGekwffmP0CXkZ4AKgYS8aR9Np4+4FrP2s
 I961asV3WXjs5GIMVSz+KarJoA9+mB8Ym3xCdgQ3PpMdm/ranF7mXqcw3L9urYVNMtYANu3QTfD
 My9yDYGO3f4KkpSk=
X-Received: by 2002:a7b:c005:: with SMTP id c5mr9117747wmb.22.1590071969338;
 Thu, 21 May 2020 07:39:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe2YsX1ZffKV9gF0OL1vZzPKcAKIIgdYhJfoSaajowuWMqRyrbE1Yn8jVHeJKjVjbGnu9J2w==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr9117734wmb.22.1590071969101;
 Thu, 21 May 2020 07:39:29 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id s19sm2949984wmj.21.2020.05.21.07.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:39:28 -0700 (PDT)
Subject: Re: [PATCH] Makefile: Let the 'help' target list the helper targets
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200423104345.5092-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3e61d6b-0750-d1f3-dfd4-ca0d0e6f049f@redhat.com>
Date: Thu, 21 May 2020 16:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423104345.5092-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/04/20 12:43, Philippe Mathieu-Daudé wrote:
> List the name of the helper targets when calling 'make help',
> along with the tool targets:
> 
>   $ make help
>   [...]
> 
>   Helper targets:
>     fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper
>     scsi/qemu-pr-helper            - Build qemu-pr-helper
>     qemu-bridge-helper             - Build qemu-bridge-helper
>     vhost-user-gpu                 - Build vhost-user-gpu
>     virtiofsd                      - Build virtiofsd
> 
>   Tools targets:
>     qemu-ga                        - Build qemu-ga tool
>     qemu-keymap                    - Build qemu-keymap tool
>     elf2dmp                        - Build elf2dmp tool
>     ivshmem-client                 - Build ivshmem-client tool
>     ivshmem-server                 - Build ivshmem-server tool
>     qemu-nbd                       - Build qemu-nbd tool
>     qemu-storage-daemon            - Build qemu-storage-daemon tool
>     qemu-img                       - Build qemu-img tool
>     qemu-io                        - Build qemu-io tool
>     qemu-edid                      - Build qemu-edid tool
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  configure | 5 +++--
>  Makefile  | 9 +++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/configure b/configure
> index 23b5e93752..caf880c38e 100755
> --- a/configure
> +++ b/configure
> @@ -6374,7 +6374,7 @@ if test "$softmmu" = yes ; then
>    if test "$linux" = yes; then
>      if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
>        virtfs=yes
> -      tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
> +      helpers="$helpers fsdev/virtfs-proxy-helper\$(EXESUF)"
>      else
>        if test "$virtfs" = yes; then
>          error_exit "VirtFS requires libcap-ng devel and libattr devel"
> @@ -6389,7 +6389,7 @@ if test "$softmmu" = yes ; then
>        fi
>        mpath=no
>      fi
> -    tools="$tools scsi/qemu-pr-helper\$(EXESUF)"
> +    helpers="$helpers scsi/qemu-pr-helper\$(EXESUF)"
>    else
>      if test "$virtfs" = yes; then
>        error_exit "VirtFS is supported only on Linux"
> @@ -7630,6 +7630,7 @@ else
>    QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
>  fi
>  
> +echo "HELPERS=$helpers" >> $config_host_mak
>  echo "TOOLS=$tools" >> $config_host_mak
>  echo "ROMS=$roms" >> $config_host_mak
>  echo "MAKE=$make" >> $config_host_mak
> diff --git a/Makefile b/Makefile
> index 8a9113e666..021a0cd491 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -336,9 +336,9 @@ $(call set-vpath, $(SRC_PATH))
>  LIBS+=-lz $(LIBS_TOOLS)
>  
>  vhost-user-json-y =
> -HELPERS-y =
> +HELPERS-y = $(HELPERS)
>  
> -HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = qemu-bridge-helper$(EXESUF)
> +HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) += qemu-bridge-helper$(EXESUF)
>  
>  ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
>  HELPERS-y += vhost-user-gpu$(EXESUF)
> @@ -1255,6 +1255,11 @@ endif
>  		$(foreach t, $(TARGET_DIRS), \
>  		$(call print-help-run,$(t)/all,Build for $(t));) \
>  		echo '')
> +	@$(if $(HELPERS-y), \
> +		echo 'Helper targets:'; \
> +		$(foreach t, $(HELPERS-y), \
> +		$(call print-help-run,$(t),Build $(shell basename $(t)));) \
> +		echo '')
>  	@$(if $(TOOLS), \
>  		echo 'Tools targets:'; \
>  		$(foreach t, $(TOOLS), \
> 

Queued, thanks.

Paolo


