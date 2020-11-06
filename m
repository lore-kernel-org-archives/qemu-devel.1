Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D225C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD1420719
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiSQEeiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD1420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb2kI-0001yr-27
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb2it-0001Ws-Lr
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:28:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb2ir-0004jI-JI
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604672891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXj442uqx/xyG2MtLYlfFM8c/VR+4+r6JjQT1wg+sFw=;
 b=TiSQEeiBnmEFeH8J8loLQNpe4oBobP4KUWFXHabZy/css49s/EIYBiOnn2NqEQj2TWO8Zk
 1KdLDJsNoRGyi3XgtGR6ZQMOTnaF5DMVSG+9E7EgrzGD561c/5cjcQZWZCPJPDmm3HlExZ
 9rjC5dx27RZ0PwNGvU7vH2Nl7qOsnyU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-LwmoWkFHPx-0z1SC7GfIGQ-1; Fri, 06 Nov 2020 09:28:09 -0500
X-MC-Unique: LwmoWkFHPx-0z1SC7GfIGQ-1
Received: by mail-wm1-f69.google.com with SMTP id o19so504432wme.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 06:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WXj442uqx/xyG2MtLYlfFM8c/VR+4+r6JjQT1wg+sFw=;
 b=RX/OVgaj9/fl9/rYl5pgMJQHKX7+gmsCJa5DD8aG9SOLmSX+wM7bPV0wBEof0/Z3/U
 sXcIo7XKeyoDyHglKCuyfgzASiZJSwVY/J2VkJbl0/AyBEp2KnTn/GPXkDnhleGGWwoc
 UVsdntDuSN0CN0IwMEZKxf9lDBCqCvbsVkMbF/EKJAmxnuShAIk/P3NmRbZZsf/ce/zU
 SbFPDW1/JAmkGp2t6dRmX3Pog/cTb+cGaZUyLxxxZXcuBIlX3afrIt6DS2EpjSMMp0JW
 DycejeZnT3PnY6QAOlevvzV6zdFQ9O0Q7iUGANgZ+0CPg1rAfdgjN+ImMWqIF8N27ijW
 ir7w==
X-Gm-Message-State: AOAM532VUfW89cH8PfwN1g+3HLFSGe9WH7nkXTguGBdCYY4ahL8LCE+x
 rM/mQhTVJkUH72splTaJeJc6DMOVSZj5tq77GaPYHOfg5RUoNeWCXBHoRkly4UR/1CPg73mnNbG
 rU8Dh4mZf8kUrQ4Q=
X-Received: by 2002:adf:9150:: with SMTP id j74mr3196987wrj.57.1604672888607; 
 Fri, 06 Nov 2020 06:28:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZuv0qjVX9VKRa/UPe8yi3rPvKamsuBCYP80CG/J7dCxLdE7eyxiE7f+tevo7Y138LUvPHMw==
X-Received: by 2002:adf:9150:: with SMTP id j74mr3196966wrj.57.1604672888399; 
 Fri, 06 Nov 2020 06:28:08 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t6sm2293007wrp.68.2020.11.06.06.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 06:28:07 -0800 (PST)
Subject: Re: [PATCH-for-5.2? v3 3/9] hw/usb: reorder fields in UASStatus
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
 <20201105221905.1350-4-dbuono@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4677dea1-bdd2-0095-e75c-2ca6d9be0cb9@redhat.com>
Date: Fri, 6 Nov 2020 15:28:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105221905.1350-4-dbuono@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 11:18 PM, Daniele Buono wrote:
> The UASStatus data structure has a variable sized field inside of type uas_iu,
> that however is not placed at the end of the data structure.
> 
> This placement triggers a warning with clang 11, and while not a bug right now,
> (the status is never a uas_iu_command, which is the variable-sized case),
> it could become one in the future.

The problem is uas_iu_command::add_cdb, indeed.

> 
> ../qemu-base/hw/usb/dev-uas.c:157:31: error: field 'status' with variable sized type 'uas_iu' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]

If possible remove the "../qemu-base/" as it does not provide
any useful information.

>     uas_iu                    status;
>                               ^
> 1 error generated.
> 
> Fix this by moving uas_iu at the end of the struct

Your patch silents the warning, but the problem is the same.
It would be safer/cleaner to make 'status' a pointer on the heap IMO.

> 
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
>  hw/usb/dev-uas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
> index cec071d96c..5ef3f4fec9 100644
> --- a/hw/usb/dev-uas.c
> +++ b/hw/usb/dev-uas.c
> @@ -154,9 +154,9 @@ struct UASRequest {
>  
>  struct UASStatus {
>      uint32_t                  stream;
> -    uas_iu                    status;
>      uint32_t                  length;
>      QTAILQ_ENTRY(UASStatus)   next;
> +    uas_iu                    status;
>  };
>  
>  /* --------------------------------------------------------------------- */
> 


