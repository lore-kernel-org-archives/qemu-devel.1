Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53DEC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64BD207DD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOtiXkJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64BD207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icS8k-0001rd-SL
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 05:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1icREF-0002EC-Vs
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1icRDd-0001mu-46
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:45:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20986
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1icRDc-0001VL-Uw
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575452709;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xvFIOvnmGxTLFUyvRDcNVgs31xpLv7WDD+97p35wE78=;
 b=GOtiXkJ+OYRGRycBQIixrdFHayOix7KCkKmLsUOyFQ75jeIPCSoBKcdcjQFKB6JMStdKTM
 u6l5B+0CAueE3pbnSUoj4ypJddZSqyqfMG5JgCkQKNBtV8rOjuZVlcjYjxZb8RjgWSqokF
 Cbl+dIqAC4kFnhTa5U0OhjqpUHlo7W0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-d4hWxITTO_WWLlK4brTP3Q-1; Wed, 04 Dec 2019 04:45:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62B4E8024CA
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 09:45:06 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B79A60FC1;
 Wed,  4 Dec 2019 09:45:05 +0000 (UTC)
Date: Wed, 4 Dec 2019 09:45:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 01/18] crypto: Fix certificate file error handling
 crash bug
Message-ID: <20191204094502.GA785462@redhat.com>
References: <20191204093625.14836-1-armbru@redhat.com>
 <20191204093625.14836-2-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191204093625.14836-2-armbru@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: d4hWxITTO_WWLlK4brTP3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 04, 2019 at 10:36:08AM +0100, Markus Armbruster wrote:
> qcrypto_tls_creds_load_cert() passes uninitialized GError *gerr by
> reference to g_file_get_contents().  When g_file_get_contents() fails,
> it'll try to set a GError.  Unless @gerr is null by dumb luck, this
> logs a ERROR_OVERWRITTEN_WARNING warning message and leaves @gerr
> unchanged.  qcrypto_tls_creds_load_cert() then dereferences the
> uninitialized @gerr.
>=20
> Fix by initializing @gerr properly.
>=20
> Fixes: 9a2fd4347c40321f5cbb4ab4220e759fcbf87d03
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  crypto/tlscredsx509.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


