Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79210C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431D22076E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIu/L++L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431D22076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnjM-0005LB-DN
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGnhv-0004WT-Ow
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGnhu-00023d-M8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:51:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGnhu-00023V-IE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585072278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qK92n9E36uevEzzv11iwthhADexsooPzIqsj0wtyXDg=;
 b=FIu/L++LOa93Tb4gHb6q16UpZpYe7bnUZU5NDh78Xpvh1vYaLPuUIcgQQUame/zXXoeE8o
 JYdxlQotR2bHugN6dSwFtCdJOYeN8n/85swnl6bk9+7FUC3etJE+RT706D3v3JjXuUQIXs
 OoreN4V4W2fpsQlYsDruxW/4jQql9Jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-O3hVZPMeO6eRK3yUI0xHKQ-1; Tue, 24 Mar 2020 13:51:13 -0400
X-MC-Unique: O3hVZPMeO6eRK3yUI0xHKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80E111005510;
 Tue, 24 Mar 2020 17:51:12 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2934E10016EB;
 Tue, 24 Mar 2020 17:51:12 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 2/3] iotests: Add poke_file_[bl]e functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200324172757.1173824-1-mreitz@redhat.com>
 <20200324172757.1173824-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <17a6ef32-38ea-157b-a275-e028781b6303@redhat.com>
Date: Tue, 24 Mar 2020 12:51:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324172757.1173824-3-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 12:27 PM, Max Reitz wrote:
> Similarly to peek_file_[bl]e, we may want to write binary integers into
> a file.  Currently, this often means messing around with poke_file and
> raw binary strings.  I hope these functions make it a bit more
> comfortable.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Code-suggested-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/qemu-iotests/common.rc | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 4c246c0450..bf3b9fdea0 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -53,6 +53,30 @@ poke_file()
>       printf "$3" | dd "of=$1" bs=1 "seek=$2" conv=notrunc &>/dev/null
>   }
>   
> +# poke_file_le $img_filename $offset $byte_width $value
> +# Example: poke_file_le "$TEST_IMG" 512 2 65534
> +poke_file_le()

Yep, that's nicer.

> +{
> +    local img=$1 ofs=$2 len=$3 val=$4 str=''
> +
> +    while ((len--)); do
> +        str+=$(printf '\\x%02x' $((val & 0xff)))
> +        val=$((val >> 8))
> +    done
> +
> +    poke_file "$img" "$ofs" "$str"
> +}

and so is that (but I'm biased, here :)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


