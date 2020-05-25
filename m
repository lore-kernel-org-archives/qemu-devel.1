Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D03AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AC22068D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dON7WSqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AC22068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8LU-0008Q3-6n
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd8KU-0007zi-6A
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:19:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd8KT-00026C-CJ
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590394764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B4IV+o/Zdcqd5oaaZ7R+GsiHLcwR4h2Uol2t0CejYts=;
 b=dON7WSqrzhPH+96Q22slHtHqTM40TeR7ma8eXghk+UEDxr50706Jy2lQwJSa7Qi18z5WN6
 HvVUMXbnJUO/7lAN2/ccekRU0JLgRUngoAEhxp25+p7fwqkd2OFXq3rtyzOwY82zJ6YofU
 Ytg0kbzOVyqqz/HHX/UbNL8n6Xnav1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-0RjHmPpCPI6uWsycBXWoDQ-1; Mon, 25 May 2020 04:19:22 -0400
X-MC-Unique: 0RjHmPpCPI6uWsycBXWoDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AEB2464
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:19:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0326E60CC0;
 Mon, 25 May 2020 08:19:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69D78113864A; Mon, 25 May 2020 10:19:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
References: <20200317195908.283800-1-peterx@redhat.com>
Date: Mon, 25 May 2020 10:19:09 +0200
In-Reply-To: <20200317195908.283800-1-peterx@redhat.com> (Peter Xu's message
 of "Tue, 17 Mar 2020 15:59:08 -0400")
Message-ID: <87a71wfmv6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 00:06:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> writes:

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
> ---
[...]
> diff --git a/qapi/misc.json b/qapi/misc.json
> index c18fe681fb..f8d33ddb4e 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -403,6 +403,8 @@
>  #
>  # @irq: if an IRQ is assigned to the device, the IRQ number
>  #
> +# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
> +#

For the IRQ number, we make the member optional, and use "member absent"
for "no IRQ assigned".

For the IRQ pin, we make the member mandatory, and use zero value for
"no IRQ assigned".

Any particular reason for the difference?

>  # @qdev_id: the device name of the PCI device
>  #
>  # @pci_bridge: if the device is a PCI bridge, the bridge information
> @@ -417,8 +419,8 @@
>  { 'struct': 'PciDeviceInfo',
>    'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
>             'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
> -           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
> -           'regions': ['PciMemoryRegion']} }
> +           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
> +           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegion'] }}
>  
>  ##
>  # @PciInfo:


