Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C2FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C48D207FC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmK2QlJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C48D207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2yUr-0007Bi-KN
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 11:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1k2yU5-0006kk-Sm
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:04:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1k2yU2-0003Sy-TN
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596553444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JA17bUD499vwkBRhHz59CMc99eUCk2vZ1hUj0Eaz3io=;
 b=HmK2QlJctveiwpR4KLsQJkfqhlRs5oKhTcZiIvgZiXcXGGc0cduzmW2cgQxyDqN8VWtiHg
 YSuBK2gch79VRdAZ9X9L68dbq28RCEuChdTW/kQ++mjWcUyW13O84WyWgQ1BTVNvgH0aYX
 H33XQNXvPIyDmDI3tK5Mv1+DBhdVp10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-HgxQffhPPK-s2pxHRBcqYA-1; Tue, 04 Aug 2020 11:02:29 -0400
X-MC-Unique: HgxQffhPPK-s2pxHRBcqYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36087800685;
 Tue,  4 Aug 2020 15:02:28 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-9.gru2.redhat.com [10.97.112.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23D15100EBA4;
 Tue,  4 Aug 2020 15:02:24 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
 id 140FB4168BAA; Mon,  3 Aug 2020 14:33:38 -0300 (-03)
Date: Mon, 3 Aug 2020 14:33:38 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
Message-ID: <20200803173338.GA83945@fuller.cnet>
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
 <20200319114424.5723e777@office.mammed.net>
 <4d42697e-ba84-e5af-3a17-a2cc52cf0dbc@redhat.com>
 <20200319160800.614de5fb@redhat.com>
 <d6c0dc2f-5b0f-2e34-6c12-e9d9cd7402c6@redhat.com>
 <3f70d63d-e9ae-6676-edd5-20613b4b8856@redhat.com>
 <20200323110452.GA14031@fuller.cnet>
 <f8a17eb5-7c70-4deb-82b3-54bc097dcfd6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f8a17eb5-7c70-4deb-82b3-54bc097dcfd6@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mtosatti@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-1, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 03, 2020 at 07:10:11PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Igor, Paolo.
> 
> On 3/23/20 12:04 PM, Marcelo Tosatti wrote:
> > On Mon, Mar 23, 2020 at 09:05:06AM +0100, Paolo Bonzini wrote:
> >> On 22/03/20 17:27, Philippe Mathieu-Daudé wrote:
> >>>>>
> >>>> That 'ugly' is typically used within QEMU to deal with such things
> >>>> probably due to its low complexity.
> >>>
> >>> OK. Can you point me to the documentation for this feature? I can find
> >>> reference of GPE in the ICH9, but I can't find where this IO address on
> >>> the PIIX4 comes from:
> >>>
> >>> #define GPE_BASE 0xafe0
> >>
> >> It's made up.  The implementation is placed in PIIX4_PM because it is
> >> referenced by the ACPI tables.  Real hardware would probably place this
> >> in the ACPI embedded controller or in the BMC.
> >>
> >> Paolo
> > 
> > Yes, there was nothing at 0xafe0 at the time ACPI support was written.
> > 
> 
> Igor earlier said:
> "it's already pretty twisted code and adding one more knob
> to workaround other compat knobs makes it worse."
> 
> Is that OK to rename this file "hw/acpi/piix4_twisted.c" and
> copy/paste the same content to "hw/acpi/piix4.c" but remove the
> non-PIIX4 code (GPE from ICH9)?
> 
> This seems counterproductive from a maintenance PoV, but the PIIX4 bug
> (https://bugs.launchpad.net/qemu/+bug/1835865) is more than 1 year old
> now...
> 
> If someone has a clever idea, I'm open to listen and implement it, but
> keeping ignoring this issue is not good.
> 
> Note there is a similar issue with the LPC bus not existing on the
> PIIX, so maybe renaming this to something like "piix_virt.c" and having
> someone writing the specs (or differences with the physical datasheet)
> is not a such bad idea.
> 
> Thanks,
> 
> Phil.

Make the port address architecture specific ? 


