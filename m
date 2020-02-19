Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB66C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E2324656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkXGlRKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E2324656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Qd6-00072d-TC
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4QcO-0006WX-3v
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4QcN-0004Cg-0z
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:46:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4QcM-0004AG-Ri
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582123586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvehIyGQR3ja5S1xooLkob0f2DnC2fXaXKZlp/JUdqI=;
 b=KkXGlRKvhQxIw5Snk0XY/RAMdU6qEF7NGHD+s9/5NcR/lIyU/fRvIXdmatbp+fdx4Loiwj
 Zz0Q7z1JaKK5Li5fUwGM3v6tbpdVInQL/D1vVdn4SJ+M73ESE11MllBr/bZ+tiJYI9Z/SB
 EHF0WHrfokMb2pw8Yw2HOcVmxKaBOf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-vyzavkRHNYau_g_s0J47dQ-1; Wed, 19 Feb 2020 09:46:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 718E113FB;
 Wed, 19 Feb 2020 14:46:15 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B481319756;
 Wed, 19 Feb 2020 14:46:14 +0000 (UTC)
Subject: Re: [PATCH] iotests: Fix nonportable use of od --endian
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200219144103.2919292-1-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <596f14e4-8412-f984-8bcc-6140a914bb31@redhat.com>
Date: Wed, 19 Feb 2020 08:46:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219144103.2919292-1-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: vyzavkRHNYau_g_s0J47dQ-1
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
Cc: qemu-trivial@nongnu.org, andrey.shinkevich@virtuozzo.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 8:41 AM, Eric Blake wrote:
> Tests 261 and 272 fail on RHEL 7 with coreutils 8.22, since od
> --endian was not added until coreutils 8.23.  Fix this by manually
> constructing the final value one byte at a time.
> 
> Fixes: fc8ba423
> Reported-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/qemu-iotests/common.rc | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 8a6366c09daf..b77ef3d22cd1 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -56,6 +56,12 @@ poke_file()
>   # peek_file_le 'test.img' 512 2 => 65534
>   peek_file_le()
>   {
> -    # Wrap in echo $() to strip spaces
> -    echo $(od -j"$2" -N"$3" --endian=little -An -vtu"$3" "$1")
> +    local val=0 shift=0 i
> +
> +    # coreutils' od --endian is not portable, so manually assemble bytes.
> +    for i in $(od -j"$2" -N"$3" -An -v -tu1 "$1"); do
> +        val=$(( val | (i << shift) ))
> +        shift=$((shift + 8))
> +    done
> +    echo $val

Reports large 8-byte values as negative, whereas the pre-patch version 
reported them as positive.  To preserve behavior, we should squash in:

diff --git i/tests/qemu-iotests/common.rc w/tests/qemu-iotests/common.rc
index 8966ad5cde78..a596856d4d8c 100644
--- i/tests/qemu-iotests/common.rc
+++ w/tests/qemu-iotests/common.rc
@@ -63,7 +63,7 @@ peek_file_le()
          val=$(( val | (i << shift) ))
          shift=$((shift + 8))
      done
-    echo $val
+    printf %llu $val
  }

  # peek_file_be 'test.img' 512 2 => 65279
@@ -75,7 +75,7 @@ peek_file_be()
      for i in $(od -j"$2" -N"$3" -An -v -tu1 "$1"); do
          val=$(( (val << 8) | i ))
      done
-    echo $val
+    printf %llu $val
  }

  # peek_file_raw 'test.img' 512 2 => '\xff\xfe'. Do not use if the raw data



-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


