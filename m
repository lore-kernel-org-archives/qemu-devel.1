Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A113C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B84620936
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9br2KJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B84620936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVhD-00005G-FJ
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kVVgS-0007ly-Hk
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kVVgK-0000cY-CJ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603354240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4menn46JEe0tHk8zdMP/xpl7sYIJxXvoGqmU3Un7AQ=;
 b=f9br2KJTCgWRrhvX2gk1BLksC6auZlJraF0ipH3VYA7ATyVzHWQdicDgPb85erJ46caqa6
 euCfcbWZV+BeqPC+Uj1Usf4tthPfdEQZaK87NghbokhpIt1ryMczkndpUkmz4fiQ5C/4tS
 hXfJyhDM6T+ckx19HMa0lE0bmakwj+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-1_xwl2v4MVaeTuooLd4WlA-1; Thu, 22 Oct 2020 04:10:39 -0400
X-MC-Unique: 1_xwl2v4MVaeTuooLd4WlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D230B86ABDB;
 Thu, 22 Oct 2020 08:10:37 +0000 (UTC)
Received: from [10.36.113.152] (ovpn-113-152.ams2.redhat.com [10.36.113.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CCAB5B4C1;
 Thu, 22 Oct 2020 08:10:33 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] virtio-mem: block size and address-assignment
 optimizations
To: qemu-devel@nongnu.org
References: <20201008083029.9504-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <242d30e9-f22b-d570-0186-629792f5bdf1@redhat.com>
Date: Thu, 22 Oct 2020 10:10:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008083029.9504-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.10.20 10:30, David Hildenbrand wrote:
> 
> 
> Let's try to detect the actual THP size and use it as default block size
> (unless the page size of the backend indicates that THP don't apply).
> Always allow to set a block size of 1 MiB, but warn if the configured block
> size is smaller than the default. Handle large block sizes better, avoiding
> a virtio-spec violation and optimizing address auto-detection.
> 
> For existing setups (x86-64), the default block size won't change (was, and
> will be 2 MiB on anonymous memory). For existing x86-64 setups, the address
> auto-detection won't change in relevant setups (esp., anonymous memory
> and hugetlbfs with 2 MiB pages and no manual configuration of the block
> size). I don't see the need for compatibility handling (especially, as
> virtio-mem is still not considered production-ready).
> 
> Most of this is a preparation for future architectures, using hugetlbfs
> to full extend, and using manually configured, larger block sizes
> (relevant for vfio in the future).

Ping.

-- 
Thanks,

David / dhildenb


