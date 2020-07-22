Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734C4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1AA2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuwhNOcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1AA2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHTR-0006kT-G6
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jyHSd-0005Se-4M
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21937
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jyHSb-0004AZ-BQ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595434752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wpmTYikSdbjcf+/JbUC0xrPOhhmaHgwKVJRyehi4Ng=;
 b=UuwhNOcVddSODS65h02hhqpkErKDe0ctWzd0CZf9wgmJQju2d3YiWbSFGfjt2jR4E0gJHb
 xUGVPpNG64GsGb7tjQlv8jbMabXizpXPs19gvzoSbyTxyYGaN2u2QZSXgLtSX+pSd5jowc
 X+tq66v5Hmy3tE6YWm9B+czjK5KIg7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-ft2Q9X6VPUi84FgixYoiVw-1; Wed, 22 Jul 2020 12:19:09 -0400
X-MC-Unique: ft2Q9X6VPUi84FgixYoiVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C27159;
 Wed, 22 Jul 2020 16:19:06 +0000 (UTC)
Received: from starship (unknown [10.35.206.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F4965C3F8;
 Wed, 22 Jul 2020 16:19:02 +0000 (UTC)
Message-ID: <3c4a37263eaceffec01fb00bc9b3549a3c9df90e.camel@redhat.com>
Subject: Re: [PATCH 1/1] pci/pcie: refuse another hotplug/unplug event if
 attention button is pending
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 Jul 2020 19:19:01 +0300
In-Reply-To: <20200722161722.51416-2-mlevitsk@redhat.com>
References: <20200722161722.51416-1-mlevitsk@redhat.com>
 <20200722161722.51416-2-mlevitsk@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-07-22 at 19:17 +0300, Maxim Levitsky wrote:
> Curently it is possible to hotplug a device and then immediatly
> hotunplug it before the OS notices, and that will result
> in missed unplug event since we can only send one attention button event.
> 
> Moreover the device will stuck in unplugging state forever.
> 
> Error out in such cases and rely on the caller (e.g libvirt) to retry
> the unplug a bit later
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/pci/pcie.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 5b48bae0f6..9e836cf2f4 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -402,6 +402,17 @@ static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
>           */
>          error_setg_errno(errp, EBUSY, "slot is electromechanically locked");
>      }
> +
> +    if (sltsta & PCI_EXP_SLTSTA_ABP) {
> +        /*
> +         * Attention button is pressed, thus we can't send another
> +         * hotpplug event
Typo here, forgot to refresh the commit.
> +         */
> +        error_setg_errno(errp, EBUSY,
> +                         "attention button is already pressed, can't "
> +                         "send another hotplug event");
> +    }
> +
>  }
>  
>  void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,



