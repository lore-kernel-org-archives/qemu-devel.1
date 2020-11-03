Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A1EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A988521556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaFtiWAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A988521556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2yz-0001Ip-N7
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ka2yB-0000tC-0x
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ka2y9-00066r-Aq
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604435512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2xoQMtcZ45M2FDoabAb+oIuMsPmr+LIxDstfsaLsQQ=;
 b=PaFtiWABs/hju6rEiVxiwFwvi8p0nxvCyqd6C+UnXMW6h9Ui7sudt53kCUL5m6hNcBdJjP
 ADhzP26AYryahEj0+EJcZgag9AFIDo7LsBoTtcAJBhUb8VuWcIc0d2dAqJzJlISc7PFSsL
 /85ec3wJIOi51sZevWxlXXD9vih4GyA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-9KP-yz5jP3efZO8WAF4xNQ-1; Tue, 03 Nov 2020 15:31:50 -0500
X-MC-Unique: 9KP-yz5jP3efZO8WAF4xNQ-1
Received: by mail-wm1-f71.google.com with SMTP id c204so241032wmd.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W2xoQMtcZ45M2FDoabAb+oIuMsPmr+LIxDstfsaLsQQ=;
 b=R7egUmCXMWOwNb/F7o9QX2aN0LaRM3peAknagwx3JjtmC/ImEUCYmal0PECM4G6Hbb
 Ow63FkpQnKPXsvC2gp3hvJo/+PanPKFQV6A6YMEhsfybURmd67+X0QHGrx3d5WKKQiZz
 gCuAjhF0g77mbDCbyPqWpIfjoaSfNEbdHC5i3a2IGuU1AY3p66sI5dTEHZ6nHepqOacY
 7XdFl34xlgCqQuuSBK52LoqZ88OB0TcTUhXj/11IOerm7wrpVopIX05VShgFH9s3M7Bf
 CgXyWcIOrQvoB3KWbUpw3fYvTtnlVi65NDqJ4v7UTBkjR3ipqu8mdYN9sgXCAYA9vP1y
 cIeg==
X-Gm-Message-State: AOAM533GnbDt6xiKYVuKS8dllI0TcE0S0ehSQ6bl73uzDsGvTT03Mdbn
 g9Yy61Vw+g7clYtE56mF3KcFSKWim2v6R3cPs3XBwJ1ucFbbV4Kkv0UUWJPqBJQBL/e7DG5Sjz3
 C08lx6f58U9xzlF4=
X-Received: by 2002:adf:e892:: with SMTP id d18mr29946479wrm.103.1604435509316; 
 Tue, 03 Nov 2020 12:31:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5Kal2Q2BqN2crCt7Phj5MtwdE1YSjlg+L4Ckbm8BNES6hH2qy/addHtnYSbGKkq4WxUWSBQ==
X-Received: by 2002:adf:e892:: with SMTP id d18mr29946459wrm.103.1604435509125; 
 Tue, 03 Nov 2020 12:31:49 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x10sm26462274wrp.62.2020.11.03.12.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 12:31:48 -0800 (PST)
Subject: Re: [Qemu-devel] [PULL 09/36] 9p: simplify source file selection
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
 <1566284395-30287-10-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ab9a47b9-8ac5-c8f1-b035-b8b812551b3b@redhat.com>
Date: Tue, 3 Nov 2020 21:31:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1566284395-30287-10-git-send-email-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Cornelia Huck <cohuck@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 8/20/19 8:59 AM, Paolo Bonzini wrote:
> Express the complex conditions in Kconfig rather than Makefiles, since Kconfig
> is better suited at expressing dependencies and detecting contradictions.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Kconfig.host        | 1 +
>  fsdev/Makefile.objs | 2 +-
>  hw/9pfs/Kconfig     | 5 +++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Kconfig.host b/Kconfig.host
> index aec9536..bb6e116 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -28,6 +28,7 @@ config VHOST_USER
>  
>  config XEN
>      bool
> +    select FSDEV_9P if VIRTFS

There is something odd with CONFIG_XEN, as it is used
to select accelerator and hardware.

>  
>  config VIRTFS
>      bool
> diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
> index 24bbb3e..42cd70c 100644
> --- a/fsdev/Makefile.objs
> +++ b/fsdev/Makefile.objs
> @@ -1,6 +1,6 @@
>  # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
>  # only pull in the actual 9p backend if we also enabled virtio or xen.
> -ifeq ($(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN))),y)
> +ifeq ($(CONFIG_FSDEV_9P),y)
>  common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
>  else
>  common-obj-y = qemu-fsdev-dummy.o
> diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
> index 8c5032c..3ae5749 100644
> --- a/hw/9pfs/Kconfig
> +++ b/hw/9pfs/Kconfig
> @@ -1,4 +1,9 @@
> +config FSDEV_9P
> +    bool
> +    depends on VIRTFS

Using "depends on VIRTFS && 9PFS" instead helps to
reduce the link failure using --without-default-devices.

> +
>  config VIRTIO_9P
>      bool
>      default y
>      depends on VIRTFS && VIRTIO
> +    select FSDEV_9P

Here I used "depends on FSDEV_9P && VIRTIO" but this
doesn't look right...

Is it possible to include "config-devices.h" in
hw/xen/xen-legacy-backend.c to use CONFIG_9PFS?

xen_be_register_common() unconditionally calls:

  xen_be_register("9pfs", &xen_9pfs_ops);

As I have no much idea about Xen & 9pfs, I'm a bit
lost here (regarding the dependencies order).

Thanks,

Phil.


