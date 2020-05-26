Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F150AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3241207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhmJG+xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3241207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdgRf-0006AJ-UG
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 16:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jdgQT-0005AC-8J
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:43:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jdgQR-0007Rt-RP
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590525829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MqwAiWPvkyWeTuHOgcPlU8vd9VeflHy8pmTYV2+LUFg=;
 b=bhmJG+xlLplIdXLGzMPJ7WWYwWNHVzcXzPoEOYoeXx6eUFlgo4Oq8kfCP076/+z+ZJ1K5Y
 vj6ask0n+NgwIadm4tH2papRGKGhcXf+YkDe3hOgEK9f89H1ZM335uMFtANZv8gmSzRFLV
 XY/7K0WXxaoDNU5IcZIyovlDR5/Kzeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-mdOunh_FOOKYqNqQXAbX2A-1; Tue, 26 May 2020 16:43:45 -0400
X-MC-Unique: mdOunh_FOOKYqNqQXAbX2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3AFF18017E5;
 Tue, 26 May 2020 20:43:44 +0000 (UTC)
Received: from x1.home (ovpn-114-203.phx2.redhat.com [10.3.114.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DD5310013D7;
 Tue, 26 May 2020 20:43:44 +0000 (UTC)
Date: Tue, 26 May 2020 14:43:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leonardo Bras <leobras.c@gmail.com>
Subject: Re: [RESEND PATCH 1/1] vfio/nvlink: Remove exec permission to avoid
 SELinux AVCs
Message-ID: <20200526144343.7c6c6def@x1.home>
In-Reply-To: <8f5ae1658103b71b09555d3ab499edaf3f36a15d.camel@gmail.com>
References: <8f5ae1658103b71b09555d3ab499edaf3f36a15d.camel@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 15:25:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, dgibson@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 12:05:24 -0300
Leonardo Bras <leobras.c@gmail.com> wrote:

> If SELinux is setup without 'execmem' permission for qemu, all mmap
> with (PROT_WRITE | PROT_EXEC) will fail and print a warning in
> SELinux log.
> 
> If "nvlink2-mr" memory allocation fails (fist diff), it will cause
> guest NUMA nodes to not be correctly configured (V100 memory will
> not be visible for guest, nor its NUMA nodes).
> 
> Not having 'execmem' permission is intesting for virtual machines to
> avoid buffer-overflow based attacks, and it's adopted in distros
> like RHEL.
> 
> So, removing the PROT_EXEC flag seems the right thing to do.
> 
> Browsing some other code that mmaps memory for usage with
> memory_region_init_ram_device_ptr, I could notice it's usual to
> not have PROT_EXEC (only PROT_READ | PROT_WRITE), so it should be
> no problem around this.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> ---

Seems David Gibson might be in a position to send a pull request
including this before I can, so:

Acked-by: Alex Williamson <alex.williamson@redhat.com>


> - Alexey's review is here: https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg00006.html
> 
>  hw/vfio/pci-quirks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 2d348f8237..124d4f57e1 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1620,7 +1620,7 @@ int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
>      }
>      cap = (void *) hdr;
>  
> -    p = mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +    p = mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE,
>               MAP_SHARED, vdev->vbasedev.fd, nv2reg->offset);
>      if (p == MAP_FAILED) {
>          ret = -errno;
> @@ -1680,7 +1680,7 @@ int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
>  
>      /* Some NVLink bridges may not have assigned ATSD */
>      if (atsdreg->size) {
> -        p = mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +        p = mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE,
>                   MAP_SHARED, vdev->vbasedev.fd, atsdreg->offset);
>          if (p == MAP_FAILED) {
>              ret = -errno;
> 


