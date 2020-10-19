Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2CEC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667BB222C2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yob6ijJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667BB222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbDj-0002UM-79
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 15:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUbBz-0000s6-Nm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUbBv-0007UC-HA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603137094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9cN1vHF1+bZy2pzVaC1u5fNUSxcDAYzCZLtunjn0kc=;
 b=Yob6ijJmVruSrNezSb6R9lYgzxizpxXeL6qUP6gpIxqlsK/7eVMciCKCvM7KayGDWpx8l3
 hvoNy5y/7D7DKstnY1DofCdYrpO1RHJqjf+auQJumf8s05VHCuxSO96yBAYi/ATUFLszkP
 WpcGg+6sXyt+8RNqK+D3TMOdactbb+E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-uDA0ELw8PxWAdjGleqDIBA-1; Mon, 19 Oct 2020 15:51:32 -0400
X-MC-Unique: uDA0ELw8PxWAdjGleqDIBA-1
Received: by mail-wr1-f70.google.com with SMTP id 33so272918wrf.22
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 12:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D9cN1vHF1+bZy2pzVaC1u5fNUSxcDAYzCZLtunjn0kc=;
 b=hWAppFXD+vSSiry24HcmuuXFgAR69qQg3u523IaL/l4+auw7Im9C8saYss0WTYK1JR
 J5Xq+gSFYCOfxLK3XruTTrmVAwWE0YU1dutkAk6pYaEXDSdttBl9RS2/+lWAwrma9yjh
 e9R3eRcLG+1bCZImYsZToYt4sDjyHh3cW9fEFo0Bp6inr6Qx0GZ59UuyRxscuF2TyU6x
 b5N7SEZ1BhuL0IY9I/3wOk4AWrY85a0H5Twk/0dbOFlPIxrov+dHTW3lwIaNKTYnHKfF
 021F4GZ8pz6JH4LJzxKoPdKEfXJZp73YXpTHmCsd1MDE/bD9G3kLaTxcvEoNWvB5dvlM
 O0ng==
X-Gm-Message-State: AOAM530VpNmRiMbv+tyBfoEhR7FPQpsIyVhXy3AWMl7K1gEoHnc6fOju
 9W4uM6SXc1BIw/I5FyBwlwRaZSkOWZ3rWivmWf8yAAuNIW2yTdDc3n29Avw6hOmjsv/zfYctuMT
 7dbIlp5FWhB60B40=
X-Received: by 2002:a7b:c112:: with SMTP id w18mr853785wmi.62.1603137091750;
 Mon, 19 Oct 2020 12:51:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSwYwtoa40MENxqSXxxxe6RPrBK9af4yOQXXNoETVUHAuuffYTGo1n7xJDyr0AjOiJdjdi/g==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr853771wmi.62.1603137091559;
 Mon, 19 Oct 2020 12:51:31 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id j7sm925557wrn.81.2020.10.19.12.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 12:51:30 -0700 (PDT)
Subject: Re: [PATCH 1/4] qdev: Fix two typos
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20201019163702.471239-1-mlevitsk@redhat.com>
 <20201019163702.471239-2-mlevitsk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <99f70b22-fc91-8c3d-5cba-3af245737486@redhat.com>
Date: Mon, 19 Oct 2020 21:51:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019163702.471239-2-mlevitsk@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 6:36 PM, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   include/hw/qdev-core.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 868973319e..3761186804 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -163,8 +163,8 @@ struct NamedClockList {
>   /**
>    * DeviceState:
>    * @realized: Indicates whether the device has been fully constructed.
> - *            When accessed outsize big qemu lock, must be accessed with
> - *            atomic_load_acquire()
> + *            When accessed outside big qemu lock, must be accessed with
> + *            qatomic_load_acquire()
>    * @reset: ResettableState for the device; handled by Resettable interface.
>    *
>    * This structure should not be accessed directly.  We declare it here
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


