Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123A3C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 20:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D190E2158C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 20:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1ekSSoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D190E2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia40n-0008It-0x
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 15:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ia3zN-0007eq-U4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ia3zK-0001pI-3B
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:32:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ia3zF-0001j6-SU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574886749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zH/T5jU4tH/8Gb+1qmuFB+rSdeHGBSoJ0BA6rM2mcnc=;
 b=S1ekSSoONW6WJ38wUMM7o0k/VTEavatvgWPE/oNWWSnrxmz+I8CqgKLZP24neXT74HScJG
 UrrAddVG7awCIO+vxSQB82T1uFxagtnd7Y4Kr743RqkaS24UxO+uNdCUQb8WLcwu2HzD2k
 28BTKeztYyKCBEU0aqbVYBX5tUN4A7g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-DsfRQc8dMnyBKbjVSs3vBQ-1; Wed, 27 Nov 2019 15:32:25 -0500
Received: by mail-qv1-f69.google.com with SMTP id b6so15615065qvo.4
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 12:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7MY+sx+Nuv189evu6jc/7Ff6+j+qSUxD3qsuDjudl3E=;
 b=eh/15nz/CB7cF/Tt0HYVB+TU3yOXw/+aa/aqpIXsIXLKfv1ZuuBM8k9KFmZCWwH0Gq
 CiH1qTZLCDgwbmr26cfB+O20WLBz4ZelCg9GI4DrguBLFhkMXY6Gw6yNeVXhqmlIsBli
 ByFf4HpeKuqcNlVw8sRL/6URQtV0CfMOfD6exKeFWqgEJH5RcX867Y0h8/ExDIGLbmnk
 baHrK1feP+b9FwSqV1JX8bNl23ve3uop/eDmzdLKw7Xw2kDW1bB8610NuGCtvQkd8fUw
 1L8Q/wz2Ql7U/fPM6a8rvgVCMXJa6LW9iR6xdSYWF5hoWstSXAA1l3gLdvKpklFj0/pa
 /BJg==
X-Gm-Message-State: APjAAAWxZqpR+hg7iVX/1MIXWIeDUX5/bBGAhsTHjX4NqOTFN3owjnDu
 C+Qs555UwqynIjQ85KIp1dY8epFO4lh31/q8TtqT8bBxvN/CsR+MG10cX+sQ4wguWDamOJRNQM4
 DUfLDzZF/scY1gSw=
X-Received: by 2002:ad4:55e8:: with SMTP id bu8mr3198581qvb.61.1574886745491; 
 Wed, 27 Nov 2019 12:32:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOaXOFxvrAACGTJt/FeYHy85AqcOBKnTlQND1DqS/Jm+RE0uTl1tA+4+iDEbGw4t6w2fwm7A==
X-Received: by 2002:ad4:55e8:: with SMTP id bu8mr3198538qvb.61.1574886745141; 
 Wed, 27 Nov 2019 12:32:25 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id o70sm7418083qke.47.2019.11.27.12.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 12:32:24 -0800 (PST)
Date: Wed, 27 Nov 2019 15:32:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [RFC net-next 00/18] virtio_net XDP offload
Message-ID: <20191127152653-mutt-send-email-mst@kernel.org>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126123514.3bdf6d6f@cakuba.netronome.com>
MIME-Version: 1.0
In-Reply-To: <20191126123514.3bdf6d6f@cakuba.netronome.com>
X-MC-Unique: DsfRQc8dMnyBKbjVSs3vBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Tue, Nov 26, 2019 at 12:35:14PM -0800, Jakub Kicinski wrote:
> On Tue, 26 Nov 2019 19:07:26 +0900, Prashant Bhole wrote:
> > Note: This RFC has been sent to netdev as well as qemu-devel lists
> >=20
> > This series introduces XDP offloading from virtio_net. It is based on
> > the following work by Jason Wang:
> > https://netdevconf.info/0x13/session.html?xdp-offload-with-virtio-net
> >=20
> > Current XDP performance in virtio-net is far from what we can achieve
> > on host. Several major factors cause the difference:
> > - Cost of virtualization
> > - Cost of virtio (populating virtqueue and context switching)
> > - Cost of vhost, it needs more optimization
> > - Cost of data copy
> > Because of above reasons there is a need of offloading XDP program to
> > host. This set is an attempt to implement XDP offload from the guest.
>=20
> This turns the guest kernel into a uAPI proxy.
>=20
> BPF uAPI calls related to the "offloaded" BPF objects are forwarded=20
> to the hypervisor, they pop up in QEMU which makes the requested call
> to the hypervisor kernel. Today it's the Linux kernel tomorrow it may=20
> be someone's proprietary "SmartNIC" implementation.
>=20
> Why can't those calls be forwarded at the higher layer? Why do they
> have to go through the guest kernel?

Well everyone is writing these programs and attaching them to NICs.

For better or worse that's how userspace is written.

Yes, in the simple case where everything is passed through, it could
instead be passed through some other channel just as well, but then
userspace would need significant changes just to make it work with
virtio.



> If kernel performs no significant work (or "adds value", pardon the
> expression), and problem can easily be solved otherwise we shouldn't=20
> do the work of maintaining the mechanism.
>=20
> The approach of kernel generating actual machine code which is then
> loaded into a sandbox on the hypervisor/SmartNIC is another story.

But that's transparent to guest userspace. Making userspace care whether
it's a SmartNIC or a software device breaks part of virtualization's
appeal, which is that it looks like a hardware box to the guest.

> I'd appreciate if others could chime in.


