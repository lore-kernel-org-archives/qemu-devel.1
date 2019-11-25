Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D34C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11361207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxtuzZw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11361207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZAp6-0000BN-3E
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 04:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iZAo4-0007vR-SH
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iZAo3-0005yu-8N
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:37:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28737
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iZAo3-0005wO-4o
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574674638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiqjedxAFN+dSi/udCuMYwMO1iGMtAE7u2HqW+1iDsw=;
 b=MxtuzZw5NL03FbM1TZmzrCMsI9B+zKBv7AMa7WQyFnKHK2+IGNEEm67AJnfti1um6rERMJ
 BzGcmNRuKI3g4VPw+mVUKyfnvNvHyL/XqGCBO8lMNfF736rPGlCvtYa1eQ/MUm6flRAanU
 LhbM7CjykuSwiennrERXZzNrucaThPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-LZIhOXWON6yAqii7gehcAg-1; Mon, 25 Nov 2019 04:37:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93B7B801E5E;
 Mon, 25 Nov 2019 09:37:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DA585C1D4;
 Mon, 25 Nov 2019 09:37:08 +0000 (UTC)
Date: Mon, 25 Nov 2019 10:37:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [RESEND PATCH v21 5/6] target-arm: kvm64: handle SIGBUS signal
 from kernel or KVM
Message-ID: <20191125103706.46300ff1@redhat.com>
In-Reply-To: <CADSWDzsg9aMCbbLadmc+twmJw3dZvRYgqKKWsDQRiJSRS7=GDQ@mail.gmail.com>
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-6-zhengxiang9@huawei.com>
 <20191115173713.795e5f63@redhat.com>
 <CADSWDzsg9aMCbbLadmc+twmJw3dZvRYgqKKWsDQRiJSRS7=GDQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: LZIhOXWON6yAqii7gehcAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com, mtosatti@redhat.com,
 linuxarm@huawei.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, wanghaibin.wang@huawei.com,
 gengdongjiu@huawei.com, Laszlo Ersek <lersek@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 Nov 2019 15:47:24 +0000
Beata Michalska <beata.michalska@linaro.org> wrote:

> Hi,
> 
> On Fri, 15 Nov 2019 at 16:54, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Mon, 11 Nov 2019 09:40:47 +0800
> > Xiang Zheng <zhengxiang9@huawei.com> wrote:
> >  
> > > From: Dongjiu Geng <gengdongjiu@huawei.com>
> > >
> > > Add a SIGBUS signal handler. In this handler, it checks the SIGBUS type,
> > > translates the host VA delivered by host to guest PA, then fills this PA
> > > to guest APEI GHES memory, then notifies guest according to the SIGBUS
> > > type.
> > >
> > > When guest accesses the poisoned memory, it will generate a Synchronous
> > > External Abort(SEA). Then host kernel gets an APEI notification and calls
> > > memory_failure() to unmapped the affected page in stage 2, finally
> > > returns to guest.
> > >
> > > Guest continues to access the PG_hwpoison page, it will trap to KVM as
> > > stage2 fault, then a SIGBUS_MCEERR_AR synchronous signal is delivered to
> > > Qemu, Qemu records this error address into guest APEI GHES memory and
> > > notifes guest using Synchronous-External-Abort(SEA).
> > >
> > > In order to inject a vSEA, we introduce the kvm_inject_arm_sea() function
> > > in which we can setup the type of exception and the syndrome information.
> > > When switching to guest, the target vcpu will jump to the synchronous
> > > external abort vector table entry.
> > >
> > > The ESR_ELx.DFSC is set to synchronous external abort(0x10), and the
> > > ESR_ELx.FnV is set to not valid(0x1), which will tell guest that FAR is
> > > not valid and hold an UNKNOWN value. These values will be set to KVM
> > > register structures through KVM_SET_ONE_REG IOCTL.
> > >
> > > Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> > > Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  hw/acpi/acpi_ghes.c         | 297 ++++++++++++++++++++++++++++++++++++
[...]
> > > +static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> > > +                                      uint64_t error_physical_addr,
> > > +                                      uint32_t data_length)
> > > +{
> > > +    GArray *block;
> > > +    uint64_t current_block_length;
> > > +    /* Memory Error Section Type */
> > > +    QemuUUID mem_section_id_le = UEFI_CPER_SEC_PLATFORM_MEM;  
> >                                ^^
> > UEFI_CPER_SEC_PLATFORM_MEM is defined as BE, so _le here is wrong
> > and then later you use qemu_uuid_bswap() to make it LE.
> >
> > Why not define it as LE to begin with, like it's been done for NVDIMM_UUID_LE?
> >  
> Is there a chance to make it common for both ?

sure, it just should be a separate patch.

Maybe put it in include/qemu/uuid.h
or maybe make qemu_uuid_parse() return QemuUUID
so we could initialize like this:
  QemuUUID mem_section_id_le = qemu_uuid_parse("00000000-0000-0000-0000-000000000000", &error_abort);
where used UUID value is easy to read and compare with spec.

[...]


