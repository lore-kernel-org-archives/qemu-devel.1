Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D90C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F9820702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InSHptbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F9820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwtuX-0005u4-Jt
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 15:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwttR-0004zt-0A
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwttO-0000LS-Sy
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:24:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwttN-0000GI-EQ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580329491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=msn+4JuMETfwAU/0a7q3M3ZdaHSQK44bFRghDrNmLL4=;
 b=InSHptbe9j485O9d8G+HNHsEv9zKIunEtNMtF0vVAtPEFI3pQ8rJ9z9GgbpArwWActYqv/
 EWjcTit43RW6Ss+TapVyM7RG1aGui3292zK/vjoOFYIu4ByTrBFL1uBz2MUqtRh2fws4+Y
 qPNdZS5qI+Zmgj+KJBgokHZ2mKBySV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-j_QhJbJ0OZC9B-d_5j0xjg-1; Wed, 29 Jan 2020 15:24:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0349318C35A3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 20:24:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-51.gru2.redhat.com
 [10.97.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DB69100194E;
 Wed, 29 Jan 2020 20:24:44 +0000 (UTC)
Subject: Re: [PATCH] python: Treat None-return of greeting cmd
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 qemu-devel@nongnu.org
References: <20200120071202.30646-1-ldoktor@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <ba9c2d1b-d4d9-340c-0e6a-66afa4765d76@redhat.com>
Date: Wed, 29 Jan 2020 18:24:42 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200120071202.30646-1-ldoktor@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: j_QhJbJ0OZC9B-d_5j0xjg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/20/20 5:12 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> In case qemu process dies the "monitor.cmd" returns None which gets
> passed to the "__negotiate_capabilities" and leads to unhandled
> exception. Let's only check the resp in case it has a value.
>
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
>   python/qemu/qmp.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> index 5c8cf6a056..a3e5de718a 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp.py
> @@ -73,7 +73,7 @@ class QEMUMonitorProtocol(object):
>               raise QMPConnectError
>           # Greeting seems ok, negotiate capabilities
>           resp =3D self.cmd('qmp_capabilities')
> -        if "return" in resp:
> +        if resp and "return" in resp:
>               return greeting
>           raise QMPCapabilitiesError
>  =20


