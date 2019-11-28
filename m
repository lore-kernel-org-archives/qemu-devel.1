Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3DFC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D8F215F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAXwqhLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D8F215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaBHU-0006wo-QG
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 23:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iaBGS-0006Cd-Lk
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iaBGP-0007Ao-QU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:18:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24772
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iaBGP-000792-Bg
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574914724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZHfnpUHMVQfOJML2Ic3SHu+PaQ/ZeBlsp9ffMkTs9Y=;
 b=AAXwqhLG/0/IFUx+xHPdH0jQK3kErsj9rL48Etk6vXa8jaLGVpzfIk0Q4ZdaQ7nDX7E5ay
 W0siSLKLQV519yNYTO5yNe5GfdjTUPuez+zu8C1IemT1c0631wPwXILLMSCWvyv8EMBeHx
 BRU+fOMY2zV4/9svyIS6Nt3uPVSt8Vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-phLk_qt-Pc6H7_DN1poGOw-1; Wed, 27 Nov 2019 23:18:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04631184CAA1;
 Thu, 28 Nov 2019 04:18:39 +0000 (UTC)
Received: from [10.72.12.231] (ovpn-12-231.pek2.redhat.com [10.72.12.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 114B1100164D;
 Thu, 28 Nov 2019 04:18:22 +0000 (UTC)
Subject: Re: [RFC net-next 00/18] virtio_net XDP offload
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126123514.3bdf6d6f@cakuba.netronome.com>
 <20191128033255.r66d4zedmhudeaa6@ast-mbp.dhcp.thefacebook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c6c6ca98-8793-5510-ad24-583e25403e35@redhat.com>
Date: Thu, 28 Nov 2019 12:18:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191128033255.r66d4zedmhudeaa6@ast-mbp.dhcp.thefacebook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: phLk_qt-Pc6H7_DN1poGOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 qemu-devel@nongnu.org, Alexei Starovoitov <ast@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/11/28 =E4=B8=8A=E5=8D=8811:32, Alexei Starovoitov wrote:
> On Tue, Nov 26, 2019 at 12:35:14PM -0800, Jakub Kicinski wrote:
>> I'd appreciate if others could chime in.
> The performance improvements are quite appealing.
> In general offloading from higher layers into lower layers is necessary l=
ong term.
>
> But the approach taken by patches 15 and 17 is a dead end. I don't see ho=
w it
> can ever catch up with the pace of bpf development.


This applies for any hardware offloading features, isn't it?


>   As presented this approach
> works for the most basic programs and simple maps. No line info, no BTF, =
no
> debuggability. There are no tail_calls either.


If I understand correctly, neither of above were implemented in NFP. We=20
can collaborate to find solution for all of those.


>   I don't think I've seen a single
> production XDP program that doesn't use tail calls.


It looks to me we can manage to add this support.


> Static and dynamic linking
> is coming. Wraping one bpf feature at a time with virtio api is never goi=
ng to
> be complete.


It's a common problem for hardware that want to implement eBPF=20
offloading, not a virtio specific one.


> How FDs are going to be passed back? OBJ_GET_INFO_BY_FD ?
> OBJ_PIN/GET ? Where bpffs is going to live ?


If we want pinning work in the case of virt, it should live in both host=20
and guest probably.


>   Any realistic XDP application will
> be using a lot more than single self contained XDP prog with hash and arr=
ay
> maps.


It's possible if we want to use XDP offloading to accelerate VNF which=20
often has simple logic.


> It feels that the whole sys_bpf needs to be forwarded as a whole from
> guest into host. In case of true hw offload the host is managing HW. So i=
t
> doesn't forward syscalls into the driver. The offload from guest into hos=
t is
> different. BPF can be seen as a resource that host provides and guest ker=
nel
> plus qemu would be forwarding requests between guest user space and host
> kernel. Like sys_bpf(BPF_MAP_CREATE) can passthrough into the host direct=
ly.
> The FD that hosts sees would need a corresponding mirror FD in the guest.=
 There
> are still questions about bpffs paths, but the main issue of
> one-feature-at-a-time will be addressed in such approach.


We try to follow what NFP did by starting from a fraction of the whole=20
eBPF features. It would be very hard to have all eBPF features=20
implemented from the start.=C2=A0 It would be helpful to clarify what's the=
=20
minimal set of features that you want to have from the start.


> There could be other
> solutions, of course.
>
>

Suggestions are welcomed.

Thanks


