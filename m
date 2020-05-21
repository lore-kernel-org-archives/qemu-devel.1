Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C6EC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A2E207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPwsCHE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A2E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbj65-000703-Nk
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 07:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbj4g-0005D6-JJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:09:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40826
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbj4e-0002pJ-6o
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590059354;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lcjfLoydq1WZekwXJXBnrERkRk2lMK9aA2Do2Aa9BtA=;
 b=SPwsCHE1E1rflfQvTQIoiYhyjIWS0yf1Fel2PV7UIK+syrcCOBGiRfbV/HC2MdSJNUtEMK
 5v1eO9vqJYw39Kguyigd0uM0LZtRxcDF8ORXGvCDRAFj87WBhx34yI5zEubLKSsmHP8GNP
 /IWak0sRmo70pLvrj4+/dOR/ZUUHPag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-8K9sWhLTNXWc9V-yFOnEXQ-1; Thu, 21 May 2020 07:09:11 -0400
X-MC-Unique: 8K9sWhLTNXWc9V-yFOnEXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B7A718A0724;
 Thu, 21 May 2020 11:09:10 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CD8A6EA43;
 Thu, 21 May 2020 11:09:08 +0000 (UTC)
Date: Thu, 21 May 2020 12:09:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Subject: Re: [PATCH v3 1/3] crypto/secret: move main logic from 'secret' to
 'secret_common'.
Message-ID: <20200521110905.GE2211791@redhat.com>
References: <20200518202804.3761-1-alex-krasikov@yandex-team.ru>
 <20200518202804.3761-2-alex-krasikov@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200518202804.3761-2-alex-krasikov@yandex-team.ru>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 11:28:02PM +0300, Alexey Krasikov wrote:
> Create base class 'common secret'. Move common data and logic from
> 'secret' to 'common_secret' class. This allowed adding abstraction layer
> for easier adding new 'secret' objects in future.
> Convert 'secret' class to child from basic 'secret_common' with 'data'
> and 'file' properties.
> 
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> ---
>  crypto/Makefile.objs           |   1 +
>  crypto/secret.c                | 351 +---------------------------
>  crypto/secret_common.c         | 407 +++++++++++++++++++++++++++++++++
>  include/crypto/secret.h        |  20 +-
>  include/crypto/secret_common.h |  68 ++++++
>  5 files changed, 486 insertions(+), 361 deletions(-)
>  create mode 100644 crypto/secret_common.c
>  create mode 100644 include/crypto/secret_common.h
> 
> diff --git a/crypto/secret_common.c b/crypto/secret_common.c
> new file mode 100644
> index 0000000000..4ef15b98a2
> --- /dev/null
> +++ b/crypto/secret_common.c

> +static void qcrypto_secret_decrypt(QCryptoSecretCommon  *secret,
> +                                   const uint8_t        *input,
> +                                   size_t               inputlen,
> +                                   uint8_t              **output,
> +                                   size_t               *outputlen,
> +                                   Error                **errp)

This has reformatted the original code to vertically line up parameter
names. This is not something we do, so please remove all this extra
whitespace alignment. The is present in other funtions and patches
too, all of which need fixes.


> +static void
> +qcrypto_secret_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_bool(oc, "loaded",
> +                                   qcrypto_secret_prop_get_loaded,
> +                                   qcrypto_secret_prop_set_loaded,
> +                                   NULL);
> +    object_class_property_add_enum(oc, "format",
> +                                   "QCryptoSecretFormat",
> +                                   &QCryptoSecretFormat_lookup,
> +                                   qcrypto_secret_prop_get_format,
> +                                   qcrypto_secret_prop_set_format,
> +                                   NULL);
> +    object_class_property_add_str(oc, "keyid",
> +                                  qcrypto_secret_prop_get_keyid,
> +                                  qcrypto_secret_prop_set_keyid,
> +                                  NULL);
> +    object_class_property_add_str(oc, "iv",
> +                                  qcrypto_secret_prop_get_iv,
> +                                  qcrypto_secret_prop_set_iv,
> +                                  NULL);

A patch recently merged which removed the "ERror **errp" parameter
which causes merge conflicts on this patch. You'll just need to
drop the last "NULL" to fix it.


> diff --git a/include/crypto/secret_common.h b/include/crypto/secret_common.h
> new file mode 100644
> index 0000000000..41c06b5391
> --- /dev/null
> +++ b/include/crypto/secret_common.h
> @@ -0,0 +1,68 @@
> +/*
> + * QEMU crypto secret support
> + *
> + * Copyright (c) 2015 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#ifndef QCRYPTO_SECRET_COMMON_H
> +#define QCRYPTO_SECRET_COMMON_H
> +
> +#include "qapi/qapi-types-crypto.h"
> +#include "qom/object.h"
> +
> +#define TYPE_QCRYPTO_SECRET_COMMON "secret_common"
> +#define QCRYPTO_SECRET_COMMON(obj) \
> +    OBJECT_CHECK(QCryptoSecretCommon, (obj), TYPE_QCRYPTO_SECRET_COMMON)
> +#define QCRYPTO_SECRET_COMMON_CLASS(class) \
> +    OBJECT_CLASS_CHECK(QCryptoSecretCommonClass, \
> +                       (class), TYPE_QCRYPTO_SECRET_COMMON)
> +#define QCRYPTO_SECRET_COMMON_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(QCryptoSecretCommonClass, \
> +                     (obj), TYPE_QCRYPTO_SECRET_COMMON)
> +
> +typedef struct QCryptoSecretCommon QCryptoSecretCommon;
> +typedef struct QCryptoSecretCommonClass QCryptoSecretCommonClass;
> +
> +struct QCryptoSecretCommon {
> +    Object               parent_obj;
> +    uint8_t              *rawdata;
> +    size_t               rawlen;
> +    QCryptoSecretFormat  format;
> +    char                 *keyid;
> +    char                 *iv;
> +};

Don't vertically align struct fields either.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


