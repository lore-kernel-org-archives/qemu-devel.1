Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D8AC43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 16:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35FB24670
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 16:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flOzRSkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35FB24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iddEN-0005Bc-U2
	for qemu-devel@archiver.kernel.org; Sat, 07 Dec 2019 11:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1iddCt-0004Ly-Ea
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 11:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1iddCq-0004Qj-Jt
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 11:45:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1iddCq-0004QE-Gd
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 11:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575737118;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+/Hsjkg3YFscfPsjwHjFA7OuH9WQFbdH31aq2VP904=;
 b=flOzRSkvNrC6dxroaial0TQTIfqMoTBVmg6fzoRFoow45CjjukBuWr1iivc5O+bwPIKaiC
 i5WVOdG2bwCmMnECl3nPHI61fmjfbJ7wMtCDlxP5xPjxJeTemLtLlebr8HSPgomDkmhY33
 Fhfd1BktBx7reShTVxp3JjIAto9Y2Q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-PmZSQ8j4N1mfhxFHMO-lfg-1; Sat, 07 Dec 2019 08:44:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C83DB1856A62;
 Sat,  7 Dec 2019 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-34.bne.redhat.com [10.64.54.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF381001B11;
 Sat,  7 Dec 2019 13:44:18 +0000 (UTC)
Subject: Re: [PATCH] hw/nmi: Fix the NMI() macro, based on INTERFACE_CHECK()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20191207094823.20707-1-philmd@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <7c698f75-5be4-de98-2e8a-c271ae4c28d8@redhat.com>
Date: Sun, 8 Dec 2019 00:44:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191207094823.20707-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: PmZSQ8j4N1mfhxFHMO-lfg-1
X-Mimecast-Spam-Score: 0
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/7/19 8:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> There is no declaration of the 'NMI' type. INTERFACE_CHECK()
> returns an abstract type (see commit aa1b35b975d8). The abstract
> type corresponding to the TYPE_NMI interface is 'NMIState'.
>=20
> Fixes: 9cb805fd267
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Gavin Shan <gshan@redhat.com>

>   include/hw/nmi.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
> index a1e128724e..fe37ce3ad8 100644
> --- a/include/hw/nmi.h
> +++ b/include/hw/nmi.h
> @@ -31,7 +31,7 @@
>   #define NMI_GET_CLASS(obj) \
>       OBJECT_GET_CLASS(NMIClass, (obj), TYPE_NMI)
>   #define NMI(obj) \
> -     INTERFACE_CHECK(NMI, (obj), TYPE_NMI)
> +     INTERFACE_CHECK(NMIState, (obj), TYPE_NMI)
>  =20
>   typedef struct NMIState NMIState;
>  =20
>=20


