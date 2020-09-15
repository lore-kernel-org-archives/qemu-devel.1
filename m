Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EE1C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D525B2074B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D525B2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9l3-0001qe-Qq
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kI9hW-0005eJ-TE; Tue, 15 Sep 2020 08:04:46 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:52827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kI9hS-0006oc-Ow; Tue, 15 Sep 2020 08:04:46 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.217])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id AC58C61D0976;
 Tue, 15 Sep 2020 14:04:38 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 15 Sep
 2020 14:04:24 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0029ba1a047-b311-403b-a1e1-352c018c87fe,
 DB33878D1665C97D8818E18A24225F630DB8C599) smtp.auth=groug@kaod.org
Date: Tue, 15 Sep 2020 14:04:23 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 14/15] spapr: Simplify error handling in
 spapr_memory_plug()
Message-ID: <20200915140423.7bb9dfdb@bahia.lan>
In-Reply-To: <91774a03-3c70-4eab-8e02-137c6c151cb5@virtuozzo.com>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-15-groug@kaod.org>
 <11f0dcb7-7923-0164-df69-4911b3293663@virtuozzo.com>
 <20200915134340.0cc3f9eb@bahia.lan>
 <91774a03-3c70-4eab-8e02-137c6c151cb5@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 90b1eafa-b69d-4caa-891d-aeecff76b9aa
X-Ovh-Tracer-Id: 12522258767550912931
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtddtgdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 07:43:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've dropped the SPAM mentions from the subject this time :)

On Tue, 15 Sep 2020 14:53:53 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 15.09.2020 14:43, Greg Kurz wrote:
> > On Tue, 15 Sep 2020 13:58:53 +0300
> > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> > 
> >> 14.09.2020 15:35, Greg Kurz wrote:
> >>> As recommended in "qapi/error.h", add a bool return value to
> >>> spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
> >>> of local_err in spapr_memory_plug().
> >>>
> >>> Since object_property_get_uint() only returns 0 on failure, use
> >>> that as well.
> >>
> >> Why are you sure? Can't the property be 0 itself?
> >>
> > 
> > Hmmm... I've based this assumption on the header:
> > 
> >   * Returns: the value of the property, converted to an unsigned integer, or 0
> >   * an error occurs (including when the property value is not an integer).
> > 
> > but looking at the implementation, I don't see any check that
> > a property cannot be 0 indeed...
> > 
> > It's a bit misleading to mention this in the header though. I
> > understand that the function should return something, which
> > should have a some explicitly assigned value to avoid compilers
> > or static analyzers to yell, but the written contract should be
> > that the value is _undefined_ IMHO.
> > 
> > In its present form, the only way to know if the property is
> > valid is to pass a non-NULL errp actually. I'd rather even see
> > that in the contract, and an assert() in the code.
> > 
> > An alternative would be to convert it to have a bool return
> > value and get the actual uint result with a pointer argument.
> > 
> >>>
> >>> Also call ERRP_GUARD() to be able to check the status of void
> >>> function pc_dimm_plug() with *errp.
> >>>
> >>
> >>
> > 
> > I'm now hesitating to either check *errp for object_property_get_uint()
> > too or simply drop this patch...
> > 
> 
> .. and the following. If no more reviewers come to look at it, you can just merge first 13 patches, not resending the whole series for last two patches, which may be moved to round 3.
> 

I don't expect much people except David or maybe Markus to look
at these patches actually. And anyway, it's up to David to merge
them. But, yes, I agree patch 14 and 15 should go to the next
round.

Thanks for the review !

Cheers,

--
Greg

