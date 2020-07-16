Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67736C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB672063A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB672063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5U5-0007uX-F6
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jw5Ks-0007r2-Gr
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:58:10 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:41153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jw5Kq-00033I-4O
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:58:10 -0400
Received: from player729.ha.ovh.net (unknown [10.110.115.91])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 0D61A28D79B
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 16:58:04 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 63E3A148BF1F5;
 Thu, 16 Jul 2020 14:57:55 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G00311403941-7b14-4fc4-85c1-d8459c7e8a15,82226C5D462F885DC4F8BFF1B5769E1A03475668)
 smtp.auth=groug@kaod.org
Date: Thu, 16 Jul 2020 16:57:54 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
Message-ID: <20200716165754.50af735a@bahia.lan>
In-Reply-To: <87r1tblerr.fsf@dusky.pond.sub.org>
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
 <20200716044540.GL93134@umbus.fritz.box>
 <20200716123244.1f854c63@bahia.lan>
 <20200716131109.GA5607@umbus.fritz.box>
 <87r1tblerr.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7709036663810333070
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfeeggdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedvledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.32.116.78; envelope-from=groug@kaod.org;
 helo=8.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 10:58:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 16:23:52 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> David Gibson <david@gibson.dropbear.id.au> writes:
> 
> > On Thu, Jul 16, 2020 at 12:32:44PM +0200, Greg Kurz wrote:
> >> On Thu, 16 Jul 2020 14:45:40 +1000
> >> David Gibson <david@gibson.dropbear.id.au> wrote:
> >> 
> >> > On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
> >> > > Some recent error handling cleanups unveiled issues with our support of
> >> > > PCI bridges:
> >> > > 
> >> > > 1) QEMU aborts when using non-standard PCI bridge types,
> >> > >    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error handling"
> >> > > 
> >> > > $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
> >> > > Unexpected error in object_property_find() at qom/object.c:1240:
> >> > > qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not found
> >> > > Aborted (core dumped)
> >> > 
> >> > Oops, I thought we had a check that we actually had a "pci-bridge"
> >> > device before continuing with the hotplug, but I guess not.
> >> 
> >> Ah... are you suggesting we should explicitly check the actual type
> >> of the bridge rather than looking for the "chassis_nr" property ?
> >
> > Uh.. I thought about it, but I don't think it matters much which way
> > we do it.
> 
> Would it make sense to add the "chassis_nr" property to *all* PCI
> bridge devices?
> 

I see that the "PCI Express to PCI/PCI-X Bridge Specification" mentions
a "Chassis Number Register" which looks very similar to the what exists
in standard PCI-to-PCI brdiges. This doesn't seem to be implemented in
our "pcie-pci-bridge" device model though, but of course I have no idea
why :)

Maybe Michael or Marcel (cc'd) can share some thoughts about that ?

> [...]
> 


