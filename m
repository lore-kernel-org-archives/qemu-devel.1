Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2806C4BA3A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B154C24670
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVpsVY6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B154C24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79Me-0000XS-UM
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j79LU-0007p9-3m
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j79LT-0003m8-5I
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:56:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46052
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j79LS-0003eB-Ve
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582772174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDEJX8xTxaywrovD65wL4zw5ZAs7g8bu7qTUdzY7Qv8=;
 b=hVpsVY6rVro6gyQr9FKKoxgK9xR+i8f1rF0j2jdUGvbcPyDWvpBUj5/xgdEKJHsGY2c0++
 Yl6D7NizNOtHQNoNwoLplFB4RpYVEokncrqYk6T390g2UrU9c6GHslnMKY6OYMW2oz3bk8
 uR3TSesPUvsjlPUlRINJH8kjpIDxUaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-6OnQJwOzO529AuSnw6In0g-1; Wed, 26 Feb 2020 21:56:12 -0500
X-MC-Unique: 6OnQJwOzO529AuSnw6In0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F1DD107ACC5;
 Thu, 27 Feb 2020 02:56:11 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17C2C1001DC0;
 Thu, 27 Feb 2020 02:56:05 +0000 (UTC)
Subject: Re: [PATCH 2/2] qtest: fix fuzzer-related 80-char limit violations
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200227024856.23777-1-alxndr@bu.edu>
 <20200227024856.23777-3-alxndr@bu.edu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f85f470e-c332-1739-c1cf-389991108f3d@redhat.com>
Date: Wed, 26 Feb 2020 20:56:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227024856.23777-3-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Bandan Das <bsd@redhat.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 8:48 PM, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>   qtest.c                     | 3 ++-
>   tests/qtest/fuzz/qos_fuzz.c | 5 ++++-
>   2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qtest.c b/qtest.c
> index 1af4e1b08d..5672b75c35 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -794,7 +794,8 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
>       }
>   }
>   
> -void qtest_server_set_send_handler(void (*send)(void*, const char*), void *opaque)
> +void qtest_server_set_send_handler(void (*send)(void*, const char*),
> +                                   void *opaque)
>   {
>       qtest_server_send = send;
>       qtest_server_send_opaque = opaque;
> diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
> index bbb17470ff..1a99277d60 100644
> --- a/tests/qtest/fuzz/qos_fuzz.c
> +++ b/tests/qtest/fuzz/qos_fuzz.c
> @@ -120,7 +120,10 @@ static void walk_path(QOSGraphNode *orig_path, int len)
>       QOSGraphNode *path;
>       QOSGraphEdge *edge;
>   
> -    /* etype set to QEDGE_CONSUMED_BY so that machine can add to the command line */
> +    /*
> +     * etype set to QEDGE_CONSUMED_BY so that machine can add to the command
> +     * line
> +     */
>       QOSEdgeType etype = QEDGE_CONSUMED_BY;
>   
>       /* twice QOS_PATH_MAX_ELEMENT_SIZE since each edge can have its arg */
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


