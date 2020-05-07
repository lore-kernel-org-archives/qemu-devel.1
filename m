Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46775C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140452082E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IM5V9wda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140452082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWimB-0007Ye-7e
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWiki-0006uA-9l
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:48:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49133
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWikh-0003xU-45
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588866477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BnJec2M5KIfTKxnmSUe6nsimepltb7ggMe3V8Jzyrso=;
 b=IM5V9wdaAEy3VZicji1gY06VUWhBUUsqbOPAnDOm+o1c89ukD6JavQaWArH51LvG8xb8De
 ea9AEhSE6SPWYKXK/hBD+e/Ejj66WIaqPdc6gwGm1af3R2oU6wsP5N3gI1jj+Xn6Umtjdr
 nCtvI2JBq03xoKmyn/j0YN6D70Mswns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-QYRb74I6P7meYpFtZy-nLg-1; Thu, 07 May 2020 11:47:53 -0400
X-MC-Unique: QYRb74I6P7meYpFtZy-nLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748FB835B41;
 Thu,  7 May 2020 15:47:52 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F01A2BFCC;
 Thu,  7 May 2020 15:47:34 +0000 (UTC)
Subject: Re: [RFC v3 3/6] qmp: decode feature bits in virtio-status
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200507114927.6733-1-lvivier@redhat.com>
 <20200507114927.6733-4-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f9120022-8e07-fed9-8817-46a76db7e5e5@redhat.com>
Date: Thu, 7 May 2020 10:47:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507114927.6733-4-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 6:49 AM, Laurent Vivier wrote:
> Display feature names instead of a features bitmap for host, guest
> and backend.
> 
> Decode features according device type, transport features are
> on the first line. Undecoded bits (if any) are stored in a separate
> field.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

I didn't closely review the code, but for the QAPI parts:

> +++ b/qapi/virtio.json

> +##
> +# @VirtioBlkFeature:
> +#
> +# An enumeration of Virtio block features
> +#
> +# Since: 5.1
> +##
> +
> +{ 'enum': 'VirtioBlkFeature',
> +  'data': [ 'size-max', 'seg-max', 'geometry', 'ro', 'blk-size', 'topology',              'mq', 'discard', 'write-zeroes', 'barrier', 'scsi', 'flush',

Missing newline.

> +##
> +# @VirtioDeviceFeatures:
> +#
> +# An union to define the list of features for a virtio device

s/An/A/ (in English, 'an' goes with soft u, 'a' goes with pronounced u. 
You can remember with "a unicorn gets an umbrella")

> +#
> +# Since: 5.1
> +##
> +
> +{ 'union': 'VirtioDeviceFeatures',
> +  'data': {
> +    'virtio-serial': [ 'VirtioSerialFeature' ],
> +    'virtio-blk': [ 'VirtioBlkFeature' ],
> +    'virtio-gpu': [ 'VirtioGpuFeature' ],
> +    'virtio-net': [ 'VirtioNetFeature' ],
> +    'virtio-scsi': [ 'VirtioScsiFeature' ],
> +    'virtio-balloon': [ 'VirtioBalloonFeature' ],
> +    'virtio-iommu': [ 'VirtioIommuFeature' ]
> +  }
> +}

This is a legacy union rather than a flat union, which results in more 
{} in the QMP wire format.  Is it worth trying to make this a flat 
union, by labeling an appropriate member as 'discriminator'?

> +
> +##
> +# @VirtioStatusFeatures:
> +#
> +# @transport: the list of transport features of the virtio device
> +#
> +# @device: the list of the virtio device specific features
> +#
> +# @unknown: virtio bitmap of the undecoded features
> +#
> +# Since: 5.1
> +##
> +
> +{ 'struct': 'VirtioStatusFeatures',
> +  'data': { 'transport': [ 'VirtioTransportFeature' ],
> +            'device': 'VirtioDeviceFeatures',
> +            'unknown': 'uint64' }
> +}
> +
>   ##
>   # @VirtioStatus:
>   #
> @@ -101,9 +245,9 @@
>     'data': {
>       'device-id': 'int',
>       'device-endian': 'VirtioStatusEndianness',
> -    'guest-features': 'uint64',
> -    'host-features': 'uint64',
> -    'backend-features': 'uint64',
> +    'guest-features': 'VirtioStatusFeatures',
> +    'host-features': 'VirtioStatusFeatures',
> +    'backend-features': 'VirtioStatusFeatures',

This is intra-series churn.  Should we be trying to get the right types 
in place from the get-go?  Or at least clarify in the commit message of 
the earlier patch that the format will be incrementally improved later?

>       'num-vqs': 'uint16'
>     }
>   }
> @@ -123,18 +267,40 @@
>   #
>   # -> { "execute": "x-debug-virtio-status",
>   #      "arguments": {
> -#          "path": "/machine/peripheral-anon/device[3]/virtio-backend"
> +#          "path": "/machine/peripheral-anon/device[1]/virtio-backend"
>   #      }
>   #   }
>   # <- { "return": {
> -#          "backend-features": 0,
> -#          "guest-features": 5111807911,
> -#          "num-vqs": 3,
> -#          "host-features": 6337593319,
>   #          "device-endian": "little",
> -#          "device-id": 1
> +#          "device-id": 3,
> +#          "backend-features": {
> +#              "device": {
> +#                  "type": "virtio-serial",
> +#                  "data": []
> +#              },
> +#              "unknown": 0,
> +#              "transport": []
> +#          },

If we use a flat union, this could look like:

"backend-feature": {
   "type": "virtio-serial",
   "features": [],
   "unknown": 0,
   "transport": []
},

Should 'unknown' be optional so it can be omitted when zero?  Should it 
be named 'unknown-features'?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


