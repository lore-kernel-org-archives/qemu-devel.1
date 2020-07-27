Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A85C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8359220672
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AERsZrDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8359220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzzzK-00018G-Rh
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 06:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzzyf-0000Vs-Rn
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:03:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzzyd-000052-8y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595844202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivy2XEBy58oI03WkVcrKvZFFGTzPEWgtS0K5KFwBdGg=;
 b=AERsZrDbbk++TsAOaIsJ5FDQhibkeqidDaf76fI7oL4pOqnonw4lLCBpRP/rNb0B6BoJdj
 3j7zL+pCKHawezX94aEoxRLaakijCZOnPqch8UiJuCHhraO2h17In4n+uC2TAil5mpjsRJ
 kEwUID/bmIt3dB6br/fiTyVktPr2NI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-W_qF33KRM0aA53-wLiWgrg-1; Mon, 27 Jul 2020 06:03:20 -0400
X-MC-Unique: W_qF33KRM0aA53-wLiWgrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76E861009441;
 Mon, 27 Jul 2020 10:03:19 +0000 (UTC)
Received: from gondolin (ovpn-112-210.ams2.redhat.com [10.36.112.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71D7E19D82;
 Mon, 27 Jul 2020 10:03:11 +0000 (UTC)
Date: Mon, 27 Jul 2020 12:03:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv3 9/9] s390x: initial support for virtio-mem
Message-ID: <20200727120308.39a4c810.cohuck@redhat.com>
In-Reply-To: <20200724143750.59836-10-david@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
 <20200724143750.59836-10-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 16:37:50 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's wire up the initial, basic virtio-mem implementation in QEMU. It will
> have to see some important extensions (esp., resizeable allocations)
> before it can be considered production ready. Also, the focus on the Linux
> driver side is on memory hotplug, there are a lot of things optimize in
> the future to improve memory unplug capabilities. However, the basics
> are in place.
> 
> Block migration for now, as we'll have to take proper care of storage
> keys and storage attributes. Also, make sure to not hotplug huge pages
> to a setup without huge pages.
> 
> With a Linux guest that supports virtio-mem (and has
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE set for now), a basic example.
> 
> 1. Start a VM with 2G initial memory and a virtio-mem device with a maximum
>    capacity of 18GB (and an initial size of 300M):
>     sudo qemu-system-s390x \
>         --enable-kvm \
>         -m 2G,maxmem=20G \
>         -smp 4 \
>         -nographic \
>         -chardev socket,id=monitor,path=/var/tmp/monitor,server,nowait \
>         -mon chardev=monitor,mode=readline \
>         -net nic -net user \
>         -hda s390x.cow2 \
>         -object memory-backend-ram,id=mem0,size=18G \
>         -device virtio-mem-ccw,id=vm0,memdev=mem0,requested-size=300M
> 
> 2. Query the current size of virtio-mem device:
>     (qemu) info memory-devices
>     Memory device [virtio-mem]: "vm0"
>       memaddr: 0x80000000
>       node: 0
>       requested-size: 314572800
>       size: 314572800
>       max-size: 19327352832
>       block-size: 1048576
>       memdev: /objects/mem0
> 
> 3. Request to grow it to 8GB:
>     (qemu) qom-set vm0 requested-size 8G
>     (qemu) info memory-devices
>     Memory device [virtio-mem]: "vm0"
>       memaddr: 0x80000000
>       node: 0
>       requested-size: 8589934592
>       size: 8589934592
>       max-size: 19327352832
>       block-size: 1048576
>       memdev: /objects/mem0
> 
> 4. Request to shrink it to 800M (might take a while, might not fully
>    succeed, and might not be able to remove memory blocks in Linux):
>   (qemu) qom-set vm0 requested-size 800M
>   (qemu) info memory-devices
>   Memory device [virtio-mem]: "vm0"
>     memaddr: 0x80000000
>     node: 0
>     requested-size: 838860800
>     size: 838860800
>     max-size: 19327352832
>     block-size: 1048576
>     memdev: /objects/mem0
> 
> Note 1: Due to lack of resizeable allocations, we will go ahead and
> reserve a 18GB vmalloc area + size the QEMU RAM slot + KVM mamory slot
> 18GB. echo 1 > /proc/sys/vm/overcommit_memory might be required for
> now. In the future, this area will instead grow on actual demand and shrink
> when possible.
> 
> Note 2: Although virtio-mem-pci is wired up as well, it does not seem to
> work currently on s390x due to lack of MSI-X.

IIRC, you can trick virtio-pci into using msi-x via nvectors. Might be
interesting to try.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/Kconfig           |   1 +
>  hw/s390x/Makefile.objs     |   1 +
>  hw/s390x/s390-virtio-ccw.c | 121 ++++++++++++++++++++++++++++++++++++-
>  hw/virtio/virtio-mem.c     |   2 +
>  4 files changed, 123 insertions(+), 2 deletions(-)


