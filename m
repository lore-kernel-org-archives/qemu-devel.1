Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B730EC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A2724659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AK+Efdtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A2724659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFaW-0001MN-Tg
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idElG-0000jr-OD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idElF-0001g6-Ni
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idElF-0001f3-I1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BD3MBsApZdbLjVhY88oByKqTwig01lY+pShh5BN2nQY=;
 b=AK+EfdtpeJd7cCRH9Q9g1LLQcVOcYPbhjE1dDJQE3OfGWTtSDcxY/jHQj3jNbAZKd/7DxD
 WijnkFjFdsU9DX4aVg1d9QVX4WEQChsv34fydlvwGUyQiJLwWuyvLg2kR/velvzndiFt++
 sescuEPt6awxIEl21VYWVdRKVrOWIoE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-_XY1jxagNourDmICCMG4og-1; Fri, 06 Dec 2019 02:37:25 -0500
Received: by mail-wr1-f72.google.com with SMTP id z10so2740304wrt.21
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 23:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m6W4GPhOHU0j0xY74XYrn/FdUC7TulYK/8eXNRujc3k=;
 b=mQx4SDBVT7nXWDcgVdVuH0oTR00OrhEcD9xX9tnBDe2VaFpwkIhtPcJCEYOfuNXamP
 8bG6nHAizLqXDXwcH/5wH9fw1G9ILJ9IDkb4tN5rbXz7L9lxUhTpzzXf7kTjtUlBrY2Q
 5XUqV7QRkPLmFnkPp3WHw210tD5HE2IBEIAY6oXYjl21xLtuf0J7lHsuAtGrzihpRwAv
 3HEF95Ym4lvDhdH6uTCsu0EKJC7tYPTUi+p5Ktc+nbuIqX9UMCnT2/hY7YB2uNw/3cFc
 CNfjtnjE4F2VAda9BpCmDzREcpx/Ldw7cQwkQPFaKfcfvpNtgMj4Q/1L1vRqG3qczT7G
 vuow==
X-Gm-Message-State: APjAAAUUT9aR/BfE7QVlbjkUUCG6cFq5YOLP/1Q7YyYmLfeH1l32iDZC
 Hc+RbKL/3jEobDYF1Z/STHZSYCftPFTqJNo/gv7r8ouwECmAGPELVbmi/VJ8GUOvWV7lHAMHY0m
 Dn0HaigwO51lZC74=
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr13629770wru.52.1575617844708; 
 Thu, 05 Dec 2019 23:37:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXKaeV1LQaDroAt9qu+kC1qm/NbiBGMCBwHKNFYfuKkqNMqzMBFXzu53iLMOcbCnU4dLLMWg==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr13629753wru.52.1575617844554; 
 Thu, 05 Dec 2019 23:37:24 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id d12sm15144043wrp.62.2019.12.05.23.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 23:37:24 -0800 (PST)
Subject: Re: [PATCH v8 13/21] monitor/qmp-cmds: rename Error ** parameter to
 more common errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-14-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <755fb698-0da9-664d-93d2-25240a6db62d@redhat.com>
Date: Fri, 6 Dec 2019 08:37:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-14-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: _XY1jxagNourDmICCMG4og-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   monitor/qmp-cmds.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 0880341a2d..c6faa3eaf0 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -109,7 +109,7 @@ void qmp_system_reset(Error **errp)
>       qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
>   }
>  =20
> -void qmp_system_powerdown(Error **erp)
> +void qmp_system_powerdown(Error **errp)
>   {
>       qemu_system_powerdown_request();
>   }
>=20


