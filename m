Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E045EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AADC320782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ew9UMp/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADC320782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKMu-0006ok-UI
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrKLz-0005pw-Sv
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:59:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52761
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrKLx-0006HD-LZ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593777576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMUKPEduPt9T7ihaye1LCWnkE9XTLd/c4k4fg6PURrs=;
 b=Ew9UMp/L2g8I+oQ2M+4qBy6sGBLiePSiaZFarHXoMkEaUeEGlQLSXdrFRgERl/KNFQWR6n
 JPKAt7Ua24xplgkkSbb7yL+1SSabe/ESwzCAbXsZ4LdNldo8ZrMsKwuJ/KMRZslNSt/I9y
 k/UOZIyvG3Ru5NPJCiNXm8voQJQBrqA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-N1s--gm7Ndi229uu0nOWUg-1; Fri, 03 Jul 2020 07:59:35 -0400
X-MC-Unique: N1s--gm7Ndi229uu0nOWUg-1
Received: by mail-wr1-f72.google.com with SMTP id i14so31175525wru.17
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 04:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FMUKPEduPt9T7ihaye1LCWnkE9XTLd/c4k4fg6PURrs=;
 b=fwoDkON+dgqOFCQin+NeMl3201zLjrsEYsZrAmcK+IUBQ1jeILXQG/KJ+HSE9ltEPk
 espDy0TJvGc25CvwVQNQ9p3CyuCzQEFapxfdaF7xRErbYlOE4CqwYFGiPTNthvqWDgbC
 Q8gx6PKJ6Gp2nnP6sKSVsu0wN1b6RR/+Bx2WpkWLKolwzxvzqRcPcDiqWrwSgL72SO5k
 hlBggtn3Qb8kmUOds/xVlXwqq3ro4Z8LWh6r+nxwidRBzcfYPH02NONFHlf7/g1kDtID
 QsC5QFKhIZGR/1bX9/zrmDwN6mtLi0JdymUS54bBDMwPB3XnCNlQgwITiuMqY1/X43QK
 B0HA==
X-Gm-Message-State: AOAM532ZgEbFjLA3+5+RRruqqPLNWn4dcRgGQEliquJodMPeAT2LIZAc
 8rqx+0QTVdmm/KY76POCWBRmMNrUh90OOyddTlhkNGdBtQZwf51aUUS04Jz38SmzrBdwSp7ZKM6
 lCY33kde8IZ57mpg=
X-Received: by 2002:a05:6000:128e:: with SMTP id
 f14mr39641078wrx.276.1593777574087; 
 Fri, 03 Jul 2020 04:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnE9rbGperO3lDVaq0lx5FgpvSsGAjhu9LvaLhy2aPvqf9SUH3VvZ/UVKfXEFzU4+H8HQkoA==
X-Received: by 2002:a05:6000:128e:: with SMTP id
 f14mr39641067wrx.276.1593777573926; 
 Fri, 03 Jul 2020 04:59:33 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 p8sm13627250wrq.29.2020.07.03.04.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 04:59:33 -0700 (PDT)
Date: Fri, 3 Jul 2020 07:59:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] virtio-net: fix removal of failover device
Message-ID: <20200703075920-mutt-send-email-mst@kernel.org>
References: <20200703114813.5911-1-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703114813.5911-1-quintela@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 01:48:13PM +0200, Juan Quintela wrote:
> If you have a networking device and its virtio failover device, and
> you remove them in this order:
> - virtio device
> - the real device
> 
> You get qemu crash.
> See bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1820120
> 
> Bug exist on qemu 4.2 and 5.0.
> But in 5.0 don't shows because commit
> 77b06bba62034a87cc61a9c8de1309ae3e527d97
> 
> somehow papers over it.
> 
> CC: Jason Wang <jasowang@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


Jason can you queue this pls?

> ---
>  hw/net/virtio-net.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9bb5578e5d..8d84713df3 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3398,6 +3398,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
>      g_free(n->vlans);
>  
>      if (n->failover) {
> +        device_listener_unregister(&n->primary_listener);
>          g_free(n->primary_device_id);
>          g_free(n->standby_id);
>          qobject_unref(n->primary_device_dict);
> -- 
> 2.25.4


