Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7A9C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0905621D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdbUu+Bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0905621D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiKea-0007Jt-8s
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iiKdw-0006sv-Hp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iiKdt-0006qi-Os
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:56:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24007
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iiKdt-0006pG-DH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576857400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNWLq8H7DSiXzD2kN3X/z/EfQ2ObIGZnNYP27gsn5bw=;
 b=MdbUu+BzVMNdOAvbg8nvnaQct4jtsDGUUQh6A4PBNVKmd5EXCRzKuDq3s+8wjRjM3KvMhC
 VoZHfehVa35NvJ5PIJaBRqXTejoA8Wp8iEju4rR2mFM1VSwZmEB1b8JbF9Mr4sGeCNirRH
 U/0uSyDs6P7FNYYa4ShHWwrrF5rt7uM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-eddJC1UTOwON1tv4Q7fJSw-1; Fri, 20 Dec 2019 10:56:39 -0500
Received: by mail-wr1-f72.google.com with SMTP id c17so1296712wrp.10
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 07:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hNWLq8H7DSiXzD2kN3X/z/EfQ2ObIGZnNYP27gsn5bw=;
 b=nNaRVtfGamZOXPphpWXxH+Q6xnLpuyDzqaFbS60i1WcAnt5VduA1cjtnKQ2grVr11K
 E/wsXhtumDgq4CWzL/g/VH0jNVoNGxgZfqW47P5TIQfa/+iWIZzUXDx/CTMCx6w//3Tc
 R8esDwH6RsGI/Cnx839Y7nuQk0YPdBPPfhjrn0+nM9l+ijpGFYniwVCE2/g3YYmil7ZX
 ZdYZIo0EmKHjM10LXNvKVWb8Stk3MZKvtvUrQ5DLFF8tanj9R+YOEjRTpIvNxeeoWWjC
 4lSUCeVVc1rY7R2Dg8Fcco8e7JjGuGb5rvk68ej/4qYy9OmUz+UutrWOcxQ5gz0/W1hO
 eMyg==
X-Gm-Message-State: APjAAAVPwoUR5vJSXTAaKxz0gl9Qx9uchW+apJ3BFOgg1jzV2AI+AvOo
 zQPqfP6BsLmq8Kw6V1ksTRtflkGtoTfiNxXxArt+syhN56gsz8M+Smo+0gz2iSCVy6IxH7IF2q8
 FQrJTjv0uW31mHZY=
X-Received: by 2002:a7b:c342:: with SMTP id l2mr18358916wmj.159.1576857397929; 
 Fri, 20 Dec 2019 07:56:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqznEaPT8tNirCHM+8EkJqfMm4GGKEKjc11P+UQMfrBGaj37RodrQPogwInWHQ8iFsyk1z7rUw==
X-Received: by 2002:a7b:c342:: with SMTP id l2mr18358890wmj.159.1576857397727; 
 Fri, 20 Dec 2019 07:56:37 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id a1sm10017837wmj.40.2019.12.20.07.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2019 07:56:37 -0800 (PST)
Subject: Re: [PATCH v39 12/22] target/avr: Add limited support for USART
 peripheral
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-13-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0be265cf-da0b-a68d-b8c4-cd7a37ce0940@redhat.com>
Date: Fri, 20 Dec 2019 16:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218210329.1960-13-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: eddJC1UTOwON1tv4Q7fJSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, richard.henderson@linaro.org,
 Sarah Harris <S.E.Harris@kent.ac.uk>, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 10:03 PM, Michael Rolnik wrote:
> These were designed to facilitate testing but should provide enough function to be useful in other contexts.
> Only a subset of the functions of each peripheral is implemented, mainly due to the lack of a standard way to handle electrical connections (like GPIO pins).
> 
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> ---
>   include/hw/char/avr_usart.h |  93 +++++++++++
>   hw/char/avr_usart.c         | 320 ++++++++++++++++++++++++++++++++++++
>   hw/char/Kconfig             |   3 +
>   hw/char/Makefile.objs       |   1 +
>   4 files changed, 417 insertions(+)
>   create mode 100644 include/hw/char/avr_usart.h
>   create mode 100644 hw/char/avr_usart.c

Note in patch subject (also the next patches:timers, intc, sample board) 
are not "target/avr" but "hw/avr".


