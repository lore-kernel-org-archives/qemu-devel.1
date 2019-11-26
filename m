Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC9EC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89C12068E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="hP8MBek+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89C12068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZjkZ-0001No-V8
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jakub.kicinski@netronome.com>) id 1iZhYn-0005YL-BB
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jakub.kicinski@netronome.com>) id 1iZhYj-0003K7-D3
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:35:45 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jakub.kicinski@netronome.com>)
 id 1iZhYd-0003Fj-I2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:35:38 -0500
Received: by mail-lj1-x242.google.com with SMTP id e10so12634942ljj.6
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 12:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netronome-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=K4Bc+8eHqvfcdZUohVg+/Nb9ohh1S05Ow4H5opvoqhk=;
 b=hP8MBek+jIyGLD+HG0jW2xvdPV0teuBv/6k2y1ZOfuFlO/HjwikQPbJcxccaCkY4ca
 gjaTQdQJuJuuDe7KXGd7CHEz647Qh6NX9XAIW3c4Z8FK6pZpjhGsPKjwmxaJVD5IlM/X
 Z5/WxylRjt2WqI7WJW+aZcE6o+zYKjTFcMG7c0n8bOuwNbF7ICmk+Fxg7pHQ7dwDF31l
 NmFxlfLTZZuYjXH9EvJKULzXQ8K11aH69Hhg25nRJk/+Jd3ZLFE+87+CG7Iv/YLiH0r1
 8nEtemUANXF+RxlU+k7p/LnGQqcmKLtW90x47b0ZBqnVjm14VykY0TyefIzMoDaXqk0J
 rZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=K4Bc+8eHqvfcdZUohVg+/Nb9ohh1S05Ow4H5opvoqhk=;
 b=hW0WRMNs1SoP0r5VYDllDSCI8fWPqe3ZiruxCKgVOty9nYhq2nnyUMX0eYuk5vNRRd
 IuD+VJksUgjG+eBsdCvLco6ofpXzuBwx97jx7AxcrzSwWTjcuIK9XtPC4sRiZ+rK9J2T
 Ckwv/P6JY/e/8Lrimsxkph6FcNaNvjKDPCslxFejA4IkxrypL5Cu7Ol/PUcVVK8/CFku
 RkN60su9g7Y4LhWcvp+K+xYYDIAolgi+FwReYdIHDv+AfPvmkDnFOtHsWAR3yu7LFDAx
 qvYg1ZjiUXWCubnOk4x9eZCksdX44qRRJoeUMfUn0GI+hzjxKFkQK4waqEFmTT026QqI
 A3tw==
X-Gm-Message-State: APjAAAU7N8L3P6ZMzgdUmaE1bQqhdZIYzTFqRD1aRqQZqt+EICAssXLv
 xpDL/smUSqyymF6bsNZbIhPenw==
X-Google-Smtp-Source: APXvYqx9IqBt3lkqgKwa8lRqh+EMXV4Z5INEt5vZARRFzhNGU5/ykWOAvkTYwnAGobZix7373gRwCQ==
X-Received: by 2002:a2e:8885:: with SMTP id k5mr11915374lji.98.1574800532208; 
 Tue, 26 Nov 2019 12:35:32 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
 by smtp.gmail.com with ESMTPSA id z127sm5839668lfa.19.2019.11.26.12.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 12:35:31 -0800 (PST)
Date: Tue, 26 Nov 2019 12:35:14 -0800
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Prashant Bhole <prashantbhole.linux@gmail.com>
Subject: Re: [RFC net-next 00/18] virtio_net XDP offload
Message-ID: <20191126123514.3bdf6d6f@cakuba.netronome.com>
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
X-Mailman-Approved-At: Tue, 26 Nov 2019 17:53:42 -0500
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
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 kvm@vger.kernel.org, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andriin@fb.com>, "David S . Miller" <davem@davemloft.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 Nov 2019 19:07:26 +0900, Prashant Bhole wrote:
> Note: This RFC has been sent to netdev as well as qemu-devel lists
> 
> This series introduces XDP offloading from virtio_net. It is based on
> the following work by Jason Wang:
> https://netdevconf.info/0x13/session.html?xdp-offload-with-virtio-net
> 
> Current XDP performance in virtio-net is far from what we can achieve
> on host. Several major factors cause the difference:
> - Cost of virtualization
> - Cost of virtio (populating virtqueue and context switching)
> - Cost of vhost, it needs more optimization
> - Cost of data copy
> Because of above reasons there is a need of offloading XDP program to
> host. This set is an attempt to implement XDP offload from the guest.

This turns the guest kernel into a uAPI proxy.

BPF uAPI calls related to the "offloaded" BPF objects are forwarded 
to the hypervisor, they pop up in QEMU which makes the requested call
to the hypervisor kernel. Today it's the Linux kernel tomorrow it may 
be someone's proprietary "SmartNIC" implementation.

Why can't those calls be forwarded at the higher layer? Why do they
have to go through the guest kernel?

If kernel performs no significant work (or "adds value", pardon the
expression), and problem can easily be solved otherwise we shouldn't 
do the work of maintaining the mechanism.

The approach of kernel generating actual machine code which is then
loaded into a sandbox on the hypervisor/SmartNIC is another story.

I'd appreciate if others could chime in.

