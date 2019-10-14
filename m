Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D7BC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B85A217F9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B85A217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJzSl-0000wT-Kh
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 08:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iJzGk-00080F-6n
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iJzGh-0002wn-Ug
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:16:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iJzGh-0002vS-Mp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:16:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 611D0C056808
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 12:16:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C05760920;
 Mon, 14 Oct 2019 12:16:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D1421138619; Mon, 14 Oct 2019 14:16:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 4/4] qapi: Allow introspecting fix for savevm's
 cooperation with blockdev
References: <20191011085027.28606-1-armbru@redhat.com>
 <20191011085027.28606-5-armbru@redhat.com>
 <20191014100653.GE7173@localhost.localdomain>
Date: Mon, 14 Oct 2019 14:16:03 +0200
In-Reply-To: <20191014100653.GE7173@localhost.localdomain> (Kevin Wolf's
 message of "Mon, 14 Oct 2019 12:06:53 +0200")
Message-ID: <87pniz4j5o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 14 Oct 2019 12:16:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 11.10.2019 um 10:50 hat Markus Armbruster geschrieben:
>> From: Peter Krempa <pkrempa@redhat.com>
>> 
>> 'savevm' was buggy as it considered all monitor-owned block device
>> nodes for snapshot. With the introduction of -blockdev, the common
>> usage made all nodes including protocol and backing file nodes be
>> monitor-owned and thus considered for snapshot.
>> 
>> This is a problem since the 'file' protocol nodes can't have internal
>> snapshots and it does not make sense to take snapshot of nodes
>> representing backing files.
>> 
>> This was fixed by commit 05f4aced658a02b02. Clients need to be able to
>> detect whether this fix is present.
>> 
>> Since savevm does not have an QMP alternative, add the feature for the
>> 'human-monitor-command' backdoor which is used to call this command in
>> modern use.
>> 
>> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi/misc.json | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 6bd11f50e6..35dca86ce7 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -1020,6 +1020,13 @@
>>  #
>>  # @cpu-index: The CPU to use for commands that require an implicit CPU
>>  #
>> +# Features:
>> +
>
> I think you want a # in this empty line.

I'll delete the line instead, so the Features part looks like the one we
already have in block-core.json.

>> +# @savevm-monitor-nodes: If present, HMP command savevm only snapshots
>> +#                        monitor-owned nodes if they have no parents.
>> +#                        This allows the use of 'savevm' with
>> +#                        -blockdev. (since 4.2)
>> +#
>>  # Returns: the output of the command as a string
>>  #
>>  # Since: 0.14.0
>> @@ -1047,7 +1054,8 @@
>>  ##
>>  { 'command': 'human-monitor-command',
>>    'data': {'command-line': 'str', '*cpu-index': 'int'},
>> -  'returns': 'str' }
>> +  'returns': 'str',
>> +  'features': [ 'savevm-monitor-nodes' ] }
>
> With this fixed:
>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Thanks!

