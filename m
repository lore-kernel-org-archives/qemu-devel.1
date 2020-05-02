Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEEFC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3292821775
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YU2eTSSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3292821775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUkQJ-0008Cg-9V
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 01:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkPS-0006tl-7x
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUkPR-0000ae-Jw
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:09:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40512
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkPR-0000a7-6k
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588396191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t/YmTBAjL0tTi7ypYtE7rNG+vQH93rtTjIWczoTjui4=;
 b=YU2eTSSmAbTbh1zqF8/z6HGQXipSK9Mm2fgjzle7eUd2dQ3np8zg031/XVn+Ryf0yIYRwJ
 ppq+thZsK0UfUE1kDXmlE3W/EiZPQc5QRs9+Wbj2pA3WkVb4X3EnjG6i/2p5uckgS8kyQH
 pqk65MFIZXjNW4DwOUaU4qinFK/sLvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-keqmkinZNa2ayKQTaGcfwQ-1; Sat, 02 May 2020 01:09:49 -0400
X-MC-Unique: keqmkinZNa2ayKQTaGcfwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABA0A1800D4A
 for <qemu-devel@nongnu.org>; Sat,  2 May 2020 05:09:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78E361001B2C;
 Sat,  2 May 2020 05:09:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C1DA11358BC; Sat,  2 May 2020 07:09:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 17/17] qom: Drop @errp parameter of object_property_del()
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-18-armbru@redhat.com>
 <c695d53c-1126-f121-b452-1931b84cb25d@redhat.com>
Date: Sat, 02 May 2020 07:09:47 +0200
In-Reply-To: <c695d53c-1126-f121-b452-1931b84cb25d@redhat.com> (Eric Blake's
 message of "Tue, 28 Apr 2020 13:50:50 -0500")
Message-ID: <87sggi7wis.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 01:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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

Eric Blake <eblake@redhat.com> writes:

> On 4/28/20 11:34 AM, Markus Armbruster wrote:
>> Same story as for object_property_add(): the only way
>> object_property_del() can fail is when the property with this name
>> does not exist.  Since our property names are all hardcoded, failure
>> is a programming error, and the appropriate way to handle it is
>> passing &error_abort.  Most callers do that, the commit before
>> previous fixed one that didn't (and got the error handling wrong), and
>> the two remaining exceptions ignore errors.
>>
>> Drop the @errp parameter and assert the precondition instead.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> I skipped review of 15/17 (it's less mechanical, and although the
> commit message was good, verifying that the patch matches the commit
> message is a bigger task).  But assuming it is right, then this one
> indeed makes sense.
>
>
>> +++ b/qom/object.c
>> @@ -1280,15 +1280,10 @@ ObjectProperty *object_class_property_find(Objec=
tClass *klass, const char *name,
>>       return prop;
>>   }
>>   -void object_property_del(Object *obj, const char *name, Error
>> **errp)
>> +void object_property_del(Object *obj, const char *name)
>>   {
>>       ObjectProperty *prop =3D g_hash_table_lookup(obj->properties, name=
);
>>   -    if (!prop) {
>> -        error_setg(errp, "Property '.%s' not found", name);
>> -        return;
>> -    }
>> -
>>       if (prop->release) {
>>           prop->release(obj, name, prop->opaque);
>>       }
>
> However, the commit message says you assert the precondition, whereas
> the code SEGVs rather than asserts if the precondition is not met.  In
> practice, both will flag the programmer error, so I don't care which
> you do, but it's worth making the commit match the intent: Did you
> mean to add an assert()?

I started with an assert, then decided asserting prop right before
dereferncing it is silly, and deleted the assertion without adjusting
the commit message.  I'll tidy up.


