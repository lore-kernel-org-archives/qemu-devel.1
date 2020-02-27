Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04BDC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06DB246AD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0GosJq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06DB246AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7OM0-0006E0-Sz
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 13:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7OLP-0005iE-BI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7OLM-0004fb-9k
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:57:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57239
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7OLL-0004en-0F
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582829825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upg0rIGmKbeUJHcwPcdl5u12PY5ohvy3UN8S1Kc42+I=;
 b=C0GosJq0ONPMmdJPAJ0PzEnBlssEARJcW+QLGJ050n38LpqDC8a+MVb2i4620yDoLaNqDl
 fy4yKLwv4UtkK1WqtI1XfyjJfIkigJArJ/2PVYG4c0rmHn1iywAW6I87/sx1Itkjo3REDE
 dyjn5FqwBLfa8RS/O+DvoJpMUe2BV7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-SXktmjpmO5ufchWhRWJHnw-1; Thu, 27 Feb 2020 13:56:51 -0500
X-MC-Unique: SXktmjpmO5ufchWhRWJHnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88558DB61;
 Thu, 27 Feb 2020 18:56:50 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C243388;
 Thu, 27 Feb 2020 18:56:50 +0000 (UTC)
Subject: Re: [PATCH 3/3] iotests/138: Test leaks/corruptions fixed report
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200227170251.86113-1-mreitz@redhat.com>
 <20200227170251.86113-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7336bd34-0f48-acf2-ef2b-0fb466f564f4@redhat.com>
Date: Thu, 27 Feb 2020 12:56:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227170251.86113-4-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 11:02 AM, Max Reitz wrote:
> Test that qemu-img check reports the number of leaks and corruptions
> fixed in its JSON report (after a successful run).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/138     | 41 ++++++++++++++++++++++++++++++++++++--
>   tests/qemu-iotests/138.out | 14 +++++++++++++
>   2 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
> index 54b01046ad..25bfbd4cca 100755
> --- a/tests/qemu-iotests/138
> +++ b/tests/qemu-iotests/138
> @@ -41,8 +41,10 @@ _supported_fmt qcow2
>   _supported_proto file
>   _supported_os Linux
>   # With an external data file, data clusters are not refcounted
> -# (and so qemu-img check does not check their refcount)
> -_unsupported_imgopts data_file
> +# (and so qemu-img check does not check their refcount);

Not this patch's problem, but is that a bug in 'qemu-img check' for not 
validating refcounts on an external data file?  Or is it merely this 
comment wording is not quite perfect?

> +# we want to modify the refcounts, so we need them to have a specific
> +# format (namely u16)
> +_unsupported_imgopts data_file 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
>   
>   echo
>   echo '=== Check on an image with a multiple of 2^32 clusters ==='
> @@ -65,6 +67,41 @@ poke_file "$TEST_IMG" $((2048 + 8)) "\x00\x80\x00\x00\x00\x00\x00\x00"
>   # allocate memory", we have an error showing that l2 entry is invalid.
>   _check_test_img
>   
> +echo
> +echo '=== Check leaks-fixed/corruptions-fixed report'
> +echo
> +
> +# After leaks and corruptions were fixed, those numbers should be
> +# reported by qemu-img check
> +_make_test_img 64k
> +
> +# Allocate data cluster
> +$QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
> +
> +reftable_ofs=$(peek_file_be "$TEST_IMG" 48 8)
> +refblock_ofs=$(peek_file_be "$TEST_IMG" $reftable_ofs 8)
> +
> +# Introduce a leak: Make the image header's refcount 2
> +poke_file "$TEST_IMG" "$refblock_ofs" "\x00\x02"

Why not use your brand-new poke_file_be "$TEST_IMG" "$refblock_ofs" 2 2

> +
> +l1_ofs=$(peek_file_be "$TEST_IMG" 40 8)
> +
> +# Introduce a corruption: Drop the COPIED flag from the (first) L1 entry
> +l1_entry=$(peek_file_be "$TEST_IMG" $l1_ofs 8)
> +l1_entry=$((l1_entry & ~(1 << 63)))
> +poke_file_be "$TEST_IMG" $l1_ofs 8 $l1_entry

Yep, the new function makes this task easier.  (You could also just peek 
1 byte at $((l1_ofs+7)) then write it back out with poke_file 
"$TEST_IMG" $((l1_ofs + 7)) $(printf '\\x%02x' $((val & 0xfe)))", but 
that just doesn't look as nice)

> +
> +echo
> +# Should print the number of corruptions and leaks fixed
> +# (Filter out all JSON fields (recognizable by their four-space
> +# indentation), but keep the "-fixed" fields (by removing two spaces
> +# from their indentation))
> +# (Also filter out the L1 entry, because why not)
> +_check_test_img -r all --output=json \
> +    | sed -e 's/^  \(.*\)-fixed"/\1-fixed"/' \
> +    | grep -v '^    ' \
> +    | sed -e "s/\\<$(printf %x $l1_entry)\\>/L1_ENTRY_VALUE/"

sed | grep | sed can often be done with a single sed:

... | sed -e 's/^  \(.*\)-fixed"/\1-fixed"/' \
        -e '/^    /d' \
        -e "s/\\..."

Using \\< and \\> in the sed regex is a GNUism; do we want this test to 
run on BSD?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


