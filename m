Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029B6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 20:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBBB20748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 20:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeUS/KJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBBB20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtzVC-0005HU-WC
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 16:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtzTC-0003SL-Mp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 16:18:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtzT9-0002iW-3j
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 16:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594412281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDyPYMYzFVxt8Bib3TSd1BQ2gJHjjLvoHfd2c7V0DiM=;
 b=MeUS/KJKCGNelVwGXtqIFUTkC46++fUW1iMSCTnK2XYGDaAAlJJ+U3zAq8gzstjmev9qkQ
 yii0vZXdSukY3YYBVKmzDaa1nmoHRhsQ9FDPb+U5Ma++xdxl0esfQNVb1mlgOix9w6OENE
 RdGWA5a2+5Y+jD/ClzIoWugt+bGBeRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-QEZZHa0LMAuRXa2KyGjAQw-1; Fri, 10 Jul 2020 16:17:57 -0400
X-MC-Unique: QEZZHa0LMAuRXa2KyGjAQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF62102C7EE;
 Fri, 10 Jul 2020 20:17:55 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E1067EF99;
 Fri, 10 Jul 2020 20:17:55 +0000 (UTC)
Date: Fri, 10 Jul 2020 16:17:52 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
Message-ID: <20200710201752.GU780932@habkost.net>
References: <CAFEAcA8mFM-O=mgCQHNz4TNB5N3Trid2o95s0Nx7JVp_q_dSrw@mail.gmail.com>
 <20200708160316.GA7276@habkost.net>
 <CAFEAcA89ueUQuVPC9O9xqbBBDEzdXmbCLL69OHvk0MJ=VvSnbw@mail.gmail.com>
 <20200708173620.GB780932@habkost.net>
 <CAFEAcA_bLs+PzjfmCaHQQ3z1BrQ9Uack_Qj7Za-dJwtHWu=8kw@mail.gmail.com>
 <20200708213240.GC780932@habkost.net>
 <87k0zdz8ud.fsf@morokweng.localdomain>
 <87imexz7v6.fsf@morokweng.localdomain>
 <973a6add-715d-319b-0e69-f0c78ef5a7d4@redhat.com>
 <87k0zb16ld.fsf@morokweng.localdomain>
MIME-Version: 1.0
In-Reply-To: <87k0zb16ld.fsf@morokweng.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 16:04:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 05:02:38PM -0300, Thiago Jung Bauermann wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
> > On 7/9/20 5:26 AM, Thiago Jung Bauermann wrote:
> >>
> >> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> >>
> >>> I'm seeing the vcpu being KVM_RUN'd too early twice during hotplug.
> >>> Both of them are before cpu_reset() and ppc_cpu_reset().
> >>
> >> Hm, rereading the message obviously the above is partially wrong. The
> >> second case happens during ppc_cpu_reset().
> >>
> >>> Here's the second:
> >>>
> >>> #0  in qemu_cpu_kick_thread ()
> >>> #1  in qemu_cpu_kick ()
> >>> #2  in queue_work_on_cpu ()
> >>> #3  in async_run_on_cpu ()
> >>> #4  in tlb_flush_by_mmuidx ()
> >>> #5  in tlb_flush ()
> >>> #6  in ppc_tlb_invalidate_all ()
> >>> #7  in ppc_cpu_reset ()
> >>> #8  in device_transitional_reset ()
> >>> #9  in resettable_phase_hold ()
> >>> #10 in resettable_assert_reset ()
> >>> #11 in device_set_realized ()
> >
> > Dunno if related, might be helpful:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg686477.html
> 
> Yes, it's helpful. Thanks!
> 
> So is was it resolved whether it's appropriate to do a cpu_reset()
> within realize?
> 
> Is the core of the problem that device_set_realize() ends up calling
> ppc_cpu_reset()?

There are 15 realize functions which call cpu_reset(), currently.
Making it safe seems more appropriate than forbidding it.

-- 
Eduardo


