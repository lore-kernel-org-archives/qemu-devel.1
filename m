Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB01C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3A0207D0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVt6FjT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3A0207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhA1R-0005fB-Sb
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhA0Q-0004k2-0c
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:55:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35534
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhA0P-0004wS-6h
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591354519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jqzEFAmP+wiSC+oGpCImeB7+gOsv977I/lhj0oFVSo=;
 b=EVt6FjT9Jm8j+Za6rWwZq/d7Pbqum3D6e4TqZCJ3X2CYH0f4B9FwZsyV6xcuPWBe2ql35s
 ylu9ns9acAfeCms9u7E1YN1+9XDukd3yoEfxbp8WDj10WHi0EJgNOSnp2EJpHwj9vH0IeK
 qhb65swBVjnwxYUj68TvfymokRREK2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-2KNrhLL4P7G99GlRwg7b4w-1; Fri, 05 Jun 2020 06:55:15 -0400
X-MC-Unique: 2KNrhLL4P7G99GlRwg7b4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A366B1005512;
 Fri,  5 Jun 2020 10:55:13 +0000 (UTC)
Received: from gondolin (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20C01579A3;
 Fri,  5 Jun 2020 10:55:07 +0000 (UTC)
Date: Fri, 5 Jun 2020 12:55:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200605125505.3fdd7de8.cohuck@redhat.com>
In-Reply-To: <20200521034304.340040-1-david@gibson.dropbear.id.au>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 13:42:46 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> A number of hardware platforms are implementing mechanisms whereby the
> hypervisor does not have unfettered access to guest memory, in order
> to mitigate the security impact of a compromised hypervisor.
> 
> AMD's SEV implements this with in-cpu memory encryption, and Intel has
> its own memory encryption mechanism.  POWER has an upcoming mechanism
> to accomplish this in a different way, using a new memory protection
> level plus a small trusted ultravisor.  s390 also has a protected
> execution environment.
> 
> The current code (committed or draft) for these features has each
> platform's version configured entirely differently.  That doesn't seem
> ideal for users, or particularly for management layers.
> 
> AMD SEV introduces a notionally generic machine option
> "machine-encryption", but it doesn't actually cover any cases other
> than SEV.
> 
> This series is a proposal to at least partially unify configuration
> for these mechanisms, by renaming and generalizing AMD's
> "memory-encryption" property.  It is replaced by a
> "guest-memory-protection" property pointing to a platform specific
> object which configures and manages the specific details.
> 
> For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> can be extended to cover the Intel and s390 mechanisms as well,
> though.

For s390, there's the 'unpack' cpu facility bit, which is indicated iff
the kernel indicates availability of the feature (depending on hardware
support). If that cpu facility is available, a guest can choose to
transition into protected mode. The current state (protected mode or
not) is tracked in the s390 ccw machine.

If I understand the series here correctly (I only did a quick
read-through), the user has to instruct QEMU to make protection
available, via a new machine property that links to an object?

> 
> Note: I'm using the term "guest memory protection" throughout to refer
> to mechanisms like this.  I don't particular like the term, it's both
> long and not really precise.  If someone can think of a succinct way
> of saying "a means of protecting guest memory from a possibly
> compromised hypervisor", I'd be grateful for the suggestion.
> 
> Changes since v1:
>  * Rebased
>  * Fixed some errors pointed out by Dave Gilbert
> 
> David Gibson (18):
>   target/i386: sev: Remove unused QSevGuestInfoClass
>   target/i386: sev: Move local structure definitions into .c file
>   target/i386: sev: Rename QSevGuestInfo
>   target/i386: sev: Embed SEVState in SevGuestState
>   target/i386: sev: Partial cleanup to sev_state global
>   target/i386: sev: Remove redundant cbitpos and reduced_phys_bits
>     fields
>   target/i386: sev: Remove redundant policy field
>   target/i386: sev: Remove redundant handle field
>   target/i386: sev: Unify SEVState and SevGuestState
>   guest memory protection: Add guest memory protection interface
>   guest memory protection: Handle memory encrption via interface
>   guest memory protection: Perform KVM init via interface
>   guest memory protection: Move side effect out of
>     machine_set_memory_encryption()
>   guest memory protection: Rework the "memory-encryption" property
>   guest memory protection: Decouple kvm_memcrypt_*() helpers from KVM
>   guest memory protection: Add Error ** to
>     GuestMemoryProtection::kvm_init
>   spapr: Added PEF based guest memory protection
>   guest memory protection: Alter virtio default properties for protected
>     guests
> 
>  accel/kvm/kvm-all.c                    |  40 +--
>  accel/kvm/sev-stub.c                   |   5 -
>  accel/stubs/kvm-stub.c                 |  10 -
>  backends/Makefile.objs                 |   2 +
>  backends/guest-memory-protection.c     |  29 ++
>  hw/core/machine.c                      |  61 ++++-
>  hw/i386/pc_sysfw.c                     |   6 +-
>  include/exec/guest-memory-protection.h |  77 ++++++
>  include/hw/boards.h                    |   4 +-
>  include/sysemu/kvm.h                   |  17 --
>  include/sysemu/sev.h                   |   6 +-
>  target/i386/sev.c                      | 351 +++++++++++++------------
>  target/i386/sev_i386.h                 |  49 ----
>  target/ppc/Makefile.objs               |   2 +-
>  target/ppc/pef.c                       |  81 ++++++
>  15 files changed, 441 insertions(+), 299 deletions(-)
>  create mode 100644 backends/guest-memory-protection.c
>  create mode 100644 include/exec/guest-memory-protection.h
>  create mode 100644 target/ppc/pef.c
> 


