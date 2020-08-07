Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789CDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB482086A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlIjrh3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB482086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k42JN-00065U-FK
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 09:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k42If-0005Qz-TL
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:20:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48243
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k42Ic-0005J5-UM
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596806441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3I/uqml+0XLX73er8wGkhGjsAmPc4wqglryl4/4olqI=;
 b=MlIjrh3xPbmfE+CM8S/h/z5asInAupVBl/XTCbfjkF074v/54hrb87EbHLcu0Mi74+CBze
 NF4v27HAqVLC7MvBCqGBp9oI5OERsHR25NMQDYc0rZgDUrZ3dSeYpYMmoK9556XChFBTX1
 1s42RktQG5orCxr0v7WNDkVTq1w05uc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-MgNRQ-bkP0aE4MfscKDMgA-1; Fri, 07 Aug 2020 09:20:34 -0400
X-MC-Unique: MgNRQ-bkP0aE4MfscKDMgA-1
Received: by mail-wm1-f71.google.com with SMTP id t26so800243wmn.4
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 06:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3I/uqml+0XLX73er8wGkhGjsAmPc4wqglryl4/4olqI=;
 b=aoUjvzPR/0ulk+Itj1ZDh9qw+u3n0Um6HLTPnzjGJBHv9sUdqw0pBggpNPIBtuKYcg
 eKnjVILHEv+7zkTqyGvSpTvdR1hYhWzPX808IutDoQvS301dL9pXBHIxwBQTkqRBpWlc
 n/CfyPF0OEQZ0RMLGPxpQGnVbc0Z987A2lgK30Uq0YtSL+iHYtO9NyZ2jUMJVpo8c3ro
 DGYauBYyUKyJpGR1WDPE+ha6l6e4q0NUMlS4x3a0QzyqQnogicIZfTWD/Eb0bn2nZ6Iy
 0moxCJmMvotUJvw8RAQPjdrT8oWq4Ol9onbwrqx2bbJ23E4tBxYMtseFBfqN+MbQSyKW
 zenw==
X-Gm-Message-State: AOAM533i9yeb70jvEWgkpdlkXO/IocIa8W729afB+W8sfucIsYCvR9oE
 lIrKp8SWwiU/6Zzi6RSlL7DO+wK41bQO4bBGiCUMl+7iEQhvE8I4VCP190nKIF2AQ0QQ46aht1Z
 ha+7e5QSTSZTktPk=
X-Received: by 2002:a1c:9d12:: with SMTP id g18mr11913557wme.80.1596806433268; 
 Fri, 07 Aug 2020 06:20:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+kaGouea9MpYMm9HB5OZl7TGpRfVGVwrAj/OJsaUowNyoxgnIrM3Oz3AuT8rpgCo5dY5qzA==
X-Received: by 2002:a1c:9d12:: with SMTP id g18mr11913547wme.80.1596806432979; 
 Fri, 07 Aug 2020 06:20:32 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d11sm10359350wrw.77.2020.08.07.06.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 06:20:32 -0700 (PDT)
Subject: Re: [PATCH 037/143] meson: add qemu-bridge-helper
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-38-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <503aefcc-7b7b-2558-1355-cb443c32d3e2@redhat.com>
Date: Fri, 7 Aug 2020 15:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596741379-12902-38-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:11:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 8/6/20 9:14 PM, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile    | 4 ----
>  meson.build | 8 +++++++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 5df772b..0a2bbd5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -181,8 +181,6 @@ LIBS+=-lz $(LIBS_TOOLS)
>  
>  HELPERS-y = $(HELPERS)
>  
> -HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) += qemu-bridge-helper$(EXESUF)
> -
>  # Sphinx does not allow building manuals into the same directory as
>  # the source files, so if we're doing an in-tree QEMU build we must
>  # build the manuals into a subdirectory (and then install them from
> @@ -415,8 +413,6 @@ qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
>  qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>  qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(COMMON_LDADDS)
>  
> -qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
> -
>  qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
>  
>  qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
> diff --git a/meson.build b/meson.build
> index a68c7b4..9eb1204 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -270,7 +270,6 @@ qemuutil = declare_dependency(link_with: libqemuutil,
>                                sources: genh + version_res)
>  
>  # Other build targets
> -
>  if 'CONFIG_GUEST_AGENT' in config_host
>    subdir('qga')
>  endif
> @@ -289,6 +288,13 @@ if have_tools
>      subdir('contrib/vhost-user-scsi')
>    endif
>  
> +  if host_machine.system() == 'linux'
> +    executable('qemu-bridge-helper', files('qemu-bridge-helper.c'),
> +               dependencies: [qemuutil, libcap_ng],

Is libcap_ng still optional?

> +               install: true,
> +               install_dir: get_option('libexecdir'))
> +  endif
> +
>    if 'CONFIG_IVSHMEM' in config_host
>      subdir('contrib/ivshmem-client')
>      subdir('contrib/ivshmem-server')
> 


