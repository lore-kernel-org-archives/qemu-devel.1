Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F887C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 06:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1652065F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 06:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXfgdoxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1652065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxP7U-0007tz-Em
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 02:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxP6k-0007Sa-HO
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 02:17:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44990
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxP6i-00027Q-2z
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 02:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595225818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=wQo4ePjLqEqnqtyNJ97l4a7D5ucCFgAPGr155ZObeYs=;
 b=MXfgdoxfKim9cizgWURpAOfOI5ZOE0hHhTCJ/l9TWMpEAf6LkrEF6q9Pssl1vc81ToDF/J
 sdO2cpPGMcAjismVrW3AOaTs/fzPnV5OrLk34fnTsSEYTTfrIWaLaHnT5xv1QyxsDvLOHS
 kVqsZ01s/Y/LmlDakXNWTz4kbaxBbJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-teiOy5hpMrOaKkQ2k9sHxg-1; Mon, 20 Jul 2020 02:16:56 -0400
X-MC-Unique: teiOy5hpMrOaKkQ2k9sHxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACFFF1902EB5;
 Mon, 20 Jul 2020 06:16:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 420BA8FA20;
 Mon, 20 Jul 2020 06:16:54 +0000 (UTC)
Subject: Memory leak in bitmap code? (was: QEMU | Pipeline #168317253 has
 failed for master | 9fc87111)
References: <5f14a0997a4e8_4e6d3fcbdd8e41b010815d@sidekiq-catchall-05-sv-gprd.mail>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
To: QEMU Developers <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <16102b4a-160a-a400-a332-4477b83468d8@redhat.com>
Date: Mon, 20 Jul 2020 08:16:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5f14a0997a4e8_4e6d3fcbdd8e41b010815d@sidekiq-catchall-05-sv-gprd.mail>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:16:39
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


 Hi,

looks like the LeakSanitizer spotted a memory leak in the bitmap related
code ... not sure why it just triggered with Richard's pull request, and
I can also not reproduce it... But since there is a nice backtrace in it
and there have been some bitmap-related patches recently, could you
maybe have a look whether this rings a bell by any chance:

 https://gitlab.com/qemu-project/qemu/-/jobs/645799805#L3282

?

 Thanks,
  Thomas


On 19/07/2020 21.35, GitLab via wrote:
> GitLab
> ✖ 	Your pipeline has failed.
> 
>  
> Project 	QEMU <https://gitlab.com/qemu-project> / QEMU
> <https://gitlab.com/qemu-project/qemu>
> Branch 	
> 	master <https://gitlab.com/qemu-project/qemu/-/commits/master>
> 
> Commit 	
> 	9fc87111
> <https://gitlab.com/qemu-project/qemu/-/commit/9fc87111005e8903785db40819af66b8f85b8b96>
> 
> 
> Merge remote-tracking branch 'remotes/rth/tags/...
> Commit Author 	
> 	Peter Maydell <https://gitlab.com/pm215>
> 
>  
> Pipeline #168317253
> <https://gitlab.com/qemu-project/qemu/-/pipelines/168317253>
> triggered by 		Alex Bennée <https://gitlab.com/stsquad>
> 
> had 1 failed build.
> Logs may contain sensitive data. Please consider before forwarding this
> email.
> ✖ 	build
> 
> 	build-fuzzer <https://gitlab.com/qemu-project/qemu/-/jobs/645799805>
> 
> ==11111==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 2359296 byte(s) in 9 object(s) allocated from:
> #0 0x5570060105d7 in calloc
> (/builds/qemu-project/qemu/build/x86_64-softmmu/qemu-system-x86_64+0x2bdb5d7)
> #1 0x55700605ddf9 in bitmap_try_new
> /builds/qemu-project/qemu/include/qemu/bitmap.h:96:12
> #2 0x55700605ddf9 in bitmap_new
> /builds/qemu-project/qemu/include/qemu/bitmap.h:101:26
> #3 0x55700605ddf9 in dirty_memory_extend
> /builds/qemu-project/qemu/exec.c:2219:37
> #4 0x55700605ddf9 in ram_block_add /builds/qemu-project/qemu/exec.c:2268:9
> #5 0x5570060611b4 in qemu_ram_alloc_internal
> /builds/qemu-project/qemu/exec.c:2441:5
> #6 0x557006061567 in qemu_ram_alloc /builds/qemu-project/qemu/exec.c:2460:12
> #7 0x55700675d350 in memory_region_init_ram_shared_nomigrate
> /builds/qemu-project/qemu/softmmu/memory.c:1514:21
> #8 0x557006bdd127 in ram_backend_memory_alloc
> /builds/qemu-project/qemu/backends/hostmem-ram.c:30:5
> #9 0x557006bd9733 in host_memory_backend_memory_complete
> /builds/qemu-project/qemu/backends/hostmem.c:333:9
> #10 0x557007a20ffc in user_creatable_complete
> /builds/qemu-project/qemu/qom/object_interfaces.c:23:9
> #11 0x557007a2178a in user_creatable_add_type
> /builds/qemu-project/qemu/qom/object_interfaces.c:93:10
> #12 0x557007a219dc in user_creatable_add_dict
> /builds/qemu-project/qemu/qom/object_interfaces.c:134:11
> #13 0x557007ee7eb6 in qmp_dispatch
> /builds/qemu-project/qemu/qapi/qmp-dispatch.c:155:5
> #14 0x5570077452a8 in monitor_qmp_dispatch
> /builds/qemu-project/qemu/monitor/qmp.c:145:11
> #15 0x55700774411d in monitor_qmp_bh_dispatcher
> /builds/qemu-project/qemu/monitor/qmp.c:234:9
> #16 0x557008065c66 in aio_bh_poll
> /builds/qemu-project/qemu/util/async.c:164:13
> #17 0x55700800235c in aio_dispatch
> /builds/qemu-project/qemu/util/aio-posix.c:380:5
> #18 0x55700806a62c in aio_ctx_dispatch
> /builds/qemu-project/qemu/util/async.c:306:5
> #19 0x7f93662807ae in g_main_context_dispatch
> (/lib64/libglib-2.0.so.0+0x527ae)
> 
> SUMMARY: AddressSanitizer: 2359296 byte(s) leaked in 9 allocation(s).
> /builds/qemu-project/qemu/tests/qtest/libqtest.c:166: kill_qemu() tried
> to terminate QEMU process but encountered exit status 1 (expected 0)
> ERROR qmp-cmd-test - too few tests run (expected 51, got 50)
> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:650:
> check-qtest-x86_64] Error 1
> ERROR: Job failed: exit code 1
> 
> GitLab
> You're receiving this email because of your account on gitlab.com.
> Manage all notifications <https://gitlab.com/profile/notifications> ·
> Help <https://gitlab.com/help>
> 


