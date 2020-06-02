Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C24C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 05:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D36D206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 05:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1Ng/XTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D36D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfzWD-0003QU-AW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 01:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfzVF-0002kk-VK
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 01:30:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfzVE-00080Z-N5
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 01:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591075819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qzoUxl/WLYb+063eW2TIeYv68TR2Bx8Y1d1JB0krKgI=;
 b=I1Ng/XTUMMT7TcepBCypAvLuanvkVa49SVRbh7Fxj0MjOFIfHFgWkQWfOBB5lCrh4VgeoC
 OKFG/dHw1IhTKWuFK1yWQEt+cj5ezG+VTRYivP6esajFPVdjgfhiCO6Ir4Jp2NdE3o58iZ
 m/iWae45ezo0ATg8W5vCK0Kup/QkUEM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-lXt6aBurO5a89MUyCluzaA-1; Tue, 02 Jun 2020 01:30:16 -0400
X-MC-Unique: lXt6aBurO5a89MUyCluzaA-1
Received: by mail-wm1-f71.google.com with SMTP id b65so503673wmb.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 22:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qzoUxl/WLYb+063eW2TIeYv68TR2Bx8Y1d1JB0krKgI=;
 b=AHqYw4deqiNbU9VAbg2rbzL1/K4mW0QXxA+elfkAqDo5IDLcLwyQltOngG5vOlYQzM
 HAWztnwD5Fq/vjdKrUy6SQh7ioJvburami38kDuNBuMHn2y7zpSprSBY7fT8U1xC566e
 10yQ6+bSPaSqDywNS1cDGQHDDa/dFQZPlgAb6OsrDtgrxa/0eBZeo1+1XwGDJ+th8h2u
 rIWFi62VYsDibtVtJda89XibPy+GoyGNM+7YZtB3A/nsISU/IBUUr20Xd4jQ0xE+V0S3
 MsJZiLUvmMImfAsSt24/6dB+aBCMb5fd224WDVz9GJIwKCkc4ssR4hyR4f/lkmEoSvg0
 M69w==
X-Gm-Message-State: AOAM5309aw/chQs1BJ2X4GuBTcfOyTYvuSGQS0SVkClq+Uz6Ps98ekyg
 yGwTGcbuHzwxHVdOAIjqo62VhW+qRoEjvdN/v7DfCT+udF1BoD3wf4F0NiWQU05FLKjpKn5VGLg
 1KN7aakSAzTIWrQY=
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr26298840wrr.410.1591075815776; 
 Mon, 01 Jun 2020 22:30:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm9pd8/UBwSfLvzSGS3kH8718EtuelpkpKCVpKrXAc490C5Bc8iBs799ATExgZ/w+YruoNzg==
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr26298819wrr.410.1591075815494; 
 Mon, 01 Jun 2020 22:30:15 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 30sm2040428wrd.47.2020.06.01.22.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 22:30:14 -0700 (PDT)
Date: Tue, 2 Jun 2020 01:30:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 0/4] microvm: memory config tweaks
Message-ID: <20200602012911-mutt-send-email-mst@kernel.org>
References: <20200529073957.8018-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200529073957.8018-1-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 22:14:55
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org, imammedo@redhat.com,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 09:39:53AM +0200, Gerd Hoffmann wrote:
> With more microvm memory config tweaks split this into its owns series,
> the microvm acpi patch series is already big enough ...

Okay.

We might want to add pci to microvm and maybe we'll need more space
then, but let's leave this for another day.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> v2:
>  - use 3G split.
>  - add patch to move virtio-mmio region.
>  - pick up acks & reviews.
> v3:
>  - fix xen build.
>  - pick up acks & reviews.
> 
> take care,
>   Gerd
> 
> Gerd Hoffmann (4):
>   microvm: use 3G split unconditionally
>   microvm: drop max-ram-below-4g support
>   x86: move max-ram-below-4g to pc
>   microvm: move virtio base to 0xfeb00000
> 
>  include/hw/i386/microvm.h |  2 +-
>  include/hw/i386/pc.h      |  2 ++
>  include/hw/i386/x86.h     |  4 ----
>  hw/i386/microvm.c         | 35 +----------------------------
>  hw/i386/pc.c              | 46 +++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc_piix.c         | 10 ++++-----
>  hw/i386/pc_q35.c          | 10 ++++-----
>  hw/i386/x86.c             | 46 ---------------------------------------
>  hw/i386/xen/xen-hvm.c     |  2 +-
>  9 files changed, 61 insertions(+), 96 deletions(-)
> 
> -- 
> 2.18.4


