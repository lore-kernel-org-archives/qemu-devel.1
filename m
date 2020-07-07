Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F92C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1E2206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTIBwlzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1E2206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskTu-0005Xg-1b
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jskTB-0004WV-Nq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:04:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jskT9-0008Vd-47
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594116289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkbR018ikHVeo7/9dyvz4wLIubLeaeSzWqnHOFTBsO8=;
 b=GTIBwlzAU+KeLt5m6pwwOroTtTF+SYGQYJMyzKuat3rtmboVgsq8gjcoLpJk0bj3aiBbsu
 NG6te9FZ4nWM9UvIIYImGNTFU9cdJsCVnT//uHEJG3rt469QtW8BwwBijBGKk6BOpYN5os
 ObCscft2+RxBVANJTolFcIsUH2Qv0mk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-NuYVgZ2zOS-CapPihf_R4g-1; Tue, 07 Jul 2020 06:04:46 -0400
X-MC-Unique: NuYVgZ2zOS-CapPihf_R4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40E24800C64;
 Tue,  7 Jul 2020 10:04:45 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B12185C1B2;
 Tue,  7 Jul 2020 10:04:39 +0000 (UTC)
Date: Tue, 7 Jul 2020 12:04:36 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] virt/acpi: set PSCI flag even when psci_conduit is disabled
Message-ID: <20200707100436.72ldilqrnwc7pg55@kamzik.brq.redhat.com>
References: <1593769409-13534-1-git-send-email-guoheyi@linux.alibaba.com>
 <CAFEAcA8RU6fS8PX7LMhn4U33nKoRvcO_mnyBFcmW3iOpA40sCQ@mail.gmail.com>
 <00016872-f1ca-5989-8ad6-28cf05ea0c57@linux.alibaba.com>
 <CAFEAcA-eyudHSQhEaM-G5hpVOqEG4G_kZpT=vjraciux-7P7Bw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-eyudHSQhEaM-G5hpVOqEG4G_kZpT=vjraciux-7P7Bw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: yitian.ly@alibaba-inc.com, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 03:41:05PM +0100, Peter Maydell wrote:
> On Fri, 3 Jul 2020 at 15:36, Heyi Guo <guoheyi@linux.alibaba.com> wrote:
> >
> >
> > 在 2020/7/3 下午6:37, Peter Maydell 写道:
> > > On Fri, 3 Jul 2020 at 10:44, Heyi Guo <guoheyi@linux.alibaba.com> wrote:
> > >> vms->psci_conduit being disabled only means PSCI is not implemented by
> > >> qemu; it doesn't mean PSCI is not supported on this virtual machine.
> > >> Actually vms->psci_conduit is set to disabled when vms->secure and
> > >> firmware_loaded are both set, which means we will run ARM trusted
> > >> firmware, which will definitely provide PSCI.
> > >>
> > >> The issue can be reproduced when running qemu in TCG mode with secure
> > >> enabled, while using ARM trusted firmware + qemu virt UEFI as firmware
> > >> binaries, and we can see secondary cores will not be waken up.
> > > If you're using a real EL3 guest firmware then it's the job of
> > > the guest firmware to provide a DTB to the guest EL2/EL1 that says
> > > "and I support PSCI" if it supports PSCI, surely? QEMU can't tell
> > > whether the EL3 code does or doesn't do that...
> >
> > Thanks, Peter. Does that mean the ACPI tables generated in qemu are only
> > templates and firmware should update them if necessary?
> 
> I don't really know enough about ACPI to say. I hadn't noticed
> that this patch only updated the ACPI tables, sorry. Perhaps it
> is correct; Andrew will probably know better than me.
>

This seems a bit messy to me. With an EL3 firmware, the DTB is provided
by the EL3 firmware. I guess that's why when I look at the DTB generation
in virt.c we don't properly set "enable-method" of the CPUs to
"spin-table", even though we don't set it to "psci"[*]. However, if the
EL3 firmware isn't providing the ACPI tables too, then how do the DTB
and ACPI tables stay in synch? We can't be sure that just because we
have (vms->secure && firmware_loaded) that we should / should not
generate certain ACPI table entries when we don't also know what the
corresponding DTB will be.

So, I think the EL3 firmware should also provide the ACPI tables.
However, this patch it probably fine too. For a configuration where
the EL3 firmware provides the ACPI tables, it will do no harm. For
configurations where EL3 firmware isn't involved, it will do no harm.
And, for configurations like this, which I consider a bit hacky, it's
probably better to assume PSCI than not.

Thanks,
drew

[*] kernel doc Documentation/devicetree/bindings/arm/cpus.yaml says
    "enable-method" must be "spin-table" or "psci"


