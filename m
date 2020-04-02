Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E97C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E36E2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U58GuujL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E36E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1Py-0005gl-Aa
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 11:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jK1Iu-0004Ws-PR
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jK1It-0006pZ-8s
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:58:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51953
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jK1It-0006mM-4y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585839522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmvllzK3a4G/2rTzCSIZqmfwJR73U9E0oaHipt9MTuo=;
 b=U58GuujL52duYBFY1cpfgILxVM0DqFEYA/OeF02ruUnDdLwdQo4K9ERKosh9LC2tZqPY4E
 t2znoEUHMjRHqa4OVEieL9j1rx8cWFTiW52vOpy4U0qYskYEv19XTMASJRmHxUk5ehak8a
 EldA7kNteMAGZq4RIt4fG8AncwoQ9Ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-1D_4Mek3NnK8X1hS0alTTg-1; Thu, 02 Apr 2020 10:58:40 -0400
X-MC-Unique: 1D_4Mek3NnK8X1hS0alTTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D95E10CE781;
 Thu,  2 Apr 2020 14:58:39 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8E89A242;
 Thu,  2 Apr 2020 14:58:32 +0000 (UTC)
Date: Thu, 2 Apr 2020 15:58:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC 4/5] qmp: add QMP command virtio-queue-element
Message-ID: <20200402145830.GP2834@work-vm>
References: <20200402100302.833267-1-lvivier@redhat.com>
 <20200402100302.833267-5-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200402100302.833267-5-lvivier@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laurent Vivier (lvivier@redhat.com) wrote:
> This new command shows the information of a VirtQueue element.

Having had a few second play with this, I think I've always seen it say
that the ring is empty; is this pretty much always the case when the VM
is running and the device is consuming elements off the queue - so most
cases where this is useful is where the VM is paused?
> +        desc_cache =3D &caches->desc;
> +        vring_split_desc_read(vdev, &desc, desc_cache, i);
> +        if (desc.flags & VRING_DESC_F_INDIRECT) {
> +            error_setg(errp, "Unsupported indirect buffer feature");
> +            return NULL;
> +        }

I did trigger this in the case I was playing with.

Dave

> +        element =3D g_new0(VirtioQueueElement, 1);
> +        element->index =3D head;
> +        element->ndescs =3D 1;
> +        element->descs =3D g_new0(VirtioRingDescList, 1);
> +        element->descs->value =3D g_new0(VirtioRingDesc, 1);
> +        element->descs->value->addr =3D desc.addr;
> +        element->descs->value->len =3D desc.len;
> +        element->descs->value->flags =3D desc.flags;
> +    }
> +
> +    return element;
> +}
> +
>  static const TypeInfo virtio_device_info =3D {
>      .name =3D TYPE_VIRTIO_DEVICE,
>      .parent =3D TYPE_DEVICE,
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index ab70500d919b..3e8865511217 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -215,3 +215,88 @@
>    'data': { 'path': 'str', 'queue': 'uint16' },
>    'returns': 'VirtQueueStatus'
>  }
> +
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
> +  }
> +}
> +
> +##
> +# @VirtioQueueElement:
> +#
> +# @index: index of the element in the queue
> +#
> +# @len: length of the element data
> +#
> +# @ndescs: number of descriptors
> +#
> +# @descs: list of the descriptors
> +#
> +# Since: 5.1
> +#
> +##
> +
> +{ 'struct': 'VirtioQueueElement',
> +  'data': {
> +    'index': 'uint32',
> +    'len': 'uint32',
> +    'ndescs': 'uint32',
> +    'descs': ['VirtioRingDesc']
> +  }
> +}
> +
> +##
> +# @virtio-queue-element:
> +#
> +# Return the information about an element queue (by default head)
> +#
> +# @path: QOBject path of the VirtIODevice
> +#
> +# @queue: queue number to examine
> +#
> +# @index: the index in the queue, by default head
> +#
> +# Returns: the element information
> +#
> +# Since: 5.1
> +#
> +# Example:
> +#
> +# -> { "execute": "virtio-queue-element",
> +#      "arguments": {
> +#          "path": "/machine/peripheral-anon/device[3]/virtio-backend",
> +#          "queue": 0
> +#      }
> +#   }
> +# -> { "return": {
> +#         "index": 109,
> +#         "len": 0,
> +#         "ndescs": 1,
> +#         "descs": [
> +#             { "flags": 2, "len": 2048, "addr": 853145600 }
> +#         ]
> +#      }
> +#   }
> +#
> +##
> +
> +{ 'command': 'virtio-queue-element',
> +  'data': { 'path': 'str', 'queue': 'uint16', '*index': 'uint16' },
> +  'returns': 'VirtioQueueElement'
> +}
> --=20
> 2.25.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


