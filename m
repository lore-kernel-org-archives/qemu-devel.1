Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DE9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC5720657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NioiI9oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC5720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamxC-0002uH-Q0
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 17:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jamw7-0002PZ-Du
 for qemu-devel@nongnu.org; Mon, 18 May 2020 17:04:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26515
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jamvy-0000wJ-Iw
 for qemu-devel@nongnu.org; Mon, 18 May 2020 17:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589835863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pw3snzyj9L7WiQMOf+g2kEsGJzWA4XnFWN4NO6/YfDM=;
 b=NioiI9oHibjWUPAsGRSEo6B8793Mo+sbTr1j2F384SsLKuUUxvwA++wTFj8JF8ReLcJ7hX
 Lo8fEqp1Yd0p8L4G2/9VleDs0rHoLrY+du6NJl45BSaI3d2X3cJOPoFRiSvRS/t1wwlr+A
 8Np9yfzJNjHxfSrhP7y8VZcOW9ty0D0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-0ai88izJNEy8E4S-E1i-IQ-1; Mon, 18 May 2020 17:04:21 -0400
X-MC-Unique: 0ai88izJNEy8E4S-E1i-IQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E80C1800D42
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 21:04:20 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D93C6EA19;
 Mon, 18 May 2020 21:04:20 +0000 (UTC)
Subject: Re: [PATCH not-for-merge 2/5] qom: Make "info qom-tree" show children
 sorted
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200518051945.8621-1-armbru@redhat.com>
 <20200518051945.8621-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c6eae4be-7d00-bc47-f5a0-4a5977136ac0@redhat.com>
Date: Mon, 18 May 2020 16:04:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518051945.8621-3-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 12:19 AM, Markus Armbruster wrote:
> "info qom-tree" prints children in unstable order.  This is a pain
> when diffing output for different versions to find change.  Print it
> sorted.

Yes, this does seem reasonable to include even without the rest of the 
series.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qom/qom-hmp-cmds.c | 40 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index 4a61ee1b8c..cf0af8f6b5 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -78,6 +78,35 @@ static int print_qom_composition_child(Object *obj, void *opaque)
>       return 0;
>   }
>   
> +static int qom_composition_compare(const void *a, const void *b, void *ignore)
> +{
> +    Object *obja = (void *)a, *objb = (void *)b;

Casting away const...

> +    const char *namea, *nameb;
> +
> +    if (obja == object_get_root()) {
> +        namea = g_strdup("");
> +    } else {
> +        namea = object_get_canonical_path_component(obja);

...should we instead improve object_get_canonical_path_component to work 
with 'const Object *'?

> +    }
> +
> +    if (objb == object_get_root()) {
> +        nameb = g_strdup("");
> +    } else {
> +        nameb = object_get_canonical_path_component(objb);
> +    }
> +
> +
> +    return strcmp(namea, nameb);

Why the two blank lines?  This leaks namea and/or nameb if either object 
is the object root.  Should you instead use g_strcmp0 here, with namea/b 
set to NULL instead of g_strdup("") above?


> @@ -105,7 +134,16 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
>       monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
>                      object_get_typename(obj));
>       g_free(name);
> -    object_child_foreach(obj, print_qom_composition_child, &s);
> +
> +    GQueue children;
> +    Object *child;

Mid-function declarations - I assume you'd clean this up if we want this 
for real?

> +    g_queue_init(&children);
> +    object_child_foreach(obj, insert_qom_composition_child, &children);
> +    while ((child = g_queue_pop_head(&children))) {
> +        print_qom_composition(mon, child, indent + 2);
> +    }
> +    (void)s;
> +    (void)print_qom_composition_child;

Also, this looks like leftover debugger aids?

>   }
>   
>   void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


