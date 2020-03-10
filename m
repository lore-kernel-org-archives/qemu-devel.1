Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFDCC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6126C21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPGW6JOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6126C21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBoif-0000CJ-Eq
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 19:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jBoi6-0008EQ-FM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1jBoi4-0008Ml-I2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:54:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30558
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1jBoi4-0008Lp-Ds
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583884491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRRI7W3mGAOd+0o7Dz/AmVq2LVwZvBHiSW/7NdS3rtE=;
 b=WPGW6JOYqo/3bFZsJG7DCSz/OMOWp4jdacl2wVB8gQt5rkhoViwv7RJs0rbMYNIkx5KSJw
 uKEWfkxlCGJBmrJ9vxRQ7Coa/BA6x0QhPa+8OuZd6AouaikYHtwp07KJbD5cepmYKgQ7xv
 wHiUiqHAhB5hn/VDrKyEBhwVvNNaAGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-fee3QWRtPvSRW8rID8d63w-1; Tue, 10 Mar 2020 19:54:49 -0400
X-MC-Unique: fee3QWRtPvSRW8rID8d63w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B28F8018D8;
 Tue, 10 Mar 2020 23:54:48 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-246.ams2.redhat.com
 [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A915D8B547;
 Tue, 10 Mar 2020 23:54:47 +0000 (UTC)
Subject: Re: [PATCH] vfio/pci: Use defined memcpy() behavior
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <158386047731.30997.5580377889283866404.stgit@gimli.home>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a6ffe170-bd01-1733-888e-cb116fd1972d@redhat.com>
Date: Wed, 11 Mar 2020 00:54:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <158386047731.30997.5580377889283866404.stgit@gimli.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: longpeng2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/20 18:15, Alex Williamson wrote:
> vfio_rom_read() relies on memcpy() doing the logically correct thing,
> ie. safely copying zero bytes from a NULL pointer when rom_size is
> zero, rather than the spec definition, which is undefined when the
> source or target pointers are NULL.  Resolve this by wrapping the
> call in the condition expressed previously by the ternary.
> 
> Additionally, we still use @val to fill data based on the provided
> @size regardless of mempcy(), so we should initialize @val rather
> than @data.
> 
> Reported-by: Longpeng <longpeng2@huawei.com>
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/vfio/pci.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 5e75a95129ac..b0799cdc28ad 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -859,16 +859,17 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>          uint16_t word;
>          uint32_t dword;
>          uint64_t qword;
> -    } val;
> -    uint64_t data = 0;
> +    } val = { 0 };
> +    uint64_t data;
>  
>      /* Load the ROM lazily when the guest tries to read it */
>      if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
>          vfio_pci_load_rom(vdev);
>      }
>  
> -    memcpy(&val, vdev->rom + addr,
> -           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
> +    if (addr < vdev->rom_size) {
> +        memcpy(&val, vdev->rom + addr, MIN(size, vdev->rom_size - addr));
> +    }
>  
>      switch (size) {
>      case 1:
> 

sorry I'm processing my INBOX in basically... random order. :/

So as I stated in the earlier thread, I suggest casting "vdev->rom" to a
character type, before the addition operator "+" binds.

With that:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo


