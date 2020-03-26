Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7CC2D0E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243C520775
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCkBImJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243C520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSGr-0004DQ-Dh
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHSFm-00036Z-3j
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHSFk-0006DM-Kv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:08:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24875)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHSFk-0006DD-I5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585228136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NdQbngeC6+8sctvBux0Ecjsmlgr10NCY+2KpEpoMaM=;
 b=LCkBImJZm9EVMb9L6Gxzeu0Tbtqg6h8yWBZPbGp4LYW44BF+6lbmS7vsjrlpYgYbbLYu+A
 7T86UhhbcScdTc8ZRwHewGP1qNpriGH7XkNRL/TbFYD+EHTtgRLQUmJuHtodQDNb+bee8j
 Zb7CrqGKKGFUbI9Mboizcw5z01T/I08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-p-tFZwKrN_e--Se_t5Hztg-1; Thu, 26 Mar 2020 09:08:49 -0400
X-MC-Unique: p-tFZwKrN_e--Se_t5Hztg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E409F107ACC7;
 Thu, 26 Mar 2020 13:08:47 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10BA7A0A87;
 Thu, 26 Mar 2020 13:08:46 +0000 (UTC)
Subject: Re: [PATCH v2] block: make BlockConf.*_size properties 32-bit
To: Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org
References: <20200326065217.1626748-1-rvkagan@yandex-team.ru>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <948d6780-ef99-9eec-c7f5-8aac693f5d0b@redhat.com>
Date: Thu, 26 Mar 2020 08:08:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326065217.1626748-1-rvkagan@yandex-team.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 1:52 AM, Roman Kagan wrote:
> Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
> 32-bit for logical_block_size, physical_block_size, and min_io_size.
> However, the properties in BlockConf are defined as uint16_t limiting
> the values to 32768.
> 
> This appears unnecessary tight, and we've seen bigger block sizes handy
> at times.
> 
> Make them 32 bit instead and lift the limitation up to 2 MiB which
> appears to be good enough for everybody.

and matches the current qemu limit for qcow2 cluster sizes

> 
> As the values can now be fairly big and awkward to type, make the
> property setter accept common size suffixes (k, m).
> 
> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> ---
> v1 -> v2:
> - cap the property at 2 MiB [Eric]
> - accept size suffixes
> 

> +++ b/hw/core/qdev-properties.c
> @@ -14,6 +14,7 @@
>   #include "qapi/visitor.h"
>   #include "chardev/char.h"
>   #include "qemu/uuid.h"
> +#include "qemu/units.h"
>   
>   void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>                                     Error **errp)
> @@ -729,30 +730,39 @@ const PropertyInfo qdev_prop_pci_devfn = {
>   
>   /* --- blocksize --- */
>   
> +/* lower limit is sector size */
> +#define MIN_BLOCK_SIZE          512
> +#define MIN_BLOCK_SIZE_STR      "512 B"
> +/* upper limit is arbitrary, 2 MiB looks sufficient */
> +#define MAX_BLOCK_SIZE          (2 * MiB)
> +#define MAX_BLOCK_SIZE_STR      "2 MiB"

For this comment, I might add that it matches our limit for qcow2 
cluster size.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


