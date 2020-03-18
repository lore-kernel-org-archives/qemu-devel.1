Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B801DC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850CD2071C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIh11QXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850CD2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEcFw-0005sx-Oc
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 13:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEcEz-0005So-DQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEcEx-0007pd-SF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:12:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEcEx-0007oN-MQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584551542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEbC8W2rkP9HWqH9jd5Zdf8BHMNzuxKDO3vs5GIUje8=;
 b=OIh11QXgdyh2wtLnwVVBJ5md+uZGOW5t8UXsxKrjb5j49+2RsfweuCSUNO3d7WqjoSGiw/
 j1wYFQHTSWH4+OL7PhopXjIlHHRqrjicUIf/OWISk9MlNjlXvkKnQyb9SfS5dQwRTlqm7n
 J5tkwPte271XiRF2D3uHyXFkEmDthaE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-BBwu_y0fNz-7A9Ygv81Q9g-1; Wed, 18 Mar 2020 13:12:20 -0400
X-MC-Unique: BBwu_y0fNz-7A9Ygv81Q9g-1
Received: by mail-wr1-f70.google.com with SMTP id q18so12651818wrw.5
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FbOqrBIi+5ItAeq8hs8ZIHE69y257WrF0oijEQjDdXc=;
 b=d+RPf7at98lLWp9SPDLIqSz3pTbyxmDlERTu1Jzm1ly387cUBd1vpvo+WiwB8oPpSi
 MgcCKmyEo748edJfULkajwA9fjEmQCF/h5t66gS2qs8fqpFmb4gtWYNWaA/vb52tCNb0
 BqFZUQ9TXpV9ToL6zIwk/8cHZwfb7WHewh5hPj6tc3F/iOCBdfYYLCwU3VkdzSUxmXno
 KssADuoTV4CD/HLlNujl20bJa95zkHrWuYKJqQG+KcwSo9nax2mV9kW9CJJMPUKjMD3Z
 CSGjj77tgSQ3jfQ+M+W+mbnS62h0HkP1V6Lt8zXD0peZXxpMeZJaB+JsSW/RFlFITBix
 eS2g==
X-Gm-Message-State: ANhLgQ1zClotkUXQhUspKx3WOmvvvI3RxH0sjWd0DLR/nbGIHkNrKfTJ
 I2oEDd71wj6sIourSBPQ7Y8tyYiLrCdNMeCvKsDMoWKjByLTrbYAP6WVVNEAClBigMyzgIORF6W
 eqLCEDVOQ8JKau6g=
X-Received: by 2002:adf:e808:: with SMTP id o8mr6636332wrm.366.1584551539481; 
 Wed, 18 Mar 2020 10:12:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsdcbnvLBebwiTku7OJTQr6frqmp2bp+K9ERJvYcv0LXicgNGs9v4mSsJUAkf2ZBuFePdER5g==
X-Received: by 2002:adf:e808:: with SMTP id o8mr6636323wrm.366.1584551539260; 
 Wed, 18 Mar 2020 10:12:19 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id s1sm10130449wrp.41.2020.03.18.10.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 10:12:18 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Upgrade myself as 9pfs co-maintainer
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <E1jEYz4-0004pt-Cs@lizzy.crudebyte.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1fd5e856-3165-f14e-36bf-b0a61e32dda7@redhat.com>
Date: Wed, 18 Mar 2020 18:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <E1jEYz4-0004pt-Cs@lizzy.crudebyte.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 2:33 PM, Christian Schoenebeck wrote:
> As suggested by Greg, let's upgrade myself as co-maintainer of 9pfs.
>=20
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7364af0d8b..8d9cd04ab5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1630,7 +1630,7 @@ F: include/hw/virtio/
>  =20
>   virtio-9p
>   M: Greg Kurz <groug@kaod.org>
> -R: Christian Schoenebeck <qemu_oss@crudebyte.com>
> +M: Christian Schoenebeck <qemu_oss@crudebyte.com>
>   S: Odd Fixes
>   F: hw/9pfs/
>   X: hw/9pfs/xen-9p*
>=20

FWIW:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


