Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D81C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E3D206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt3lvzcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E3D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjUV-0000mx-Q6
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgjTM-0008EB-Up
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:35:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgjTL-0007gj-CP
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591252525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/QJ1B7gfT86Ixt/8saTMISjjPKCr+7drMZY6cgqVehA=;
 b=Xt3lvzcHUGXoSB41/ZSWRKx1+4+bNWbDyi+Q1WJY5bgOX32IAM4yT85LZDF5smP43YNMcv
 N4iUAvGGthKEthviQQ8ccPNjJbCukPROyW/3gerKNvVdeWeM0fGpgy8ylMY9qhALAVTgJd
 moDRL2Ii8O5U5iMgIGtAKRJ3caYONbY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-lROUk0xoNtiWp1jnf_flLA-1; Thu, 04 Jun 2020 02:35:23 -0400
X-MC-Unique: lROUk0xoNtiWp1jnf_flLA-1
Received: by mail-wm1-f71.google.com with SMTP id f62so1438995wme.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 23:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/QJ1B7gfT86Ixt/8saTMISjjPKCr+7drMZY6cgqVehA=;
 b=RPXkZ9sQe+g+I8DkfWU65nNI1mvtNijAafY+a7iKQ5aL+TfXKXD41pQkzC5yAN2A3/
 FM5/F23AkeVXcpcLgyMi5TCJFD9/ziYfseYGjO9TzIunxqeMvv6feMWwH3fdgL8HssLM
 aivYB4sQKksAemunuabwpDecdeJpFnpdQ/+kVRPc/IAhkTDVkCLDgnTM3hP/hYQ1EriT
 uXYbCawd8rWXRNY5nQUOKPuA5Ur0unIa6KGVhGK7162ZpCHlOO6dIiYgg2lFXNeOfJix
 KeulNMzEXwHmMsh2EpE6BXp1muxgSKlsCpUUWdLh3ebyxe6a3oPtQlYKDHYzQEvsnLnD
 +Ubw==
X-Gm-Message-State: AOAM532g33NNycB7X/uOZVG/oh/ZE4bDuTqjJiAkfH8JL0ZR+dSlGPft
 9J6AATCYVIFArV4Q15gQLY1dqR5CyczQMBlGo/MKDEnTYYcwpkPw+VbEtoEGKQB5Il0408nsR4d
 XerZqpTj5kU0EFwg=
X-Received: by 2002:a05:6000:100e:: with SMTP id
 a14mr2762556wrx.349.1591252522720; 
 Wed, 03 Jun 2020 23:35:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfbzLPLFbnOgMwTayLitznzlJzivgHFB1KqNGNOHlmlnwolVdWzluKnVpKWD6AT/M0b05INw==
X-Received: by 2002:a05:6000:100e:: with SMTP id
 a14mr2762537wrx.349.1591252522489; 
 Wed, 03 Jun 2020 23:35:22 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k64sm6067293wmf.34.2020.06.03.23.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 23:35:21 -0700 (PDT)
Subject: Re: [PATCH 04/13] i386: hvf: Drop unused variable
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-5-r.bolshakov@yadro.com>
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
Message-ID: <90100948-8120-ef8a-32e6-5ad9c638231d@redhat.com>
Date: Thu, 4 Jun 2020 08:35:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528193758.51454-5-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 9:37 PM, Roman Bolshakov wrote:
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  target/i386/hvf/x86.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
> index c95d5b2116..56fcde13c6 100644
> --- a/target/i386/hvf/x86.h
> +++ b/target/i386/hvf/x86.h
> @@ -293,7 +293,6 @@ typedef struct lazy_flags {
>  
>  /* Definition of hvf_x86_state is here */
>  struct HVFX86EmulatorState {
> -    int interruptable;
>      uint64_t fetch_rip;
>      uint64_t rip;
>      struct x86_register regs[16];
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


