Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B39AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07A62053B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdACZ2Dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07A62053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXfd-0004im-3a
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdXeh-0003sz-Oc
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:22:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdXeg-0007l5-IR
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590492117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sAErj47iynwpJlIJhXI/3CNRpU6ksm3OJgfYzwD5hWk=;
 b=NdACZ2DrrSXaNHtDNqMhtqc6X3OALnUdbrpQm/QLpWJhJ9FIn+WGj0TRbClcsUdfJjcijQ
 HtD4/dKTizMK6bbSUFqwJ1Lt2S+aQrqgcn8O2r6dCDhczELWu94MrT/W0wk+butiGunpBE
 8F6Wo4Mqjg/2h09nlPTNmU7J7sIWGcs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-J0W4Z7zqOsmrrCZqzRpKuw-1; Tue, 26 May 2020 07:21:55 -0400
X-MC-Unique: J0W4Z7zqOsmrrCZqzRpKuw-1
Received: by mail-ed1-f72.google.com with SMTP id y5so865543edw.19
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 04:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=sAErj47iynwpJlIJhXI/3CNRpU6ksm3OJgfYzwD5hWk=;
 b=qDJ/n+rgGCJPh42T2OzlWLaWSVHaLXPCwy2Tm0CQM4WxAvi9wZyL8fIoOB6V8X6+wf
 yiRA5tofeeGD7avMNwWrfrhmAQkZgiccErLrl205yNJlyjHU7g53fABvBYICB/4SvMNu
 U3vmX71AC1CIuZVXeL0LNX4gWfgTKJoT590fgcQi7G3Q22b9YwbiVlzhGMAikp59GNXo
 lu744wXGdZbviA83vJPIjigKtc47IS+3RvfD6eiVeK7k4+D9lni+trEMp4k5HI2G5Vz5
 PnlbWE/YLVonyrANsPii7QKGa2SNRnwMBRSyc9ImbAMZyWPO4kpCGk824RLjOQ9rydlb
 mw6w==
X-Gm-Message-State: AOAM531mM+AlLUoDWpj0c1/mqSana4yx/wQOomuYRyaCJoR6UaNg147Y
 J2u0D3modUg6CNAyWA95vAG4x4I5nZJ31pVIoRiflIw3WB2fEA8r6c4fac9HTALbqvGOiQYVHxO
 K0KwR81qWO67RVpo=
X-Received: by 2002:a50:da06:: with SMTP id z6mr18853541edj.372.1590492114717; 
 Tue, 26 May 2020 04:21:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvTpNNDQEPLHDTNia+O4Pt6AuzJqKRryI2h3Cy0ZeC9UvWbl6HfYw6eTurMzpQA3W9Ybkaqg==
X-Received: by 2002:a50:da06:: with SMTP id z6mr18853441edj.372.1590492113005; 
 Tue, 26 May 2020 04:21:53 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id y17sm18039608edo.23.2020.05.26.04.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 04:21:52 -0700 (PDT)
Subject: Re: [PATCH v4] exec: set map length to zero when returning NULL
To: P J P <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200526111743.428367-1-ppandit@redhat.com>
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
Message-ID: <a1a210ae-6a1b-d769-74b7-da4ec23656a7@redhat.com>
Date: Tue, 26 May 2020 13:21:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200526111743.428367-1-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 00:48:49
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Ding Ren <rding@gatech.edu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 1:17 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When mapping physical memory into host's virtual address space,
> 'address_space_map' may return NULL if BounceBuffer is in_use.
> Set and return '*plen = 0' to avoid later NULL pointer dereference.
> 
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1878259
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  exec.c                | 1 +
>  include/exec/memory.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Update v4: update address_space_map API doc text
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg07281.html
> 
> diff --git a/exec.c b/exec.c
> index 5162f0d12f..4eea84bf66 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3538,6 +3538,7 @@ void *address_space_map(AddressSpace *as,
>  
>      if (!memory_access_is_direct(mr, is_write)) {
>          if (atomic_xchg(&bounce.in_use, true)) {
> +            *plen = 0;

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>              return NULL;
>          }
>          /* Avoid unbounded allocations */
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e000bd2f97..8fa2d3cab2 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2303,7 +2303,8 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
>  /* address_space_map: map a physical memory region into a host virtual address
>   *
>   * May map a subset of the requested range, given by and returned in @plen.
> - * May return %NULL if resources needed to perform the mapping are exhausted.
> + * May return %NULL and set *@plen to zero(0), if resources needed to perform
> + * the mapping are exhausted.
>   * Use only for reads OR writes - not for read-modify-write operations.
>   * Use cpu_register_map_client() to know when retrying the map operation is
>   * likely to succeed.
> 


