Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B9EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740BF2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwojQzAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740BF2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0tx-0007LZ-PD
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jK0sa-0006Ip-85
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jK0sZ-0006v6-5P
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:31:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jK0sY-0006uQ-Vj
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585837894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqPYXtiqhD4dMaoEedYmwkzV+0Iav8ZW8hucYRIa8Cc=;
 b=VwojQzAOlYE/MLQYcx5xpg08zTDDrnABaYzj9vhueB+93K2VggUEznt4Ljm3CnVR3tYOjv
 aY8lbFz2z2EKh4lQWzj0zEKHYK0/nH8AUqrY9mTT4n/IrjpeshXA550XHHBJsd09fqjwfk
 Gbf0gEjl1amd+49DT3CnLZ+K0+Y3SRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-rXu39514PoejGA8SHmtudw-1; Thu, 02 Apr 2020 10:31:31 -0400
X-MC-Unique: rXu39514PoejGA8SHmtudw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 012C88017CE;
 Thu,  2 Apr 2020 14:31:30 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5269925276;
 Thu,  2 Apr 2020 14:31:26 +0000 (UTC)
Subject: Re: [RFC 4/5] qmp: add QMP command virtio-queue-element
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200402100302.833267-1-lvivier@redhat.com>
 <20200402100302.833267-5-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7ff5fab7-c5f5-157e-4f07-543a88b14068@redhat.com>
Date: Thu, 2 Apr 2020 09:31:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402100302.833267-5-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 5:03 AM, Laurent Vivier wrote:
> This new command shows the information of a VirtQueue element.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/virtio/virtio-stub.c |  7 ++++
>   hw/virtio/virtio.c      | 85 +++++++++++++++++++++++++++++++++++++++++
>   qapi/virtio.json        | 85 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 177 insertions(+)
> 

> +##
> +# @VirtioRingDesc:
> +#
> +# @addr: guest physical address of the descriptor data
> +#
> +# @len: length of the descriptor data
> +#
> +# @flags: descriptor flags (write-only, read-only, ...)
> +#
> +# Since: 5.1
> +#
> +##
> +
> +{ 'struct': 'VirtioRingDesc',
> +  'data': {
> +    'addr': 'uint64',
> +    'len': 'uint32',
> +    'flags': 'uint16'

Again, flags should probably be an array of enum values, rather than a 
bare int.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


