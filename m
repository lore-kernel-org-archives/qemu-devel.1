Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC553C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FF4215F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKQtPlN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FF4215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaAYu-0003sv-Ot
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 22:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexei.starovoitov@gmail.com>) id 1iaAYB-0003K4-V2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexei.starovoitov@gmail.com>) id 1iaAYA-0004pn-MH
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:33:03 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexei.starovoitov@gmail.com>)
 id 1iaAYA-0004lq-B2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:33:02 -0500
Received: by mail-pj1-x1041.google.com with SMTP id v93so7950541pjb.6
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 19:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VZufOeI6EHnATdk+crGenMQXH1a1O/8tB/n0iGNLkV8=;
 b=dKQtPlN91MNy87OySN9B18nRHCSvt9bTQlxOGxhPhkhLnRVVYy630ue5Ia/NYZnKTS
 BM3QmJpHmWoi5B+VzPN8eAGyQBqBURKxfWpCMq4dVNHg2zDFOtMbh6hnIyQY/72vI4OB
 Vz8OM7iimW4JCTrBO8pcHIqPm/IAukMHlWDJE5P2sp+jIGvVXAc2t1ewEPfyjxuQTOnj
 inGA002wU5as6GPAhKBzVr/pMjMwPEmA6Hv3XKNCMoEGLAkG4lpZ9c1R02aDQy4rgibK
 h+0cijupCMC+UVfsbSL86wxmKi86P5WMLRISxyLfYE9x2fvwmYpBZQ6GbUhBxgG6vLR+
 0Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VZufOeI6EHnATdk+crGenMQXH1a1O/8tB/n0iGNLkV8=;
 b=i5qA41VXeJASniDSYr1IjvU7enGpK5O6rnB0r3vcPGTP1z4EUeWEIdzoARbKSFmb2l
 KXcu2PCikXFLAqL41OalJxk7KuOuriU2ti1wcg3FwWmZAqhMKr7RhlVwfZ1qGGlTWj2Y
 X8oV9SZz4VvRuBOY515BwYnnoB0GkC16CppWo3XgLNecC8jF+lGOXtf8XEHufwFbH5ro
 tlCjIMFsHoiWvx8s/mjgEkoLmJYWyWTV9EfQwbH6/yb+moBmeRlfW9Xj7VrhVb+k2XR0
 0M4VkdK3+rQL57fJy0baahj4fFrTeB9F+AjmZfNDm5Q82w4PHI2Onz/K+Av+zyOnWe+b
 9W4Q==
X-Gm-Message-State: APjAAAVNS2F8jKjUlSuMn/3NUzdhpCdUZHCiaAe8oztP40lbfAqhgBM6
 JTTIX5pA3mdqy9VYGZBtYbU=
X-Google-Smtp-Source: APXvYqxribCE1N5toVJebzazASUvHWYS7YA66p7nDo+H1p+nZMKgBJT3LsQrl8bmwxM+QDhzryBd5Q==
X-Received: by 2002:a17:902:8a8e:: with SMTP id
 p14mr7493221plo.72.1574911979995; 
 Wed, 27 Nov 2019 19:32:59 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::faaf])
 by smtp.gmail.com with ESMTPSA id t8sm2932493pjg.17.2019.11.27.19.32.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Nov 2019 19:32:59 -0800 (PST)
Date: Wed, 27 Nov 2019 19:32:57 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [RFC net-next 00/18] virtio_net XDP offload
Message-ID: <20191128033255.r66d4zedmhudeaa6@ast-mbp.dhcp.thefacebook.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126123514.3bdf6d6f@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126123514.3bdf6d6f@cakuba.netronome.com>
User-Agent: NeoMutt/20180223
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 12:35:14PM -0800, Jakub Kicinski wrote:
> 
> I'd appreciate if others could chime in.

The performance improvements are quite appealing.
In general offloading from higher layers into lower layers is necessary long term.

But the approach taken by patches 15 and 17 is a dead end. I don't see how it
can ever catch up with the pace of bpf development. As presented this approach
works for the most basic programs and simple maps. No line info, no BTF, no
debuggability. There are no tail_calls either. I don't think I've seen a single
production XDP program that doesn't use tail calls. Static and dynamic linking
is coming. Wraping one bpf feature at a time with virtio api is never going to
be complete. How FDs are going to be passed back? OBJ_GET_INFO_BY_FD ?
OBJ_PIN/GET ? Where bpffs is going to live ? Any realistic XDP application will
be using a lot more than single self contained XDP prog with hash and array
maps. It feels that the whole sys_bpf needs to be forwarded as a whole from
guest into host. In case of true hw offload the host is managing HW. So it
doesn't forward syscalls into the driver. The offload from guest into host is
different. BPF can be seen as a resource that host provides and guest kernel
plus qemu would be forwarding requests between guest user space and host
kernel. Like sys_bpf(BPF_MAP_CREATE) can passthrough into the host directly.
The FD that hosts sees would need a corresponding mirror FD in the guest. There
are still questions about bpffs paths, but the main issue of
one-feature-at-a-time will be addressed in such approach. There could be other
solutions, of course.


