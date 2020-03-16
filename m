Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D6C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E232051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DePusss4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E232051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsEO-0002RI-4e
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jDpBV-0004ma-Ab
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jDpBP-0003bZ-KK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:49:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20948
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jDpBP-0003Zx-F5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584362967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMBmqqjrVDoNBM0i5RDn4Af4LJu1yJvrmIbMkJ1iq0I=;
 b=DePusss4z8LPhGQFPKvSok4bPVsUt1fMSLt33Mh5Dv16Q8xbSBomJ/KHOzNKexeSrpr8zI
 cv3uyAXDPFtuFA0IuO1bTMa4zAWD1Uiu3gUY0AogZEWcpsLkerIMfJ++0VgUnfTWHVOALc
 ENOujqF7plnjJHKfwfv/BTgjN2+pYzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-T7fC42KaNySOZ_ub-KuZIA-1; Mon, 16 Mar 2020 08:49:25 -0400
X-MC-Unique: T7fC42KaNySOZ_ub-KuZIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39FC518FF660;
 Mon, 16 Mar 2020 12:49:24 +0000 (UTC)
Received: from localhost (ovpn-200-42.brq.redhat.com [10.40.200.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE53260BE2;
 Mon, 16 Mar 2020 12:49:16 +0000 (UTC)
Date: Mon, 16 Mar 2020 13:49:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 8/8] qapi/misc: Restrict device memory commands to
 machine code
Message-ID: <20200316134914.2152130a@redhat.com>
In-Reply-To: <20200316000348.29692-9-philmd@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-9-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 01:03:48 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  qapi/machine.json               | 131 +++++++++++++++++++++++++++++++
>  qapi/misc.json                  | 132 --------------------------------
>  include/hw/mem/memory-device.h  |   1 +
>  include/hw/virtio/virtio-pmem.h |   2 +-
>  4 files changed, 133 insertions(+), 133 deletions(-)
>=20
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 33b259dbd0..17ccebda14 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1476,3 +1476,134 @@
>  #
>  ##
>  { 'command': 'query-pci', 'returns': ['PciInfo'] }
> +
> +##
> +# @MemoryInfo:
> +#
> +# Actual memory information in bytes.
> +#
> +# @base-memory: size of "base" memory specified with command line
> +#               option -m.
> +#
> +# @plugged-memory: size of memory that can be hot-unplugged. This field
> +#                  is omitted if target doesn't support memory hotplug
> +#                  (i.e. CONFIG_MEM_DEVICE not defined at build time).
> +#
> +# Since: 2.11.0
> +##
> +{ 'struct': 'MemoryInfo',
> +  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size' } }
> +
> +##
> +# @query-memory-size-summary:
> +#
> +# Return the amount of initially allocated and present hotpluggable (if
> +# enabled) memory in bytes.
> +#
> +# Example:
> +#
> +# -> { "execute": "query-memory-size-summary" }
> +# <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
> +#
> +# Since: 2.11.0
> +##
> +{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
> +
> +##
> +# @PCDIMMDeviceInfo:
> +#
> +# PCDIMMDevice state information
> +#
> +# @id: device's ID
> +#
> +# @addr: physical address, where device is mapped
> +#
> +# @size: size of memory that the device provides
> +#
> +# @slot: slot number at which device is plugged in
> +#
> +# @node: NUMA node number where device is plugged in
> +#
> +# @memdev: memory backend linked with device
> +#
> +# @hotplugged: true if device was hotplugged
> +#
> +# @hotpluggable: true if device if could be added/removed while machine =
is running
> +#
> +# Since: 2.1
> +##
> +{ 'struct': 'PCDIMMDeviceInfo',
> +  'data': { '*id': 'str',
> +            'addr': 'int',
> +            'size': 'int',
> +            'slot': 'int',
> +            'node': 'int',
> +            'memdev': 'str',
> +            'hotplugged': 'bool',
> +            'hotpluggable': 'bool'
> +          }
> +}
> +
> +##
> +# @VirtioPMEMDeviceInfo:
> +#
> +# VirtioPMEM state information
> +#
> +# @id: device's ID
> +#
> +# @memaddr: physical address in memory, where device is mapped
> +#
> +# @size: size of memory that the device provides
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 4.1
> +##
> +{ 'struct': 'VirtioPMEMDeviceInfo',
> +  'data': { '*id': 'str',
> +            'memaddr': 'size',
> +            'size': 'size',
> +            'memdev': 'str'
> +          }
> +}
> +
> +##
> +# @MemoryDeviceInfo:
> +#
> +# Union containing information about a memory device
> +#
> +# nvdimm is included since 2.12. virtio-pmem is included since 4.1.
> +#
> +# Since: 2.1
> +##
> +{ 'union': 'MemoryDeviceInfo',
> +  'data': { 'dimm': 'PCDIMMDeviceInfo',
> +            'nvdimm': 'PCDIMMDeviceInfo',
> +            'virtio-pmem': 'VirtioPMEMDeviceInfo'
> +          }
> +}
> +
> +##
> +# @query-memory-devices:
> +#
> +# Lists available memory devices and their state
> +#
> +# Since: 2.1
> +#
> +# Example:
> +#
> +# -> { "execute": "query-memory-devices" }
> +# <- { "return": [ { "data":
> +#                       { "addr": 5368709120,
> +#                         "hotpluggable": true,
> +#                         "hotplugged": true,
> +#                         "id": "d1",
> +#                         "memdev": "/objects/memX",
> +#                         "node": 0,
> +#                         "size": 1073741824,
> +#                         "slot": 0},
> +#                    "type": "dimm"
> +#                  } ] }
> +#
> +##
> +{ 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 92b3926c6b..670b902999 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -518,39 +518,6 @@
>  ##
>  { 'command': 'closefd', 'data': {'fdname': 'str'} }
> =20
> -##
> -# @MemoryInfo:
> -#
> -# Actual memory information in bytes.
> -#
> -# @base-memory: size of "base" memory specified with command line
> -#               option -m.
> -#
> -# @plugged-memory: size of memory that can be hot-unplugged. This field
> -#                  is omitted if target doesn't support memory hotplug
> -#                  (i.e. CONFIG_MEM_DEVICE not defined at build time).
> -#
> -# Since: 2.11.0
> -##
> -{ 'struct': 'MemoryInfo',
> -  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size' } }
> -
> -##
> -# @query-memory-size-summary:
> -#
> -# Return the amount of initially allocated and present hotpluggable (if
> -# enabled) memory in bytes.
> -#
> -# Example:
> -#
> -# -> { "execute": "query-memory-size-summary" }
> -# <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
> -#
> -# Since: 2.11.0
> -##
> -{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
> -
> -
>  ##
>  # @AddfdInfo:
>  #
> @@ -788,105 +755,6 @@
>   'returns': ['CommandLineOptionInfo'],
>   'allow-preconfig': true }
> =20
> -##
> -# @PCDIMMDeviceInfo:
> -#
> -# PCDIMMDevice state information
> -#
> -# @id: device's ID
> -#
> -# @addr: physical address, where device is mapped
> -#
> -# @size: size of memory that the device provides
> -#
> -# @slot: slot number at which device is plugged in
> -#
> -# @node: NUMA node number where device is plugged in
> -#
> -# @memdev: memory backend linked with device
> -#
> -# @hotplugged: true if device was hotplugged
> -#
> -# @hotpluggable: true if device if could be added/removed while machine =
is running
> -#
> -# Since: 2.1
> -##
> -{ 'struct': 'PCDIMMDeviceInfo',
> -  'data': { '*id': 'str',
> -            'addr': 'int',
> -            'size': 'int',
> -            'slot': 'int',
> -            'node': 'int',
> -            'memdev': 'str',
> -            'hotplugged': 'bool',
> -            'hotpluggable': 'bool'
> -          }
> -}
> -
> -##
> -# @VirtioPMEMDeviceInfo:
> -#
> -# VirtioPMEM state information
> -#
> -# @id: device's ID
> -#
> -# @memaddr: physical address in memory, where device is mapped
> -#
> -# @size: size of memory that the device provides
> -#
> -# @memdev: memory backend linked with device
> -#
> -# Since: 4.1
> -##
> -{ 'struct': 'VirtioPMEMDeviceInfo',
> -  'data': { '*id': 'str',
> -            'memaddr': 'size',
> -            'size': 'size',
> -            'memdev': 'str'
> -          }
> -}
> -
> -##
> -# @MemoryDeviceInfo:
> -#
> -# Union containing information about a memory device
> -#
> -# nvdimm is included since 2.12. virtio-pmem is included since 4.1.
> -#
> -# Since: 2.1
> -##
> -{ 'union': 'MemoryDeviceInfo',
> -  'data': { 'dimm': 'PCDIMMDeviceInfo',
> -            'nvdimm': 'PCDIMMDeviceInfo',
> -            'virtio-pmem': 'VirtioPMEMDeviceInfo'
> -          }
> -}
> -
> -##
> -# @query-memory-devices:
> -#
> -# Lists available memory devices and their state
> -#
> -# Since: 2.1
> -#
> -# Example:
> -#
> -# -> { "execute": "query-memory-devices" }
> -# <- { "return": [ { "data":
> -#                       { "addr": 5368709120,
> -#                         "hotpluggable": true,
> -#                         "hotplugged": true,
> -#                         "id": "d1",
> -#                         "memdev": "/objects/memX",
> -#                         "node": 0,
> -#                         "size": 1073741824,
> -#                         "slot": 0},
> -#                    "type": "dimm"
> -#                  } ] }
> -#
> -##
> -{ 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
> -
>  ##
>  # @ReplayMode:
>  #
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-devic=
e.h
> index 04476acb8f..76f3de0f7e 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -14,6 +14,7 @@
>  #define MEMORY_DEVICE_H
> =20
>  #include "hw/qdev-core.h"
> +#include "qapi/qapi-types-machine.h"
>  #include "qapi/qapi-types-misc.h"
>  #include "qom/object.h"
> =20
> diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-p=
mem.h
> index 33f1999320..72863412b2 100644
> --- a/include/hw/virtio/virtio-pmem.h
> +++ b/include/hw/virtio/virtio-pmem.h
> @@ -15,7 +15,7 @@
>  #define HW_VIRTIO_PMEM_H
> =20
>  #include "hw/virtio/virtio.h"
> -#include "qapi/qapi-types-misc.h"
> +#include "qapi/qapi-types-machine.h"
> =20
>  #define TYPE_VIRTIO_PMEM "virtio-pmem"
> =20


