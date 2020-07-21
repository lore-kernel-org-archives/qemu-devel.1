Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDADC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F2C20792
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULXvD5FK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F2C20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxoQO-0005SK-1G
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 05:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxoPX-0004za-Eo
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:18:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxoPU-0007xp-E7
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595323082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kQ4g5TEkEms3MhIf7AZ2S+dU5MUTrIogaoQgRiYrSqM=;
 b=ULXvD5FKlB+/j7tFVEtNeC+R19jSY2iDvYhMFfaD5om+jSc7ON71GeIFaOVmEmo4Vl3Ktr
 jwCaP2WuxnXUJ6X0hIFmK0O1cbYCXmKJdx60TnHbnmiVg34+GMQAN270XykKMKZ8iZeoQH
 tLYyAej48eOG1zVCw5IeRylTI2qOfbo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-74zx6Eu0NN-SczLJ6iuTPQ-1; Tue, 21 Jul 2020 05:18:00 -0400
X-MC-Unique: 74zx6Eu0NN-SczLJ6iuTPQ-1
Received: by mail-wm1-f70.google.com with SMTP id w25so381846wmc.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 02:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=kQ4g5TEkEms3MhIf7AZ2S+dU5MUTrIogaoQgRiYrSqM=;
 b=NR6oxPEFUFqHuFFMkmj+nMSXA/O/qPPgf57TQog4tGprRB+VCzRdSxAwruYs9bzsJ+
 mz7STNUw+iHoR9jB8aWgTyS2k18rswZsVuSgBJNg26LLcJ+oadJuuFE9GNo/+mlbN4uk
 QB/RCE0b9yYKMQdacXcoqvFIeh5NvOQwF9B/lpnG5o5YtkXwqD0riHhypBbAT/pN/UNq
 uJeIt9KHXgDzQBAayxKH2+PCvOfgDmDnts8Jkg1njiLE77oJX1IUeFz+fBLlKAaCT381
 dPnTQO/U58ErEZSeVZoDK5H140srOUtpoFBKbzIRZrDUl8Lx5hMjwhbb1fPSafXL41MQ
 7rhw==
X-Gm-Message-State: AOAM5335QfhsF87M9kevY+FhqGGvC7F4tgNHfQiueKbaUQwE/tf9YWAL
 ZwIWLKgibBxZaYGl1a3XnZNMG8GEeqPiQGxam5F/tzKUWpG8NSiYfLfcGMNBAdVGfpFwdnOqbuO
 5QIkCXRFu7MMtgqQ=
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr3236740wmc.187.1595323079324; 
 Tue, 21 Jul 2020 02:17:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwafwbJtCUyJ94U+PSJmHjP9Y5dEzOj7k2DNrmuVihCnAQpvz1uUW/zfR042h7E3W2cJjcpNQ==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr3236720wmc.187.1595323079101; 
 Tue, 21 Jul 2020 02:17:59 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 60sm12323499wrs.20.2020.07.21.02.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 02:17:58 -0700 (PDT)
Subject: Re: [PATCH for-5.1] xhci: fix valid.max_access_size to access address
 registers
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200721083322.90651-1-lvivier@redhat.com>
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
Message-ID: <65c1e6b9-523b-99ec-39eb-00ce59399ccf@redhat.com>
Date: Tue, 21 Jul 2020 11:17:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200721083322.90651-1-lvivier@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 10:33 AM, Laurent Vivier wrote:
> QEMU XHCI advertises AC64 (64-bit addressing) but doesn't allow
> 64-bit mode access in "runtime" and "operational" MemoryRegionOps.
> 
> Set the max_access_size based on sizeof(dma_addr_t) as AC64 is set.
> 
> XHCI specs:
> "If the xHC supports 64-bit addressing (AC64 = ‘1’), then software
> should write 64-bit registers using only Qword accesses.  If a
> system is incapable of issuing Qword accesses, then writes to the
> 64-bit address fields shall be performed using 2 Dword accesses;
> low Dword-first, high-Dword second.  If the xHC supports 32-bit
> addressing (AC64 = ‘0’), then the high Dword of registers containing
> 64-bit address fields are unused and software should write addresses
> using only Dword accesses"

You only describe the WRITE path. Is the READ path similar?

> 
> The problem has been detected with SLOF, as linux kernel always accesses
> registers using 32-bit access even if AC64 is set and revealed by
> 5d971f9e6725 ("memory: Revert "memory: accept mismatching sizes in memory_region_access_valid"")
> 
> Suggested-by: Alexey Kardashevskiy <aik@au1.ibm.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/usb/hcd-xhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index b330e36fe6cc..67a18fe2b64c 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3184,7 +3184,7 @@ static const MemoryRegionOps xhci_oper_ops = {
>      .read = xhci_oper_read,
>      .write = xhci_oper_write,
>      .valid.min_access_size = 4,
> -    .valid.max_access_size = 4,
> +    .valid.max_access_size = sizeof(dma_addr_t),
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> @@ -3200,7 +3200,7 @@ static const MemoryRegionOps xhci_runtime_ops = {
>      .read = xhci_runtime_read,
>      .write = xhci_runtime_write,
>      .valid.min_access_size = 4,
> -    .valid.max_access_size = 4,
> +    .valid.max_access_size = sizeof(dma_addr_t),
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };

I wonder if we shouldn't check the access size now, something like:

bool xhci_check_access_size(void *opaque, hwaddr addr,
                            unsigned size, bool is_write,
                            MemTxAttrs attrs);
{
    XHCIState *xhci = opaque;

    /* FIXME only for is_write??? */
    return xhci->ac64 || size == 4;
}

And add to both MemoryRegionOps:

       .accepts = xhci_check_access_size,


