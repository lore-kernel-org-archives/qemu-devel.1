Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E03C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C192E2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4gsdvPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C192E2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvwb8-0002qF-1C
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 01:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvwaI-00026t-W2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 01:37:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvwaG-0005ft-5a
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 01:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594877846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2H7mI1XRse7iK1zvXaMtZjcTu9t4ovcty1wpRbv3Ib8=;
 b=b4gsdvPSSk14O1DYCp7GTYv65tyxnqub8Lb18jxqNdj5SleIaDPNExLwosjYOzr8ASLnkc
 nDVdlWJaRgRhG3zyvaLzTanjQSiAcAXZeeVuIhzqg2NZBGIGHgdSwzjOPfkg3kVPAbGAKC
 ci1mAIQsaR79YSRNIwBAVVaMvX+qnx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-6lrqlHwINlCREqHrjQJOKA-1; Thu, 16 Jul 2020 01:37:21 -0400
X-MC-Unique: 6lrqlHwINlCREqHrjQJOKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6907B100CCC6;
 Thu, 16 Jul 2020 05:37:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01A2717DFE;
 Thu, 16 Jul 2020 05:37:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4522311385E0; Thu, 16 Jul 2020 07:37:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Gibson <dgibson@redhat.com>
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
 <5e967e5f-8ae5-01cc-0dfe-f22e0f03b6b3@redhat.com>
 <87y2nvanya.fsf@dusky.pond.sub.org>
 <794f6901-5fe3-f7a1-45e7-f277f687cb6b@redhat.com>
 <87v9iz7cxl.fsf@dusky.pond.sub.org>
 <20200713111344.23c1b313@umbus.fritz.box>
 <874kqbbdft.fsf@dusky.pond.sub.org>
 <20200716095926.74caee16@umbus.fritz.box>
Date: Thu, 16 Jul 2020 07:37:17 +0200
In-Reply-To: <20200716095926.74caee16@umbus.fritz.box> (David Gibson's message
 of "Thu, 16 Jul 2020 09:59:26 +1000")
Message-ID: <87a700rpf6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:37:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?utf-8?Q?C=C3=A9dr?= =?utf-8?Q?ic?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-D?= =?utf-8?Q?aud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <dgibson@redhat.com> writes:

> On Mon, 13 Jul 2020 18:13:42 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> David Gibson <dgibson@redhat.com> writes:
>> 
>>  [...]  
>>  [...]  
>>  [...]  
>>  [...]  
>>  [...]  
>>  [...]  
>>  [...]  
>>  [...]  
>>  [...]  
>>  [...]  
>> >> 
>> >> The surprising part is that n turns out to be large enough for n^2 to
>> >> matter *that* much.  
>> >
>> > Is this another consequence of the ludicrous number of QOM objects we
>> > create for LMB DRCs (one for every 256MiB of guest RAM)?  Avoiding that
>> > is on my list.  
>> 
>> You're talking about machine pseries, I presume.
>
> Yes.
>
>>  With
>> print_qom_composition() patched to print the number of children, I get
>> 
>>     $ echo -e 'info qom-tree\nq' | ../qemu/bld/ppc64-softmmu/qemu-system-ppc64 -S -display none -M pseries -accel qtest -monitor stdio | grep '###' | sort | uniq -c | sort -k 3n
>>         360 ### 0 children
>>           5 ### 1 children
>>           5 ### 2 children
>>           2 ### 3 children
>>           1 ### 4 children
>>           1 ### 15 children
>>           1 ### 16 children
>>           1 ### 18 children
>>           1 ### 37 children
>>           1 ### 266 children
>> 
>> The outlier is
>> 
>>         /device[5] (spapr-pci-host-bridge)
>> 
>> due to its 256 spapr-drc-pci children.
>
> Right, that's one for each possible PCI slot on the bus.  That will be
> reduced by the idea I have in mind for this, but...
>
>> I found quite a few machines with similar outliers.  ARM machines nuri
>> and smdkc210 together take the cake: they each have a node with 513
>> children.
>> 
>> My stupid n^2 sort is unnoticable in normal, human usage even for n=513.
>
> ... as you say, 256 shouldn't really be a problem.  I was concerned
> about LMB DRCs rather than PCI DRCs.  To have that show up, you might
> need to create a machine with a large difference between initial memory
> and maxmem - I think you'll get a DRC object for every 256MiB in there,
> which can easily get into the thousands for large (potential) memory
> VMs.

Okay, I can reproduce: with -m 256,128G, /machine has 549 children, of
which 511 are spapr-drc-lmb.

> I don't know what the config was that showed up this problem in the
> first place, and whether that could be the case there.

Thomas reported device-introspect-test -m slow has become much slower
for ppc64.  Bisection traced it to my commit e8c9e65816 "qom: Make "info
qom-tree" show children sorted".  Uses default memory size, no
spapr-drc-lmb as far as I remember.

>> >                 Though avoiding a n^2 behaviour here is probably a good
>> > idea anyway.  
>> 
>> Agreed.

Patch posted:

    Subject: [PATCH for-5.1 5/5] qom: Make info qom-tree sort children more efficiently
    Message-Id: <20200714160202.3121879-6-armbru@redhat.com>


