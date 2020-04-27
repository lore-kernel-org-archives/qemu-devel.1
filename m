Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3228EC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71A3206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXPziBEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71A3206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1yU-0006wF-1B
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jT1x4-0005GM-Py
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jT1x3-00057G-M4
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:29:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60277
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jT1x3-00056z-31
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587986967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDha5+Oxhhkj/ZRiihvsM2A8cnD5RfXnIHM5gcvUOXQ=;
 b=KXPziBEA9wub0hISdkOAfXeUcqmKmwoNbk0LtRTSDi0u+p7YEixy0Ahb+PPNrN2bBdEegt
 /EYEvKzn8KUhRB3RXHgeESCoqZvZW+bbJ9pMUKVAiZYYUfZGDj8FdorSzC0EPviaV1enp5
 nRxfSUyjzT9FJUWO+rN4ZreHHzNt4uI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-nop6ncdcOGGzRRQQx_MhAQ-1; Mon, 27 Apr 2020 07:29:23 -0400
X-MC-Unique: nop6ncdcOGGzRRQQx_MhAQ-1
Received: by mail-wr1-f72.google.com with SMTP id p16so10342611wro.16
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 04:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K707fzTvHg9xJXk3dzwnCgItDRCLmrk6efmhhWEjzNw=;
 b=F6KFWoiJ3A6wiE4UoqnwzHyQDdqHiQ2WhLCYI9pSrSc0rvp4O2PXh4nj38nXLMI/xa
 FyQUFRjCXUbhLWTwKtI3/I2+wFPQP7+5G37xVRo9iJPX6nBqGEBGLSr+5BN30zUlPuEe
 WbX3c1vuVY5wnRY03rx0FxZ4GfXjqlzBUpGTUNoOJir14xlVQAD/W56qd84/uB+P8oQT
 POZ1HFH8BU1pNTZsG87o7gbDewvXZ2qJX65XyPgTi9YqWEw24ZMqJmFQRyPcV46tMInh
 hQu1mOmKRcaEqhAt803j459b5hbjeunZ9COsUvLa9fG6qYcOzbbCrJ7mqLXe5JjBVfQT
 gKjA==
X-Gm-Message-State: AGi0PubM/xA5/rR7VdFpMzt7tcfOkTyRvPXKEL4/oNP7+GHVxdOHEIud
 NhFXrIQ+l+X2vI7x7k8LlidlUBX3m6GhIseGWpNtjq+0XDCV2EsDzyu/DswBGKwdb/p/twVr+NY
 raf9X2CH8tUJPILE=
X-Received: by 2002:adf:f748:: with SMTP id z8mr25680346wrp.45.1587986960167; 
 Mon, 27 Apr 2020 04:29:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypJVI9jVG0FB4LpkBEcJiRUb2VGO5Xi0pCqIEHfxznovN0G5WmkcJxU62dRw5UbjErr8FaNMTQ==
X-Received: by 2002:adf:f748:: with SMTP id z8mr25680321wrp.45.1587986959899; 
 Mon, 27 Apr 2020 04:29:19 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 t67sm16280536wmg.40.2020.04.27.04.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 04:29:19 -0700 (PDT)
Date: Mon, 27 Apr 2020 07:29:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/3] headers update and virtio-net fixup
Message-ID: <20200427072856-mutt-send-email-mst@kernel.org>
References: <20200427102415.10915-1-cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200427102415.10915-1-cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 12:24:12PM +0200, Cornelia Huck wrote:
> This updates the headers to Linux 5.7-rc3. Doing so exposes
> a problem in virtio-net (the #define for compat covers too much),
> fix it.
>=20
> Note 1: I'd like this to go through s390-next so that I can go
>         ahead with protected virtualization, which needs a headers
>         update.
>=20
> Note 2: Why has the feature been merged in the first place without the
>         kernel part being upstream yet?

Windows drivers use it.

> Cornelia Huck (3):
>   virtio-net: fix rsc_ext compat handling
>   linux-headers: update against Linux 5.7-rc3
>   virtio-net: remove VIRTIO_NET_HDR_F_RSC_INFO compat handling
>=20
>  hw/net/virtio-net.c                           |   8 --
>  include/standard-headers/linux/ethtool.h      |  10 +-
>  .../linux/input-event-codes.h                 |   5 +-
>  include/standard-headers/linux/pci_regs.h     |   2 +
>  include/standard-headers/linux/vhost_types.h  |   8 ++
>  .../standard-headers/linux/virtio_balloon.h   |  12 ++-
>  include/standard-headers/linux/virtio_ids.h   |   1 +
>  include/standard-headers/linux/virtio_net.h   | 102 +++++++++++++++++-
>  linux-headers/COPYING                         |   2 +
>  linux-headers/asm-x86/kvm.h                   |   1 +
>  linux-headers/asm-x86/unistd_32.h             |   1 +
>  linux-headers/asm-x86/unistd_64.h             |   1 +
>  linux-headers/asm-x86/unistd_x32.h            |   1 +
>  linux-headers/linux/kvm.h                     |  47 +++++++-
>  linux-headers/linux/mman.h                    |   5 +-
>  linux-headers/linux/userfaultfd.h             |  40 +++++--
>  linux-headers/linux/vfio.h                    |  37 +++++++
>  linux-headers/linux/vhost.h                   |  24 +++++
>  18 files changed, 280 insertions(+), 27 deletions(-)
>=20
> --=20
> 2.21.1


