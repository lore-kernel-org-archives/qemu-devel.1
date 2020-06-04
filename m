Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74494C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAD5204EA
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXjJ46VX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAD5204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmeK-0007GY-E2
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jgmda-0006OJ-92
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:58:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36545
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jgmdZ-0007aB-89
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591264692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W+UANcxtQ8/KjNOAJeWLi+6qqQRBUd7qdXr12xK65lU=;
 b=aXjJ46VXywc+q7HiRIDcuOdcNt+akYwzYvLPRCO/dcw2oS7LuIUrAkdfn2ctvnp9pa/KR6
 fFiH6Mxs4ELzBvNMxdsixqLiZ5d5AS2EfiUrJdzWzsadLE2q3yzfBZ7fpYh8hlB7wEwnpf
 v3YDoVcJdJKzHsXBNnvrfEfv72vQsT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-x4Dy6cdlOPeloOjrcT814Q-1; Thu, 04 Jun 2020 05:58:10 -0400
X-MC-Unique: x4Dy6cdlOPeloOjrcT814Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71AB8EC1AD;
 Thu,  4 Jun 2020 09:58:09 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D8DB6111F;
 Thu,  4 Jun 2020 09:58:02 +0000 (UTC)
Date: Thu, 4 Jun 2020 10:57:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] iotests: 194: wait migration completion on target too
Message-ID: <20200604095759.GC2851@work-vm>
References: <20200604083341.26978-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200604083341.26978-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, thuth@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> It is possible, that shutdown on target occurs earlier than migration
> finish. In this case we crash in bdrv_release_dirty_bitmap_locked()
> on assertion "assert(!bdrv_dirty_bitmap_busy(bitmap));" as we do have
> busy bitmap, as bitmap migration is ongoing.
> 
> We'll fix bitmap migration to gracefully cancel on early shutdown soon.
> Now let's fix iotest 194 to wait migration completion before shutdown.
> 
> Note that in this test dest_vm.shutdown() is called implicitly, as vms
> used as context-providers, see __exit__() method of QEMUMachine class.
> 
> Actually, not waiting migration finish is a wrong thing, but the test
> started to crash after commit ae00aa239847682
> "iotests: 194: test also migration of dirty bitmap", which added dirty
> bitmaps here. So, Fixes: tag won't hurt.

Without knowing the iotests framework, the actual problem sounds right;
I just fixed a similar bug in the acceptance test migration code.
Every migration test seems to make the same mistake!

Dave

> Fixes: ae00aa2398476824f0eca80461da215e7cdc1c3b
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/194     | 10 ++++++++++
>  tests/qemu-iotests/194.out |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
> index 3fad7c6c1a..6dc2bc94d7 100755
> --- a/tests/qemu-iotests/194
> +++ b/tests/qemu-iotests/194
> @@ -87,4 +87,14 @@ with iotests.FilePath('source.img') as source_img_path, \
>              iotests.log(dest_vm.qmp('nbd-server-stop'))
>              break
>  
> +    iotests.log('Wait migration completion on target...')
> +    migr_events = (('MIGRATION', {'data': {'status': 'completed'}}),
> +                   ('MIGRATION', {'data': {'status': 'failed'}}))
> +    event = dest_vm.events_wait(migr_events)
> +    iotests.log(event, filters=[iotests.filter_qmp_event])
> +
> +    iotests.log('Check bitmaps on source:')
>      iotests.log(source_vm.qmp('query-block')['return'][0]['dirty-bitmaps'])
> +
> +    iotests.log('Check bitmaps on target:')
> +    iotests.log(dest_vm.qmp('query-block')['return'][0]['dirty-bitmaps'])
> diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
> index dd60dcc14f..f70cf7610e 100644
> --- a/tests/qemu-iotests/194.out
> +++ b/tests/qemu-iotests/194.out
> @@ -21,4 +21,9 @@ Gracefully ending the `drive-mirror` job on source...
>  {"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>  Stopping the NBD server on destination...
>  {"return": {}}
> +Wait migration completion on target...
> +{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +Check bitmaps on source:
> +[{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
> +Check bitmaps on target:
>  [{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


