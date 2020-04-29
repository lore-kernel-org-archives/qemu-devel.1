Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B4EC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B26320775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbS0IlNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B26320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTiXz-0004xu-Mt
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jTiVX-0000q6-LU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jTiUr-0008KI-Al
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:55:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20792
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jTiUq-0008Eu-Tc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588150511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e57l5YTKI4bFng9/Rv8zdl9Fcv+tUeFGml+k3HGJWHw=;
 b=VbS0IlNMlqkSBqb1C2uTi6L3Eg+nwCVq5EBT9c64RQaBtHg51wjUt3ptkj2RRfKwFxysCB
 iZyUzRFOb6NlK7xbPiOQsUZtStFJjGPMd1PdaA7VDXFI2fTHQyEL1QGcktvlqp03N1nDdg
 O6r2fVghI3QDAyb5Q3Py0It8fTTjSOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-HJi82mMdMEKgSlHHOp0lMg-1; Wed, 29 Apr 2020 04:55:09 -0400
X-MC-Unique: HJi82mMdMEKgSlHHOp0lMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BE16100CC84
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 08:55:08 +0000 (UTC)
Received: from [10.72.13.2] (ovpn-13-2.pek2.redhat.com [10.72.13.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDFC3605CB;
 Wed, 29 Apr 2020 08:55:06 +0000 (UTC)
Subject: Re: [PATCH 10/17] e1000: Don't run e1000_instance_init() twice
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-11-armbru@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <addfb661-76cc-468f-50dd-ac691b042578@redhat.com>
Date: Wed, 29 Apr 2020 16:55:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-11-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/29 =E4=B8=8A=E5=8D=8812:34, Markus Armbruster wrote:
> QOM object initialization runs .instance_init() for the type and all
> its supertypes; see object_init_with_type().
>
> Both TYPE_E1000_BASE and its concrete subtypes set .instance_init() to
> e1000_instance_init().  For the concrete subtypes, it duly gets run
> twice.  The second run fails, but the error gets ignored (a later
> commit will change that).
>
> Remove it from the subtypes.
>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   hw/net/e1000.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 2a69eee63f..0d2c2759e3 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -1824,7 +1824,6 @@ static void e1000_register_types(void)
>           type_info.parent =3D TYPE_E1000_BASE;
>           type_info.class_data =3D (void *)info;
>           type_info.class_init =3D e1000_class_init;
> -        type_info.instance_init =3D e1000_instance_init;
>  =20
>           type_register(&type_info);
>       }


