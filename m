Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE110C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBEF20936
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeO9pKCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBEF20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOh7h-0000Tg-UE
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jOh71-0008DU-OZ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jOh70-00043e-6h
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:25:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jOh70-00043S-1Q
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586953549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIIEK5i5q8wo1LvKRXioGMew6oNRUb0wy1d8m7NaUKI=;
 b=FeO9pKCiGMPRjIHhvF5Bbq5I9xOWXwvs3c77ZG1DC+QOHuy6V6iqi24gHN+NA0skmg1zhG
 /MLasRsSpid8dfmSesQFu3qFGICFJkCYG7MMi4q/C3EXentoy8mBkUCct+ECoHDtzPvErR
 Q/mNR1oHjkjTeM5c4B+BxHSAMET3WKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-qQZF1bR5NA2etI2wCifZXA-1; Wed, 15 Apr 2020 08:25:45 -0400
X-MC-Unique: qQZF1bR5NA2etI2wCifZXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E333FDB65;
 Wed, 15 Apr 2020 12:25:43 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80E3210016EB;
 Wed, 15 Apr 2020 12:25:43 +0000 (UTC)
Subject: Re: [PATCH for-5.1 1/5] qobject: Clean up QLIST_FOREACH_ENTRY()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200415083048.14339-1-armbru@redhat.com>
 <20200415083048.14339-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2dfbc0f3-b186-9c19-4eec-96b64048ffb3@redhat.com>
Date: Wed, 15 Apr 2020 07:25:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415083048.14339-2-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 3:30 AM, Markus Armbruster wrote:
> QLIST_FOREACH_ENTRY() traverses a tail queue manually.  Use
> QTAILQ_FIRST() and QTAILQ_NEXT() instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/qlist.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
> index 8d2c32ca28..07ecae81e4 100644
> --- a/include/qapi/qmp/qlist.h
> +++ b/include/qapi/qmp/qlist.h
> @@ -34,10 +34,10 @@ void qlist_append_int(QList *qlist, int64_t value);
>   void qlist_append_null(QList *qlist);
>   void qlist_append_str(QList *qlist, const char *value);
>   
> -#define QLIST_FOREACH_ENTRY(qlist, var)             \
> -        for ((var) = ((qlist)->head.tqh_first);     \
> -            (var);                                  \
> -            (var) = ((var)->next.tqe_next))
> +#define QLIST_FOREACH_ENTRY(qlist, var)                 \
> +        for ((var) = QTAILQ_FIRST(&(qlist)->head);      \
> +             (var);                                     \
> +             (var) = QTAILQ_NEXT((var), next))
>   
>   static inline QObject *qlist_entry_obj(const QListEntry *entry)
>   {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


