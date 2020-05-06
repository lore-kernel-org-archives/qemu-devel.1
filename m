Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E845DC4724C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 16:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4289208CA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 16:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fO2+sJR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4289208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWMfr-0002QF-QY
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 12:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWMf9-0001zY-4N
 for qemu-devel@nongnu.org; Wed, 06 May 2020 12:12:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWMf8-00016K-1G
 for qemu-devel@nongnu.org; Wed, 06 May 2020 12:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588781564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZRDjL7nazpxt3wSuOJ5/WwzUELoarexy41YvOu/dZk=;
 b=fO2+sJR5zdNpOEumdJoYB53TZHtU3uWK2wIhElMw2MpyGPkdmJaDT5H5qrK2BVyerrSL69
 O7jeSlsdgDQcw6Qyh7v3xySBL4yMX96JOjg+tkh6H3dOu8Qd3G4qpbjnNvPBG+eNkcpw5B
 GSUxl7ZPtD9IWQKG8cXZXrg/GzyAr3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-l-m5nLYwP7axoWQd8MLKoA-1; Wed, 06 May 2020 12:12:37 -0400
X-MC-Unique: l-m5nLYwP7axoWQd8MLKoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E01D41005510;
 Wed,  6 May 2020 16:12:35 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F6CA6299C;
 Wed,  6 May 2020 16:12:29 +0000 (UTC)
Subject: Re: [PATCH v1 10/17] virtio-mem: Paravirtualized memory hot(un)plug
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200506094948.76388-1-david@redhat.com>
 <20200506094948.76388-11-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <051610a8-4773-2de5-0d4c-48e39791f05e@redhat.com>
Date: Wed, 6 May 2020 11:12:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506094948.76388-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 4:49 AM, David Hildenbrand wrote:
> This is the very basic/initial version of virtio-mem. An introduction to
> virtio-mem can be found in the Linux kernel driver [1]. While it can be
> used in the current state for hotplug of a smaller amount of memory, it
> will heavily benefit from resizeable memory regions in the future.
> 
> Each virtio-mem device manages a memory region (provided via a memory
> backend). After requested by the hypervisor ("requested-size"), the
> guest can try to plug/unplug blocks of memory within that region, in order
> to reach the requested size. Initially, and after a reboot, all memory is
> unplugged (except in special cases - reboot during postcopy).
> 
> The guest may only try to plug/unplug blocks of memory within the usable
> region size. The usable region size is a little bigger than the
> requested size, to give the device driver some flexibility. The usable
> region size will only grow, except on reboots or when all memory is
> requested to get unplugged. The guest can never plug more memory than
> requested. Unplugged memory will get zapped/discarded, similar to in a
> balloon device.
> 
> The block size is variable, however, it is always chosen in a way such that
> THP splits are avoided (e.g., 2MB). The state of each block
> (plugged/unplugged) is tracked in a bitmap.
> 
> As virtio-mem devices (e.g., virtio-mem-pci) will be memory devices, we now
> expose "VirtioMEMDeviceInfo" via "query-memory-devices".
> 

> +++ b/qapi/misc.json
> @@ -1354,19 +1354,56 @@
>             }
>   }
>   
> +##
> +# @VirtioMEMDeviceInfo:
> +#

> +# @memdev: memory backend linked with the region
> +#
> +# Since: 5.1

Here you claim 5.1,

> +##
> +{ 'struct': 'VirtioMEMDeviceInfo',
> +  'data': { '*id': 'str',
> +            'memaddr': 'size',
> +            'requested-size': 'size',
> +            'size': 'size',
> +            'max-size': 'size',
> +            'block-size': 'size',
> +            'node': 'int',
> +            'memdev': 'str'
> +          }
> +}
> +
>   ##
>   # @MemoryDeviceInfo:
>   #
>   # Union containing information about a memory device
>   #
>   # nvdimm is included since 2.12. virtio-pmem is included since 4.1.
> +# virtio-mem is included since 5.2.

but here 5.2.  They should probably be the same :)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


