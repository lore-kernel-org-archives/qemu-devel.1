Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FE0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD652065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6H2iili"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD652065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskrQ-0003U1-PJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jskq5-0001Vp-Ku
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:28:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jskq3-0004Ss-U2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594117715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=okpc1VCIsq822zaflyyibcEFb4pbwgTvLcH+yMdcyu0=;
 b=c6H2iiliN3uR82Ywb55qhfDNSM6wg+WQXQpRy9oa5Sl9a2nGjbm18XpY2RxB0199/qlGc0
 XDDlkmDJ2QZtYmVEXJJa36IXvi/AoVp92gm5/vyqmewP0VjNKBn5uOC1SEtzENUPcD4TnG
 evwAC71KLcV3MhGV1whXdY7zvDVjNjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-1wbGHgfSO9i1NbwTkcCofA-1; Tue, 07 Jul 2020 06:28:33 -0400
X-MC-Unique: 1wbGHgfSO9i1NbwTkcCofA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 040D5107ACF2;
 Tue,  7 Jul 2020 10:28:32 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E57560E1C;
 Tue,  7 Jul 2020 10:28:23 +0000 (UTC)
Date: Tue, 7 Jul 2020 12:28:20 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] virt/acpi: set PSCI flag even when psci_conduit is disabled
Message-ID: <20200707102820.tfbmnendbrm6vdbv@kamzik.brq.redhat.com>
References: <1593769409-13534-1-git-send-email-guoheyi@linux.alibaba.com>
 <CAFEAcA8RU6fS8PX7LMhn4U33nKoRvcO_mnyBFcmW3iOpA40sCQ@mail.gmail.com>
 <00016872-f1ca-5989-8ad6-28cf05ea0c57@linux.alibaba.com>
 <CAFEAcA-eyudHSQhEaM-G5hpVOqEG4G_kZpT=vjraciux-7P7Bw@mail.gmail.com>
 <20200707100436.72ldilqrnwc7pg55@kamzik.brq.redhat.com>
 <CAFEAcA-h1wXyeqymz3jYiVA_fmADe=C8eAewxUXtLL6ERbqJgw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-h1wXyeqymz3jYiVA_fmADe=C8eAewxUXtLL6ERbqJgw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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

On Tue, Jul 07, 2020 at 11:15:30AM +0100, Peter Maydell wrote:
> On Tue, 7 Jul 2020 at 11:04, Andrew Jones <drjones@redhat.com> wrote:
> > This seems a bit messy to me. With an EL3 firmware, the DTB is provided
> > by the EL3 firmware. I guess that's why when I look at the DTB generation
> > in virt.c we don't properly set "enable-method" of the CPUs to
> > "spin-table", even though we don't set it to "psci"[*].
> 
> Well, there's no way in the DTB to say "all the CPUs start at once" :-)
> "spin-table" would be just as wrong as "psci" for us in that case.
> 
> > So, I think the EL3 firmware should also provide the ACPI tables.
> 
> Mmm, but I thought the general design for QEMU was that we have
> to help the EL3 firmware along by providing ACPI fragments for it
> to assemble. As I understand it, this is a pragmatic decision
> because the binary format of a complete ACPI table is painful
> to edit. So I suppose one question here is "if QEMU doesn't set
> the PSCI flag in the ACPI tables, how hard is it for the EL3
> firmware to edit the table to add the flag?".
> 
> > However, this patch it probably fine too. For a configuration where
> > the EL3 firmware provides the ACPI tables, it will do no harm. For
> > configurations where EL3 firmware isn't involved, it will do no harm.
> > And, for configurations like this, which I consider a bit hacky, it's
> > probably better to assume PSCI than not.
> 
> Is this really a 'hacky' configuration? I sort of expected it to
> be a fairly common one for the 'virt' board. (For sbsa-ref the
> EL3 firmware would provide a complete canned ACPI table, I think,
> but for virt it can't and shouldn't do that.)

IMO, if the EL3 firmware is providing the complete DTB, then it should
provide the complete ACPI tables. Otherwise we should expose machine
properties allowing the virt board to generate both DTB and ACPI for an
EL3 firmware configuration.

The other option of using fw-cfg to tweak ACPI tables may work too, but
only for tweaks. If the EL3 firmware controlled DTB changed in a way
that diverges too much from QEMU's ACPI generation, then there'd still
be a problem.

Thanks,
drew


