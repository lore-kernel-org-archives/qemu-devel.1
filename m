Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A4FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148A220738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIJg07Y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148A220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIRZ-0006bD-9e
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEIQo-00068V-Dv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEIQn-0005Rj-53
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:03:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEIQm-0005P4-WB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584475396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbSq4F+Kkuaw2sEuKIG1cZA4N19u5+9gNxh/Q95gyzI=;
 b=aIJg07Y1Nld+xEznmbGczojzWrpHiz5l3XlpDRoJnybQ4xd1bxLin3MrU22JJ4/0qNc0Ux
 0ccRIOUNXr0sEqNZS8uAZRMmG9YGP3Ja1Y5p6OyYb57v0crZ1ognrbHFhJg6uSih3GmjmS
 PxHu6ZLMQkjVO6gcqpA5UfmiVyg0cn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-dqyhjVL5MwaDhC9EybtFGw-1; Tue, 17 Mar 2020 16:03:10 -0400
X-MC-Unique: dqyhjVL5MwaDhC9EybtFGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54CD318FE871
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 20:03:09 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7BC91001B07;
 Tue, 17 Mar 2020 20:02:57 +0000 (UTC)
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200317195908.283800-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6beb4b5d-91c6-2536-64ab-18217be71134@redhat.com>
Date: Tue, 17 Mar 2020 15:02:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317195908.283800-1-peterx@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 2:59 PM, Peter Xu wrote:
> Sometimes it would be good to be able to read the pin number along
> with the IRQ number allocated.  Since we'll dump the IRQ number, no
> reason to not dump the pin information.  For example, the vfio-pci
> device will overwrite the pin with the hardware pin number.  It would
> be nice to know the pin number of one assigned device from QMP/HMP.
> 
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> CC: Julia Suvorova <jusual@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> This helped me to debug an IRQ sharing issue, so may good to have it
> in master too.

We're right at soft freeze.


> +++ b/qapi/misc.json
> @@ -403,6 +403,8 @@
>   #
>   # @irq: if an IRQ is assigned to the device, the IRQ number
>   #
> +# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
> +#

But if we really do want it in 5.0, this needs a tweak.  Does the delay 
hurt?

Naming convention: We prefer 'irq-pin' unless there is a consistency 
issue....

>   # @qdev_id: the device name of the PCI device
>   #
>   # @pci_bridge: if the device is a PCI bridge, the bridge information
> @@ -417,8 +419,8 @@
>   { 'struct': 'PciDeviceInfo',
>     'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
>              'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
> -           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
> -           'regions': ['PciMemoryRegion']} }
> +           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
> +           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegion'] }}

and the pre-existing pci_bridge is indeed the consistency issue.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


