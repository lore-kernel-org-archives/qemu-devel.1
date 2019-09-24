Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607C5C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8F320872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8F320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrwc-0002W4-EA
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCruL-0001Z9-DE
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCruJ-0003kO-Hn
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCruJ-0003k1-CQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:59:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D553300D1C2;
 Tue, 24 Sep 2019 20:59:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F01B95D9D5;
 Tue, 24 Sep 2019 20:59:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C35F9113864E; Tue, 24 Sep 2019 22:59:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 25/25] qapi: Improve source file read error handling
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-26-armbru@redhat.com>
 <24b79697-39bb-0154-3d3d-fd98ea8a9d5e@redhat.com>
Date: Tue, 24 Sep 2019 22:59:32 +0200
In-Reply-To: <24b79697-39bb-0154-3d3d-fd98ea8a9d5e@redhat.com> (Eric Blake's
 message of "Tue, 24 Sep 2019 14:57:09 -0500")
Message-ID: <87v9th76mj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 24 Sep 2019 20:59:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/24/19 8:28 AM, Markus Armbruster wrote:
>> qap-gen.py crashes when it can't open the main schema file, and when
>
> qapi-gen.py

Will fix.

>> it can't read from any schema file.  Lazy.
>> 
>> Change QAPISchema.__init__() to take a file name instead of a file
>> object.  Move the open code from _include() to __init__(), so it's
>> used for the main schema file, too.
>> 
>> Move the read into the try for good measure, and rephrase the error
>> message.
>> 
>> Reporting open or read failure for the main schema file needs a
>> QAPISourceInfo representing "no source".  Make QAPISourceInfo cope
>> with fname=None.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py                | 46 +++++++++++++++------------
>>  tests/qapi-schema/include-no-file.err |  2 +-
>>  2 files changed, 27 insertions(+), 21 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

