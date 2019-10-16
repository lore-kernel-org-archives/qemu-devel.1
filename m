Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A69FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296C320640
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296C320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKkUf-0004dW-A1
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 10:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKkTJ-0003m4-HA
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKkTI-0002vw-BZ
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:40:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKkTI-0002vZ-3X
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D88A10DCC8C
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 14:40:15 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C99A1001B35;
 Wed, 16 Oct 2019 14:40:06 +0000 (UTC)
Date: Wed, 16 Oct 2019 11:40:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 0/4] apic: Fix migration breakage of >255 vcpus
Message-ID: <20191016144001.GE4084@habkost.net>
References: <20191016022933.7276-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016022933.7276-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Wed, 16 Oct 2019 14:40:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 10:29:29AM +0800, Peter Xu wrote:
> v2:
> - use uint32_t rather than int64_t [Juan]
> - one more patch (patch 4) to check dup SaveStateEntry [Dave]
> - one more patch to define a macro (patch 1) to simplify patch 2
> 
> Please review, thanks.

I wonder how hard it is to write a simple test case to reproduce
the original bug.  We can extend tests/migration-test.c or
tests/acceptance/migration.py.  If using -device with explicit
apic-id, we probably don't even need to create >255 VCPUs.

> 
> Peter Xu (4):
>   migration: Define VMSTATE_INSTANCE_ID_ANY
>   migration: Change SaveStateEntry.instance_id into uint32_t
>   apic: Use 32bit APIC ID for migration instance ID
>   migration: Check in savevm_state_handler_insert for dups
> 
>  hw/arm/stellaris.c           |  2 +-
>  hw/core/qdev.c               |  3 ++-
>  hw/display/ads7846.c         |  2 +-
>  hw/i2c/core.c                |  2 +-
>  hw/input/stellaris_input.c   |  3 ++-
>  hw/intc/apic_common.c        |  7 +++++--
>  hw/misc/max111x.c            |  2 +-
>  hw/net/eepro100.c            |  2 +-
>  hw/pci/pci.c                 |  2 +-
>  hw/ppc/spapr.c               |  2 +-
>  hw/timer/arm_timer.c         |  2 +-
>  hw/tpm/tpm_emulator.c        |  3 ++-
>  include/migration/register.h |  2 +-
>  include/migration/vmstate.h  |  6 ++++--
>  migration/savevm.c           | 40 +++++++++++++++++++++++++-----------
>  stubs/vmstate.c              |  2 +-
>  16 files changed, 53 insertions(+), 29 deletions(-)
> 
> -- 
> 2.21.0
> 

-- 
Eduardo

