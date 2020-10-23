Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF9C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407C221527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQlhv1Vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407C221527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxuI-0003IA-0Y
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 10:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVxtb-0002o9-9u
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 10:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVxtY-0008V5-KH
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 10:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603462696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3mg8CTFvXVMDZHyjaOTkZVEFCEf9snkyLfDQ4Hjorcg=;
 b=AQlhv1VuU4MpPi55Mgruuk+OYovDcns/9nnoPl0NGwRQLp8Si5gfd7y4CC/v95pHEmpnEu
 luqOFx6XUChVUzF1ttpcghScT0RIg5falWJU1DY505MKDBnVBVzUQg2tp7w7IwhTjEZLeT
 2YFmmwuz2WPc/xr8trycORprRoOQ+Jc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-p0Gmd8_ZN4OoT3LXx-mNww-1; Fri, 23 Oct 2020 10:18:12 -0400
X-MC-Unique: p0Gmd8_ZN4OoT3LXx-mNww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02DF4804B6A;
 Fri, 23 Oct 2020 14:18:11 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCAEB27BB4;
 Fri, 23 Oct 2020 14:18:06 +0000 (UTC)
Date: Fri, 23 Oct 2020 16:18:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] block: End quiescent sections when a BDS is deleted
Message-ID: <20201023141805.GE4793@merkur.fritz.box>
References: <160344969243.4091343.14371338409686732879.stgit@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <160344969243.4091343.14371338409686732879.stgit@bahia.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.10.2020 um 12:41 hat Greg Kurz geschrieben:
> If a BDS gets deleted during blk_drain_all(), it might miss a
> call to bdrv_do_drained_end(). This means missing a call to
> aio_enable_external() and the AIO context remains disabled for
> ever. This can cause a device to become irresponsive and to
> disrupt the guest execution, ie. hang, loop forever or worse.
> 
> This scenario is quite easy to encounter with virtio-scsi
> on POWER when punching multiple blockdev-create QMP commands
> while the guest is booting and it is still running the SLOF
> firmware. This happens because SLOF disables/re-enables PCI
> devices multiple times via IO/MEM/MASTER bits of PCI_COMMAND
> register after the initial probe/feature negotiation, as it
> tends to work with a single device at a time at various stages
> like probing and running block/network bootloaders without
> doing a full reset in-between. This naturally generates many
> dataplane stops and starts, and thus many drain sections that
> can race with blockdev_create_run(). In the end, SLOF bails
> out.
> 
> It is somehow reproducible on x86 but it requires to generate
> articial dataplane start/stop activity with stop/cont QMP
> commands. In this case, seabios ends up looping for ever,
> waiting for the virtio-scsi device to send a response to
> a command it never received.
> 
> Add a helper that pairs all previously called bdrv_do_drained_begin()
> with a bdrv_do_drained_end() and call it from bdrv_close().
> While at it, update the "/bdrv-drain/graph-change/drain_all"
> test in test-bdrv-drain so that it can catch the issue.
> 
> BugId: https://bugzilla.redhat.com/show_bug.cgi?id=1874441
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  block.c                 |    9 +++++++++
>  block/io.c              |   13 +++++++++++++
>  include/block/block.h   |    6 ++++++
>  tests/test-bdrv-drain.c |    1 +
>  4 files changed, 29 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 430edf79bb10..ddcb36dd48a8 100644
> --- a/block.c
> +++ b/block.c
> @@ -4458,6 +4458,15 @@ static void bdrv_close(BlockDriverState *bs)
>      }
>      QLIST_INIT(&bs->aio_notifiers);
>      bdrv_drained_end(bs);
> +
> +    /*
> +     * If we're still inside some bdrv_drain_all_begin()/end() sections, end
> +     * them now since this BDS won't exist anymore when bdrv_drain_all_end()
> +     * gets called.
> +     */
> +    if (bs->quiesce_counter) {
> +        bdrv_drained_end_quiesce(bs);
> +    }
>  }
>  
>  void bdrv_close_all(void)
> diff --git a/block/io.c b/block/io.c
> index 54f0968aee27..8a0da06bbb14 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -633,6 +633,19 @@ void bdrv_drain_all_begin(void)
>      }
>  }
>  
> +void bdrv_drained_end_quiesce(BlockDriverState *bs)

I think the name should make clear that this is meant as a counterpart
for bdrv_drain_all_begin(), so maybe bdrv_drain_all_end_quiesce()?

(The function is not suitable for any other kinds of drain because the
parameters it passes to bdrv_do_drained_end() are only the same as for
bdrv_drain_all_begin().)

> +{
> +    int drained_end_counter = 0;
> +
> +    g_assert_cmpint(bs->quiesce_counter, >, 0);
> +    g_assert_cmpint(bs->refcnt, ==, 0);

By the way, I didn't know about the problem with these macros either.

> +    while (bs->quiesce_counter) {
> +        bdrv_do_drained_end(bs, false, NULL, true, &drained_end_counter);
> +    }
> +    BDRV_POLL_WHILE(bs, qatomic_read(&drained_end_counter) > 0);
> +}
> +
>  void bdrv_drain_all_end(void)
>  {
>      BlockDriverState *bs = NULL;
> diff --git a/include/block/block.h b/include/block/block.h
> index d16c401cb44e..c0ce6e690081 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -779,6 +779,12 @@ void bdrv_drained_end(BlockDriverState *bs);
>   */
>  void bdrv_drained_end_no_poll(BlockDriverState *bs, int *drained_end_counter);
>  
> +/**
> + * End all quiescent sections started by bdrv_drain_all_begin(). This is
> + * only needed when deleting a BDS before bdrv_drain_all_end() is called.
> + */
> +void bdrv_drained_end_quiesce(BlockDriverState *bs);
> +
>  /**
>   * End a quiescent section started by bdrv_subtree_drained_begin().
>   */
> diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
> index 1595bbc92e9e..8a29e33e004a 100644
> --- a/tests/test-bdrv-drain.c
> +++ b/tests/test-bdrv-drain.c
> @@ -594,6 +594,7 @@ static void test_graph_change_drain_all(void)
>  
>      g_assert_cmpint(bs_b->quiesce_counter, ==, 0);
>      g_assert_cmpint(b_s->drain_count, ==, 0);
> +    g_assert_cmpint(qemu_get_aio_context()->external_disable_cnt, ==, 0);

But here in the test case we should keep g_assert_cmpint() because it
gives better error messages when it fails (and checkpatch doesn't warn
about it in tests).

Apart from the naming and checkpatch, this looks good to me.

Kevin


