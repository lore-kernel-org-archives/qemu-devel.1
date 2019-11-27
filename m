Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B32EC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EAE206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpF6RC97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EAE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZx1w-0008S9-A9
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iZwyG-0007ZG-70
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iZwyE-0006LU-6t
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:03:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iZwyD-0006EB-Vx
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574859781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhNCOsvJPMtp9M0w6J6gP6EZj9Mvu/pSvuBtYlRmiWQ=;
 b=NpF6RC97OFsUOGwfDQxxyjJu7Fs5y6/069QPU6a6fX3C7UIEaFFhzk6cE11gQ9ssl0U1TU
 pQF5GpUeDCLEsOG3SnAVTO1hE/Q3zGOZaAskw17/Ah6G2ajjy9mXL1JltyNE4ZbpGHNape
 89P0hftjHig4X/PGrNZVn/y8TEnsnEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-_aY8ewblOoSi9eA6JHseFw-1; Wed, 27 Nov 2019 08:02:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7594A107BABB;
 Wed, 27 Nov 2019 13:02:57 +0000 (UTC)
Received: from localhost (ovpn-204-134.brq.redhat.com [10.40.204.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 401495C219;
 Wed, 27 Nov 2019 13:02:25 +0000 (UTC)
Date: Wed, 27 Nov 2019 14:02:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [RESEND PATCH v21 5/6] target-arm: kvm64: handle SIGBUS signal
 from kernel or KVM
Message-ID: <20191127140223.58d1a35b@redhat.com>
In-Reply-To: <22a3935a-a672-f8f1-e5be-6c0725f738c4@huawei.com>
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-6-zhengxiang9@huawei.com>
 <CADSWDztF=eaUDNnq8bhnPyTKW1YjAWm4UBaH-NBPkzjnzx0bxg@mail.gmail.com>
 <22a3935a-a672-f8f1-e5be-6c0725f738c4@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _aY8ewblOoSi9eA6JHseFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, kvm@vger.kernel.org,
 mst@redhat.com, wanghaibin.wang@huawei.com, mtosatti@redhat.com,
 linuxarm@huawei.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 gengdongjiu@huawei.com, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 james.morse@arm.com, xuwei5@huawei.com, jonathan.cameron@huawei.com,
 pbonzini@redhat.com, Laszlo Ersek <lersek@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 Nov 2019 20:47:15 +0800
Xiang Zheng <zhengxiang9@huawei.com> wrote:

> Hi Beata,
> 
> Thanks for you review!
> 
> On 2019/11/22 23:47, Beata Michalska wrote:
> > Hi,
> > 
> > On Mon, 11 Nov 2019 at 01:48, Xiang Zheng <zhengxiang9@huawei.com> wrote:  
> >>
> >> From: Dongjiu Geng <gengdongjiu@huawei.com>
> >>
> >> Add a SIGBUS signal handler. In this handler, it checks the SIGBUS type,
> >> translates the host VA delivered by host to guest PA, then fills this PA
> >> to guest APEI GHES memory, then notifies guest according to the SIGBUS
> >> type.
> >>
> >> When guest accesses the poisoned memory, it will generate a Synchronous
> >> External Abort(SEA). Then host kernel gets an APEI notification and calls
> >> memory_failure() to unmapped the affected page in stage 2, finally
> >> returns to guest.
> >>
> >> Guest continues to access the PG_hwpoison page, it will trap to KVM as
> >> stage2 fault, then a SIGBUS_MCEERR_AR synchronous signal is delivered to
> >> Qemu, Qemu records this error address into guest APEI GHES memory and
> >> notifes guest using Synchronous-External-Abort(SEA).
> >>
> >> In order to inject a vSEA, we introduce the kvm_inject_arm_sea() function
> >> in which we can setup the type of exception and the syndrome information.
> >> When switching to guest, the target vcpu will jump to the synchronous
> >> external abort vector table entry.
> >>
> >> The ESR_ELx.DFSC is set to synchronous external abort(0x10), and the
> >> ESR_ELx.FnV is set to not valid(0x1), which will tell guest that FAR is
> >> not valid and hold an UNKNOWN value. These values will be set to KVM
> >> register structures through KVM_SET_ONE_REG IOCTL.
> >>
> >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> >> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >> ---
[...]
> >> diff --git a/include/hw/acpi/acpi_ghes.h b/include/hw/acpi/acpi_ghes.h
> >> index cb62ec9c7b..8e3c5b879e 100644
> >> --- a/include/hw/acpi/acpi_ghes.h
> >> +++ b/include/hw/acpi/acpi_ghes.h
> >> @@ -24,6 +24,9 @@
> >>
> >>  #include "hw/acpi/bios-linker-loader.h"
> >>
> >> +#define ACPI_GHES_CPER_OK                   1
> >> +#define ACPI_GHES_CPER_FAIL                 0
> >> +  
> > 
> > Is there really a need to introduce those ?
> >   
> 
> Don't you think it's more clear than using "1" or "0"? :)

or maybe just reuse default libc return convention: 0 - ok, -1 - fail
and drop custom macros

> 
> >>  /*
> >>   * Values for Hardware Error Notification Type field
> >>   */
[...]


