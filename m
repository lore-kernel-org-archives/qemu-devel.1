Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF6CC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66C4206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikVmX+Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66C4206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwL7-0003GY-JX
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itwJx-00024L-QC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itwJv-0000xJ-GU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:24:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38816
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itwJv-0000x1-An
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579623842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfNQM6XqllPHz+fk1qG5FqlquMpXzyqTKEaXxBStVCw=;
 b=ikVmX+Sm226KRi+CwI9VyePmaBEEpJfLGI9JfiXdCBzC7zMB0HymqnNHI5dbszoWMFzn3N
 oDhpHhxfhrucsKfYzK3lER91/DIxvN9NSc00+A3qWsnUNkAo988FLiwY6KevWVimJPE0B/
 hC5+dZOGwVkLa7OHtZb47gFUzIOHHe0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-vI5mxvcwMV-j3TH_MDeixA-1; Tue, 21 Jan 2020 11:23:59 -0500
Received: by mail-wr1-f71.google.com with SMTP id f10so1557443wro.14
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 08:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SfNQM6XqllPHz+fk1qG5FqlquMpXzyqTKEaXxBStVCw=;
 b=AioAgAV1/6Li/tZkQzJKEROFN56ESp1lb26kmQ271Qq9aGrVFBKgEJ0D/e92xfsTap
 YSbSoiTvtoj1xu8DFhMjttffp+oYJarbfovXRJEX1dVNjQlCr+5dK2G+JQDxV6/ZqzUl
 Pr1dl61tDX4ciggn1776+j/r++96sdvpoF9Z9DJYBm28Xle/ue5byh6cmXb11iaRJQ22
 Esc0+lbyjf3l75Oo720ijKtLpuhTwXS3Pce8wLyYzOOeudx0+aQPD7H9AbToqJobyiOm
 W9Rfc/WOmZKJajXLdZwLRTvZmosVv+qeIbEZXARuz33A273mLhHPkpcGSyx1vMrGcZMa
 ksOQ==
X-Gm-Message-State: APjAAAUUV9qfGA+4GELTqv3jgH0rZJMcR8fshdRUqUL67ibRObbnNf3e
 P8SM6GxguBgfPw8huO1cbdt+fiPTj64mMavTufrSKnEbFkA2djFa744QyZMjkunTldSA8ETR6Q3
 BhozjUBkoWpTupdo=
X-Received: by 2002:a5d:6406:: with SMTP id z6mr6065293wru.294.1579623838153; 
 Tue, 21 Jan 2020 08:23:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4ZVKY188hFTT5H2cEpr9OtCDsxTmKOei/eYPntDtQUpm2RgFVQo+bKs+EAMkY2C6Fl8B6bw==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr6065274wru.294.1579623837846; 
 Tue, 21 Jan 2020 08:23:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a?
 ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
 by smtp.gmail.com with ESMTPSA id w17sm53053764wrt.89.2020.01.21.08.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 08:23:57 -0800 (PST)
Subject: Re: [PATCH 0/2] delete virtio queues in virtio_scsi_unrealize
To: pannengyuan@huawei.com, mst@redhat.com, fam@euphon.net
References: <20200117075547.60864-1-pannengyuan@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f5e426a-2b8d-cef0-594f-dcca95cc0a03@redhat.com>
Date: Tue, 21 Jan 2020 17:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200117075547.60864-1-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: vI5mxvcwMV-j3TH_MDeixA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/01/20 08:55, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> This serie patch fix memleaks when detaching virtio-scsi device. 
> 1. use old virtio_del_queue to fix memleaks, it's easier for stable branches to merge.
>    As the discussion in https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02903.html
> 
> 2. replace virtio_del_queue to virtio_delete_queue to make it more clear.
> 
> Pan Nengyuan (2):
>   virtio-scsi: delete vqs in unrealize to avoid memleaks
>   virtio-scsi: convert to new virtio_delete_queue
> 
>  hw/scsi/virtio-scsi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Queued, thanks.

Paolo


