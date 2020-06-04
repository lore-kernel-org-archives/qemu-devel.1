Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7A9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C876F2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnpsR6Lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C876F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmNb-00048w-2G
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgmMo-0003GC-24
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:40:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39370
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgmMm-00041b-98
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591263650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5h70cgMb/Ejpewjc0S3ZiEoYffYJOkQx2l+0StCtc6M=;
 b=fnpsR6LxkWBhE/lPpANqtgBCz507FzbVhO8fAdsPE+bTiSdrwbnwFDBb8nfXGuaTsuuYeR
 MPkP1xRbBPYdwXl2tX6LyrWp3q2pXOkoipsdTYEAXXTPE7OkQKZABpMkV/dQxlenQvOumK
 g3tNrqskx/VkdqDvxtgcoR8zJhlCtV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-cma7GvJ0NSmOp9AOO6VjYQ-1; Thu, 04 Jun 2020 05:40:47 -0400
X-MC-Unique: cma7GvJ0NSmOp9AOO6VjYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BD5B800685;
 Thu,  4 Jun 2020 09:40:46 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-105.ams2.redhat.com [10.36.112.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D50BF5C1C8;
 Thu,  4 Jun 2020 09:40:40 +0000 (UTC)
Subject: Re: [PATCH v4 4/6] iotests: 194: test also migration of dirty bitmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200521220648.3255-1-vsementsov@virtuozzo.com>
 <20200521220648.3255-5-vsementsov@virtuozzo.com>
 <8954b780-614c-421a-cca3-992f68d24812@redhat.com>
 <93c99c0a-2c79-c62f-4c38-50c5c23ea4eb@virtuozzo.com>
 <7a9d8094-574f-5622-0624-37982181d0a6@redhat.com>
 <ee39000a-8a35-04af-8e38-c6aeff59dbd6@virtuozzo.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <921309b8-b216-7f86-ad33-594a7c7991b4@redhat.com>
Date: Thu, 4 Jun 2020 11:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ee39000a-8a35-04af-8e38-c6aeff59dbd6@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:14:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, quintela@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/2020 09.51, Vladimir Sementsov-Ogievskiy wrote:
> 04.06.2020 10:21, Thomas Huth wrote:
>> On 03/06/2020 10.06, Vladimir Sementsov-Ogievskiy wrote:
>>> 03.06.2020 10:52, Thomas Huth wrote:
>>>> On 22/05/2020 00.06, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Test that dirty bitmap migration works when we deal with mirror.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>> ---
>>>>>    tests/qemu-iotests/194     | 14 ++++++++++----
>>>>>    tests/qemu-iotests/194.out |  6 ++++++
>>>>>    2 files changed, 16 insertions(+), 4 deletions(-)
>>>>
>>>>    Hi!
>>>>
>>>> This test broke the iotest in the gitlab CI:
>>>>
>>>>    https://gitlab.com/huth/qemu/-/jobs/578520599#L3780
>>>>
>>>> it works again when I revert this commit.
>>>>
>>>> Could the test be reworked so that it works in CI pipelines, too?
>>>> Otherwise, I think it's best if we disable it in the .gitlab-ci.yml
>>>> file...
>> [...]
>>> - Qemu aborted. Not good. Definitely is better to fix it than just
>>> exclude the test.. I can't reproduce. Could you provide backtrace from
>>> coredump?
>>
>> It aborted in block/dirty-bitmap.c, line 295, that's the
>> "assert(!bdrv_dirty_bitmap_busy(bitmap));" if I got it right.
>>
>> Full backtrace here:
>>
>>   https://gitlab.com/huth/qemu/-/jobs/580553686#L3638
>>
> 
> Aha, missed it, thanks.

No, you didn't miss it. That was a new run where I added some more
debugging magic to the gitlab-ci.yml file:

build-tcg-disabled:
 [...]
 - make -j"$JOBS"
 - sysctl -w kernel.core_pattern=/tmp/core
 - ulimit -c
 - cd tests/qemu-iotests/
 - ./check -raw 194 || find /tmp -name "*core*"
 - gdb -ex bt ../../x86_64-softmmu/qemu-system-x86_64 /tmp/core*

> Hm. in 194 iotest we wait for migration finish on source, but not on
> target. I can assume, that in your setup target shutdown occurs earlier
> than migration finish, so we have busy bitmap on shutdown.

Sounds plausible. Especially if you consider that these gitlab CI
containers only run with one virtual CPU, so there is likely more delay
here.

> It's known bug (at least for me :), patch is in list:
> [PATCH v2 00/22] Fix error handling during bitmap postcopy
>   [..]
>   [PATCH v2 10/22] migration/block-dirty-bitmap: cancel migration on
> shutdown 
> (https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04288.html)
>      If target is turned of prior to postcopy finished, target crashes
>      because busy bitmaps are found at shutdown.
>      Canceling incoming migration helps, as it removes all unfinished (and
>      therefore busy) bitmaps.
>   [..]
> 
> 
> Still, of course iotest 194 should be fixed too, to wait for migration
> finish on target too, I'll send a patch.

Thanks, I'll give it a try!

 Thomas


