Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E23BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70D220704
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhXn6Chf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70D220704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdaXl-0003IV-6c
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 10:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jdaTU-0001ON-1V
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:22:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47667
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jdaTS-00006S-6e
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590502953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJJJueX7AQo7+yPqQeAFEAHFKBBtCyDy7VQoB3Ju6iA=;
 b=UhXn6ChfNz6+u1HHBAFd6nSGPYaPi3K95XhJ8mylWnLryMnEOdhLQNBuCmZaYU9LkNU3YR
 ssArpqNVStg8R6f5ylGulniOe7p+qqJ9WJcPAHepWVP1dPHcL4w5VkCHtvDw/HXsYDzMmo
 zeYkhjCRRNOBAvr3gJ5HtdketW5Fxcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-O2ND-AFWOyaDcCSKDN72jQ-1; Tue, 26 May 2020 10:22:31 -0400
X-MC-Unique: O2ND-AFWOyaDcCSKDN72jQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6063F8018A7;
 Tue, 26 May 2020 14:22:30 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-102.rdu2.redhat.com [10.10.115.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79BCB5C1C5;
 Tue, 26 May 2020 14:22:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id E7A4722036E; Tue, 26 May 2020 10:22:19 -0400 (EDT)
Date: Tue, 26 May 2020 10:22:19 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices
 on all buses
Message-ID: <20200526142219.GE108774@redhat.com>
References: <20200525084511.51379-1-david@redhat.com>
 <20200526132840.GD108774@redhat.com>
 <dddadb61-b0af-a9c0-64f8-ac3c47d37566@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dddadb61-b0af-a9c0-64f8-ac3c47d37566@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 03:44:10PM +0200, David Hildenbrand wrote:
> On 26.05.20 15:28, Vivek Goyal wrote:
> > On Mon, May 25, 2020 at 10:45:11AM +0200, David Hildenbrand wrote:
> >> E.g., with "pc-q35-4.2", trying to coldplug a virtio-pmem-pci devices
> >> results in
> >>     "virtio-pmem-pci not supported on this bus"
> >>
> >> Reasons is, that the bus does not support hotplug and, therefore, does
> >> not have a hotplug handler. Let's allow coldplugging virtio-pmem devices
> >> on such buses. The hotplug order is only relevant for virtio-pmem-pci
> >> when the guest is already alive and the device is visible before
> >> memory_device_plug() wired up the memory device bits.
> >>
> >> Hotplug attempts will still fail with:
> >>     "Error: Bus 'pcie.0' does not support hotplugging"
> >>
> >> Hotunplug attempts will still fail with:
> >>     "Error: Bus 'pcie.0' does not support hotplugging"
> >>
> >> Reported-by: Vivek Goyal <vgoyal@redhat.com>
> >> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Richard Henderson <rth@twiddle.net>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/i386/pc.c | 18 ++++++++++--------
> >>  1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > Thanks for the patch David. I still seem to face a different error though.
> > 
> > 2020-05-26T13:26:05.720617Z qemu-system-x86_64: -device virtio-pmem-pci,memdev=pmem1,id=nv1: memory devices (e.g. for memory hotplug) are not enabled, please specify the maxmem option
> > 
> > Following is my domain xml file.
> > 
> > Vivek
> 
> Hi Vivek,
> 
> you have to declare the maxMemory option. Memory devices like
> virtio-pmem-pci reside in RAM like a pc-dimm or a nvdimm. If your
> virtio-pmem device will be 4GB, you have to add that to maxMemory.
> 
>   <memory unit='GiB'>64</memory>
>   <maxMemory unit='GiB'>68</maxMemory>
>   <currentMemory unit='GiB'>64</currentMemory>
> 
> (you might have to add "slots='0'" or "slots='1'" to maxMemory to make
> libvirt happy)

Ok, tried that.

<maxMemory slots='1' unit='KiB'>134217728</maxMemory>

And now it complains about.

error: unsupported configuration: At least one numa node has to be configured when enabling memory hotplug

So ultimately it seems to be wanting me to somehow enable memory hotplug
to be able to use virtio-pmem?

Thanks
Vivek

> 
> @Pankaj, do we have a virtio-pmem doc somewhere describing how to set it up?
> 
> -- 
> Thanks,
> 
> David / dhildenb


