Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9388C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90110206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSyrqQib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90110206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxTP-0004g5-M4
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1ihxSg-00049H-Sn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1ihxSe-00010F-Gx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:11:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1ihxSe-0000vz-9o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576768291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7czjTp7x/yiEPS+02pmTgXC092Pnw48urUtOrypPCw=;
 b=NSyrqQibvnj+RzrqnKWKPOfiiIYP2qWJbpyHkvz88uQUor3z7qOs1e4JbRKkSKTiYH3tsA
 E9IJ/gcM2WLC7FfbCXqQ+sBt192SO5CppLXFwzdhVsoMCE4WgnarxOdljpkwQfDpd3me47
 XNjjYPDv2VG19H+J9iH1R9oXjXLZJh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-siBpZ25pOpiIhqluqGxtgg-1; Thu, 19 Dec 2019 10:11:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59CC910C6229;
 Thu, 19 Dec 2019 15:11:24 +0000 (UTC)
Received: from [10.40.204.155] (ovpn-204-155.brq.redhat.com [10.40.204.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEC1669416;
 Thu, 19 Dec 2019 15:11:22 +0000 (UTC)
Subject: Re: [PATCH v4 21/24] nvme: support multiple namespaces
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130948eucas1p2cfed0da65071fd76446daecbb217e86e@eucas1p2.samsung.com>
 <20191219130921.309264-22-k.jensen@samsung.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <6f2fe19f-c832-032a-e898-cbe385f709ac@redhat.com>
Date: Thu, 19 Dec 2019 16:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191219130921.309264-22-k.jensen@samsung.com>
Content-Language: sk-SK
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: siBpZ25pOpiIhqluqGxtgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 2:09 PM, Klaus Jensen wrote:
> This adds support for multiple namespaces by introducing a new 'nvme-ns'
> device model. The nvme device creates a bus named from the device name
> ('id'). The nvme-ns devices then connect to this and registers
> themselves with the nvme device.
> 
> This changes how an nvme device is created. Example with two namespaces:
> 
>   -drive file=nvme0n1.img,if=none,id=disk1
>   -drive file=nvme0n2.img,if=none,id=disk2
>   -device nvme,serial=deadbeef,id=nvme0
>   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
>   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> 
> The drive property is kept on the nvme device to keep the change
> backward compatible, but the property is now optional. Specifying a
> drive for the nvme device will always create the namespace with nsid 1.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Klaus, just to make sure I understand correctly, this implements
multiple namespaces for *emulated* NVMe, right? I'm asking because I
just merged libvirt patches to support:

-drive
file.driver=nvme,file.device=0000:01:00.0,file.namespace=1,format=raw,if=none,id=drive-virtio-disk0
-device
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1

and seeing these patches made me doubt my design. But if your patches
touch emulated NVMe only, then libvirt's fine because it doesn't expose
that just yet.

Michal


