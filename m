Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD76C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0AC720737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsVKA3+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AC720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhHI-0000W0-64
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jOhFJ-0006QU-QK
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jOhFI-0008Tb-Nb
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:34:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jOhFI-0008TN-JL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586954064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAzfBe7B8SYsadCBXOKkS1W6Mf7HsAIVoxfhVf54LXY=;
 b=PsVKA3+jnSHrU8q6aA1uXQjxE0QdjfKC9P1A0QBf+9n2ZfxE99UtTaxcfxmwMExXdQkQ7W
 dVTIbOO5VFOI3KIJAAQrkJMVhMbgaBZRJe2ZggurTZSnU6+hZb0b5Jb8VzTlYRAoBK+7w+
 oJktQvka79/02Vgi3JL5KtxcdAx9QTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-b7-XTsslP4uTDv5454yZMg-1; Wed, 15 Apr 2020 08:34:22 -0400
X-MC-Unique: b7-XTsslP4uTDv5454yZMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 493C1800D5C;
 Wed, 15 Apr 2020 12:34:21 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 024455D9E2;
 Wed, 15 Apr 2020 12:34:20 +0000 (UTC)
Subject: Re: [PATCH for-5.1 4/5] qobject: Eliminate qdict_iter(), use
 qdict_first(), qdict_next()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200415083048.14339-1-armbru@redhat.com>
 <20200415083048.14339-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4574d8dc-0892-ff10-1823-697bff10f0b0@redhat.com>
Date: Wed, 15 Apr 2020 07:34:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415083048.14339-5-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 3:30 AM, Markus Armbruster wrote:
> qdict_iter() has just three uses and no test coverage.  Replace by
> qdict_first(), qdict_next() for more concise code and less type
> punning.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/qdict.h     |  3 --
>   qapi/qobject-input-visitor.c | 21 +++++++-------
>   qobject/qdict.c              | 19 -------------
>   qobject/qjson.c              | 54 +++++++++++++-----------------------
>   util/qemu-option.c           | 10 ++++++-
>   5 files changed, 40 insertions(+), 67 deletions(-)
> 

>   static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,
>                                               const char *name,
>                                               QObject *obj, void *qapi)
>   {
>       GHashTable *h;
>       StackObject *tos = g_new0(StackObject, 1);
> +    QDict *qdict = qobject_to(QDict, obj);
> +    QList *qlist = qobject_to(QList, obj);
> +    const QDictEntry *entry;
>   
>       assert(obj);
>       tos->name = name;
>       tos->obj = obj;
>       tos->qapi = qapi;
>   
> -    if (qobject_type(obj) == QTYPE_QDICT) {
> +    if (qdict) {
>           h = g_hash_table_new(g_str_hash, g_str_equal);
> -        qdict_iter(qobject_to(QDict, obj), qdict_add_key, h);
> +        for (entry = qdict_first(qdict);
> +             entry;
> +             entry = qdict_next(qdict, entry)) {
> +            g_hash_table_insert(h, (void *)qdict_entry_key(entry), NULL);

Is the cast to void* necessary?

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


