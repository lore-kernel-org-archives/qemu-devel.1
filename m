Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD1C2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 07:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB1720706
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 07:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2liXCVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB1720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijeoT-00019L-Ir
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 02:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ijenN-0000DL-Sc
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 02:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ijenL-0002mg-6v
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 02:39:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ijenI-0002lr-88
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 02:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577173191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGJP6+ula4Kds+MGAy+5EyTiOxYEIVarv7O6UPBDLFI=;
 b=U2liXCVDbwqNicoVBuJsP9l1bX1dzHB4LEEN5yTpQFZiJjjAWphecyOkRNW5eNTRU1ExES
 CV8DG094nTRWFt/i8ghFOHqIB1WV50s2SKqhIuaAijN1A5o1wJU239KBLz+84vm3PCMNW0
 L36qH6pM9MQ8yEbli4zkvuSbMh7S7PQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-CP2_L6rzNKWoMperVLFUlA-1; Tue, 24 Dec 2019 02:39:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 862D4107ACC4;
 Tue, 24 Dec 2019 07:39:45 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F1DA81740;
 Tue, 24 Dec 2019 07:39:34 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 18/20] virtio-iommu: Support migration
To: Peter Xu <peterx@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-19-eric.auger@redhat.com> <20191210200110.GM3352@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8b4829a5-f0f4-d4c6-c47e-a6dfc182a283@redhat.com>
Date: Tue, 24 Dec 2019 08:39:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191210200110.GM3352@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: CP2_L6rzNKWoMperVLFUlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 12/10/19 9:01 PM, Peter Xu wrote:
> On Fri, Nov 22, 2019 at 07:29:41PM +0100, Eric Auger wrote:
>> +static const VMStateDescription vmstate_virtio_iommu_device = {
>> +    .name = "virtio-iommu-device",
>> +    .minimum_version_id = 1,
>> +    .version_id = 1,
>> +    .post_load = iommu_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 1,
>> +                                   &vmstate_domain, viommu_domain),
>> +        VMSTATE_GTREE_DIRECT_KEY_V(endpoints, VirtIOIOMMU, 1,
>> +                                   &vmstate_endpoint, viommu_endpoint),
> 
> IIUC vmstate_domain already contains all the endpoint information (in
> endpoint_list of vmstate_domain), but here we migrate it twice. 

I migrated both because at that time I considered we could have
endpoints not attached to any domains but I think I can now simplify
based on the fact any EP is attached.


 I
> suppose that's why now we need reconstruct_ep_domain_link() to fixup
> the duplicated migration?

Even if I only migrate the domain gtree, I need to reconstruct the
ep->domain which was not migrated, on purpose, as it pointed to the old
domain in the origin.
> 
> Then I'll instead ask whether we can skip migrating here?  Then in
> post_load we simply:
> 
>   foreach(domain)
>     foreach(endpoint in domain)
>       g_tree_insert(s->endpoints);
> 
> It might help to avoid the reconstruct_ep_domain_link ugliness?
I agree that it is simpler. Also need to update the ep->domain as
mentionned above. Thank you for the suggestion.


> 
> And besides, I also agree with Jean that the endpoint data structure
> could be reused with IOMMUDevice somehow.

As I replied to Jean, I think it makes sense to keep both structures as
endpoints are not indexed by the same key and the bus number is resolved
later.

Thanks

Eric
> 
> Thanks,
> 


