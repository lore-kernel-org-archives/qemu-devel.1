Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAF1C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D280420820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D280420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCN9y-0004Ko-2I
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCN1l-00067c-GL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCN1j-0002MF-3P
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCN1i-0002Ln-KK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B8D1B88307;
 Mon, 23 Sep 2019 12:01:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04F461001B00;
 Mon, 23 Sep 2019 12:01:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4BB3113864E; Mon, 23 Sep 2019 14:01:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/19] qapi: Fix excessive
 QAPISchemaEntity.check() recursion
References: <20190914153506.2151-1-armbru@redhat.com>
 <20190914153506.2151-19-armbru@redhat.com>
 <a147bf58-46a1-4fff-269f-e36ffeb85029@redhat.com>
Date: Mon, 23 Sep 2019 14:01:05 +0200
In-Reply-To: <a147bf58-46a1-4fff-269f-e36ffeb85029@redhat.com> (Eric Blake's
 message of "Tue, 17 Sep 2019 14:26:35 -0500")
Message-ID: <87ef07nrwe.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 23 Sep 2019 12:01:09 +0000 (UTC)
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

> On 9/14/19 10:35 AM, Markus Armbruster wrote:
>> Entity checking goes back to commit ac88219a6c "qapi: New QAPISchema
>> intermediate representation", v2.5.0.  It's designed to work as
>> follows: QAPISchema.check() calls .check() for all the schema's
>> entities.  An entity's .check() recurses into another entity's
>> .check() only if the C struct generated for the former contains the C
>> struct generated for the latter (pointers don't count).  This is used
>> to detect "object contains itself".
>> 
>> There are two instances of this:
>> 
>> * An object's C struct contains its base's C struct
>> 
>>   QAPISchemaObjectType.check() calls self.base.check()
>> 
>> * An object's C struct contains its variants' C structs
>> 
>>   QAPISchemaObjectTypeVariants().check calls v.type.check().  Since
>>   commit b807a1e1e3 "qapi: Check for QAPI collisions involving variant
>>   members", v2.6.0.
>> 
>
>> Sadly, this design has since eroded:
>> 
>
>> * A QAPISchemaEntity's .module becomes valid at .check().  This is
>>   because computing it needs info and schema.fname, and because array
>>   types get it from their element type instead.
>> 
>>   Make it a property  just like .ifcond.
>
> Extra space.

Will fix.

>> Additionally, have QAPISchemaEntity.check() assert it gets called at
>> most once, so the design invariant will stick this time.  Neglecting
>> that was entirely my fault.
>
> Lengthy explanation, but it makes sense.

Writing the commit message was more work than writing the patch...

>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py | 74 +++++++++++++++++++++++++++++-------------
>>  1 file changed, 52 insertions(+), 22 deletions(-)
>> 
>
> Took me a bit longer to read this (and refresh myself on what
> '@property' actually does in Python, but you're not the first user of it
> in qemu), but it matches the commit message.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

