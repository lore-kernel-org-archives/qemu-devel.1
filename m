Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F146DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81E5206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCKslDAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81E5206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDO6N-00052E-SR
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDO3z-0001D1-Ld
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDO3x-0003pn-Qi
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599035050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cPEhcxonnUyZZCnr3X2KgYS3M1BEWUr62ls4Byv++Ag=;
 b=gCKslDAZJyD06qnT3gFWwW3TQ4mNgvHoQG+N/e5408/7xaoedGMdcna/uFsKvfqPTqhR9+
 HbSTIsQIpEIJHzn9xyYRy+m+udxiX7T0IXvUJeld9Uzg4xMj6r+zvjq6+3S5nqFU+s84nZ
 AgrQvVPITLsAqGB8F/eqKZXi7VVk49g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-TyARtsb3PlWC1Ocokj5LdA-1; Wed, 02 Sep 2020 04:24:09 -0400
X-MC-Unique: TyARtsb3PlWC1Ocokj5LdA-1
Received: by mail-wr1-f72.google.com with SMTP id g6so1668709wrv.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=cPEhcxonnUyZZCnr3X2KgYS3M1BEWUr62ls4Byv++Ag=;
 b=Vqr9klW6cuS6nQDVOy01kWZtyJ5lk1r19UnJcuJcdTF+jqWH5OpSvX+03mwUTafpTe
 Q6DNUL3K9CPrvNBFaAaCIvQXzFV/i+i3PhCG78YcmTMoUkuuHGMJGsi3dx5sfTG3xU1A
 j1zY5llaIjMpfbz40/kv5AYm6P3QHah1Z2HkinFMe8NodNhRgzzl32P4flubblnG/Tlz
 FFk57opkBiL5mbMF/BqbZsN69Z5OSrQAvzcyQeF6lhUSvJGhPYzaY5EdtPBirgexKxwN
 W+8Mit/xo5XmrdYVOc4uR1T79Hb/Iqmyluut0RcLHC0/ijcqxYNtvguFsaC0f+89C6Yk
 HRDQ==
X-Gm-Message-State: AOAM533wvYYeX/aVCPetBjJwjkUkWakdileBx+uAx+G3JKNN5eaoRtHk
 FUq21yGMtgpeAmPRyVtg2QWrMsWESg/a1hNRdzdURqm0pLhLEMgq4kTooZDi56NVoy5qcBo3iK8
 xL0j47tJsJjpg28A=
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr5366008wmd.82.1599035048131; 
 Wed, 02 Sep 2020 01:24:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBHp2ESAutULrBz4PgI9sDA6pNMDCj92aa0obrfcYA/p9AtJ0nwGNYDGkU8vgLmKyFayNrlQ==
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr5365991wmd.82.1599035047895; 
 Wed, 02 Sep 2020 01:24:07 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id r3sm6128347wro.1.2020.09.02.01.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 01:24:07 -0700 (PDT)
Subject: Re: [PATCH 07/13] net: relocate paths to helpers and scripts
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <20200901062020.26660-8-pbonzini@redhat.com>
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
Message-ID: <5f5f038a-9c65-baa3-1f9e-0c04a08b0f71@redhat.com>
Date: Wed, 2 Sep 2020 10:24:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901062020.26660-8-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 8:20 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/net/net.h |  4 ++--
>  net/tap.c         | 28 +++++++++++++++++++++-------
>  2 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index e7ef42d62b..897b2d7595 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -209,8 +209,8 @@ void netdev_add(QemuOpts *opts, Error **errp);
>  int net_hub_id_for_client(NetClientState *nc, int *id);
>  NetClientState *net_hub_port_find(int hub_id);
>  
> -#define DEFAULT_NETWORK_SCRIPT "/etc/qemu-ifup"
> -#define DEFAULT_NETWORK_DOWN_SCRIPT "/etc/qemu-ifdown"
> +#define DEFAULT_NETWORK_SCRIPT CONFIG_SYSCONFDIR "/qemu-ifup"
> +#define DEFAULT_NETWORK_DOWN_SCRIPT CONFIG_SYSCONFDIR "/qemu-ifdown"
>  #define DEFAULT_BRIDGE_HELPER CONFIG_QEMU_HELPERDIR "/qemu-bridge-helper"
>  #define DEFAULT_BRIDGE_INTERFACE "br0"
>  
> diff --git a/net/tap.c b/net/tap.c
> index 14dc904fca..a271046461 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -582,14 +582,20 @@ int net_init_bridge(const Netdev *netdev, const char *name,
>                      NetClientState *peer, Error **errp)
>  {
>      const NetdevBridgeOptions *bridge;
> -    const char *helper, *br;
> +    g_autofree char *default_helper = NULL;
> +    const char *helper;
> +    const char *br;
>      TAPState *s;
>      int fd, vnet_hdr;
>  
>      assert(netdev->type == NET_CLIENT_DRIVER_BRIDGE);
>      bridge = &netdev->u.bridge;
>  
> -    helper = bridge->has_helper ? bridge->helper : DEFAULT_BRIDGE_HELPER;
> +    if (!bridge->has_helper) {
> +        helper = default_helper = get_relocated_path(DEFAULT_BRIDGE_HELPER);
> +    } else {
> +        helper = bridge->helper;
> +    }

Nitpicking, I find easier to review adding simply once after out of the
if() statement:

  helper = bridge->helper;

>      br     = bridge->has_br     ? bridge->br     : DEFAULT_BRIDGE_INTERFACE;
>  
>      fd = net_bridge_run_helper(helper, br, errp);
> @@ -773,8 +779,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
>      const NetdevTapOptions *tap;
>      int fd, vnet_hdr = 0, i = 0, queues;
>      /* for the no-fd, no-helper case */
> -    const char *script = NULL; /* suppress wrong "uninit'd use" gcc warning */
> -    const char *downscript = NULL;
> +    const char *script;
> +    const char *downscript;
>      Error *err = NULL;
>      const char *vhostfdname;
>      char ifname[128];
> @@ -784,6 +790,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
>      tap = &netdev->u.tap;
>      queues = tap->has_queues ? tap->queues : 1;
>      vhostfdname = tap->has_vhostfd ? tap->vhostfd : NULL;
> +    script = tap->has_script ? tap->script : NULL;
> +    downscript = tap->has_downscript ? tap->downscript : NULL;
>  
>      /* QEMU hubs do not support multiqueue tap, in this case peer is set.
>       * For -netdev, peer is always NULL. */
> @@ -934,13 +942,19 @@ free_fail:
>              return -1;
>          }
>      } else {
> +        g_autofree char *default_script = NULL;
> +        g_autofree char *default_downscript = NULL;
>          if (tap->has_vhostfds) {
>              error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
>              return -1;
>          }
> -        script = tap->has_script ? tap->script : DEFAULT_NETWORK_SCRIPT;
> -        downscript = tap->has_downscript ? tap->downscript :
> -            DEFAULT_NETWORK_DOWN_SCRIPT;
> +
> +        if (!tap->has_script) {
> +            script = default_script = get_relocated_path(DEFAULT_NETWORK_SCRIPT);
> +        }
> +        if (!tap->has_downscript) {
> +            downscript = default_downscript = get_relocated_path(DEFAULT_NETWORK_SCRIPT);
> +        }

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>          if (tap->has_ifname) {
>              pstrcpy(ifname, sizeof ifname, tap->ifname);
> 


