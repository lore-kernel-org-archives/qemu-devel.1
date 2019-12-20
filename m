Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB9C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 07:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820BC227BF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 07:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeYooOg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820BC227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiCru-0004Pq-Mn
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 02:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iiCrH-0003Yd-IE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iiCrF-0004WM-Hi
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:37:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iiCrE-0004Q7-RB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576827475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcNVgaPwCzw8as2vTfCN4tBE96cNvG24nxq9b1jQE4s=;
 b=YeYooOg5kOuoBD3Yz/MN56FELWUN5dZmMQtE30nDPVTeCn1JJeSNqANYXqX3FEeFZkRES9
 SNLM6QN29FdQHxQSMIPMjt+IXidmPb/XgCDYfBC7Iz3+5UMNDNpQ2IuzIsbhQxhVAXK77G
 nVtAyvb/SHm1yKSvrHglOlIbs3fYE40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-eLO_LQViOyOxg2z3AWPWQg-1; Fri, 20 Dec 2019 02:37:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00792107ACC5;
 Fri, 20 Dec 2019 07:37:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FDFC5C1B0;
 Fri, 20 Dec 2019 07:37:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AA6C211386A7; Fri, 20 Dec 2019 08:37:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: <pannengyuan@huawei.com>
Subject: Re: [PATCH] util/module: fix a memory leak
References: <1576805650-16380-1-git-send-email-pannengyuan@huawei.com>
Date: Fri, 20 Dec 2019 08:37:46 +0100
In-Reply-To: <1576805650-16380-1-git-send-email-pannengyuan@huawei.com>
 (pannengyuan@huawei.com's message of "Fri, 20 Dec 2019 09:34:10
 +0800")
Message-ID: <87lfr7jvlh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: eLO_LQViOyOxg2z3AWPWQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-trivial@nongnu.org,
 zhang.zhanghailiang@huawei.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: qemu-trivial

<pannengyuan@huawei.com> writes:

> From: Pan Nengyuan <pannengyuan@huawei.com>
>
> spotted by ASAN
>
> Fixes: 81d8ccb1bea4fb9eaaf4c8e30bd4021180a9a39f
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  util/module.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/module.c b/util/module.c
> index e9fe3e5..8c5315a 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -214,6 +214,7 @@ bool module_load_one(const char *prefix, const char *=
lib_name)
> =20
>      if (!success) {
>          g_hash_table_remove(loaded_modules, module_name);
> +        g_free(module_name);
>      }
> =20
>      for (i =3D 0; i < n_dirs; i++) {

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewing this made me wonder: @loaded_modules is global state, but
there appears to be no synchronization.  What's the safety argument?


