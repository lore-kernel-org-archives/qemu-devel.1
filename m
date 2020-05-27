Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0289EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DE720787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crAh28LE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DE720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyjj-0003yg-2q
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jdyj2-0003SD-69
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:16:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43878
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jdyiz-00041N-VX
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590596170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OI8Wk5plU/XnHwHACZ9kQyVhfRRJqF7keZrLpZ6wINg=;
 b=crAh28LEhQM7Dy1H3btkkAJ7ZXA2LA47/PxgAeF+h9jh4CwXiRfgDAUo7JGa/CJGNXtsPu
 GWNum7qFgAnIMhViL9W2XrQWxv7TDc1xEi+m5SYXnSj4DpU6fLM1XWzlh9U8Apa63NmMGP
 ZY0Yop5NbJ7ygefBgICBmOOJxMPjYrs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Y-O0Vg2QMtSZE7EGTTMf1Q-1; Wed, 27 May 2020 12:16:06 -0400
X-MC-Unique: Y-O0Vg2QMtSZE7EGTTMf1Q-1
Received: by mail-qt1-f198.google.com with SMTP id n33so26204379qtd.10
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OI8Wk5plU/XnHwHACZ9kQyVhfRRJqF7keZrLpZ6wINg=;
 b=Z+P+/clgqVbo2imBWfN6UhivlPHwu9YfTPlO1xro1PSchJgq1ugqK2AsY6spMCuHDE
 Z6KNJx/6VV+8Cum3cHYEYbpZau9T9R2WKLJQPz6djCT7Tl5EH7MIiwW1WRzfuF02b0VD
 dWpWNCtgjtVa1nuw4X6xCblAjCMSM/GaiBpHRN6rz8Rl+E0EdfwPlqpHto6lUKCZHkKU
 B88EsJbOKgLZmVLEN7KDlDTExuuKAigSEh+jrvWFySrL+OS8gMTsK0p4dd5QkB9055kL
 3A/9ReEPoQQwJSuSIQdNXeDBIglj07Df4095aVy/Kb5nFzBVnO5rw2gcefJrzxerY2bW
 rTEw==
X-Gm-Message-State: AOAM530OPkg0TbVddgzO69gcTWpW/e1kSd8X5D8EXrmqA71I7ty/bYBx
 qt2PhQtOudGe51qHHu8RH5V8ZCDDY8Ccv1A9M7RXVLQbFY6Ws8EBs8y7HpF9NFJIllocL4GYfxO
 l0sjOkMotWHvAJS0=
X-Received: by 2002:a37:46c1:: with SMTP id t184mr5103986qka.192.1590596166508; 
 Wed, 27 May 2020 09:16:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySFHbT6pC19uhOCnUbK+lI6G+E6A18NFrDhMf+viqm2qSYvldEc2/Y21ioJeXE/9PBXq0U2w==
X-Received: by 2002:a37:46c1:: with SMTP id t184mr5103946qka.192.1590596166194; 
 Wed, 27 May 2020 09:16:06 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id p10sm2339443qkm.121.2020.05.27.09.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 09:16:05 -0700 (PDT)
Date: Wed, 27 May 2020 12:16:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/vfio/common: Trace in which mode a IOMMU is opened
Message-ID: <20200527161603.GF1194141@xz-x1>
References: <20200526173542.28710-1-philmd@redhat.com>
 <6c7c445d-0335-f67d-bb72-5b0c046bb247@redhat.com>
 <24f88212-9b32-b6dc-fcd4-685cde8bf5d7@redhat.com>
 <864ac8ab-e21e-393e-d1eb-08b3c4579bbf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <864ac8ab-e21e-393e-d1eb-08b3c4579bbf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 05:53:16PM +0200, Philippe Mathieu-Daudé wrote:
> >>> +    for (i = 0; i < ARRAY_SIZE(iommu); i++) {
> >>> +        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].type)) {
> >>> +            trace_vfio_get_iommu_type(iommu[i].type, iommu[i].name);
> >> Just wondering why you want to trace the type as you now have the name
> >> string.
> > 
> > You are right :)
> > 
> >>> +            return iommu[i].type;
> >>>          }
> >>>      }
> >>> +    trace_vfio_get_iommu_type(-1, "Not available or not supported");
> >> nit: from a debugging pov, this may be not needed as
> >> vfio_get_group/vfio_connect_container() fails and this leads to an error
> >> output.
> 
> But you can reach this for example using No-IOMMU. If you don't mind, I
> find having this information in the trace log clearer.

I kinda agree with Eric - AFAICT QEMU vfio-pci don't work with no-iommu, then
it seems meaningless to trace it...

I'm not sure whether this trace is extremely helpful because syscalls like this
could be easily traced by things like strace or bpftrace as general tools (and
this information should be a one-time thing rather than dynamically changing),
no strong opinion though.  Also, if we want to dump something, maybe it's
better to do in vfio_init_container() after vfio_get_iommu_type() succeeded, so
we dump which container is enabled with what type of iommu.

Thanks,

-- 
Peter Xu


