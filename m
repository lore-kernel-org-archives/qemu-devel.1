Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31834C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003F2206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBnJ9Q8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003F2206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhbk-0004tm-1d
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jOhb7-0004N5-Io
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jOhb6-0001Su-7H
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:56:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jOhb5-0001SO-VC
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586955415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+t1xsviuy71Av8LyjdthnLJshiGC2Y9/5japbDQGkeI=;
 b=NBnJ9Q8iT6UkqsOglkVO0xBoAT2uqEkHI93fNiG4AP49oiDTkmrfyKqWZqkPaJYWnDjnat
 zWRsiGvmbpUcwYxnjmRS4qpo1fIwn9IBdwTt1me8SF3UcfsSgqQEG/It4BrCwWuv5BMDOi
 rpS4ErbXD8MufMpErPBUgfKfjTUZ7ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-GEWREXO-OZOwU9rQRMhgvA-1; Wed, 15 Apr 2020 08:56:51 -0400
X-MC-Unique: GEWREXO-OZOwU9rQRMhgvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6388F8018A2;
 Wed, 15 Apr 2020 12:56:50 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECA9F2B479;
 Wed, 15 Apr 2020 12:56:49 +0000 (UTC)
Subject: Re: [PATCH v2 for-5.1 9/9] qemu-img: Reject broken -o ""
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200415074927.19897-1-armbru@redhat.com>
 <20200415074927.19897-10-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <13278355-9946-8b8c-759d-e8d2b632786e@redhat.com>
Date: Wed, 15 Apr 2020 07:56:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415074927.19897-10-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 2:49 AM, Markus Armbruster wrote:
> qemu-img create, convert, amend, and measure use accumulate_options()
> to merge multiple -o options.  This is broken for -o "":
> 
>      $ qemu-img create -f qcow2 -o backing_file=a -o "" -o backing_fmt=raw,size=1M new.qcow2
>      qemu-img: warning: Could not verify backing image. This may become an error in future versions.
>      Could not open 'a,backing_fmt=raw': No such file or directory
>      Formatting 'new.qcow2', fmt=qcow2 size=1048576 backing_file=a,,backing_fmt=raw cluster_size=65536 lazy_refcounts=off refcount_bits=16
>      $ qemu-img info new.qcow2
>      image: new.qcow2
>      file format: qcow2
>      virtual size: 1 MiB (1048576 bytes)
>      disk size: 196 KiB
>      cluster_size: 65536
> --> backing file: a,backing_fmt=raw
>      Format specific information:
>          compat: 1.1
>          lazy refcounts: false
>          refcount bits: 16
>          corrupt: false
> 
> Merging these three -o the obvious way is wrong, because it results in
> an unwanted ',' escape:
> 
>      backing_file=a,,backing_fmt=raw,size=1M
>                    ~~
> 
> We could silently drop -o "", but Kevin asked me to reject it instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qemu-img.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

This results in the error message:
qemu-img: Invalid option list:

with a trailing space and no indication that it was an empty string we 
were trying to warn about.  But that's tolerable.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


