Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A89FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F99207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gdoej435"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F99207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jybRT-0001sr-Kn
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jybQu-0001TJ-CH
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:38:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50346
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jybQs-0007NO-BQ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595511525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uz1owc+NMsxfu8+0mFApUbVI31+7DxLGn1Ymxu7/eu8=;
 b=Gdoej435KQLGfsxc72QpBtQtG6o9BZuQRXhs9AQrkPNKKq/AkmlXhiIco5hTV3w4v87oH3
 JupMQvC2YRS6U2TMiB0w3q9jTwa8Nrs9O6y2nFo64+yMpGhUqtr7xee5bPjD/elu5s/Bxp
 s00QxayVImZVznzuPdiM7MdAWVkwa4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-FjEVobmGNzqMx2hwM45XzA-1; Thu, 23 Jul 2020 09:38:43 -0400
X-MC-Unique: FjEVobmGNzqMx2hwM45XzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2126E57;
 Thu, 23 Jul 2020 13:38:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 104D961983;
 Thu, 23 Jul 2020 13:38:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C0EB111CA26; Thu, 23 Jul 2020 15:38:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 3/4] error: Remove NULL checks on error_propagate() calls
 (again)
References: <20200722084048.1726105-1-armbru@redhat.com>
 <20200722084048.1726105-4-armbru@redhat.com>
 <5def3655-aa29-aef1-6683-b97b2faaa289@redhat.com>
 <87pn8moanx.fsf@dusky.pond.sub.org>
Date: Thu, 23 Jul 2020 15:38:36 +0200
In-Reply-To: <87pn8moanx.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 23 Jul 2020 11:14:42 +0200")
Message-ID: <87eep2fj1f.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
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
Cc: Juan Quintela <quintela@redhat.com>, Jens Freimann <jfreimann@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 7/22/20 3:40 AM, Markus Armbruster wrote:
>>> Patch created mechanically by rerunning:
>>>
>>>      $ spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
>>>               --macro-file scripts/cocci-macro-file.h \
>>>               --use-gitgrep .
>>>
>>> Cc: Jens Freimann <jfreimann@redhat.com>
>>> Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
>>> Cc: Juan Quintela <quintela@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>>> +++ b/migration/colo.c
>>> @@ -798,9 +798,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>>>         colo_send_message(mis->to_src_file,
>>> COLO_MESSAGE_VMSTATE_LOADED,
>>>                    &local_err);
>>> -    if (local_err) {
>>> -        error_propagate(errp, local_err);
>>> -    }
>>> +    error_propagate(errp, local_err);
>>>   }
>>
>> As this is mechanical, it is fine. But there is now a further cleanup
>> possible of passing errp directly to colo_send_message, and possibly
>> dropping local_err altogether.
>
> True.
>
> The patch is small and simple enough for squashing in further manual
> cleanups.  I'd like to first check whether a followup patch created with
> the machinery I used for eliminating error_propagate() comes out better.

Vladimir's scripts/coccinelle/errp-guard.cocci will take care of it.

Eliminating error propagation altogether would be even better, but it's
also more work: several void functions need to return bool instead.

>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Thanks!


