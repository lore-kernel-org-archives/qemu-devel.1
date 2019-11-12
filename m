Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB5FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EC82084F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUiBDI+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EC82084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUWSU-0002jE-Or
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 08:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUWRn-0002In-M7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUWRl-0003Wr-FN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:43:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUWRl-0003WF-Bq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573566184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nub0s+Zx1POdhbS7dveYsgY2Lp9GqtJs1cwZuSA9C50=;
 b=ZUiBDI+JSacC+M8pDWC58nwRPVLPu7OOdg9vncLmNAOfflwZYAvPKq3KqOa0StcaEG7Fuk
 OxP6T2uDQ4pgEHagT4QYF8gYisd6YvgVT92gl7+yjefc5D3an78GrrGeOu0aOsPblSTgAP
 pgssdgVszLiNXK58sMpRcnZ+sglApPQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-ZsPSOKUyO5Ox0efplZPUhQ-1; Tue, 12 Nov 2019 08:41:53 -0500
Received: by mail-wm1-f71.google.com with SMTP id f16so1173744wmb.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 05:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WLxbm54fA/cmntev27hYbb9okDTUqQC777aFToSe/G0=;
 b=ABnbW6b40KUcIICN82DIFr8Su+zYFMhbTqJecvV8lx8V+/Irzk4zq2VgX+3hg88xQg
 s6FmyDrw4GB7wowy6KzRhe9xUzPmfrXb5f8FaGw5QPb/wldhJPHsXZ7iFkfDbpfTi/rm
 BOMd4oqcO+wGjwvx59RGyrn5l5QTXJnVu/GkAen+BHOr68+e0izYelnXvvXy9KmDi3NQ
 pk/RRtxl0y03DE4DCIq+cdqNdQpxd6o/0vN7lbsXoyzQ39ObTMNTT4L4wfm+d7JWxc3w
 JM+MO9PAMcAQD4Hd6OUIncxSRdSzcnxQkurtciYNdDwrKBfvp2W1manJBDjBHrR6FnAu
 jyFQ==
X-Gm-Message-State: APjAAAV2RlhM5LwhJ+O1d/+KpV9VT8c06VJq33OvPckyQnCXmu01LwG3
 xcAGMsmACxIClvm41dgnoXPeNSqYBhsShyqpQRFXOirDFB7oVktUAslnas/CMHf5lNor66TndP5
 mCmOZrempG4SgWE8=
X-Received: by 2002:adf:fe89:: with SMTP id l9mr10437754wrr.368.1573566112307; 
 Tue, 12 Nov 2019 05:41:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzlDhvYXlz6eUtJASX1G/QALft5F/JoQ92IeyoUvc5pdfS4IKid8yJ+k5Ij4yRjNjvSX7m2Tg==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr10437748wrr.368.1573566112133; 
 Tue, 12 Nov 2019 05:41:52 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id 65sm39312427wrs.9.2019.11.12.05.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 05:41:51 -0800 (PST)
Subject: Re: [PATCH] linux-user: fix missing break
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191112105055.32269-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <99dd2737-5c95-8e8f-b9b7-0d7d1ede552a@redhat.com>
Date: Tue, 12 Nov 2019 14:41:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112105055.32269-1-laurent@vivier.eu>
Content-Language: en-US
X-MC-Unique: ZsPSOKUyO5Ox0efplZPUhQ-1
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
Cc: Josh Kunz <jkz@google.com>, Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 11:50 AM, Laurent Vivier wrote:
> Reported by Coverity (CID 1407221)
> Fixes: a2d866827bd8 ("linux-user: Support for NETLINK socket options")
> cc: Josh Kunz <jkz@google.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/syscall.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ab9d933e53af..4e97bcf1e5a9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2632,6 +2632,7 @@ static abi_long do_getsockopt(int sockfd, int level=
, int optname,
>           default:
>               goto unimplemented;
>           }
> +        break;
>   #endif /* SOL_NETLINK */
>       default:
>       unimplemented:
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


