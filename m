Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DC5C55191
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162292087E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y83x72Fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162292087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRyr2-0006gJ-7v
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRyq7-0005Vg-HT
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRyq6-0001xq-FB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:57:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53043
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRyq6-0001u1-0S
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587736677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9uVOKvA3gfTGNkIVzmE5vuWd8SeRGkOj+xWtl699Dg=;
 b=Y83x72FhyYD5gLRhExCw7Sm29kO1EObWC2jZo6qYr460nMMrgqk+K4WsjEM9vDqrwDZwbq
 /cTft6iW+J93Kx1muGL4QbOBm0LzZ0RNYLuo8K0s1FjsahCwBm8hdgtZqjmiQY3iIMSMjw
 EUZbNDdOzVqoERIuuWV3Vzr4mKfRxms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-tcQB9BKOPXCvlYYk3W5SOA-1; Fri, 24 Apr 2020 09:57:55 -0400
X-MC-Unique: tcQB9BKOPXCvlYYk3W5SOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CABE80B722;
 Fri, 24 Apr 2020 13:57:54 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F38160F8A;
 Fri, 24 Apr 2020 13:57:53 +0000 (UTC)
Subject: Re: [PATCH v2 10/15] qapi: Clean up visitor's recovery from input
 with invalid type
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200424084338.26803-1-armbru@redhat.com>
 <20200424084338.26803-11-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8cea2f3d-9f3e-85b0-3d07-59ad45a90682@redhat.com>
Date: Fri, 24 Apr 2020 08:57:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424084338.26803-11-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 3:43 AM, Markus Armbruster wrote:
> An alternate type's visit_type_FOO() fails when it runs into an
> invalid ->type.  If it's an input visit, we then need to free the the
> object we got from visit_start_alternate().  We do that with
> qapi_free_FOO(), which uses the dealloc visitor.
> 
> Trouble is that object is in a bad state: its ->type is invalid.  So
> the dealloc visitor will run into the same error again, and the error
> recovery skips deallocating the alternate's (invalid) alternative.
> Works, because qapi_free_FOO() ignores the error.
> 
> Avoid it instead: free the messed up object with by g_free().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/visit.py | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index e3467b770b..678109dfb5 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -234,6 +234,9 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
>       default:
>           error_setg(&err, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
>                      "%(name)s");
> +        /* Avoid passing invalid *obj to qapi_free_%(c_name)s() */
> +        g_free(*obj);
> +        *obj = NULL;

Yep, fixes the problem I spotted in v1, and much easier to review with 
the reduced scope of change.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


