Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8B9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA04D20721
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfjHFSpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA04D20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcaJ-0001zk-1o
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdcYX-0000Aq-H7
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:35:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdcYW-0006kv-0e
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590510954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZLgJyCger61hPw5ZyqZ8cavAWoGrDX/LOuL7s1o9ZTU=;
 b=XfjHFSpRDpqvBnsAwTJtm+ukl6VP1ulLDTLKmcZoAN3CbIwDl0fkk1aS8K6ShRmnDhEu7n
 1hdzfvsQ0Ebh39N9trtaeTCQUmw4c87c85xeW2Sv/XSQgFxCD7bwaMSZjcRQErT6i5XM/8
 VroOqXVRjiIe0d4j9SR/euO/BdFcrsk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-aoGQTKFYNVaIFiIozfEUZg-1; Tue, 26 May 2020 12:35:53 -0400
X-MC-Unique: aoGQTKFYNVaIFiIozfEUZg-1
Received: by mail-ed1-f69.google.com with SMTP id s14so1248064edr.7
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 09:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZLgJyCger61hPw5ZyqZ8cavAWoGrDX/LOuL7s1o9ZTU=;
 b=I4o2NyPWtqn1PiuPGdGQu0/1XftfafQpyH6WDRA9aPN+ZPGBSjqSyO9l64/KIvI2BY
 iWT/my5PoHcEHXJxuhG872xAggUUHtdtFJoH8v73ti0LZjgLTF7wjic7HwzTahY1GLGC
 tGg6022JAR8djkjCqcPe4WFf2teKrJh+jrHM5/54/ZOPiH7fEroaTNOUyJzriYCv14sT
 mLqjHe53Ife10mW5hk1rQ7vpEMe/GwqSnktWSTlSGOOlVPpdk/Dz6MnQEsx8e6+bpgMs
 8f2wFEz9hkEwZfLgDgu9zUvQJ2RhOn1l0xktqrYRl2K9otUu4ZuCNSWLgv4NWC8GWiAC
 WTGw==
X-Gm-Message-State: AOAM532o1KBs8tK2nsziCtYN3/0FEuAH6WYwsr3/hEcbdoTeZ//zUaCW
 wXJRPa95iOQkDUNVRVcjSCd/klapKVGB2EGvpJptZ0QAltylYr4vz9R7gUrjxDaisvnNPUIehIY
 sDzaVwj6nO0Gbdz4=
X-Received: by 2002:a17:906:f112:: with SMTP id
 gv18mr1865398ejb.142.1590510951404; 
 Tue, 26 May 2020 09:35:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9NKYZdP5sCdgnnVf9GMrfr0zYE7oWKNtuEOcmtJheMuiAESnE1HkuJiG/jWbFO31R8DbfyA==
X-Received: by 2002:a17:906:f112:: with SMTP id
 gv18mr1865378ejb.142.1590510951173; 
 Tue, 26 May 2020 09:35:51 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id f24sm343149edq.21.2020.05.26.09.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 09:35:50 -0700 (PDT)
Subject: Re: [PATCH] target/ppc: Fix argument to
 ppc_radix64_partition_scoped_xlate() again
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159051003729.407106.10610703877543955831.stgit@bahia.lan>
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
Message-ID: <0c9c13b0-3d45-196b-c650-fb40317c5161@redhat.com>
Date: Tue, 26 May 2020 18:35:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159051003729.407106.10610703877543955831.stgit@bahia.lan>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 6:20 PM, Greg Kurz wrote:
> The penultimate argument of function ppc_radix64_partition_scoped_xlate()
> has the bool type.
> 
> Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped translation"
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> A patch fixing the same issue in other places was merged recently in
> ppc-for-5.1. Maybe worth squashing the two patches into one ?
> 
> commit 372ef6e9b803ef10c3200c45311d218e2c97b218
> Author: Greg Kurz <groug@kaod.org>
> Date:   Thu May 14 00:57:13 2020 +0200
> 
>     target/ppc: Fix arguments to ppc_radix64_partition_scoped_xlate()
> ---
>  target/ppc/mmu-radix64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 0d3922537c4c..c60bf3135734 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -513,7 +513,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>  
>              ret = ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, g_raddr,
>                                                       pate, raddr, &prot, &psize,
> -                                                     0, guest_visible);
> +                                                     false, guest_visible);
>              if (ret) {
>                  return ret;
>              }
> 
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


