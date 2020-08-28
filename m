Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A334C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3E7205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KW95Z3oY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3E7205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaP6-0006ab-6k
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kBaOU-0005ms-O5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:09:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50826
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kBaOR-0002Oy-Jq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598605794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quwABx0Fo6f1jKo3zGWrVxb+C7c3VPi5/w0oHKS2yNc=;
 b=KW95Z3oYUCl3RQHtMiCag+V2sJfabLKqvUHRwRxrdd/9h6iYsV6kXilMymrn9q7QGEsGrq
 PlLX3TfrYEIcPcP7IsQPFeqDmPpo0A/iOJmJ9WCkdwlQddNSH+dv/IFVX6+d+wX4EVCRDK
 /eF0X/VLrFkZVVnXP1yqLcDGQCfSt/A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-70wOH03sMHC_wkP_ij3I_g-1; Fri, 28 Aug 2020 05:09:52 -0400
X-MC-Unique: 70wOH03sMHC_wkP_ij3I_g-1
Received: by mail-wr1-f71.google.com with SMTP id v5so202493wrs.17
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=J5v3Ti6swFBgpT18Yym5OHIK3PkjljTxnSeQWNfDM6Q=;
 b=Ne7kjpG2u4ixcxVaiQGNNT/bEv6unLT3VJlFV0gVMqcP8cXUfezQmtzrKdxd8d+G2/
 4Nf46VynGKdlfiL1sUZdKBfK8uuQqGQupTrVtU3HUVp3GImg0pb8ydjxrFy+D8cbYYji
 Anl3WIuTW7Zz/lDTw/4Utl2MlUi3ekV5TxxJhcfaK7U4DJfF+K+G016GcuTt51BfxAbk
 lw2GofnhMz5ySwI4JV0L4fZTwnwt0lk2Bm5O1FvX3WbeVI2O8/8KWQ12q73WHiStWVe6
 R5cmwlNKAvlVlK50qgPNPMI6ceJ7dTRLAeg3CB+ND6BaJnv7lS2y+SYZMro3SIKVAP1r
 lSsw==
X-Gm-Message-State: AOAM530931OxNMmvBd+bNM3/uP1uQ/IhO5hR4Nmja/7QAfgU2try7sQP
 xIRMpFwsO8bVpoOuHuTADxiyw6ecU1U+zN5HAczJmgp6S7tJozhmwTm3M07eGj3dlpSu4dtkgwo
 ZsknmnvdAbki/9NA=
X-Received: by 2002:a5d:544a:: with SMTP id w10mr558620wrv.317.1598605791493; 
 Fri, 28 Aug 2020 02:09:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxdtRQHYIsImYUVCEdLRDYMfDUg7MVPtmviXLbfXcg8qcGx9DScvNaml4t2Pk1WGM+/2unvg==
X-Received: by 2002:a5d:544a:: with SMTP id w10mr558588wrv.317.1598605791160; 
 Fri, 28 Aug 2020 02:09:51 -0700 (PDT)
Received: from steredhat ([5.170.38.42])
 by smtp.gmail.com with ESMTPSA id y16sm842548wrr.83.2020.08.28.02.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:09:50 -0700 (PDT)
Date: Fri, 28 Aug 2020 11:09:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 0/2] util/hexdump: Cleanup qemu_hexdump()
Message-ID: <20200828090947.k7enk535sce64h4h@steredhat>
References: <20200822180950.1343963-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200822180950.1343963-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, Zhang Chen <chen.zhang@intel.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 22, 2020 at 08:09:48PM +0200, Philippe Mathieu-Daudé wrote:
> - Pass const void* buffer
> - Reorder arguments
> 
> Supersedes: <20200822150457.1322519-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (2):
>   util/hexdump: Convert to take a void pointer argument
>   util/hexdump: Reorder qemu_hexdump() arguments
> 
>  include/qemu-common.h    |  3 ++-
>  hw/dma/xlnx_dpdma.c      |  2 +-
>  hw/net/fsl_etsec/etsec.c |  2 +-
>  hw/net/fsl_etsec/rings.c |  2 +-
>  hw/sd/sd.c               |  2 +-
>  hw/usb/redirect.c        |  2 +-
>  net/colo-compare.c       | 24 ++++++++++++------------
>  net/net.c                |  2 +-
>  util/hexdump.c           |  4 +++-
>  util/iov.c               |  2 +-
>  10 files changed, 24 insertions(+), 21 deletions(-)
> 
> -- 
> 2.26.2
> 
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


