Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E42EC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A7924670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pqmj7FzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A7924670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idF59-0006ww-Le
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1idEUz-0008Ge-5B
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1idEUx-0003UP-NT
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:22:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51345
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1idEUx-0003RY-IH
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0gkfWYjg7Crj9Rrs7Gv6tjjYi4fzalonsqr68l03TI=;
 b=Pqmj7FzTwuFSEAFEuqrqItKT/nQlSLFpqfdE1+kFfuoXw19eNz2JLMx3me3pcQQ/5wxVd5
 Q7FABhQOhSNuxbXDe7O/DXG4zUPw/9JfaGPWkVsafZf6DLKspkZu3jvfG/uYn2oPsmVT0O
 AXsj2c8W/h3g+35uOpSwPqjtKKhmsc8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-sidkLSpWMQ6ATc67e8_CcA-1; Fri, 06 Dec 2019 05:21:43 -0500
Received: by mail-wm1-f70.google.com with SMTP id f4so1696224wml.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 02:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q0gkfWYjg7Crj9Rrs7Gv6tjjYi4fzalonsqr68l03TI=;
 b=Nz3PrKPPmbFSNZ1t7MIfIDIARyHMUNxIk2B8/hSQgDmjHhSor4XLtIAUByCmvN5SVW
 z382ZudMZNjnr8jHkYZ0FFductopyGqFnbef+aPKIT0SA1P8/605KVDWTqTnCuAe9udJ
 HJYEFQt14K5hYHoh3puzqAj2pjm0hS4MDcCssQBZ5PX2sW24ebDpiI8MpNreNVk2p+Ad
 wBB8HES/+L0D2Vf3pou2UmgfjL/tkx3Sy7leqEX3tYrl1USQzK7M7oetbtM8mKT1swbg
 Lw34rou4h8ex7UXyQxslfDDbbUZ6dADuBMpO+kNfhaQEZoAkmlYe6PQfU0OM5Hcob4Rj
 U3kQ==
X-Gm-Message-State: APjAAAXdO6vmX77HKZaQzNoMhy4btP2RifvM9WF4MRim5GcsUKCFxid4
 mOs+6UuKJC0Z3XdzQBwQjG8W31x0hAMnN+xV/82FQlDuiDdFGdn7KI6DMSVs01xnAt23xS22rBh
 4lEns/qEnYQkl/FI=
X-Received: by 2002:a1c:1987:: with SMTP id 129mr9600477wmz.112.1575627701943; 
 Fri, 06 Dec 2019 02:21:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5ot1DS3sYMRZ3ysh0ualBcHa7bQBUul++3lSzxuejGkOBd3KaowNNIika3BMqGYQbkxOzJQ==
X-Received: by 2002:a1c:1987:: with SMTP id 129mr9600455wmz.112.1575627701767; 
 Fri, 06 Dec 2019 02:21:41 -0800 (PST)
Received: from [10.201.49.168] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id v20sm2933072wmj.32.2019.12.06.02.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 02:21:41 -0800 (PST)
Subject: Re: [PATCH 3/3] hw/pci: Remove the "command_serr_enable" property
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20191205160652.23493-1-thuth@redhat.com>
 <20191205160652.23493-4-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d71b68b-ac66-46ed-b9d6-e54d40b7cb88@redhat.com>
Date: Fri, 6 Dec 2019 11:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191205160652.23493-4-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: sidkLSpWMQ6ATc67e8_CcA-1
X-Mimecast-Spam-Score: 0
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/12/19 17:06, Thomas Huth wrote:
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index db75c6dfd0..5b6ebd15c6 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -174,9 +174,6 @@ enum {
>  #define QEMU_PCI_CAP_MULTIFUNCTION_BITNR        3
>      QEMU_PCI_CAP_MULTIFUNCTION = (1 << QEMU_PCI_CAP_MULTIFUNCTION_BITNR),
>  
> -    /* command register SERR bit enabled */
> -#define QEMU_PCI_CAP_SERR_BITNR 4
> -    QEMU_PCI_CAP_SERR = (1 << QEMU_PCI_CAP_SERR_BITNR),
>      /* Standard hot plug controller. */
>  #define QEMU_PCI_SHPC_BITNR 5
>      QEMU_PCI_CAP_SHPC = (1 << QEMU_PCI_SHPC_BITNR),

I think it's okay to keep this enum.

Paolo


