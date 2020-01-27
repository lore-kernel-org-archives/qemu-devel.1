Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EC6C33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E2D24656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiaU29uC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E2D24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwD7J-0001B7-JG
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 17:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iwD2D-0000xY-SV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iwD2C-0007rv-NU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:39:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iwD2C-0007rc-K2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580164747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6OO66nTxW7dWhw0Jpl6aYkIhmLHEs/bTWJsphPPJe4=;
 b=YiaU29uC/gty+B0BN6IO0GXdnt+9MuufQswRslJ7qdky9KSgbNoEl9Gh9jU76qDBa1/JIr
 CTWZMI31fB+k+CtJj3FkcUiHsHuzJ8JAafVKeNKjuDZWOyI/nQNW3BlGkR5s4ZS1Du8Yob
 UZq94Jp1MoVWcv6JjctW1HjrgpbvO6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-BsFyXcIGMKKaCrWsgmqK2Q-1; Mon, 27 Jan 2020 17:39:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0369E800EBB;
 Mon, 27 Jan 2020 22:39:03 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A6D23B7;
 Mon, 27 Jan 2020 22:39:02 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] qemu-img: Add --target-is-zero to convert
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20200124103458.1525982-1-david.edmondson@oracle.com>
 <20200124103458.1525982-2-david.edmondson@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a689f9d9-a4b1-9201-1847-02a5afc255fd@redhat.com>
Date: Mon, 27 Jan 2020 16:39:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124103458.1525982-2-david.edmondson@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: BsFyXcIGMKKaCrWsgmqK2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 4:34 AM, David Edmondson wrote:
> In many cases the target of a convert operation is a newly provisioned
> target that the user knows is blank (filled with zeroes). In this
> situation there is no requirement for qemu-img to wastefully zero out
> the entire device.
> 
> Add a new option, --target-is-zero, allowing the user to indicate that
> an existing target device is already zero filled.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   qemu-img-cmds.hx |  4 ++--
>   qemu-img.c       | 25 ++++++++++++++++++++++---
>   qemu-img.texi    |  4 ++++
>   3 files changed, 28 insertions(+), 5 deletions(-)

I'm working up a patch series that tries to auto-set this flag without 
user interaction where possible (for example, if lseek(fd, 0, SEEK_DATA) 
returns EOF, or if fstat() reports 0 blocks allocated, or if qcow2 sees 
no L2 tables allocated, or a proposed extension to NBD passes on the 
same...).  I may rebase my series on top of your patch and tweak things 
in yours accordingly.

But as it stands, the idea makes sense to me; even if we add ways for 
some images to efficiently report initial state (and our existing 
bdrv_has_zero_init() is NOT such a method), there are enough other 
scenarios where the knob will be the only way to let qemu-img know the 
intent.


> +        case OPTION_TARGET_IS_ZERO:
> +            /*
> +             * The user asserting that the target is blank has the
> +             * same effect as the target driver supporting zero
> +             * initialisation.

Hmm. A git grep shows that 'initialization' has 200 hits, 
'initialisation' has only 29. But I think it's a US vs. UK thing, so I 
don't care which spelling you use.


> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>           warn_report("This will become an error in future QEMU versions.");
>       }
>   
> +    if (s.has_zero_init && !skip_create) {
> +        error_report("--target-is-zero requires use of -n flag");
> +        goto fail_getopt;
> +    }
> +

Makes sense, although we could perhaps relax it to also work even when 
the -n flag is supplied IF the destination image supports my proposal 
for a new status bit set when an image is known to be opened with all 
zero content.

>       s.src_num = argc - optind - 1;
>       out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
>   
> @@ -2380,6 +2394,11 @@ static int img_convert(int argc, char **argv)
>       }
>       s.target_has_backing = (bool) out_baseimg;
>   
> +    if (s.has_zero_init && s.target_has_backing) {
> +        error_report("Cannot use --target-is-zero with a backing file");
> +        goto out;
> +    }
> +

Makes sense, although we could perhaps relax it to also work even when 
there is a backing file IF the backing file supports my proposal for a 
new status bit set when an image is known to be opened with all zero 
content.

As my patch proposal is still not submitted, I'm fine if yours lands as-is:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


