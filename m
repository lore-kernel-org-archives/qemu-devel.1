Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CE7C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B579020757
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+SDyg6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B579020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTURG-0002bV-Kw
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUOc-0007PW-ME
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUOb-0004D6-SA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:51:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35967
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTUOb-00044a-9t
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588096308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4YYFpl18eA7DXtCHnnh6w71Pb35ii+/lhjdYb0w3Ltc=;
 b=T+SDyg6aQ6LPFzZoSWrSDcqSOBw2UQHS0SwXd9eL4usViM4JNrgLDLCZqdv4M/t7T0qIZV
 AxkNms3+M3+h4OKmSK5J/uL/HynhUouhTsHlu7YpZ5J+27SXg7aeRA8SeuHveIyRQyR5sU
 tfmsnYoI1rUY8BnyKlmLL3fIqbdw0iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-UaoLaVCYPIeTfoqW3ByXeA-1; Tue, 28 Apr 2020 13:51:43 -0400
X-MC-Unique: UaoLaVCYPIeTfoqW3ByXeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96753468
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 17:51:42 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCBA15D9E5;
 Tue, 28 Apr 2020 17:51:41 +0000 (UTC)
Subject: Re: [PATCH 05/17] qom: Make all the object_property_add_FOO() return
 the property
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7b47868e-f8ed-9dc9-8590-28bdfa9ed893@redhat.com>
Date: Tue, 28 Apr 2020 12:51:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-6-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 11:34 AM, Markus Armbruster wrote:
> Some object_property_add_FOO() return the newly added property, some
> don't.  Clean that up.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qom/object.h |  50 ++++++---
>   qom/object.c         | 250 ++++++++++++++++++++++---------------------
>   2 files changed, 164 insertions(+), 136 deletions(-)
> 

> +++ b/qom/object.c
> @@ -1679,33 +1679,30 @@ static void object_finalize_child_property(Object *obj, const char *name,
>       object_unref(child);
>   }
>   
> -void object_property_add_child(Object *obj, const char *name,
> -                               Object *child, Error **errp)
> +ObjectProperty *
> +object_property_add_child(Object *obj, const char *name,
> +                          Object *child, Error **errp)
>   {
> -    Error *local_err = NULL;
> -    char *type;
> +    g_autofree char *type = NULL;

I love how g_autofree simplifies things.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


