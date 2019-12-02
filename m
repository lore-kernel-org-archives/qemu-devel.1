Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0A9C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D85A20722
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRHizxlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D85A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iboeO-0005Cn-5t
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 11:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ibocH-00049c-EN
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ibocC-0004Qa-Gt
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:32:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ibocA-0004QD-8T
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575304317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1E5tXqfxzEKgiYWC+c5osp5dlCGXNERNdTJWSBpe6PI=;
 b=cRHizxlu50PiaNLBwdZSuggwX/gm2FotCxMr0VRWvf1JgeduLHMnhB9r5x2dxoON1P/BM0
 Az3sQInYoO1dY7nuasTKYcpIFwEL2uXQN7LKu+8vgGbKzRGpYqkrnf0jX8pOQtAxoSZod3
 gPVSxIqXuk8x9Jmy50yy3WXjIMaD5yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-tw1zrM31NumvNd_4OjsK1A-1; Mon, 02 Dec 2019 11:31:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18B05803B6E;
 Mon,  2 Dec 2019 16:31:53 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1B2819C7F;
 Mon,  2 Dec 2019 16:31:49 +0000 (UTC)
Date: Mon, 2 Dec 2019 17:31:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error
 handling bugs
Message-ID: <20191202173147.3085b1a6.cohuck@redhat.com>
In-Reply-To: <20191130194240.10517-18-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-18-armbru@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: tw1zrM31NumvNd_4OjsK1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 30 Nov 2019 20:42:36 +0100
Markus Armbruster <armbru@redhat.com> wrote:

I don't really want to restart the discussion :), but what about:

> cpu_model_from_info() is a helper for qmp_query_cpu_model_expansion(),
> qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().  It
> crashes when the visitor or the QOM setter fails, and its @errp
> argument is null. 

"It would crash when the visitor or the QOM setter fails if its @errp
argument were NULL." ?

(Hope I got my conditionals right...)

> Messed up in commit 137974cea3 's390x/cpumodel:

I agree that "Introduced" is a bit nicer than "Messed up".

> implement QMP interface "query-cpu-model-expansion"'.
> 
> Its three callers have the same bug.  Messed up in commit 4e82ef0502
> 's390x/cpumodel: implement QMP interface "query-cpu-model-comparison"'
> and commit f1a47d08ef 's390x/cpumodel: implement QMP interface
> "query-cpu-model-baseline"'.

If we agree, I can tweak the various commit messages for the s390x
patches and apply them.

> The bugs can't bite as no caller actually passes null.  Fix them
> anyway.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  target/s390x/cpu_models.c | 43 ++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 16 deletions(-)

David, I don't think you gave a R-b for that one yet?


