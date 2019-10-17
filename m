Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBADECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C5D2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPO3PXWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C5D2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9zn-0004Fa-Ry
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1iL9tA-0006UG-I7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1iL9t9-0004xN-Ej
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:48:40 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1iL9t9-0004x1-Ai
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:48:39 -0400
Received: by mail-qt1-x844.google.com with SMTP id m61so4827849qte.7
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ARyaOVfylo7p1ZK3XO2SduVhJIGuRYR4RxpfP5H0wrw=;
 b=aPO3PXWD+WnH8sk+j0wUKGNTHaddkRCMa5ktNWWU+gwqem4BWKy9tijP5zu8kRoQYD
 V8ud+Uj1izgj3ZgZT7krMsdZiYTDdnBWfIknZ+NfGCmE7o+2Hk4RpvpfIwchtqZl0Xl2
 aHRqNMaCngAY5LC92jmwOWgL+kJnfT2WRCo+UNTNjlRQp6w8JPUf31jLZpdX/8jVX2f1
 p5EqU1orIpSoCLA+JKZPx21ZZZLr7CtZ22GVwo3inVQ+14JzkXQ/cD+BM7yUrugVTsfh
 hrbtqw5lg9mlZZXcsM30KynMNP0ICNabKHYq4w6XzjczV9NRBUXRbwUUNSJXc8VJYkfr
 CqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ARyaOVfylo7p1ZK3XO2SduVhJIGuRYR4RxpfP5H0wrw=;
 b=mPr5TMJnwL7pAVmJixG0AY2NbsuYPfd7ghZbMIICJzn8UpjVcH3vlyUxxh2qBBiaqB
 Ov/iwGlVDBQT2L5NI+YlSLKDXZQjT8GO37W5F72HZ3b0QXBwcvIw1W31H50hL0z+/VcE
 20pAsWyFch1Qiwc81WvEZ//KxuDBx9gfETp+ef0NEG4y6EV7Bi6hdIXIP+13d6l3u3Xi
 orvsEw5Iq1tlSva/X1tt/k2XuEMcKTKm8C99Gy5lkzQvJ71gKVqVep5JQr9BFS2qjQwR
 7cJN+KhrRAKE1aGNu2SL6/4i9VgvKly2sBcGvto+lQme9/hA7q5+NBl51+r0mtW0+tVC
 7d3g==
X-Gm-Message-State: APjAAAXGq+qZMduhVsGVpcC/j9BI7E/W/4Vza8OR8gpntYvrgri7b5hn
 SMNHWXa9wIujOBEN79nTsfc=
X-Google-Smtp-Source: APXvYqwlqGhoDEulzfo2ZJuPXBySOZrmqeqxyZbGIB6sRXuy1zY58/Lmf42+dBYnaHwApLDyzl53uA==
X-Received: by 2002:ad4:4488:: with SMTP id m8mr5169842qvt.89.1571334518582;
 Thu, 17 Oct 2019 10:48:38 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:d25e:a983:2b3:2523:a41?
 ([2804:431:c7c7:d25e:a983:2b3:2523:a41])
 by smtp.gmail.com with ESMTPSA id q64sm1599460qkb.32.2019.10.17.10.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 10:48:38 -0700 (PDT)
Subject: Re: [PATCH v7 0/4] delete created files when
 block_crypto_co_create_opts_luks fails
To: qemu-devel@nongnu.org
References: <20190903135708.21624-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <de5096ea-54f2-ae95-9a9c-e03438c6133b@gmail.com>
Date: Thu, 17 Oct 2019 14:48:35 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190903135708.21624-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: kwolf@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

On 9/3/19 10:57 AM, Daniel Henrique Barboza wrote:
> Changes from previous version 6 [1]:
> 
> - bdrv_delete_file() now uses BlockDriverState as a parameter rather
> than a filename string.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00139.html
> 
> Daniel Henrique Barboza (4):
>    block: introducing 'bdrv_co_delete_file' interface
>    block.c: adding bdrv_delete_file
>    crypto.c: cleanup created file when block_crypto_co_create_opts_luks
>      fails
>    qemu-iotests: adding LUKS cleanup for non-UTF8 secret error
> 
>   block.c                    | 73 ++++++++++++++++++++++++++++++++++++++
>   block/crypto.c             | 22 ++++++++++++
>   block/file-posix.c         | 28 +++++++++++++++
>   include/block/block.h      |  1 +
>   include/block/block_int.h  |  6 ++++
>   tests/qemu-iotests/259     | 67 ++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/259.out | 11 ++++++
>   tests/qemu-iotests/group   |  1 +
>   8 files changed, 209 insertions(+)
>   create mode 100755 tests/qemu-iotests/259
>   create mode 100644 tests/qemu-iotests/259.out
> 

