Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F7DC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0206A206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlzZFuHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0206A206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1nnp-0004ec-2d
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 03:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j1nmx-0003x2-RO
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j1nmv-00075c-Sw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:54:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46032
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j1nmv-000750-IT
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581497668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b86iE6BxA4OzviDRaOusy5saIH2IrYs+ZfbxDb3OuWI=;
 b=GlzZFuHS33VmlykFgkvo66oek3XJM4DV2Y8A7q0U2iehJg6Rfrd/HFJXCUJwFaqw0YPegW
 smb+DNg23TGtws8rwkESXfjOfuf23LFOoFmd1aXCtH+wkGRVUnQ1QQIEOkPPo035UkfoUB
 5Xh1AfB0kw9b5rkgjPx1s0yS+Pbup58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-6_6tteevMuG1hUBHC_f7yw-1; Wed, 12 Feb 2020 03:54:23 -0500
X-MC-Unique: 6_6tteevMuG1hUBHC_f7yw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C57FC10054E3;
 Wed, 12 Feb 2020 08:54:21 +0000 (UTC)
Received: from [10.72.13.111] (ovpn-13-111.pek2.redhat.com [10.72.13.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A26E5C1B2;
 Wed, 12 Feb 2020 08:53:52 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
 <20200211062205-mutt-send-email-mst@kernel.org>
 <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
 <20200212024158-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d4eb9cde-5d06-3df9-df28-15378a9c6929@redhat.com>
Date: Wed, 12 Feb 2020 16:53:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200212024158-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/12 =E4=B8=8B=E5=8D=884:18, Michael S. Tsirkin wrote:
> On Wed, Feb 12, 2020 at 11:39:54AM +0800, Jason Wang wrote:
>> On 2020/2/11 =E4=B8=8B=E5=8D=887:33, Michael S. Tsirkin wrote:
>>> On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>
>>>> The standard virtio-mmio devices use notification register to signal
>>>> backend. This will cause vmexits and slow down the performance when =
we
>>>> passthrough the virtio-mmio devices to guest virtual machines.
>>>> We proposed to update virtio over MMIO spec to add the per-queue
>>>> notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM t=
o
>>>> configure notify location for each queue.
>>>>
>>>> [1]https://lkml.org/lkml/2020/1/21/31
>>>>
>>>> Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
>>>> Co-developed-by: Zha Bin<zhabin@linux.alibaba.com>
>>>> Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
>>>> Co-developed-by: Jing Liu<jing2.liu@linux.intel.com>
>>>> Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
>>>> Co-developed-by: Chao Peng<chao.p.peng@linux.intel.com>
>>>> Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
>>> Hmm. Any way to make this static so we don't need
>>> base and multiplier?
>> E.g page per vq?
>>
>> Thanks
> Problem is, is page size well defined enough?
> Are there cases where guest and host page sizes differ?
> I suspect there might be.


Right, so it looks better to keep base and multiplier, e.g for vDPA.


>
> But I also think this whole patch is unproven. Is someone actually
> working on QEMU code to support pass-trough of virtio-pci
> as virtio-mmio for nested guests? What's the performance
> gain like?


I don't know.

Thanks


>
> -- MST


