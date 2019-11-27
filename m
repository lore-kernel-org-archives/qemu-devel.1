Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AFFC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 03:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBB42075C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 03:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDKPk1l7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBB42075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZnaR-0003MM-DU
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 22:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iZnYa-0002pR-VK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 21:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iZnYX-00034y-W7
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 21:59:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32744
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iZnYX-00034Q-IX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 21:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574823592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ji+yJ67I1Iom1aOBlNKpqsHp/9zBaJttE1QcdwF472w=;
 b=dDKPk1l78yxYwYAQfpwNPq+HVNp7O+6btBZALtirF0wCVnSuMihLhWtYwDtsI4FepBMwW0
 BPuWi5dG57x2EIckb0NqE7+Y6Wad8ugpIFd37m2BfyEWHFuurlI6nPQrbk21mqI6a9i+su
 GNaUeydUwaX+p9I0HwhBz/OUBkbooo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-QZJ9ioGoMDiPTagYvj_0zw-1; Tue, 26 Nov 2019 21:59:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5DD0593A1;
 Wed, 27 Nov 2019 02:59:46 +0000 (UTC)
Received: from [10.72.12.237] (ovpn-12-237.pek2.redhat.com [10.72.12.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA93C19C7F;
 Wed, 27 Nov 2019 02:59:38 +0000 (UTC)
Subject: Re: [RFC net-next 00/18] virtio_net XDP offload
To: Jakub Kicinski <jakub.kicinski@netronome.com>,
 Prashant Bhole <prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126123514.3bdf6d6f@cakuba.netronome.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <48cec928-871f-3f50-e99f-c6a6d124cf4c@redhat.com>
Date: Wed, 27 Nov 2019 10:59:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191126123514.3bdf6d6f@cakuba.netronome.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: QZJ9ioGoMDiPTagYvj_0zw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 qemu-devel@nongnu.org, Alexei Starovoitov <ast@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jakub:

On 2019/11/27 =E4=B8=8A=E5=8D=884:35, Jakub Kicinski wrote:
> On Tue, 26 Nov 2019 19:07:26 +0900, Prashant Bhole wrote:
>> Note: This RFC has been sent to netdev as well as qemu-devel lists
>>
>> This series introduces XDP offloading from virtio_net. It is based on
>> the following work by Jason Wang:
>> https://netdevconf.info/0x13/session.html?xdp-offload-with-virtio-net
>>
>> Current XDP performance in virtio-net is far from what we can achieve
>> on host. Several major factors cause the difference:
>> - Cost of virtualization
>> - Cost of virtio (populating virtqueue and context switching)
>> - Cost of vhost, it needs more optimization
>> - Cost of data copy
>> Because of above reasons there is a need of offloading XDP program to
>> host. This set is an attempt to implement XDP offload from the guest.
> This turns the guest kernel into a uAPI proxy.
>
> BPF uAPI calls related to the "offloaded" BPF objects are forwarded
> to the hypervisor, they pop up in QEMU which makes the requested call
> to the hypervisor kernel. Today it's the Linux kernel tomorrow it may
> be someone's proprietary "SmartNIC" implementation.
>
> Why can't those calls be forwarded at the higher layer? Why do they
> have to go through the guest kernel?


I think doing forwarding at higher layer have the following issues:

- Need a dedicated library (probably libbpf) but application may choose=20
to do eBPF syscall directly
- Depends on guest agent to work
- Can't work for virtio-net hardware, since it still requires a hardware=20
interface for carrying=C2=A0 offloading information
- Implement at the level of kernel may help for future extension like=20
BPF object pinning and eBPF helper etc.

Basically, this series is trying to have an implementation of=20
transporting eBPF through virtio, so it's not necessarily a guest to=20
host but driver and device. For device, it could be either a virtual one=20
(as done in qemu) or a real hardware.


>
> If kernel performs no significant work (or "adds value", pardon the
> expression), and problem can easily be solved otherwise we shouldn't
> do the work of maintaining the mechanism.


My understanding is that it should not be much difference compared to=20
other offloading technology.


>
> The approach of kernel generating actual machine code which is then
> loaded into a sandbox on the hypervisor/SmartNIC is another story.


We've considered such way, but actual machine code is not as portable as=20
eBPF bytecode consider we may want:

- Support migration
- Further offload the program to smart NIC (e.g through macvtap=20
passthrough mode etc).

Thanks


> I'd appreciate if others could chime in.
>


