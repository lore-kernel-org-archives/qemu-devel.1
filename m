Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB24C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21607218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21607218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GOz-0004VS-94
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j2G94-0000DA-DD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j2G90-00029n-Ub
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:11:13 -0500
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:35343)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j2G90-00025g-Nr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:11:10 -0500
Received: from player789.ha.ovh.net (unknown [10.108.35.122])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3C67A265C08
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:11:08 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id EBDAAF5FCAE3;
 Thu, 13 Feb 2020 15:10:57 +0000 (UTC)
Date: Thu, 13 Feb 2020 16:10:55 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/3] spapr: Fix device unplug vs CAS or migration
Message-ID: <20200213161055.3d1b25aa@bahia.lan>
In-Reply-To: <158076936422.2118610.5626450767672103134.stgit@bahia.lan>
References: <158076936422.2118610.5626450767672103134.stgit@bahia.lan>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7425028411529468390
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrieekgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepqhgvmhhurdhorhhgpdhoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.119.138
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping ?

This series fixes actual bugs. Also, I have another patch on top of
that to cold plug (or remove) devices pending hot plug (or unplug)
before CAS, hence removing the need for CAS reboot in these cases.
This requires SLOF to correctly parse the FDT it gets at CAS. Patches
have been sent for that too:

https://git.qemu.org/?p=SLOF.git;a=commitdiff;h=689ff6f6554d94fdab854bf4fc4ec85e2675e43d
https://git.qemu.org/?p=SLOF.git;a=commitdiff;h=a093be1ebe7a48321646601d94be6cf735c81e12
https://patchwork.ozlabs.org/patch/1235817/

On Mon, 03 Feb 2020 23:36:04 +0100
Greg Kurz <groug@kaod.org> wrote:

> While working on getting rid of CAS reboot, I realized that we currently
> don't handle device hot unplug properly in the following situations:
> 
> 1) if the device is unplugged between boot and CAS, SLOF doesn't handle
>    the even, which is a known limitation. The device hence stays around
>    forever (specifically, until some other event is emitted and the guest
>    eventually completes the unplug or a reboot). Until we can teach SLOF
>    to correctly process the full FDT at CAS, we should trigger a CAS reboot,
>    like we already do for hotplug.
> 
> 2) if the guest is migrated after the even was emitted but before the
>    guest could process it, the destination is unaware of the pending
>    unplug operation and doesn't remove the device when the guests
>    releases it. The 'unplug_requested' field of the DRC is actually state
>    that should be migrated.
> 
> --
> Greg
> 
> ---
> 
> Greg Kurz (3):
>       spapr: Don't use spapr_drc_needed() in CAS code
>       spapr: Detect hot unplugged devices during CAS
>       spapr: Migrate SpaprDrc::unplug_requested
> 
> 
>  hw/ppc/spapr_drc.c         |   30 ++++++++++++++++++++++++++----
>  hw/ppc/spapr_hcall.c       |   12 +++++++++---
>  include/hw/ppc/spapr_drc.h |    8 +++++++-
>  3 files changed, 42 insertions(+), 8 deletions(-)
> 
> 


