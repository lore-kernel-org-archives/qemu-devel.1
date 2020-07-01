Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECE4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA5B2073E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuaUn8zD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA5B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqb7V-00008G-Cs
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 07:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqb6v-00086o-KQ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 07:41:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqb6t-0001Jy-IP
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 07:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593603662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlXYYQw7nwLlH6/6TklDOMIPnY4O7ptiKnR9susBKVY=;
 b=cuaUn8zD8MdcZPVh3Nyn2YUZXBIWivIZqTfwchPjvgJPWipwcaHwaHxTJkm8PwtqE3ySty
 DEONQohPMQwHqhSxElSxEh0ZLxil/p5rLJ8PYWo55G86bSIP9P+BAcdSodfnkOkgBgyG98
 cseyuip8GNubbJ3bZN87UyN3ndvPRlU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-5wWyWz1TPc-vJAqUihW-fw-1; Wed, 01 Jul 2020 07:41:00 -0400
X-MC-Unique: 5wWyWz1TPc-vJAqUihW-fw-1
Received: by mail-wm1-f70.google.com with SMTP id b13so20859757wme.9
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 04:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KlXYYQw7nwLlH6/6TklDOMIPnY4O7ptiKnR9susBKVY=;
 b=OS+jjEGecxI6LCMreKnCpSkpJa617cWvBLWA9jGGA3gQARbTjPAwdvcFQ0tGvTUHmt
 p4ZRcUWoZ2iGCT/RKuW7G2OQT5Y+ru1pwwnge5lXTr38+yBCIVkcpeliNCQ+lbT7plSi
 lLZ57i2ud7l9YB9PeuKJgdnCE4i4r1UyAiompw4j1AfRWFQcCUoUC/62Lo1OK6to8wSX
 MlgYL2GOHUgkdmPk5B2oiE7fw7KrntAPMTdFnEJ1kDq0rrePs7NHW7uleiyZpyZLGrx1
 e6mnUHWw9uaMqHPRlPyekfso4GVa06DOY3MOPC467uT3hFsA/6bqKWht2rUhPc9By62Z
 h/1g==
X-Gm-Message-State: AOAM530abCnTP8Ipm86Tcf+4h4GZFATirKkitUCAkse/HOruFOO3/Yrm
 G3M784y0ThhIqA4wgygrElm99CHha1kfS11yhQUlaeWC/tmIuUEMRR+CnhSc/KophmEuW+fY7qB
 7AYC3Nhx8t7ZcBIA=
X-Received: by 2002:a1c:2044:: with SMTP id g65mr25022381wmg.127.1593603659225; 
 Wed, 01 Jul 2020 04:40:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNPkEHHDTn7JxyULt/eK0/kF7Stbg+ikR0lUJt+ZpbQDQYmMBtU5wiAnvZl4vx3slOMcl5PA==
X-Received: by 2002:a1c:2044:: with SMTP id g65mr25022359wmg.127.1593603658938; 
 Wed, 01 Jul 2020 04:40:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1142:70d6:6b9b:3cd1?
 ([2001:b07:6468:f312:1142:70d6:6b9b:3cd1])
 by smtp.gmail.com with ESMTPSA id v11sm43783313wmb.3.2020.07.01.04.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 04:40:58 -0700 (PDT)
Subject: Re: [PATCH 2/2] iscsi: return -EIO when sense fields are meaningless
To: Xie Yongji <xieyongji@bytedance.com>, kwolf@redhat.com, mreitz@redhat.com
References: <20200701105444.3226-1-xieyongji@bytedance.com>
 <20200701105444.3226-2-xieyongji@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b9eaebc-0897-5348-79ef-a877e3300bd3@redhat.com>
Date: Wed, 1 Jul 2020 13:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200701105444.3226-2-xieyongji@bytedance.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: elohimes@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 12:54, Xie Yongji wrote:
> When an I/O request failed, now we only return correct
> value on scsi check condition. We should also have a
> default errno such as -EIO in other case.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  block/iscsi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 2964c9f8d2..387ed872ef 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -241,9 +241,11 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
>  
>      iTask->status = status;
>      iTask->do_retry = 0;
> +    iTask->err_code = 0;
>      iTask->task = task;
>  
>      if (status != SCSI_STATUS_GOOD) {
> +        iTask->err_code = -EIO;
>          if (iTask->retries++ < ISCSI_CMD_RETRIES) {
>              if (status == SCSI_STATUS_BUSY ||
>                  status == SCSI_STATUS_TIMEOUT ||
> 

Queued both, thanks.

Paolo


