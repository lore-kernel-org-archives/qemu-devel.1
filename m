Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F25C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18D3222DC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18D3222DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9YC-0000pD-V6
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 14:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iX9X0-00086r-03
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iX9Wy-0003WE-U0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:51:21 -0500
Received: from charlie.dont.surf ([128.199.63.193]:37958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iX9Ww-0003Uy-9n; Tue, 19 Nov 2019 14:51:18 -0500
Received: from apples.localdomain (ip-5-186-123-87.cgn.fibianet.dk
 [5.186.123.87])
 by charlie.dont.surf (Postfix) with ESMTPSA id 501F2BF614;
 Tue, 19 Nov 2019 19:51:14 +0000 (UTC)
Date: Tue, 19 Nov 2019 20:51:10 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 09/20] nvme: add support for the asynchronous event
 request command
Message-ID: <20191119195110.GA1022320@apples.localdomain>
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-10-its@irrelevant.dk>
 <CADSWDzuzDPZdXUi-3e-TbwDy8GcGZPM78cA0fUU84nOj+y3NCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSWDzuzDPZdXUi-3e-TbwDy8GcGZPM78cA0fUU84nOj+y3NCA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 03:04:59PM +0000, Beata Michalska wrote:
> Hi Klaus,
> 
> On Tue, 15 Oct 2019 at 11:49, Klaus Jensen <its@irrelevant.dk> wrote:
> > @@ -1188,6 +1326,9 @@ static int nvme_start_ctrl(NvmeCtrl *n)
> >
> >      nvme_set_timestamp(n, 0ULL);
> >
> > +    n->aer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_aers, n);
> > +    QTAILQ_INIT(&n->aer_queue);
> > +
> 
> Is the timer really needed here ? The CEQ can be posted either when requested
> by host through AER, if there are any pending events, or once the
> event is triggered
> and there are active AER's.
> 

I guess you are right. I mostly cribbed this from Keith's tree, but I
see no reason to keep the timer.

Keith, do you have any comments on this?

> > @@ -1380,6 +1521,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
> >                             "completion queue doorbell write"
> >                             " for nonexistent queue,"
> >                             " sqid=%"PRIu32", ignoring", qid);
> > +
> > +            if (n->outstanding_aers) {
> > +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> > +                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
> > +                    NVME_LOG_ERROR_INFO);
> > +            }
> > +
> This one (as well as cases below) might not be entirely right
> according to the spec. If given event is enabled for asynchronous
> reporting the controller should retain that even. In this case, the event
> will be ignored as there is no pending request.
> 

I understand these notifications to be special cases (i.e. they cannot
be enabled/disabled through the Asynchronous Event Configuration
feature). See Section 4.1 of NVM Express 1.2.1. The spec specifically
says that "... and an Asynchronous Event Request command is outstanding,
...).

> > @@ -1591,6 +1759,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> >      id->ver = cpu_to_le32(0x00010201);
> >      id->oacs = cpu_to_le16(0);
> >      id->acl = 3;
> > +    id->aerl = n->params.aerl;
> 
> What about the configuration for the asynchronous events ?
> 

It will default to an AEC vector of 0 (everything disabled).


K

