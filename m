Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E408C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4990E20702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eM48wzl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4990E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1cp-0002qh-D2
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iv1cB-0002Ff-At
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iv1c9-0002I4-Op
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:15:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50519
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iv1c9-0002Gj-3S
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579882519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3MtR/81t0xiwo1PwJLHOKouCO2rLV0l/xlXQjcP2szU=;
 b=eM48wzl3sKhHslZjvu8aKBu+9iqenO/Tz+w+fqegAY7s2XqsplGWIGrKg4xKMwh/fmtVxq
 5T4iTB+3Qds9kFDOESr4U1Ny9nRmSscFhvlkzh3umSMscnPyeWNPJ3RBurxh55T0HK7c/E
 ov/hGpSXYun+5mkWO7DSNfvpv5HQTwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-26YmTvJpONGCW53yl-QsjA-1; Fri, 24 Jan 2020 11:15:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E33EB109F65B
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 16:15:15 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 066935DA75;
 Fri, 24 Jan 2020 16:15:14 +0000 (UTC)
Subject: Re: [PATCH v3 09/21] migration: Add multifd-compress parameter
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-10-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c7c0c5bc-6eb4-1ca0-f7d7-5d2b573a3335@redhat.com>
Date: Fri, 24 Jan 2020 10:15:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-10-quintela@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 26YmTvJpONGCW53yl-QsjA-1
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
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> ---
> Rename it to NONE
> Fix typos (dave)
> We don't need to chek values returned by visit_type_MultifdCompress (markus)
> Fix yet more typos (wei)
> ---
>   hw/core/qdev-properties.c    | 13 +++++++++++++

> +++ b/qapi/migration.json
> @@ -488,6 +488,19 @@
>   ##
>   { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
>   
> +##
> +# @MultifdCompress:
> +#
> +# An enumeration of multifd compression.
> +#
> +# @none: no compression.
> +#
> +# Since: 4.1

5.0, now

> +#
> +##
> +{ 'enum': 'MultifdCompress',
> +  'data': [ 'none' ] }
> +
>   ##
>   # @MigrationParameter:
>   #
> @@ -586,6 +599,9 @@
>   # @max-cpu-throttle: maximum cpu throttle percentage.
>   #                    Defaults to 99. (Since 3.1)
>   #
> +# @multifd-compress: Which compression method to use.
> +#                    Defaults to none. (Since 5.0)
> +#
>   # Since: 2.4
>   ##
>   { 'enum': 'MigrationParameter',
> @@ -598,7 +614,7 @@
>              'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>              'multifd-channels',
>              'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle' ] }
> +           'max-cpu-throttle', 'multifd-compress' ] }
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


