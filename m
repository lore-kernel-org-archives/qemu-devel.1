Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E5BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5A720708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQVfdgj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5A720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixIX2-0001Au-PL
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixIVl-0000Uw-Tv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixIVk-00045q-Pq
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:42:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixIVk-000454-Lm
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580424128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mpW3BeRYxanjYguq06w4xM+GOuRkh2PVsb0jY/iQJU=;
 b=hQVfdgj1htOdfjaQCaABFm6rhJVqoa2zdLMArBQDvmVl7Aj2fAFaNN1quL3wZ8Cy5NPpfm
 3gHd+aNxy2+otw8Wr7xjdyYAnsiAme/yD06/XMXA7F36tmq0wmH66xTqk+uYSVmqXqzREf
 JH6sH4NfPAlhtR/iPhx+zyPWKZoPuZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-JSU7o9gQOfqPqMqIHbYB9g-1; Thu, 30 Jan 2020 17:42:00 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so2371218wrm.16
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/mpW3BeRYxanjYguq06w4xM+GOuRkh2PVsb0jY/iQJU=;
 b=ffp2ZKXA4IjYOUd0NYx2b/EBmZBLHTidXPTsDcxQ6qqo9/CitlzsPk5JwMMwSLU5LC
 KKgv0GSWA6GQyFPreQ/lXrRaAckW3rXpzMsEdLv8vsJMjxCbRVq94s0cRSGaPryITDLM
 KSyWFjcRtv41cla/qQk3UzYxQ7wy9t3OJQCdAQ6ekxxZMyDwUgM/keWemC+mwA2M+PCp
 ZpIVobPkDvstw3Ek07MAbXZosIABWjZ/SBfBvVf7LhHX0PHIzy3/iMTj8Ay8UMHANmSi
 jIYrvg5YYBRbFkbhy7MYGmE18hsZTARQY4A3D2K9CYujBJn6Fp2W71fmsDp5yPhX7rlV
 gUOw==
X-Gm-Message-State: APjAAAW5AaOTCT6PedDW1L0N8/rz9bZQK9VX3Qe2JxqF8uF48/HyZ/1x
 7VCPVEYyvbV41RmWbN6hTjd+51tuPvEOqAyjE/yA2XNisNqsraTAdRjGVk7z5aqNt7wmD/5a5dF
 DYRrrdhmby0jHiG8=
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr7981198wml.180.1580424118593; 
 Thu, 30 Jan 2020 14:41:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfBkgvmi7/sAWlHO4dCWM4PGjMjOwHMhCdZuOAkW4CRae2BNfgGvwpbEGaQbkaxPLGZbE7Ug==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr7981178wml.180.1580424118304; 
 Thu, 30 Jan 2020 14:41:58 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x17sm8864457wrt.74.2020.01.30.14.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:41:57 -0800 (PST)
Subject: Re: [PATCH 0/5] python/qemu: qmp: Fix, delint and improvements
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191227134101.244496-1-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fe3ffe05-c620-7770-2752-3d2c4973da03@redhat.com>
Date: Thu, 30 Jan 2020 23:41:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227134101.244496-1-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: JSU7o9gQOfqPqMqIHbYB9g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/27/19 2:40 PM, Wainer dos Santos Moschetta wrote:
> I started fixing an issue on exception handling which in some places
> currently use the deprecated (in Python 3.3) `socket.error`. Then I
> ended up delinting the module code and making some improvements.
> 
> Git:
> - Tree: https://github.com/wainersm/qemu
> - Branch: python_qmp_sockets_error
> 
> CI:
> - Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/629772066
>    Failure not related with this series. Even QEMU master branch is
>    failing to build when `--without-default-devices --disable-user`.
> 
> Wainer dos Santos Moschetta (5):
>    python/qemu: qmp: Replace socket.error with OSError
>    python/qemu: Delint the qmp module
>    python/qemu: qmp: Make accept()'s timeout configurable
>    python/qemu: qmp: Make QEMUMonitorProtocol a context manager
>    python/qemu: qmp: Remove unnused attributes
> 
>   python/qemu/qmp.py | 91 +++++++++++++++++++++++++++++++++-------------
>   1 file changed, 65 insertions(+), 26 deletions(-)
> 

Thanks, applied patches 1, 2 and 5 to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


