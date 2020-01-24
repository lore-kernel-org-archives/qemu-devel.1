Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C85C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621112075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlkgcX0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621112075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1hk-0000GM-GB
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iv1f8-00060l-TE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iv1f7-0004KN-ED
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:18:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60434
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iv1f7-0004Iy-A6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579882704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRBg3phZUNLcD0ACBizrQi3ockNBocm2PKRAp6HF0Vg=;
 b=XlkgcX0ABpwUvgjEoC0hwsVqNTnPQuxgIoknthU2CacFCSY29a2Mu46N9YvtLpa4WcwPMX
 xslO5xm/xA79ithsmXf7dplpu4ZdP9eTNZDfT724Riushs0oP86v3745KpOLtChFohsEUj
 ZL2uVy6NP3IZxu+4A9S6x98Rhy9die0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-KbmzH9pGMTm1iuB3nkvqLw-1; Fri, 24 Jan 2020 11:18:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B47919251A1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 16:18:20 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5333928DD8;
 Fri, 24 Jan 2020 16:18:11 +0000 (UTC)
Subject: Re: [PATCH v3 21/21] migration: Add zstd compression multifd support
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-22-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ac07802b-9e4c-d993-3fc9-a7d2951bce1f@redhat.com>
Date: Fri, 24 Jan 2020 10:18:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-22-quintela@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: KbmzH9pGMTm1iuB3nkvqLw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 5:58 AM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   hw/core/qdev-properties.c    |   2 +-
>   migration/Makefile.objs      |   1 +
>   migration/migration.c        |   6 +
>   migration/multifd-zstd.c     | 304 +++++++++++++++++++++++++++++++++++
>   migration/multifd.h          |  20 +++
>   migration/ram.c              |   1 -
>   qapi/migration.json          |   2 +-
>   tests/qtest/migration-test.c |  10 ++
>   8 files changed, 343 insertions(+), 3 deletions(-)
>   create mode 100644 migration/multifd-zstd.c
> 

> +++ b/migration/Makefile.objs
> @@ -9,6 +9,7 @@ common-obj-y += qjson.o
>   common-obj-y += block-dirty-bitmap.o
>   common-obj-y += multifd.o
>   common-obj-y += multifd-zlib.o
> +common-obj-$(CONFIG_ZSTD) += multifd-zstd.o

zstd support is conditional...


> +++ b/qapi/migration.json
> @@ -499,7 +499,7 @@
>   #
>   ##
>   { 'enum': 'MultifdCompress',
> -  'data': [ 'none', 'zlib' ] }
> +  'data': [ 'none', 'zlib', 'zstd' ] }

...so I would expect an 'if' conditional here when declaring the enum. 
It also needs documentation.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


