Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA97C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC7B20791
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDNFxPHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC7B20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL99T-0007Qu-Cb
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kL97t-0006dk-Sc
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kL97l-0005xz-Vl
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600884253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CEey0yBnFwxLjz8Q2NEXdW1c4eTL5u/IKeqh5xkj/Mo=;
 b=QDNFxPHG1oz4VtbkATFp56v62nIrpB1FniLMPhxUfAmtj6jJ9XGG1aq+vEMMDMSRbQ5Qqq
 x9vPg6fdqxcbhFMGc66uxczoisKf0Kx49KzM7t+pLpXOLzhCiPSniQDMZNvcpQZ/6TeoTG
 HBC6IXe+481GI51+zuYwoLDKdrihKTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-qs4UWSOkOUaDK7zX1KsoLA-1; Wed, 23 Sep 2020 14:04:09 -0400
X-MC-Unique: qs4UWSOkOUaDK7zX1KsoLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE49D100CEC1;
 Wed, 23 Sep 2020 18:04:07 +0000 (UTC)
Received: from work-vm (ovpn-113-46.ams2.redhat.com [10.36.113.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0991278827;
 Wed, 23 Sep 2020 18:04:05 +0000 (UTC)
Date: Wed, 23 Sep 2020 19:04:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v10 00/12] *** A Method for evaluating dirty page rate ***
Message-ID: <20200923180403.GB124840@work-vm>
References: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 liq3ea@gmail.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Queued

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> v9 -> v10:
>     rename find_page_matched as find_block_matched
>     fix wrong termination condition in find_block_matched
>     add review-by for patches
> 
> v8 -> v9:
>     fix wrong index return of record_ramblock_hash_info
>     optimize variable name according to review
>     reset dirty_rate as -1
>     change returns of compare_page_hash_info to bool
> 
> v7 -> v8:
>     add atomic_read for dirtyrate status
>     add error_report if set dirtyrate state failed
>     change returns of save_ramblock_hash and record_ramblock_hash_info to bool
>     alloc ramblock dirtyinfo array at one time
>     add review-by for patches
> 
> v6 -> v7:
>     fix minior comments and coding style by review
>     add review-by for patches
> 
> v5 -> v6:
>     fix coding style according to review
>     use TARGET_PAGE_SIZE and TARGET_PAGE_BITS instead of self-defined macros
>     return start-time and calc-time by qmp command
> 
> v4 -> v5:
>     fix git apply failed due to meson-build
>     add review-by for patches in v3
> 
> v3 -> v4:
>     use crc32 to get hash result instead of md5
>     add DirtyRateStatus to denote calculation status
>     add some trace_calls to make it easier to debug
>     fix some comments accroding to review
> 
> v2 -> v3:
>     fix size_t compile warning
>     fix codestyle checked by checkpatch.pl
> 
> v1 -> v2:
>     use g_rand_new() to generate rand_buf
>     move RAMBLOCK_FOREACH_MIGRATABLE into migration/ram.h
>     add skip_sample_ramblock to filter sampled ramblock
>     fix multi-numa vm coredump when query dirtyrate
>     rename qapi interface and rename some structures and functions
>     succeed to compile by appling each patch
>     add test for migrating vm
> 
> Sometimes it is neccessary to evaluate dirty page rate before migration.
> Users could decide whether to proceed migration based on the evaluation
> in case of vm performance loss due to heavy workload.
> Unlikey simulating dirtylog sync which could do harm on runnning vm,
> we provide a sample-hash method to compare hash results for samping page.
> In this way, it would have hardly no impact on vm performance.
> 
> Evaluate the dirtypage rate both on running and migration vm.
> The VM specifications for migration are as follows:
> - VM use 4-K page;
> - the number of VCPU is 32;
> - the total memory is 32Gigabit;
> - use 'mempress' tool to pressurize VM(mempress 4096 1024);
> - migration bandwidth is 1GB/s
> 
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> |                      |  running  |                  migrating                           |
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> | no mempress          |   4MB/s   |          8MB/s      (migrated success)               |
> -------------------------------------------------------------------------------------------
> | mempress 4096 1024   |  1060MB/s |     456MB/s ~ 1142MB/s (cpu throttle triggered)      |
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> | mempress 4096 4096   |  4114MB/s |     688MB/s ~ 4132MB/s (cpu throttle triggered)      |
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Test dirtyrate by qmp command like this:
> 1.  virsh qemu-monitor-command [vmname] '{"execute":"calc-dirty-rate", "arguments": {"calc-time": [sleep-time]}}'; 
> 2.  sleep specific time which is a bit larger than sleep-time
> 3.  virsh qemu-monitor-command [vmname] '{"execute":"query-dirty-rate"}'
> 
> The qmp command returns like this:
> {"return":{"status":"measured","dirty-rate":374,"start-time":3718293,"calc-time":1},"id":"libvirt-15"}
> 
> Further test dirtyrate by libvirt api like this:
> virsh getdirtyrate [vmname] [sleep-time]
> 
> Chuan Zheng (12):
>   migration/dirtyrate: setup up query-dirtyrate framwork
>   migration/dirtyrate: add DirtyRateStatus to denote calculation status
>   migration/dirtyrate: Add RamblockDirtyInfo to store sampled page info
>   migration/dirtyrate: Add dirtyrate statistics series functions
>   migration/dirtyrate: move RAMBLOCK_FOREACH_MIGRATABLE into ram.h
>   migration/dirtyrate: Record hash results for each sampled page
>   migration/dirtyrate: Compare page hash results for recorded sampled
>     page
>   migration/dirtyrate: skip sampling ramblock with size below
>     MIN_RAMBLOCK_SIZE
>   migration/dirtyrate: Implement set_sample_page_period() and
>     is_sample_period_valid()
>   migration/dirtyrate: Implement calculate_dirtyrate() function
>   migration/dirtyrate: Implement
>     qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
>   migration/dirtyrate: Add trace_calls to make it easier to debug
> 
>  migration/dirtyrate.c  | 426 +++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/dirtyrate.h  |  70 ++++++++
>  migration/meson.build  |   2 +-
>  migration/ram.c        |  11 +-
>  migration/ram.h        |  10 ++
>  migration/trace-events |   8 +
>  qapi/migration.json    |  67 ++++++++
>  7 files changed, 583 insertions(+), 11 deletions(-)
>  create mode 100644 migration/dirtyrate.c
>  create mode 100644 migration/dirtyrate.h
> 
> -- 
> 1.8.3.1
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


