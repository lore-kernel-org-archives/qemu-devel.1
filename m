Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D94C2BBFD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 18:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120DD20735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4EkRtNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120DD20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO3ap-0000aV-AT
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 14:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jO3YN-0005vR-RM
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jO3YM-0006gi-JV
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:11:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jO3YM-0006gI-FS
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586801485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5uvgEP4puIuPF2gcjkc0NuwoM1oY3H0l3UmQIM5Pro=;
 b=K4EkRtNzUQw0+phcBLADLiiS7JCV4CfJ8DCsJIZpnFWPsQoJMu04L89f6aJ3kloCSZ7jzs
 YNJjCsCL37D3eX57AaTD8za7t9PplJrF+4ae7Geb36D3CR8JULaQpvZh7BqPXXM51TBOo3
 B6O1/B6FNlKdCY+fGgdQI1zBqjo3hok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-qdzgkNKJNrua49LFsKBkTw-1; Mon, 13 Apr 2020 14:11:20 -0400
X-MC-Unique: qdzgkNKJNrua49LFsKBkTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30E7418CA240;
 Mon, 13 Apr 2020 18:11:19 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B08218A85;
 Mon, 13 Apr 2020 18:11:18 +0000 (UTC)
Subject: Re: [PATCH for-5.0] qcow2: Add incompatibility note between backing
 files and raw external data files
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200410121816.8334-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1f31551c-2ac1-ac5b-01c4-005cca2cb2af@redhat.com>
Date: Mon, 13 Apr 2020 13:11:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410121816.8334-1-berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/10/20 7:18 AM, Alberto Garcia wrote:
> Backing files and raw external data files are mutually exclusive.
> The documentation of the raw external data bit (in autoclear_features)
> already indicates that, but we should also mention it on the other
> side.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   docs/interop/qcow2.txt | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 640e0eca40..298a031310 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -25,6 +25,9 @@ The first cluster of a qcow2 image contains the file header:
>                       is stored (NB: The string is not null terminated). 0 if the
>                       image doesn't have a backing file.
>   
> +                    Note: backing files are incompatible with raw external data
> +                    files (auto-clear feature bit 1).
> +
>            16 - 19:   backing_file_size
>                       Length of the backing file name in bytes. Must not be
>                       longer than 1023 bytes. Undefined if the image doesn't have
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


