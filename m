Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D69C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D276206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F68NYpnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D276206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jye7L-0000pp-O6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 12:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jye64-0000Ag-Rp
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:29:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45311
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jye62-0001rE-0f
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595521764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCXe3jfotzbUvjD8I3tsHxWwbY51L/PudZ2QLiT+y4I=;
 b=F68NYpnWePe40b+Z4g4ahbVb6ZtPI9vuJTvfNxVeZ67rIDgjzc60XrYCBzMHB6FoYKGTE2
 bf4054kgE6JpHiPYlpZCOfMbb8WF4YkZDTa/2/L8TaItqxUCuElM1uIpwsuLmks16CRzZJ
 fthXqHxs+G0HC7EqeqDwwKAb3DRWRXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-hpE9W005M6a1hRLzUP7obQ-1; Thu, 23 Jul 2020 12:29:22 -0400
X-MC-Unique: hpE9W005M6a1hRLzUP7obQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB6BB1005504;
 Thu, 23 Jul 2020 16:29:20 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA787854D;
 Thu, 23 Jul 2020 16:29:17 +0000 (UTC)
Date: Thu, 23 Jul 2020 10:29:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [RFC PATCH] s390x/pci: vfio-pci breakage with disabled mem
 enforcement
Message-ID: <20200723102916.7cf15b43@w520.home>
In-Reply-To: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
References: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jul 2020 11:13:55 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> I noticed that after kernel commit abafbc55 'vfio-pci: Invalidate mmaps
> and block MMIO access on disabled memory' vfio-pci via qemu on s390x
> fails spectacularly, with errors in qemu like:
> 
> qemu-system-s390x: vfio_region_read(0001:00:00.0:region0+0x0, 4) failed: Input/output error
> 
> From read to bar 0 originating out of hw/s390x/s390-pci-inst.c:zpci_read_bar().
> 
> So, I'm trying to figure out how to get vfio-pci happy again on s390x.  From
> a bit of tracing, we seem to be triggering the new trap in
> __vfio_pci_memory_enabled().  Sure enough, if I just force this function to
> return 'true' as a test case, things work again.
> The included patch attempts to enforce the setting, which restores everything
> to working order but also triggers vfio_bar_restore() in the process....  So
> this isn't the right answer, more of a proof-of-concept.
> 
> @Alex: Any guidance on what needs to happen to make qemu-s390x happy with this
> recent kernel change?

Bummer!  I won't claim to understand s390 PCI, but if we have a VF
exposed to the "host" (ie. the first level where vfio-pci is being
used), but we can't tell that it's a VF, how do we know whether the
memory bit in the command register is unimplemented because it's a VF
or unimplemented because the device doesn't support MMIO?  How are the
device ID, vendor ID, and BAR registers virtualized to the host?  Could
the memory enable bit also be emulated by that virtualization, much
like vfio-pci does for userspace?  If the other registers are
virtualized, but these command register bits are left unimplemented, do
we need code to deduce that we have a VF based on the existence of MMIO
BARs, but lack of memory enable bit?  Thanks,

Alex

> @Nilkas/@Pierre: I wonder if this might be related to host device is_virtfn?
> I note that my host device lspci output looks like:
> 
> 0000:00:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx Virtual Function]
> 
> But the device is not marked as is_virtfn..  Otherwise, Alex's fix
> from htps://lkml.org/lkml/2020/6/25/628 should cover the case.
> 
> 
> 
> Matthew Rosato (1):
>   s390x/pci: Enforce PCI_COMMAND_MEMORY for vfio-pci
> 
>  hw/s390x/s390-pci-inst.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 


