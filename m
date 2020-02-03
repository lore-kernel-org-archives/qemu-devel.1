Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E56EC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00CB20838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdOEaOoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00CB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydG0-0000mE-3w
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iydEf-0007QO-K4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iydEa-00029b-HC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:02:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iydEa-00029O-DX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580742116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1tdHEbL0o7WKYp4BEXVNY/iTYjFAcPjYJ0lzwgsDes=;
 b=GdOEaOoXroKbHBdSA06iKe5p0cBNz+gv3G4DqP6xbbc9yI9nVOYwghAS3yk1sTVeBb3mEZ
 tbUUTyHo8kwvlpAU6aHeaCqzSNomrs2gx4JmDLLpThZiw0Jv4hLpOBmaz4f1GTMhiF2SJ1
 1bGeF5pROsY8BUSti5oYHTj4bZa0uJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-wL-26xFaPEa2XdlG68MuBw-1; Mon, 03 Feb 2020 10:01:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E4E11903CA9;
 Mon,  3 Feb 2020 15:01:50 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C7BC60BE2;
 Mon,  3 Feb 2020 15:01:42 +0000 (UTC)
Subject: Re: [PATCH v13 06/10] virtio-iommu: Implement fault reporting
To: Peter Xu <peterx@redhat.com>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-7-eric.auger@redhat.com>
 <20200203135503.GC155875@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9797ddd6-f77f-c461-5584-fdfb3d90b92a@redhat.com>
Date: Mon, 3 Feb 2020 16:01:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200203135503.GC155875@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wL-26xFaPEa2XdlG68MuBw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/3/20 2:55 PM, Peter Xu wrote:
> On Sat, Jan 25, 2020 at 06:19:51PM +0100, Eric Auger wrote:
> 
> [...]
> 
>> +static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
>> +                                      int flags, uint32_t endpoint,
>> +                                      uint64_t address)
>> +{
>> +    VirtIODevice *vdev = &viommu->parent_obj;
>> +    VirtQueue *vq = viommu->event_vq;
>> +    struct virtio_iommu_fault fault;
>> +    VirtQueueElement *elem;
>> +    size_t sz;
>> +
>> +    memset(&fault, 0, sizeof(fault));
>> +    fault.reason = reason;
>> +    fault.flags = cpu_to_le32(flags);
>> +    fault.endpoint = cpu_to_le32(endpoint);
>> +    fault.address = cpu_to_le64(address);
>> +
>> +    for (;;) {
>> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>> +
>> +        if (!elem) {
>> +            error_report_once(
>> +                "no buffer available in event queue to report event");
>> +            return;
>> +        }
>> +
>> +        if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
>> +            virtio_error(vdev, "error buffer of wrong size");
>> +            virtqueue_detach_element(vq, elem, 0);
>> +            g_free(elem);
>> +            return;
>> +        }
>> +        break;
> 
> This for loop is not needed any more?  Other than that:
hum yes indeed.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

Eric
> 


