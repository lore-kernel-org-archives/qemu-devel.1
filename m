Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A2CC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3CA2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsBXLQQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3CA2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isR85-0000WX-Kg
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isR7S-00005c-D9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isR7O-0003Q2-I8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:52:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34520
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isR7O-0003PA-Dn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579265573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsJ6tc5re05NNrZASY4tN+onAxEd1rUC3njodQZSW5o=;
 b=NsBXLQQb4lCNw6fLCPDxt/IzxIR3Q9l7/5+IHddFdwiqsb8J+99S9E2QiYJGBOwTdKyiZP
 pwRK23ihtJ+pnKy11VQkHnWOK04tm5Iyn/5I90n16k78jnaaue/hReaJ6LQo/tmQqOlveh
 o5JbY0OWliHtBQoB0cx55x3i60TO+HE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-3DiDolYhMIKHQm1dgGftSA-1; Fri, 17 Jan 2020 07:52:50 -0500
Received: by mail-wr1-f71.google.com with SMTP id w6so10429621wrm.16
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 04:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tsJ6tc5re05NNrZASY4tN+onAxEd1rUC3njodQZSW5o=;
 b=QZuj6h6Xe8nPRBAITONeuaDiQiwHq30VubJNcZbmpVz/rxGNWh6UwkS9vh0xJ/RcFP
 4qUzI4/Ojcj394w6S+FAfZoA9DBpYPjZWQx98bnPPsxbQXx23RGRyXw54udLyO+QRUUD
 cX7GjLMOxN6i6vdBZ1QRde/C1/WRq2yNUhlZtNG+XQzUYIGkP6YlRdqnaElbM27WHHVJ
 03C4Xu+PYYTkxTQl95RylPdtXiUMVDHXy91SoOwZyC9ZekWw7Ab5TqzhIymd9vLoQ379
 42N12j8jZLd/Nou+yHkEoi3qjHDf4eDC3qqaijPxcI95VWOrf+29v5Dm6AbLnBWSxx4f
 WVtg==
X-Gm-Message-State: APjAAAUDvAZD6C7UPJS2gwfyNKhjFn1+oikN8GZKb42inspf4bRTxGwG
 pRm08VjqIo8Dd/Mh1mMls6TYYgXPVR5uT7AHWgkf1cghKfqt1Q115sIGG8FV/+NY8QNTYrP9zQv
 rw0ZQliZ8ZdrQB5M=
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr4470250wmb.162.1579265569184; 
 Fri, 17 Jan 2020 04:52:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyaqW8hRoZHSYz9z4mBDY+3GxXhJb5O/PCKY/FVwv0yIKfhfdK4qY+2jWmz/j3nu6YOgxc9MA==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr4470229wmb.162.1579265568965; 
 Fri, 17 Jan 2020 04:52:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a?
 ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
 by smtp.gmail.com with ESMTPSA id u22sm35458332wru.30.2020.01.17.04.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 04:52:47 -0800 (PST)
Subject: Re: [PATCH v3 2/2] vhost: Only align sections for vhost-user
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com,
 jasowang@redhat.com
References: <20200116202414.157959-1-dgilbert@redhat.com>
 <20200116202414.157959-3-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4bf72509-3e60-0d78-c2ba-665a71a978e1@redhat.com>
Date: Fri, 17 Jan 2020 13:52:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200116202414.157959-3-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: 3DiDolYhMIKHQm1dgGftSA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/01/20 21:24, Dr. David Alan Gilbert (git) wrote:
> +    if (dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER) {   
> +        /* Round the section to it's page size */
> +        /* First align the start down to a page boundary */
> +        size_t mrs_page = qemu_ram_pagesize(mrs_rb);
> +        uint64_t alignage = mrs_host & (mrs_page - 1);
> +        if (alignage) {
> +            mrs_host -= alignage;
> +            mrs_size += alignage;
> +            mrs_gpa  -= alignage;
> +        }
> +        /* Now align the size up to a page boundary */
> +        alignage = mrs_size & (mrs_page - 1);
> +        if (alignage) {
> +            mrs_size += mrs_page - alignage;
> +        }
> +        trace_vhost_region_add_section_aligned(section->mr->name, mrs_gpa, mrs_size,
> +                                               mrs_host);
> +    }

Ok, now I understand!

So it seems to me that the vhost-user protocol is deficient, it should
have had two different fields for the region size and the region
alignment (so that mmap does not fail).  But I guess that's just yet
another thing to remember for vhost-user v2.

I would add a comment to explain why the alignment is needed in the
first place, but this fix is certainly much more pleasant.  Thanks very
much.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


