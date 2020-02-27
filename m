Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89CAC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B95246C6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2u/1VdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B95246C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7OCq-0003h6-LD
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 13:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7OBF-0002ZB-CR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7OBE-0004US-0f
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:46:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7OBD-0004Tb-Rs
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582829198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5qJ89daaiDb3M2UDgfCi1heNLinL7g+00YTtaOjOv8=;
 b=W2u/1VdPkLxt/XCcX1h7vsnte2InZpxQBBo9To+ko+ZVe5yHF+NhJyii60iQanfhzoVTWg
 JcidaMtKpqc63c9MPqLs345fVyp990mrVWNAu0526vaoAwy3HRD2AVqqCmd3Fk1mVYsE4G
 Gw5BuipeZTg7CHik5i85qUQo/t4FIQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-CQGxnonlPEiXg3rgGve0pQ-1; Thu, 27 Feb 2020 13:46:37 -0500
X-MC-Unique: CQGxnonlPEiXg3rgGve0pQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24AAE801E6C;
 Thu, 27 Feb 2020 18:46:34 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7DDC77945;
 Thu, 27 Feb 2020 18:46:33 +0000 (UTC)
Subject: Re: [PATCH 2/3] iotests: Add poke_file_[bl]e functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200227170251.86113-1-mreitz@redhat.com>
 <20200227170251.86113-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <473f2e22-bf5b-32f4-51db-bf12f7a2d4fe@redhat.com>
Date: Thu, 27 Feb 2020 12:46:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227170251.86113-3-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 11:02 AM, Max Reitz wrote:
> Similarly to peek_file_[bl]e, we may want to write binary integers into
> a file.  Currently, this often means messing around with poke_file and
> raw binary strings.  I hope these functions make it a bit more
> comfortable.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/common.rc | 37 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 4c246c0450..604f837668 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -53,6 +53,43 @@ poke_file()
>       printf "$3" | dd "of=$1" bs=1 "seek=$2" conv=notrunc &>/dev/null
>   }
>   
> +# poke_file_le 'test.img' 512 2 65534
> +poke_file_le()
> +{

I like the interface.  However, the implementation is a bit bloated (but 
then again, that's why you cc'd me for review ;)

> +    local img=$1 ofs=$2 len=$3 val=$4 str=''
> +
> +    for i in $(seq 0 $((len - 1))); do

No need to fork seq, when we can let bash do the iteration for us:

while ((len--)); do

> +        byte=$((val & 0xff))
> +        if [ $byte != 0 ]; then
> +            chr="$(printf "\x$(printf %x $byte)")"

Why are we doing two printf command substitutions instead of 1?

> +        else
> +            chr="\0"

Why do we have to special-case 0?  printf '\x00' does the right thing.

> +        fi
> +        str+="$chr"

I'd go with the faster str+=$(printf '\\x%02x' $((val & 0xff))), 
completely skipping the byte and chr variables.

> +        val=$((val >> 8))
> +    done
> +
> +    poke_file "$img" "$ofs" "$str"
> +}

So my version:

poke_file_le()
{
     local img=$1 ofs=$2 len=$3 val=$4 str=
     while ((len--)); do
         str+=$(printf '\\x%02x' $((val & 0xff)))
         val=$((val >> 8))
     done
     poke_file "$img" "$ofs" "$str"
}

> +
> +# poke_file_be 'test.img' 512 2 65279
> +poke_file_be()
> +{
> +    local img=$1 ofs=$2 len=$3 val=$4 str=''

And this one's even easier: we get big-endian for free from printf 
output, with a sed post-processing to add \x:

poke_file_be()
{
     local str="$(printf "%0$(($3 * 2))x\n" $4 | sed 's/\(..\)/\\x\1/g')"
     poke_file "$1" "$2" "$str"
}

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


