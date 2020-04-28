Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCFC83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A201720575
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuzH9VUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A201720575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVKp-0005TQ-N8
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTVJq-0004bp-I6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTVJp-0002tA-D2
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:50:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47689
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTVJo-0002sm-Pa
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588099855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=67gahdHtJfVQl5pSWcO/99XcqqkIJhB7HW5ibQI7LKM=;
 b=YuzH9VUKi2bzSuNgUydZemfaEiHEx7go8KaG9qMR8YLeE8axglJ1M6KH9iUxGgrxCTOakQ
 zh2dMQf5y1vSFZm7FBCwIRxOz04ERJ+/xJuBineWHd8aleFt9oZP97XOUH6GeUlAvx4Jte
 9tr4wJOO9fiIdLyPBqrMiwd0XmQS0R8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-hCBidi6JN92OSNyeKqOnBQ-1; Tue, 28 Apr 2020 14:50:53 -0400
X-MC-Unique: hCBidi6JN92OSNyeKqOnBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45E44108BD09
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 18:50:52 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5694C60D37;
 Tue, 28 Apr 2020 18:50:51 +0000 (UTC)
Subject: Re: [PATCH 17/17] qom: Drop @errp parameter of object_property_del()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-18-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c695d53c-1126-f121-b452-1931b84cb25d@redhat.com>
Date: Tue, 28 Apr 2020 13:50:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-18-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 11:34 AM, Markus Armbruster wrote:
> Same story as for object_property_add(): the only way
> object_property_del() can fail is when the property with this name
> does not exist.  Since our property names are all hardcoded, failure
> is a programming error, and the appropriate way to handle it is
> passing &error_abort.  Most callers do that, the commit before
> previous fixed one that didn't (and got the error handling wrong), and
> the two remaining exceptions ignore errors.
> 
> Drop the @errp parameter and assert the precondition instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

I skipped review of 15/17 (it's less mechanical, and although the commit 
message was good, verifying that the patch matches the commit message is 
a bigger task).  But assuming it is right, then this one indeed makes sense.


> +++ b/qom/object.c
> @@ -1280,15 +1280,10 @@ ObjectProperty *object_class_property_find(ObjectClass *klass, const char *name,
>       return prop;
>   }
>   
> -void object_property_del(Object *obj, const char *name, Error **errp)
> +void object_property_del(Object *obj, const char *name)
>   {
>       ObjectProperty *prop = g_hash_table_lookup(obj->properties, name);
>   
> -    if (!prop) {
> -        error_setg(errp, "Property '.%s' not found", name);
> -        return;
> -    }
> -
>       if (prop->release) {
>           prop->release(obj, name, prop->opaque);
>       }

However, the commit message says you assert the precondition, whereas 
the code SEGVs rather than asserts if the precondition is not met.  In 
practice, both will flag the programmer error, so I don't care which you 
do, but it's worth making the commit match the intent: Did you mean to 
add an assert()?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


