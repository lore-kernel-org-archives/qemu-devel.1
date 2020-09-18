Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12465C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921F32075E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921F32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJ1R-0007Ly-L6
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kJIxb-0002FC-2K; Fri, 18 Sep 2020 12:10:07 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:42899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kJIxZ-0003YT-1B; Fri, 18 Sep 2020 12:10:06 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.134])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id EFED96335409;
 Fri, 18 Sep 2020 18:10:02 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 18 Sep
 2020 18:10:01 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002bbabef1d-fea4-4575-99ea-73d655b18d28,
 26E73787F9CAC9185D3FF732CC8AC9B997D690EB) smtp.auth=groug@kaod.org
Date: Fri, 18 Sep 2020 18:10:00 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 12/13] block/qcow2: simplify qcow2_co_invalidate_cache()
Message-ID: <20200918181000.415d0016@bahia.lan>
In-Reply-To: <a009147d-bc03-9549-3d95-1b58ea830099@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
 <20200917195519.19589-13-vsementsov@virtuozzo.com>
 <20200918173006.5f49cb06@bahia.lan>
 <w51k0wr2id9.fsf@maestria.local.igalia.com>
 <a009147d-bc03-9549-3d95-1b58ea830099@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 92770f74-68a3-4bff-9997-bb18f1955ee9
X-Ovh-Tracer-Id: 15841974643345889723
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepkhifohhlfhesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 11:15:16
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
Cc: kwolf@redhat.com, Alberto Garcia <berto@igalia.com>,
 pavel.dovgaluk@ispras.ru, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 armbru@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 19:01:34 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 18.09.2020 18:51, Alberto Garcia wrote:
> > On Fri 18 Sep 2020 05:30:06 PM CEST, Greg Kurz wrote:
> >>> qcow2_do_open correctly sets errp on each failure path. So, we can
> >>> simplify code in qcow2_co_invalidate_cache() and drop explicit error
> >>> propagation. We should use ERRP_GUARD() (accordingly to comment in
> >>> include/qapi/error.h) together with error_append() call which we add to
> >>> avoid problems with error_fatal.
> >>>
> >>
> >> The wording gives the impression that we add error_append() to avoid problems
> >> with error_fatal which is certainly not true. Also it isn't _append() but
> >> _prepend() :)
> >>
> >> What about ?
> >>
> >> "Add ERRP_GUARD() as mandated by the documentation in include/qapi/error.h
> >>   to avoid problems with the error_prepend() call if errp is
> >>   &error_fatal."
> 
> OK for me.
> 
> > 
> > I had to go to the individual error functions to see what "it doesn't
> > work with &error_fatal" actually means.
> > 
> > So in a case like qcow2_do_open() which has:
> > 
> >     error_setg(errp, ...)
> >     error_append_hint(errp, ...)
> > 
> > As far as I can see this works just fine without ERRP_GUARD() and with
> > error_fatal, the difference is that if we don't use the guard then the
> > process exists during error_setg(), and if we use the guard it exists
> > during the implicit error_propagate() call triggered by its destruction
> > at the end of the function. In this latter case the printed error
> > message would include the hint.
> > 
> 
> Yes the only problem is that without ERRP_GUARD we lose the hint in case of error_fatal.
> 

Yeah, so rather:

"Add ERRP_GUARD() as mandated by the documentation in include/qapi/error.h
 so that error_prepend() is actually called even if errp is &error_fatal."

Cheers,

--
Greg

