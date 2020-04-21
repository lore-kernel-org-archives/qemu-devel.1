Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237EAC54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 14:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE9E206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 14:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIP4vI/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE9E206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQuI8-0005aw-O1
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 10:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQuHU-00057i-4R
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQuHS-0002Ii-Vf
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:53:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56052
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQuHS-0002Gm-I6
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587480825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nZNy2NSBYOHPp5qbtVJz+EjLDAIPGtrG8yJzY91myw=;
 b=UIP4vI/rJmuY6lZz7eu9zVvvItwUiTE6hgGofIhobhiqQ0v+g1XFgSqvytpA+LMuK5LMQl
 SY1limGqWnAaZHh+8hqoSjzrj4oEqrlgKkTgMsKyp6fSSaKZMau/X3jd/mbqnb/4HFcv8U
 sdA/Ct/5UUuu3+5ThhymiLmqSDwq/Vk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-uHdKHWYZMDqUFQ8woSFeSA-1; Tue, 21 Apr 2020 10:53:36 -0400
X-MC-Unique: uHdKHWYZMDqUFQ8woSFeSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF2FFDB2E;
 Tue, 21 Apr 2020 14:53:34 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB5615DA83;
 Tue, 21 Apr 2020 14:53:31 +0000 (UTC)
Message-ID: <5dbf8e4cefbbcbf9c0bab3eb7e314124be8385d8.camel@redhat.com>
Subject: Re: [PATCH v2 09/16] nvme: factor out property/constraint checks
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 21 Apr 2020 17:53:30 +0300
In-Reply-To: <20200415130159.611361-10-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-10-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-04-15 at 15:01 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 43 ++++++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 44856e873fd1..5f9ebbd6a1d5 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1311,24 +1311,19 @@ static const MemoryRegionOps nvme_cmb_ops = {
>      },
>  };
>  
> -static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
>  {
> -    NvmeCtrl *n = NVME(pci_dev);
> -    NvmeIdCtrl *id = &n->id_ctrl;
> +    NvmeParams *params = &n->params;
>  
> -    int i;
> -    int64_t bs_size;
> -    uint8_t *pci_conf;
> -
> -    if (n->params.num_queues) {
> +    if (params->num_queues) {
>          warn_report("num_queues is deprecated; please use max_ioqpairs "
>                      "instead");
>  
> -        n->params.max_ioqpairs = n->params.num_queues - 1;
> +        params->max_ioqpairs = params->num_queues - 1;
>      }
>  
> -    if (n->params.max_ioqpairs < 1 ||
> -        n->params.max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
> +    if (params->max_ioqpairs < 1 ||
> +        params->max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
>          error_setg(errp, "max_ioqpairs must be between 1 and %d",
>                     PCI_MSIX_FLAGS_QSIZE);
>          return;
> @@ -1339,16 +1334,34 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>          return;
>      }
>  
> +    if (!params->serial) {
> +        error_setg(errp, "serial property not set");
> +        return;
> +    }
> +}
> +
> +static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    NvmeCtrl *n = NVME(pci_dev);
> +    NvmeIdCtrl *id = &n->id_ctrl;
> +    Error *err = NULL;
Yep, lets name it indeed local_err.
> +
> +    int i;
> +    int64_t bs_size;
> +    uint8_t *pci_conf;
> +
> +    nvme_check_constraints(n, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
>      bs_size = blk_getlength(n->conf.blk);
>      if (bs_size < 0) {
>          error_setg(errp, "could not get backing file size");
>          return;
>      }
>  
> -    if (!n->params.serial) {
> -        error_setg(errp, "serial property not set");
> -        return;
> -    }
>      blkconf_blocksizes(&n->conf);
>      if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
>                                         false, errp)) {
 

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


