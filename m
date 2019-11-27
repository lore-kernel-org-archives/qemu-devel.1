Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47141C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 23:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6122051A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 23:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="EyY2nlfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6122051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia6wI-0004vi-6n
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 18:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jakub.kicinski@netronome.com>) id 1ia6vL-0004By-7a
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jakub.kicinski@netronome.com>) id 1ia6vJ-0000Kf-5q
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:40:43 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jakub.kicinski@netronome.com>)
 id 1ia6vF-0000HL-1s
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:40:37 -0500
Received: by mail-lf1-x143.google.com with SMTP id f16so18565902lfm.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 15:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netronome-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=p7axeNoTAof088gM7pzbSHLI6Q/IQavsCGxKE7DXG/U=;
 b=EyY2nlfReMtFjJhWIYjXR2lZFGKN4Zxf+p2xXXwuUeYE/thGc7BcZYIsa+r4Hf8mnd
 TKBLZ15GD+6CKe2qkfeSo8KkpsN3/rUtvJtEycKFhjcs67kO0LTOGnGXVSE+jOJFLVv/
 WS6LWthjkpLLyBqJO/TZ3sQbkxjzULIuN6tVh9rUJf31RKjLaVvoD0RaqL6pzbADkd8j
 aakeWcKVvnSeZKIKXqRh3zjZi5ERGoFEoIRXukGrxQY+JQmiTGZ65UM3qocrIYOstl27
 FWYyWPDSKnQE/qyeeZFSrEdRD3IxCnNqDoeoI/h0GPmcnmsjUUeWu7xpf2+CCuPQDiUc
 7XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=p7axeNoTAof088gM7pzbSHLI6Q/IQavsCGxKE7DXG/U=;
 b=DBzwl5RNNYzN1caDzicKFaoxBraPu+kMq3Vj5F1K1jIdRAxV/V5cZY70pZd57abpfZ
 BIrqROqh6kDQB4yt5kJuCqmqVEUL26chCyZMBl9YwZ/ZCxKolgNXe9hCUih3pHVLfine
 styCdvOLo8LUdFC7SAIncqGDip9ktJxPoZwhCPfHbdNQp1RoLXBwfrbXE/8LXE76RafJ
 USA1GDa/1Os5vXHL4j6uFOpr1uHIQJ9B6iWCeArXogq6nQGQHP7Y3dwU5xkMR2THTdKr
 TexOkRkiwlE6R1+ITN+x6JnUhshbsan0C4qohXuSSMq+p/gmn1lMQT7AWiES95v7kRGe
 fUPw==
X-Gm-Message-State: APjAAAX4dp/miTbIVjCr/JCYt/kLFMiUW+bdOzJHNWtLtycoXHJGK2hx
 XKzjvWDVCqUgViry806vuFqT0w==
X-Google-Smtp-Source: APXvYqxHUECno26xNrBVPfFt+5AMB/6kpfKtdY093O3UHDC9X/C0eO6xU3lDRl+QXYtjPWxzJz4u4Q==
X-Received: by 2002:a19:e343:: with SMTP id c3mr4626704lfk.192.1574898033168; 
 Wed, 27 Nov 2019 15:40:33 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
 by smtp.gmail.com with ESMTPSA id q13sm317527ljc.17.2019.11.27.15.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 15:40:32 -0800 (PST)
Date: Wed, 27 Nov 2019 15:40:14 -0800
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC net-next 00/18] virtio_net XDP offload
Message-ID: <20191127154014.2b91ecc2@cakuba.netronome.com>
In-Reply-To: <20191127152653-mutt-send-email-mst@kernel.org>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126123514.3bdf6d6f@cakuba.netronome.com>
 <20191127152653-mutt-send-email-mst@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org,
 netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 Nov 2019 15:32:17 -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 26, 2019 at 12:35:14PM -0800, Jakub Kicinski wrote:
> > On Tue, 26 Nov 2019 19:07:26 +0900, Prashant Bhole wrote:  
> > > Note: This RFC has been sent to netdev as well as qemu-devel lists
> > > 
> > > This series introduces XDP offloading from virtio_net. It is based on
> > > the following work by Jason Wang:
> > > https://netdevconf.info/0x13/session.html?xdp-offload-with-virtio-net
> > > 
> > > Current XDP performance in virtio-net is far from what we can achieve
> > > on host. Several major factors cause the difference:
> > > - Cost of virtualization
> > > - Cost of virtio (populating virtqueue and context switching)
> > > - Cost of vhost, it needs more optimization
> > > - Cost of data copy
> > > Because of above reasons there is a need of offloading XDP program to
> > > host. This set is an attempt to implement XDP offload from the guest.  
> > 
> > This turns the guest kernel into a uAPI proxy.
> > 
> > BPF uAPI calls related to the "offloaded" BPF objects are forwarded 
> > to the hypervisor, they pop up in QEMU which makes the requested call
> > to the hypervisor kernel. Today it's the Linux kernel tomorrow it may 
> > be someone's proprietary "SmartNIC" implementation.
> > 
> > Why can't those calls be forwarded at the higher layer? Why do they
> > have to go through the guest kernel?  
> 
> Well everyone is writing these programs and attaching them to NICs.

Who's everyone?

> For better or worse that's how userspace is written.

HW offload requires modifying the user space, too. The offload is not
transparent. Do you know that?

> Yes, in the simple case where everything is passed through, it could
> instead be passed through some other channel just as well, but then
> userspace would need significant changes just to make it work with
> virtio.

There is a recently spawned effort to create an "XDP daemon" or
otherwise a control application which would among other things link
separate XDP apps to share a NIC attachment point.

Making use of cloud APIs would make a perfect addition to that.

Obviously if one asks a kernel guy to solve a problem one'll get kernel
code as an answer. And writing higher layer code requires companies to
actually organize their teams and have "full stack" strategies.

We've seen this story already with net_failover wart. At least that
time we weren't risking building a proxy to someone's proprietary FW.

> > If kernel performs no significant work (or "adds value", pardon the
> > expression), and problem can easily be solved otherwise we shouldn't 
> > do the work of maintaining the mechanism.
> > 
> > The approach of kernel generating actual machine code which is then
> > loaded into a sandbox on the hypervisor/SmartNIC is another story.  
> 
> But that's transparent to guest userspace. Making userspace care whether
> it's a SmartNIC or a software device breaks part of virtualization's
> appeal, which is that it looks like a hardware box to the guest.

It's not hardware unless you JITed machine code for it, it's just
someone else's software.

I'm not arguing with the appeal. I'm arguing the risk/benefit ratio
doesn't justify opening this can of worms.

> > I'd appreciate if others could chime in.  

