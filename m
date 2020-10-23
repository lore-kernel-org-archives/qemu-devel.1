Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B08C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2E52192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2E52192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyLW-0007UM-2V
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 10:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kVyJs-0006Tp-NF; Fri, 23 Oct 2020 10:45:28 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:33347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kVyJp-0003hE-SI; Fri, 23 Oct 2020 10:45:28 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.8])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 2ED6068287F1;
 Fri, 23 Oct 2020 16:45:22 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 23 Oct
 2020 16:45:21 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003b929e85f-4402-4332-95fa-088b3f1d6103,
 C0BA1F4BE5C42AD64430581CA289E8EEBB8A5892) smtp.auth=groug@kaod.org
Date: Fri, 23 Oct 2020 16:45:20 +0200
From: Greg Kurz <groug@kaod.org>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] block: End quiescent sections when a BDS is deleted
Message-ID: <20201023164520.7a7211f7@bahia.lan>
In-Reply-To: <20201023141805.GE4793@merkur.fritz.box>
References: <160344969243.4091343.14371338409686732879.stgit@bahia.lan>
 <20201023141805.GE4793@merkur.fritz.box>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 251dec91-46b9-48b7-8d31-b466678c1385
X-Ovh-Tracer-Id: 17041902465231788451
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkedtgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepvdefgfdtgeeluddujeejleffgffhhedtieeggffguddvgfekvefgfeettdejheevnecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 10:45:22
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 16:18:05 +0200
Kevin Wolf <kwolf@redhat.com> wrote:

> Am 23.10.2020 um 12:41 hat Greg Kurz geschrieben:
> > If a BDS gets deleted during blk_drain_all(), it might miss a
> > call to bdrv_do_drained_end(). This means missing a call to
> > aio_enable_external() and the AIO context remains disabled for
> > ever. This can cause a device to become irresponsive and to
> > disrupt the guest execution, ie. hang, loop forever or worse.
> > 
> > This scenario is quite easy to encounter with virtio-scsi
> > on POWER when punching multiple blockdev-create QMP commands
> > while the guest is booting and it is still running the SLOF
> > firmware. This happens because SLOF disables/re-enables PCI
> > devices multiple times via IO/MEM/MASTER bits of PCI_COMMAND
> > register after the initial probe/feature negotiation, as it
> > tends to work with a single device at a time at various stages
> > like probing and running block/network bootloaders without
> > doing a full reset in-between. This naturally generates many
> > dataplane stops and starts, and thus many drain sections that
> > can race with blockdev_create_run(). In the end, SLOF bails
> > out.
> > 
> > It is somehow reproducible on x86 but it requires to generate
> > articial dataplane start/stop activity with stop/cont QMP
> > commands. In this case, seabios ends up looping for ever,
> > waiting for the virtio-scsi device to send a response to
> > a command it never received.
> > 
> > Add a helper that pairs all previously called bdrv_do_drained_begin()
> > with a bdrv_do_drained_end() and call it from bdrv_close().
> > While at it, update the "/bdrv-drain/graph-change/drain_all"
> > test in test-bdrv-drain so that it can catch the issue.
> > 
> > BugId: https://bugzilla.redhat.com/show_bug.cgi?id=1874441
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  block.c                 |    9 +++++++++
> >  block/io.c              |   13 +++++++++++++
> >  include/block/block.h   |    6 ++++++
> >  tests/test-bdrv-drain.c |    1 +
> >  4 files changed, 29 insertions(+)
> > 
> > diff --git a/block.c b/block.c
> > index 430edf79bb10..ddcb36dd48a8 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -4458,6 +4458,15 @@ static void bdrv_close(BlockDriverState *bs)
> >      }
> >      QLIST_INIT(&bs->aio_notifiers);
> >      bdrv_drained_end(bs);
> > +
> > +    /*
> > +     * If we're still inside some bdrv_drain_all_begin()/end() sections, end
> > +     * them now since this BDS won't exist anymore when bdrv_drain_all_end()
> > +     * gets called.
> > +     */
> > +    if (bs->quiesce_counter) {
> > +        bdrv_drained_end_quiesce(bs);
> > +    }
> >  }
> >  
> >  void bdrv_close_all(void)
> > diff --git a/block/io.c b/block/io.c
> > index 54f0968aee27..8a0da06bbb14 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -633,6 +633,19 @@ void bdrv_drain_all_begin(void)
> >      }
> >  }
> >  
> > +void bdrv_drained_end_quiesce(BlockDriverState *bs)
> 
> I think the name should make clear that this is meant as a counterpart
> for bdrv_drain_all_begin(), so maybe bdrv_drain_all_end_quiesce()?
> 

Sure.

> (The function is not suitable for any other kinds of drain because the
> parameters it passes to bdrv_do_drained_end() are only the same as for
> bdrv_drain_all_begin().)
> 
> > +{
> > +    int drained_end_counter = 0;
> > +
> > +    g_assert_cmpint(bs->quiesce_counter, >, 0);
> > +    g_assert_cmpint(bs->refcnt, ==, 0);
> 
> By the way, I didn't know about the problem with these macros either.
> 
> > +    while (bs->quiesce_counter) {
> > +        bdrv_do_drained_end(bs, false, NULL, true, &drained_end_counter);
> > +    }
> > +    BDRV_POLL_WHILE(bs, qatomic_read(&drained_end_counter) > 0);
> > +}
> > +
> >  void bdrv_drain_all_end(void)
> >  {
> >      BlockDriverState *bs = NULL;
> > diff --git a/include/block/block.h b/include/block/block.h
> > index d16c401cb44e..c0ce6e690081 100644
> > --- a/include/block/block.h
> > +++ b/include/block/block.h
> > @@ -779,6 +779,12 @@ void bdrv_drained_end(BlockDriverState *bs);
> >   */
> >  void bdrv_drained_end_no_poll(BlockDriverState *bs, int *drained_end_counter);
> >  
> > +/**
> > + * End all quiescent sections started by bdrv_drain_all_begin(). This is
> > + * only needed when deleting a BDS before bdrv_drain_all_end() is called.
> > + */
> > +void bdrv_drained_end_quiesce(BlockDriverState *bs);
> > +
> >  /**
> >   * End a quiescent section started by bdrv_subtree_drained_begin().
> >   */
> > diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
> > index 1595bbc92e9e..8a29e33e004a 100644
> > --- a/tests/test-bdrv-drain.c
> > +++ b/tests/test-bdrv-drain.c
> > @@ -594,6 +594,7 @@ static void test_graph_change_drain_all(void)
> >  
> >      g_assert_cmpint(bs_b->quiesce_counter, ==, 0);
> >      g_assert_cmpint(b_s->drain_count, ==, 0);
> > +    g_assert_cmpint(qemu_get_aio_context()->external_disable_cnt, ==, 0);
> 
> But here in the test case we should keep g_assert_cmpint() because it
> gives better error messages when it fails (and checkpatch doesn't warn
> about it in tests).
> 

Sure, it makes sense to keep them in tests. The limitation only applies
to the core code.

> Apart from the naming and checkpatch, this looks good to me.
> 

Cool, I'll send a v2 shortly.

> Kevin
> 


