Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08332C00454
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB88206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U13DC7el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB88206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4cQ-0000I5-0h
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1if4W1-00052c-2s
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1if4Vz-0006H4-TR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:07:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44583
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1if4Vz-0006Fv-O9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576080423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CeAOTEYzW24NlGHuOXnqDkyN3cAUcG/0+13t+1KJkY=;
 b=U13DC7elbxlMx6NU48G/66jAv33ED1L1C11INGcOIuzCCLavbjrfoEbMPQxBp9nsd5GovO
 nRwTkKsJ/+yPyvxZt1EBGmWY2wTimQUkRKukzhvpZ9MhqEzb1Go5b5KTMkNXSmh3HUlBb2
 2Rkf+muoHyA3zF7cBPp1+8f1alaWoOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-xKkEARg7M6qPPSTAemwKxw-1; Wed, 11 Dec 2019 11:07:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C6FA9124D
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 16:06:59 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D4FE5DA7B;
 Wed, 11 Dec 2019 16:06:56 +0000 (UTC)
Subject: Re: [PATCH 25/26] qapi/qmp: add ObjectPropertyInfo.default-value
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
 <20191201111531.1136947-26-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fdf74ec2-5916-b885-c251-c768e9810584@redhat.com>
Date: Wed, 11 Dec 2019 10:06:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191201111531.1136947-26-marcandre.lureau@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: xKkEARg7M6qPPSTAemwKxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/1/19 5:15 AM, Marc-Andr=C3=A9 Lureau wrote:
> Report the default value associated with a property.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   qapi/qom.json      | 7 ++++++-
>   qom/qom-qmp-cmds.c | 4 ++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 32db96ffc4..471e4b484b 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -26,10 +26,15 @@
>   #
>   # @description: if specified, the description of the property.
>   #
> +# @default-value: the default value, if any (since 5.0)
> +#
>   # Since: 1.2
>   ##
>   { 'struct': 'ObjectPropertyInfo',
> -  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
> +  'data': { 'name': 'str',
> +            'type': 'str',
> +            '*description': 'str',
> +            '*default-value': 'str' } }

Do we always want to output the stringized value, or would it be wise to=20
make this 'any' and output integers where that makes sense?


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


