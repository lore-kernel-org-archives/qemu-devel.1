Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A74C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9098420820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9098420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCN6r-0000lb-En
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCN0P-0005AU-6d
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCN0O-0001Vm-8y
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:59:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCN0O-0001VL-3p
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:59:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CC5E30860DD;
 Mon, 23 Sep 2019 11:59:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9934860BF7;
 Mon, 23 Sep 2019 11:59:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 24764113864E; Mon, 23 Sep 2019 13:59:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/19] qapi: Normalize 'if' in check_exprs(),
 like other sugar
References: <20190914153506.2151-1-armbru@redhat.com>
 <20190914153506.2151-14-armbru@redhat.com>
 <60d81331-ea7b-a375-cb68-e2fff7d54ccb@redhat.com>
Date: Mon, 23 Sep 2019 13:59:43 +0200
In-Reply-To: <60d81331-ea7b-a375-cb68-e2fff7d54ccb@redhat.com> (Eric Blake's
 message of "Tue, 17 Sep 2019 13:14:52 -0500")
Message-ID: <87k19znryo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 23 Sep 2019 11:59:47 +0000 (UTC)
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
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/14/19 10:35 AM, Markus Armbruster wrote:
>> We normalize shorthand to longhand forms in check_expr(): enumeration
>> values with normalize_enum(), feature values with
>> normalize_features(), struct members, union branches and alternate
>> branches with normalize_members().  If conditions are an exception: we
>> normalize them in QAPISchemaEntity.check() and
>> QAPISchemaMember.__init(), with listify_cond().  The idea goes back to
>> commit 2cbc94376e "qapi: pass 'if' condition into QAPISchemaEntity
>> objects", v3.0.0.
>> 
>> Normalize in check_expr() instead, with new helper normalize_if().
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py | 26 +++++++++++++++-----------
>>  1 file changed, 15 insertions(+), 11 deletions(-)
>> 
>
> Definitely more consistent.
>
>
>> @@ -904,6 +905,7 @@ def check_union(expr, info):
>>          check_known_keys(info, "member '%s' of union '%s'" % (key, name),
>>                           value, ['type'], ['if'])
>>          check_if(value, info)
>> +        normalize_if(value)
>
> Is it worth combining check_if() and normalize_if() into a single helper
> function, since they always seem to be paired?

The normalize_{enum,members,features}() are similarly paired with
check_keys().  I sidestepped the question whether checking and
normalizing should be fused.  We can revisit it later.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

