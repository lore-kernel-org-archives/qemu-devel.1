Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12300C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97F720758
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hreRAnKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97F720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaw5f-0003Ah-Vw
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 02:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaw58-0002aR-Se
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:50:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60649
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaw57-0001G0-Oj
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589871028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IT9j25YxrKZTd99xm5nd/PIHUVKhmu8Y9lnIvkr3Gno=;
 b=hreRAnKQl83lknJ8NMop5Wf8CdauwJ00UnOTg3xSkwpyPT3MdOaKDLhsDGxWIpXvBpW01j
 g9kpwT4F7vlZpdELn8F28ub9FVSAQeNf2gvWCBVDtGsDwnf9zZh60VV4Q3u2N6tYry78nn
 r2ymjtx2p0EeK6NKqcvWnhFX1z7/JrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-rrPxp1GGP2qOBC7mVekfYA-1; Tue, 19 May 2020 02:50:24 -0400
X-MC-Unique: rrPxp1GGP2qOBC7mVekfYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5455B835B40;
 Tue, 19 May 2020 06:50:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07D25196AE;
 Tue, 19 May 2020 06:50:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D45711358BC; Tue, 19 May 2020 08:50:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH not-for-merge 0/5] Instrumentation for "Fixes around
 device realization"
References: <20200518051945.8621-1-armbru@redhat.com>
 <6058b1d7-53c2-adc1-9cc0-f6cbd85d2e48@ilande.co.uk>
Date: Tue, 19 May 2020 08:50:21 +0200
In-Reply-To: <6058b1d7-53c2-adc1-9cc0-f6cbd85d2e48@ilande.co.uk> (Mark
 Cave-Ayland's message of "Mon, 18 May 2020 21:56:12 +0100")
Message-ID: <87k1184dw2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 18/05/2020 06:19, Markus Armbruster wrote:
>
>> This is the instrumentation mentioned in "[PATCH 00/24] Fixes around
>> device realization".
>> 
>> PATCH 2/5 might have value on its own.  You tell me.
>> 
>> Shell script to smoke-test all machines:
>> 
>> #!/bin/sh
>> success=0
>> fail=0
>> ulimit -c 0
>> git-describe --dirty --match v\*
>> git-log --oneline -1
>> for i in bld/*-softmmu
>> do
>>     t=${i%-softmmu}
>>     t=${t##*/}
>>     q=$i/qemu-system-$t
>>     echo "= $t ="
>> 
>>     for m in `$q -M help | sed -n '/(alias of/d;2,$s/ .*//p'`
>>     do
>> 	echo "== $m =="
>> 	echo -e 'info qom-tree\ninfo qtree\nq' | $q -S -accel qtest -display none -L smoke-mon-roms -M $m -monitor stdio
>> 	if [ $? -eq 0 ]
>> 	then echo "*** Success: $m ***"; let success++
>> 	else echo "*** Fail: $m"; let fail++
>> 	fi
>>     done
>> done
>> echo $success succeeded, $fail failed
>> 
>> 
>> Markus Armbruster (5):
>>   qom: Instrument to detect missed realize
>>   qom: Make "info qom-tree" show children sorted
>>   qdev: Make "info qtree" show child devices sorted by QOM path
>>   qdev: Instrument to detect missed QOM parenting
>>   qdev: Instrument to detect bus mismatch
>> 
>>  hw/core/qdev.c     | 17 ++++++++++++++++
>>  qdev-monitor.c     | 32 ++++++++++++++++++++++++++++-
>>  qom/qom-hmp-cmds.c | 51 +++++++++++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 98 insertions(+), 2 deletions(-)
>
> Thanks for sharing these patches! I certainly think that they have value and after a
> quick read through I'm thinking:
>
> - Patch 1 I assume is no longer needed once you previous series is merged

Correct, "[PATCH 24/24] qdev: Assert onboard devices all get realized
properly" supersedes.

> - Patches 2 & 3 would be really useful at the start of your previous series (as
> someone who has gone crossed-eyed enough trying to spot these differences, this is
> really helpful)

It's where they sat while I developed my fixes, so I don't go
cross-eyed, too :)

> - Patches 4 and 5 are good sanity checks for developers but I'm wondering what is the
> extent of work that needs to be done? Could existing failures be whitelisted with the
> aim of removal which would then at least prevent new devices being added that aren't
> correct?

Since realization assigns a QOM parent to orphans, "[PATCH 24/24] qdev:
Assert onboard devices all get realized properly" supersedes PATCH 4,
too.  I needed both PATCH 1 and 4 to track down missing realizes,
because some were visible only in "info qtree" (PATCH 4), and some only
in "info qom-tree" (PATCH 1).

"[PATCH 22/24] qdev: Assert devices are plugged into a bus that can take
them" supersedes PATCH 5.

Thanks!


