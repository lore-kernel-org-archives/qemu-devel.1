Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD76C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7942082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym0jkGL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7942082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isO2f-0005sd-KD
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 04:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1isO20-0005NM-Js
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1isO1w-0003ff-Pf
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:35:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42174
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1isO1w-0003e9-LP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579253703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Ndr7yv85xj2W872q9Z9OUXqWeO0aT6FTorwFLx5O3k4=;
 b=Ym0jkGL/5ZNbVO2nva+Q5enXL9COcTlWmnh3iw5v+HFupGEZwTuOXtUORx+c5FkmDtFtiC
 NOC6UmNVA2Wb0+41N0ZC/ZT3QiU8DDEaDVOtwB5pdzU48Lk81XNWhYwnF6VqZ9LaHTftSX
 6/tJUbEa6UtSliP7OijwdQIrkxL65xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-6TP_e7nvO-WtKhftkAPVzA-1; Fri, 17 Jan 2020 04:34:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96FD2107ACC7;
 Fri, 17 Jan 2020 09:34:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-212.ams2.redhat.com [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 714ED61069;
 Fri, 17 Jan 2020 09:34:57 +0000 (UTC)
Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200116202558.31473-1-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <163735a5-b8d0-e657-86b2-a3921d754381@redhat.com>
Date: Fri, 17 Jan 2020 10:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116202558.31473-1-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 6TP_e7nvO-WtKhftkAPVzA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/01/2020 21.25, Markus Armbruster wrote:
> Recent commit 3e7fb5811b "qapi: Fix code generation for empty modules"
> modules" switched QAPISchema.visit() from
> 
>     for entity in self._entity_list:
> 
> effectively to
> 
>     for mod in self._module_dict.values():
>         for entity in mod._entity_list:
> 
> Visits in the same order as long as .values() is in insertion order.
> That's the case only for Python 3.6 and later.  Before, it's in some
> arbitrary order, which results in broken generated code.
> 
> Fix by making self._module_dict an OrderedDict rather than a dict.
> 
> Fixes: 3e7fb5811baab213dcc7149c3aa69442d683c26c
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/schema.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 0bfc5256fb..5100110fa2 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -795,7 +795,7 @@ class QAPISchema(object):
>          self.docs = parser.docs
>          self._entity_list = []
>          self._entity_dict = {}
> -        self._module_dict = {}
> +        self._module_dict = OrderedDict()
>          self._schema_dir = os.path.dirname(fname)
>          self._make_module(None) # built-ins
>          self._make_module(fname)
> 

Thanks, this fixes the problems on Travis for me!

Tested-by: Thomas Huth <thuth@redhat.com>

Peter, could you maybe apply this directly to the master branch as a
build fix?


