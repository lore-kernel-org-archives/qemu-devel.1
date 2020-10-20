Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E91C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46785221FC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsTSRlqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46785221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUy1U-0004CD-8S
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 16:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kUy0v-0003l4-Ap
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kUy0t-0005Z0-Ct
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603224821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Si+kOBodxev9CFQ/JdzQEEJg5tM5eQY0GT/Kn2KgFbw=;
 b=PsTSRlqMEAOp48dU9M45jZs6NsKN+HBqhMGWRDc7FQRj5x1HCgHpPi1nEG7IdBSxszUc/9
 HSwHZgTKZV7ysr/ueveeyMjT1b+ynEWi1JkgEce2Y8WQ/35g3MMFRFODQNqVY2482p+dOw
 CP/ICZE9pPOGrzMntNatw5YOcIj9DbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-4i9TQo8dPiCU2F1AuPt4bw-1; Tue, 20 Oct 2020 16:13:39 -0400
X-MC-Unique: 4i9TQo8dPiCU2F1AuPt4bw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AFBD18A0764;
 Tue, 20 Oct 2020 20:13:38 +0000 (UTC)
Received: from [10.36.114.141] (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88B3F1002C12;
 Tue, 20 Oct 2020 20:13:22 +0000 (UTC)
Subject: Re: [PATCH PROTOTYPE 1/6] memory: Introduce sparse RAM handler for
 memory regions
To: Peter Xu <peterx@redhat.com>
References: <20200924160423.106747-1-david@redhat.com>
 <20200924160423.106747-2-david@redhat.com> <20201020192401.GC200400@xz-x1>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <669a2e0b-3338-b485-3adb-5477da1aa309@redhat.com>
Date: Tue, 20 Oct 2020 22:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020192401.GC200400@xz-x1>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.10.20 21:24, Peter Xu wrote:
> On Thu, Sep 24, 2020 at 06:04:18PM +0200, David Hildenbrand wrote:
>> +static inline void memory_region_set_sparse_ram_handler(MemoryRegion *mr,
>> +                                                        SparseRAMHandler *srh)
>> +{
>> +    g_assert(memory_region_is_ram(mr));
> 
> Nit: Maybe assert mr->srh==NULL here?  If sparse ram handler is exclusive,
> which afaiu, is a yes.

Indeed. The owner of the memory region.

> 
>> +    mr->srh = srh;
>> +}
>> +
>> +static inline void memory_region_register_sparse_ram_notifier(MemoryRegion *mr,
>> +                                                           SparseRAMNotifier *n)
>> +{
>> +    SparseRAMHandler *srh = memory_region_get_sparse_ram_handler(mr);
>> +    SparseRAMHandlerClass *srhc = SPARSE_RAM_HANDLER_GET_CLASS(srh);
>> +
>> +    srhc->register_listener(srh, mr, n);
> 
> I feel like you need to check srhc!=NULL first or vfio may start crash without
> virtio-mem...  Same question to the other ones (at least unregister).

I think nobody should be calling this function unless
memory_region_is_sparse_ram() returns true.

I'm still considering moving it down to RAMBlock level. Feels more
natural, and would allow other RAMBlock users figure out what's going
on. If only my list of TODO items wouldn't be that long ... :)

Thanks Peter!

-- 
Thanks,

David / dhildenb


