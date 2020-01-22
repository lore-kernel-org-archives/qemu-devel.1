Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6ABC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B17217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeoLgGfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B17217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuFJo-0008Of-EK
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 07:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuFIz-0007u0-2m
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuFIw-0001L9-Qp
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:40:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuFIw-0001Kx-Ma
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579696818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Whw7rjhjy+0lSf+YoBW12+8Tiqr0BTgDhE+lqUIhxDI=;
 b=KeoLgGfwazeNLU4GKZXmDAvbnhjcsjGG1azOByuE0CgcenRftFDXlYb957QGiz2o6/YeUz
 b3Mb8d2mUdG7Fa16LgR/nmBM0/ofxpiuSoti2ILaYPEFT/eK4jTMuWDzj+FAmhvJn/X/5L
 2xZ+xFnLmNPE20bbq2Oadll6xtYk3OY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-Z1TnSOLMMHq0YOU2XUEhnQ-1; Wed, 22 Jan 2020 07:40:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47B15477
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 12:40:13 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E51C9811FF;
 Wed, 22 Jan 2020 12:40:11 +0000 (UTC)
Subject: Re: [PATCH v4 1/6] migration-test: Use g_free() instead of free()
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20200122111517.33223-1-quintela@redhat.com>
 <20200122111517.33223-2-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8279b0b6-1d25-76fe-f32e-d8fdf9c5401d@redhat.com>
Date: Wed, 22 Jan 2020 13:40:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122111517.33223-2-quintela@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Z1TnSOLMMHq0YOU2XUEhnQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/01/2020 12.15, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 26e2e77289..b6a74a05ce 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1291,7 +1291,7 @@ static void test_multifd_tcp(void)
>      wait_for_serial("dest_serial");
>      wait_for_migration_complete(from);
>      test_migrate_end(from, to, true);
> -    free(uri);
> +    g_free(uri);
>  }
>  
>  int main(int argc, char **argv)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


