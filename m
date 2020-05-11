Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B65C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 04:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEDE2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 04:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkXcM4SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEDE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXziP-0005Cj-GC
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 00:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXzhY-00047b-02
 for qemu-devel@nongnu.org; Mon, 11 May 2020 00:06:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47648
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXzhX-0004m8-2D
 for qemu-devel@nongnu.org; Mon, 11 May 2020 00:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589169958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdEK0G69R+GT8rpZxsC1oYXopxGpnZEFGxjbXS7n+HE=;
 b=DkXcM4SIHw/41gwdj6b8NSrg7DoQk6NH+eiI04jE/a9Lt2kni1nLZTt3v/IRB0nCvWe0cb
 lyt42cq5EpPKSM8xA+i2s3dQuEoWMngxKSDMeLn03/xhSB1dlt2pWR9EIugjLYbnvgy0vt
 1gKwVgolIXaNjxAvqgaSM19NLDB/8PA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-PqTqIbl-OU-iKWbRjy3zSg-1; Mon, 11 May 2020 00:05:50 -0400
X-MC-Unique: PqTqIbl-OU-iKWbRjy3zSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0424080B70D;
 Mon, 11 May 2020 04:05:50 +0000 (UTC)
Received: from [10.72.12.137] (ovpn-12-137.pek2.redhat.com [10.72.12.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B1E55C1D2;
 Mon, 11 May 2020 04:05:42 +0000 (UTC)
Subject: Re: Assertion Failure in virtio_net_reset
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200511025956.uojost3s6vxcecdf@mozz.bu.edu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9d67b5a1-d566-96e6-a057-491263574de9@redhat.com>
Date: Mon, 11 May 2020 12:05:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511025956.uojost3s6vxcecdf@mozz.bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/11 =E4=B8=8A=E5=8D=8810:59, Alexander Bulekov wrote:
> Hello,
> While fuzzing, I found an input that triggers an assertion failure in
> virtio-net.c:
>
> hw/net/virtio-net.c:533: void virtio_net_reset(VirtIODevice *): Assertion=
 `!virtio_net_get_subqueue(nc)->async_tx.elem' failed.
>
> #9 0x55a33fa31b78 in virtio_net_reset hw/net/virtio-net.c:533:13
> #10 0x55a33fc88412 in virtio_reset hw/virtio/virtio.c:1919:9
> #11 0x55a341d82764 in virtio_bus_reset hw/virtio/virtio-bus.c:95:9
> #12 0x55a341dba2de in virtio_pci_reset hw/virtio/virtio-pci.c:1824:5
> #13 0x55a341db3e02 in virtio_pci_common_write hw/virtio/virtio-pci.c:1252=
:13
> #14 0x55a33f62117b in memory_region_write_accessor memory.c:496:5
> #15 0x55a33f6205e4 in access_with_adjusted_size memory.c:557:18
> #16 0x55a33f61e177 in memory_region_dispatch_write memory.c:1488:16
>
> I can reproduce it in a qemu 5.0 build using:
> cat << EOF | qemu-system-i386 -M pc-q35-5.0 -netdev user,id=3Dqtest-bn0 -=
device virtio-net-pci,netdev=3Dqtest-bn0 -display none -nodefaults -nograph=
ic -qtest stdio
> outl 0xcf8 0x80000820
> outl 0xcfc 0xe0004000
> outl 0xcf8 0x80000824
> outl 0xcfc 0xc021
> outl 0xcf8 0x80000804
> outw 0xcfc 0x7
> outl 0xcf8 0x8000089a
> write 0xc021e0004016 0x16 0x0100000000ff4f000100cd003d00000000000000f600
> write 0x3d00d8 0xae 0x0100007a000a00000000000d00840100007a000a00000000000=
f00840100007a000a00000000001100840100007a000a00000000001300840100007a000a00=
000000001500840100007a000a00000000001700840100007a000a000000000019008401000=
07a000a00000000001b00840100007a000a00000000001d00840100007a000a00000000001f=
00840100007a000a00000000002100840100007a000a00000000002300840100007a000a
> write 0xf60002 0x7 0x0a00000000000b
> write 0xc021e0004014 0x9 0x95a4b3c2d1e0effe0d
> write 0xc021e0004014 0x2a3 0x00000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000
> EOF
>
> I also uploaded the above trace, in case the formatting is broken:
>
> curl https://paste.debian.net/plain/1146086 | qemu-system-i386 -M pc-q35-=
5.0 -netdev user,id=3Dqtest-bn0 -device virtio-net-pci,netdev=3Dqtest-bn0 -=
display none -nodefaults -nographic -qtest stdio
>
> Please let me know if I can provide any further info.
> -Alex


I post a patch which seems to fix this issue.

Please have a look and try.

Thanks


>


