Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A92C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B64206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7iT4TTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B64206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4pf-0000X3-F2
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jw4oa-0008Mz-B2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:24:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29078
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jw4oX-00058i-Dd
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594909483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ULRFzT1+9w/flIndjLJFeRWF3FXNQiz5N1d+rhBFTdY=;
 b=O7iT4TTZZ8IovYn1LJTXcVGbleqnGn5HMgpMal9yhncbquoesHI0QRf4ve6cdWi3iWTskB
 fCcjFbbqotDvlAQeJYbW4l1COEfrjvISMSXBKToZUi/XfntEFaMNnKUg5jp3ESBE/hVdK9
 68dWqiwTjOyT2HMTLVCOmEtk7NU57Vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-Osj9QRmgPk2b9pOEYgimiQ-1; Thu, 16 Jul 2020 10:24:39 -0400
X-MC-Unique: Osj9QRmgPk2b9pOEYgimiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D246082BA7C;
 Thu, 16 Jul 2020 14:23:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8A2710631DE;
 Thu, 16 Jul 2020 14:23:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B81511385E0; Thu, 16 Jul 2020 16:23:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
 <20200716044540.GL93134@umbus.fritz.box>
 <20200716123244.1f854c63@bahia.lan>
 <20200716131109.GA5607@umbus.fritz.box>
Date: Thu, 16 Jul 2020 16:23:52 +0200
In-Reply-To: <20200716131109.GA5607@umbus.fritz.box> (David Gibson's message
 of "Thu, 16 Jul 2020 23:11:09 +1000")
Message-ID: <87r1tblerr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

> On Thu, Jul 16, 2020 at 12:32:44PM +0200, Greg Kurz wrote:
>> On Thu, 16 Jul 2020 14:45:40 +1000
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>> 
>> > On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
>> > > Some recent error handling cleanups unveiled issues with our support of
>> > > PCI bridges:
>> > > 
>> > > 1) QEMU aborts when using non-standard PCI bridge types,
>> > >    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error handling"
>> > > 
>> > > $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
>> > > Unexpected error in object_property_find() at qom/object.c:1240:
>> > > qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not found
>> > > Aborted (core dumped)
>> > 
>> > Oops, I thought we had a check that we actually had a "pci-bridge"
>> > device before continuing with the hotplug, but I guess not.
>> 
>> Ah... are you suggesting we should explicitly check the actual type
>> of the bridge rather than looking for the "chassis_nr" property ?
>
> Uh.. I thought about it, but I don't think it matters much which way
> we do it.

Would it make sense to add the "chassis_nr" property to *all* PCI
bridge devices?

[...]


