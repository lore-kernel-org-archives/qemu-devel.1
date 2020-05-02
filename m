Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6138C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07EC21775
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyC8BrWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07EC21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUkNO-0005VD-In
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 01:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkMf-0004ds-Ma
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUkMf-0005JM-3r
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:07:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkMe-0005Co-NL
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588396019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uBoXJrBCilbm7mDu4LZC2REfhG680ie4bAQalz6CA1o=;
 b=JyC8BrWACMrLlFAHg/p4SxKxI9yOm9dbw1mr+JdxbkUEyg0Ymn2EosjQomxzWw0JGR5O+7
 YUWP7mL/wqTAWifvqt8k5YeRFS6pg66y/GgpFYeTjAsIyGpxVFFsvjQUzwnGmGaQoCcqvt
 LHa7vUb9l6gIFXbTtMmjo1O+u0VJLg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-PUEvAUFjMzCxDzI87EzxEg-1; Sat, 02 May 2020 01:06:57 -0400
X-MC-Unique: PUEvAUFjMzCxDzI87EzxEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC1891895915
 for <qemu-devel@nongnu.org>; Sat,  2 May 2020 05:06:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F35260BF1;
 Sat,  2 May 2020 05:06:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5514011358BD; Sat,  2 May 2020 07:06:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 04/17] qom: Change object_property_get_uint16List() to
 match its doc
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-5-armbru@redhat.com>
 <1dd34bf3-542f-44ce-05c4-a351edc92cc3@redhat.com>
Date: Sat, 02 May 2020 07:06:53 +0200
In-Reply-To: <1dd34bf3-542f-44ce-05c4-a351edc92cc3@redhat.com> (Eric Blake's
 message of "Tue, 28 Apr 2020 12:46:39 -0500")
Message-ID: <87wo5v6i36.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 01:06:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qom/object.h       | 4 ++--
>>   hw/core/machine-qmp-cmds.c | 6 +++---
>>   qom/object.c               | 9 +++++----
>>   3 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index ccfa82e33d..5d1ed672c3 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -1331,8 +1331,8 @@ int object_property_get_enum(Object *obj, const ch=
ar *name,
>
> Adding context:
>
> /**
>  * object_property_get_uint16List:
>  * @obj: the object
>  * @name: the name of the property
>  * @list: the returned int list
>  * @errp: returns an error if this function fails
>  *
>  * Returns: the value of the property, converted to integers, or
>
>>    * undefined if an error occurs (including when the property value is =
not
>>    * an list of integers).
>>    */
>> -void object_property_get_uint16List(Object *obj, const char *name,
>> -                                    uint16List **list, Error **errp);
>> +uint16List *object_property_get_uint16List(Object *obj, const char *nam=
e,
>> +                                           Error **errp);
>
> Incomplete.  The doc comments need to drop the @list line, as well as
> s/undefined/#NULL/ in the Returns line.

Will fix.

> With that fixed,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


