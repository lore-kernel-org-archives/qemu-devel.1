Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E1C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A86F20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6knIjnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A86F20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0e5-0000Cy-4m
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kW036-0006H7-8l
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kW034-0002Dz-NP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603470973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgSM33K/lHKUrdkZ1FgzRnNuhfYt5gPmJS4shbZ90R0=;
 b=Z6knIjnfybDoRaLNX7DnVPX1F4Gw2gFQP/ZrCkUZA4wlKXzAK5qFjItExjxQW25M9KoWeG
 1QNILr6Mh8GgTxEua5rQ6VPxoAzuxhTqNzWiNux4mjcRhNx/2fyndNCmaLBKixBzXu3RTx
 SSos9/cL2pssqmKyQqRbvlBlon6L7TU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-hy2m64wwMUeeeeeB0K3zWQ-1; Fri, 23 Oct 2020 12:36:11 -0400
X-MC-Unique: hy2m64wwMUeeeeeB0K3zWQ-1
Received: by mail-wm1-f70.google.com with SMTP id u5so477588wme.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wgSM33K/lHKUrdkZ1FgzRnNuhfYt5gPmJS4shbZ90R0=;
 b=pXgILS/bM2i6/CtVY3j91RUhddnNCJ6dmC/qKdsm18iP0lwH6rp3g+ZknVd9ytnoAL
 GoKA5vQsjZi1d8n3o+8ylm+VmOgJcfhD1JYGRoqFpFd+rg4UzWgNP6JSDFTIr2nSTYdP
 9IEqap9asGYpZADaqpnNj5PAQn3G0QzgL799jcnwDgt76x7pXONBf24K5r6SB4WjRcwZ
 e+nEK2Z3K4O5B+cNnPCe7rb/6Y6VUCQpkWFSAd1XTC88nchRxPxdDCDJY29cc14ynj3P
 xO2C5AOZ5zhgFoMF567qQMe6xV5ezn3mO3Kj2aNEdt8JEOZNEFaiZ7iemyAFWLYKGs9i
 9q3A==
X-Gm-Message-State: AOAM531BV1boViGKRUme/RKsAqrnG3uBosYo+tR/FBOz4H26Y7WouXKq
 YUSxZRIEYZVdQO9Z1s6jZbP43ffvkqt14Np3y6tdRiYZJd/YreP5Gk6dS4fTCJ6Xhey11aS3QQ4
 mP+L3BwdAkSKssPU=
X-Received: by 2002:adf:c045:: with SMTP id c5mr3515165wrf.405.1603470970225; 
 Fri, 23 Oct 2020 09:36:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyntZBB6uobIG1xds1qP+wWp24HNFAl/U7vYZteWy0MIOHKLN1C6CXcf9iiXRL8NUDRmVtFIA==
X-Received: by 2002:adf:c045:: with SMTP id c5mr3515142wrf.405.1603470970051; 
 Fri, 23 Oct 2020 09:36:10 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o140sm4675866wme.43.2020.10.23.09.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 09:36:09 -0700 (PDT)
Subject: Re: [PATCH v11 05/19] multi-process: add qio channel function to
 transmit
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org
References: <cover.1602784930.git.jag.raman@oracle.com>
 <599c6eb3f07b3ef16f29ad8fda005ddecc038566.1602784930.git.jag.raman@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51fa6f71-b01b-d700-8c7d-7aa7e9634554@redhat.com>
Date: Fri, 23 Oct 2020 18:36:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <599c6eb3f07b3ef16f29ad8fda005ddecc038566.1602784930.git.jag.raman@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, quintela@redhat.com,
 mst@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 8:04 PM, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> 
> The entire array of the memory regions and file handlers.

I don't understand the description... Did you forgot the
verb?

> Will be used in the next patch.
> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/io/channel.h | 24 ++++++++++++++++++++++++
>   io/channel.c         | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)


