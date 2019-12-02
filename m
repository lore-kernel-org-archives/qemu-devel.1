Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1130C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0A82146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4pNHGee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0A82146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibbmE-0008LO-TO
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 21:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1ibblB-0007Sr-Jb
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1ibblA-0002tP-J7
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:48:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31267
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ibblA-0002t2-Fe
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575254904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eh/9LsFVVQglnm+8EHAX4r6c+/8Racl9Vyp+86QvbXA=;
 b=d4pNHGeebLPpDfnP6f9a3TtB5btRk3Q0Cf2Knhu8vyNcdVyMcpfUnZhf+2BLdnpkg/JSVp
 sAzUyUx45LvYUSFPUnQj8lvDN8VqCVrmwQMPYwSF9Xd4eW7iLCfdDP2R3lf9+JRau03iDj
 f80SJt1D5hAUVj6pwsqIMPjyCR9D17A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-fJPv4qOmNWG83CNuMLfuMA-1; Sun, 01 Dec 2019 21:48:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C59FA107ACC5;
 Mon,  2 Dec 2019 02:48:18 +0000 (UTC)
Received: from [10.72.12.226] (ovpn-12-226.pek2.redhat.com [10.72.12.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9017B5D9CA;
 Mon,  2 Dec 2019 02:48:08 +0000 (UTC)
Subject: Re: [RFC net-next 00/18] virtio_net XDP offload
To: David Ahern <dsahern@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126123514.3bdf6d6f@cakuba.netronome.com>
 <20191128033255.r66d4zedmhudeaa6@ast-mbp.dhcp.thefacebook.com>
 <c6c6ca98-8793-5510-ad24-583e25403e35@redhat.com>
 <0aa6a69a-0bbe-e0fc-1e18-2114adb18c51@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c5d567f9-9926-8fbb-5bc7-9cccca658108@redhat.com>
Date: Mon, 2 Dec 2019 10:48:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0aa6a69a-0bbe-e0fc-1e18-2114adb18c51@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: fJPv4qOmNWG83CNuMLfuMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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


On 2019/12/2 =E4=B8=8A=E5=8D=8812:54, David Ahern wrote:
> On 11/27/19 10:18 PM, Jason Wang wrote:
>> We try to follow what NFP did by starting from a fraction of the whole
>> eBPF features. It would be very hard to have all eBPF features
>> implemented from the start.=C2=A0 It would be helpful to clarify what's =
the
>> minimal set of features that you want to have from the start.
> Offloading guest programs needs to prevent a guest XDP program from
> running bpf helpers that access host kernel data. e.g., bpf_fib_lookup


Right, so we probably need a new type of eBPF program on the host and=20
filter out the unsupported helpers there.

Thanks


>


