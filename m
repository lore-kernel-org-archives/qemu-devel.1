Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911B0C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C21420732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtbFiKjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C21420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGQd-0002D1-ID
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jFGPm-0000kO-Ru
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jFGPl-0008Sv-Hc
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:06:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jFGPl-0008SB-7v
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584705972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KyageVHFLlucRCOL9WpJFdJbfg3cTxlHsP9HnluO+cI=;
 b=WtbFiKjtok5YO46IM2Aot26Gn/n8DkmN8dcTwOreFsYVlxJpLewLfTnQuU4h7PNkqtG+xc
 f9YD8nSER3j/WNaZfjllKuMrwy6gETf61zsCCeTStzvqCbYtkDbpKj4TlaKBrpFZn7HJCI
 Mnb5U/i9w9vYsUZ7NS2QNSHntrDGtOM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-GNa91q4DPVqqRpXaR2uc3w-1; Fri, 20 Mar 2020 08:06:08 -0400
X-MC-Unique: GNa91q4DPVqqRpXaR2uc3w-1
Received: by mail-wm1-f70.google.com with SMTP id w12so2290930wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 05:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KyageVHFLlucRCOL9WpJFdJbfg3cTxlHsP9HnluO+cI=;
 b=egaahHMsoHcdgH1+LZXRnBXgB7uGAn+AYI0qO+AjWYZf4IY69i1DLqSKdUefcERujV
 Mm1NEbVWvwEBPxc7wgaTOSZ1sjCkwSluZMrrtGITnI5hxaYRbYLrpJyjSBwRJeekd1zb
 Bu3jWFKGJvuUfnUhG+uxgHXAfjnVDMWSE2jnruNhcc1VEKpflSYrJ2fGq4IhBX8xN55h
 /B1s45dFWvtok+RRRo1X3Qxch4kQrkz3+hzZVvduuc7h9uGavvnehB3Ep814L9ErB0g+
 2nCM3uD+NfbYVjhKQXzli21wI68O7UaEJo9sJHfU2pgT5+pRQl2BB7UJf9RcZGo2puTd
 EAnw==
X-Gm-Message-State: ANhLgQ27huwZ54hYRI5lUD1sPw8Zk+ssTfZYnLSkRaTOmJyjdcN7Hlqk
 v0Sh7irfK9XYRpwC6xbdM80VaPIJVB43k5KrcanjccPYDSQ3m67Ph/IVVMtCaPmMKmxlRWjDz/r
 hApMfsJMCF38YwJk=
X-Received: by 2002:a05:600c:2c10:: with SMTP id
 q16mr9969274wmg.69.1584705967054; 
 Fri, 20 Mar 2020 05:06:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvCPBvPnNSc/V77QPkHCBAVaVaJQQUARCRFiIpgnjrKb97t3vFWvjgEu3TTO/qNz8BXM2LVGQ==
X-Received: by 2002:a05:600c:2c10:: with SMTP id
 q16mr9969223wmg.69.1584705966663; 
 Fri, 20 Mar 2020 05:06:06 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id s8sm3624039wrv.97.2020.03.20.05.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 05:06:05 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] lockable: replaced locks with lock guard macros
 where appropriate
To: dnbrdsky@gmail.com
References: <20200319233454.1856568-1-dnbrdsky@gmail.com>
 <20200319233454.1856568-3-dnbrdsky@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f5383d0-7bba-607e-93ae-f79e5c959d0e@redhat.com>
Date: Fri, 20 Mar 2020 13:06:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319233454.1856568-3-dnbrdsky@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/03/20 00:34, dnbrdsky@gmail.com wrote:
> index 682abd8e09..89f8a656a4 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1086,7 +1086,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
>      acb->task->expxferlen = acb->ioh->dxfer_len;
>  
>      data.size = 0;
> -    qemu_mutex_lock(&iscsilun->mutex);
> +    QEMU_LOCK_GUARD(&iscsilun->mutex);
>      if (acb->task->xfer_dir == SCSI_XFER_WRITE) {
>          if (acb->ioh->iovec_count == 0) {
>              data.data = acb->ioh->dxferp;
> @@ -1102,7 +1102,6 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
>                                   iscsi_aio_ioctl_cb,
>                                   (data.size > 0) ? &data : NULL,
>                                   acb) != 0) {
> -        qemu_mutex_unlock(&iscsilun->mutex);
>          scsi_free_scsi_task(acb->task);
>          qemu_aio_unref(acb);
>          return NULL;

Not exactly the same, should be okay but it also should be noted in the
changelog.

>  void cpu_list_remove(CPUState *cpu)
>  {
> -    qemu_mutex_lock(&qemu_cpu_list_lock);
> +    QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
>      if (!QTAILQ_IN_USE(cpu, node)) {
>          /* there is nothing to undo since cpu_exec_init() hasn't been called */
>          qemu_mutex_unlock(&qemu_cpu_list_lock);

Missed unlock.

> 
> @@ -667,14 +668,13 @@ int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s)
>          .size = QEMU_VFIO_IOVA_MAX - s->high_water_mark,
>      };
>      trace_qemu_vfio_dma_reset_temporary(s);
> -    qemu_mutex_lock(&s->lock);
> +    QEMU_LOCK_GUARD(&s->lock);
>      if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>          error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
>          qemu_mutex_unlock(&s->lock);
>          return -errno;
>      }
>      s->high_water_mark = QEMU_VFIO_IOVA_MAX;
> -    qemu_mutex_unlock(&s->lock);
>      return 0;

Missed unlock.

Otherwise looks good.

Paolo


