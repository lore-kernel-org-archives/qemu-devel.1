Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96973C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30DF20735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMjq//GO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30DF20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNJi-0005mf-Rj
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXMyb-0000YY-E1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXMyU-0003BH-1u
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603797425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fxboEc+Fec5apjC6Kad/Sl6RFHELsHnsijVve8SF6M=;
 b=LMjq//GOd/5yrkL9ugv7mQZljx1b61u8ghVhsa68aWF8wJ1ZhSqGfKcRCPMnfQT69k1ifA
 mRuI0LEjdUPXYE8DrZPSoS1pk5J9Dbrd1eA++U2M9R0MnBrUrzao8FzX884raJ3kzznmWU
 +sWV8+kJxgtVnNV0c5jLxjVCcuFJG20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-hIBxJr5ONf2B1FhlrnS24g-1; Tue, 27 Oct 2020 07:17:00 -0400
X-MC-Unique: hIBxJr5ONf2B1FhlrnS24g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A964D801FDD;
 Tue, 27 Oct 2020 11:16:59 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61BF355790;
 Tue, 27 Oct 2020 11:16:55 +0000 (UTC)
Date: Tue, 27 Oct 2020 12:16:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2] block: End quiescent sections when a BDS is deleted
Message-ID: <20201027111653.GC4628@merkur.fritz.box>
References: <160346526998.272601.9045392804399803158.stgit@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <160346526998.272601.9045392804399803158.stgit@bahia.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 23.10.2020 um 17:01 hat Greg Kurz geschrieben:
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

Thanks, applied to the block branch.

Kevin


