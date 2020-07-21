Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0558C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9EA20578
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW7y8XRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9EA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtjy-0002Ax-KE
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jxtj7-0001i9-46
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:58:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jxtj5-0000eH-Gw
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595343518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/urrWh8kmsRnAtvlzIN0fYA06DD+Z0xlQ3Rf671P/Ck=;
 b=TW7y8XRVrz5/PUaR8A4P6JDAVsukZfiQ6pSbT2V/7+zIdch0An3cLp97V+Q++E/ETETksx
 We3aqyAT9COLaqNK5ccDjOVBUX4UR0J3jn2wGp/1dOkny4aTEEtCfYO4Cqq+79diAQ6KvY
 p/WtMSmeu0FCNfgorNpZTWA7AtkVL7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-eaZuK8DbNCi_Y66xHHBYCA-1; Tue, 21 Jul 2020 10:58:36 -0400
X-MC-Unique: eaZuK8DbNCi_Y66xHHBYCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 033FE107ACCA;
 Tue, 21 Jul 2020 14:58:36 +0000 (UTC)
Received: from work-vm (ovpn-114-151.ams2.redhat.com [10.36.114.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32B5E1001901;
 Tue, 21 Jul 2020 14:58:35 +0000 (UTC)
Date: Tue, 21 Jul 2020 15:58:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: error reporting from pre_load etc callbacks
Message-ID: <20200721145832.GC2800@work-vm>
References: <CAFEAcA_rFLk2Fs1ibHH7YnR38K-nGjKas5SkPP8ReubHfHtvMQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rFLk2Fs1ibHH7YnR38K-nGjKas5SkPP8ReubHfHtvMQ@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:58:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> (This was pointed out to me off-list.)
> 
> What is the intended API of the pre_load() etc callbacks?
> docs/devel/migration.rst doesn't say, and there's no doc comment
> in include/migration/vmstate.h. Most actual device implementations
> of the hooks seem to return 0 on success and -1 on failure.
> But the callers of the hooks like vmstate_load_state() seem to
> assume they return negative-errnos: a non-zero return value
> is just propagated up to the caller, and can end up for
> instance treated as negative-errno in process_incoming_migration_co():
>         error_report("load of migration failed: %s", strerror(-ret));
> which results in nonsensical error messages to the user like:
>  qemu-system-aarch64: load of migration failed: Operation not permitted

In theory (pre|post)_(load|save) have the same interface; in practice
they're all rather inconsistent.
Returning 0 on success, -errno on failure is my preference.

> More generally, it would be nice if a pre_load/post_load/etc
> hook could report an error more precisely than just yes/no
> or even than just an errno: in the case of arm CPU loading
> we could in theory report more detail like which register the
> kernel didn't handle...

On the load side, just error_report as tightly as you can; what
you should see on stderr is basically a backtrace:
   'failed to do something in ...'
   'load of migration failed of ...'

Dave

> thanks
> -- PMM
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


