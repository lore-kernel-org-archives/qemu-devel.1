Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B0CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 20:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FE420684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 20:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GM3CGDxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FE420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNjQT-0002Fg-Mg
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 16:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNjPd-0000vp-Ay
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNjPa-0006Ao-Nr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:08:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNjPa-0006AQ-Jh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571947726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nidywdvwb7fEoOrYoMzrdetW7P4P41mkjYAVhZEdPAY=;
 b=GM3CGDxUeSuaK4ifHTk9ndf1nDQutOirt2z5fx6R6/8aJQ4n802i+PKXDWa1PltufMvGHY
 DSiIxQpLuDUejrXjuIvSkKdcO/AW45hSIhe7j9n8bpeSXKvZB0frLDKDvUe/kRxYy0mffA
 fgm/d7AKQ4fcQs70BQaGUlhLwf6zExA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-D8uw4aYcNdGGheOxIsZzmQ-1; Thu, 24 Oct 2019 16:08:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A715D1800DFB;
 Thu, 24 Oct 2019 20:08:43 +0000 (UTC)
Received: from localhost (ovpn-116-48.ams2.redhat.com [10.36.116.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25A473DE0;
 Thu, 24 Oct 2019 20:08:35 +0000 (UTC)
Date: Thu, 24 Oct 2019 22:08:34 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191024200834.ai56qwf7shtmsndg@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <AM0PR05MB486628D14AE740F3843CA236D16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191024093754.tgdd7cp5riwcsytc@jenstp.localdomain>
 <20191024105236.70403a2f@x1.home>
MIME-Version: 1.0
In-Reply-To: <20191024105236.70403a2f@x1.home>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: D8uw4aYcNdGGheOxIsZzmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "pkrempa@redhat.com" <pkrempa@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Parav Pandit <parav@mellanox.com>,
 "mst@redhat.com" <mst@redhat.com>, "aadam@redhat.com" <aadam@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "laine@redhat.com" <laine@redhat.com>, "ailan@redhat.com" <ailan@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 10:52:36AM -0600, Alex Williamson wrote:
>On Thu, 24 Oct 2019 11:37:54 +0200
>Jens Freimann <jfreimann@redhat.com> wrote:
[...]
> >
>> >While reviewing, I realized that we shouldn't have this check for below=
 reasons.
>> >
>> >1. It is user's responsibility to pass networking device.
>> >But its ok to check the class, if PCI Device is passed.
>> >So class comparison should be inside the pci_check().
>>
>> I'm not sure I understand this point, could you please elaborate?
>> You're suggesting to move the check for the class into the check for
>> pci_is_express?
>
>Seems like the suggestion is that net_failover_pair_id should be an
>option on the base class of PCIDevice (DeviceState?) and only if it's a
>PCI device would we check the class code.  But there are dependencies
>at the hotplug controller, which I think is why this is currently
>specific to PCI.

Yes, It doesn't support acpi, shpc,... hotplug as of now. It
shouldn't be hard to add but I'd like to do it as a follow-on series.

>However, it's an interesting point about pci_is_express().  This test
>is really just meant to check whether the hotplug controller supports
>this feature, which is only implemented in pciehp via this series.
>There's a bit of a mismatch though that pcie_is_express() checks
>whether the device is express, not whether the bus it sits on is
>express.  I think we really want the latter, so maybe this should be:
>
>pci_bus_is_express(pci_get_bus(dev)
>
>For example this feature should work if I plug an e1000 (not e1000e)
>into an express slot, but not if I plug an e1000e into a conventional
>slot.

I'll try this and test.=20

Thanks!

regards,
Jens=20


