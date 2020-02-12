Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97117C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 03:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612C22073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 03:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiZXcQk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612C22073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1itU-0006Er-Jh
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 22:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j1isr-0005go-Pp
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 22:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j1isp-0004CT-I6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 22:40:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47076
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j1isp-0004B4-9s
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 22:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581478813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1E0Z0wase8qOv1Belxsp5ny7Z5FV1upA2C64aN98yQ=;
 b=QiZXcQk8KQqFpS9K79aVdYfmyMyQ3kDb/zjJapiTElPD0h+hcqpTwCFYR7ELaEmvG1TXKN
 Fax1VffugEcO9Kv82DB94Oy/xmGW9zBe14X8fDl5jqwN0lIpnrstT6/4GfEe+0QNZMq0os
 epfc1Ja49kNPF4GF5YmBLqW9Ulb13OQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-keUBMm_SOAKZuWyVQWB5tA-1; Tue, 11 Feb 2020 22:40:08 -0500
X-MC-Unique: keUBMm_SOAKZuWyVQWB5tA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 481CC1005502;
 Wed, 12 Feb 2020 03:40:07 +0000 (UTC)
Received: from [10.72.13.111] (ovpn-13-111.pek2.redhat.com [10.72.13.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8C0F8ED1B;
 Wed, 12 Feb 2020 03:39:56 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
To: "Michael S. Tsirkin" <mst@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
 <20200211062205-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
Date: Wed, 12 Feb 2020 11:39:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200211062205-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, jing2.liu@linux.intel.com,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/11 =E4=B8=8B=E5=8D=887:33, Michael S. Tsirkin wrote:
> On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
>> From: Liu Jiang<gerry@linux.alibaba.com>
>>
>> The standard virtio-mmio devices use notification register to signal
>> backend. This will cause vmexits and slow down the performance when we
>> passthrough the virtio-mmio devices to guest virtual machines.
>> We proposed to update virtio over MMIO spec to add the per-queue
>> notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM to
>> configure notify location for each queue.
>>
>> [1]https://lkml.org/lkml/2020/1/21/31
>>
>> Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
>> Co-developed-by: Zha Bin<zhabin@linux.alibaba.com>
>> Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
>> Co-developed-by: Jing Liu<jing2.liu@linux.intel.com>
>> Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
>> Co-developed-by: Chao Peng<chao.p.peng@linux.intel.com>
>> Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> Hmm. Any way to make this static so we don't need
> base and multiplier?


E.g page per vq?

Thanks


