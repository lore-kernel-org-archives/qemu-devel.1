Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6787AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3574B206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKFlr3DN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3574B206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnoB-0007at-CN
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGnms-0006u3-H1
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGnmq-0005Oa-7o
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:56:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGnmq-0005OI-3s
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585072583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yhbv4L3NXfYoPy02sjAhjWYXfK8N0YpigzYHd5D2PCw=;
 b=BKFlr3DN3YGYcQZtr0N3/WftIWMz8AusyrBPfbY332h4ByPJZwnf604wGF4a+mQKaFcUO4
 GLx5Mb0vGtJmxheEu5Y4SNM/0/UGMwc3pxMJlmTyat3XVsXct0ETA3qaaduT5WM385pGYD
 S7nwrZ2M+3ySqYE/muv8d2CDVVrq/6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-lxTJ2pC5NWWMaQISNs8oLA-1; Tue, 24 Mar 2020 13:56:21 -0400
X-MC-Unique: lxTJ2pC5NWWMaQISNs8oLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A165107ACCA;
 Tue, 24 Mar 2020 17:56:20 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE6315C1B2;
 Tue, 24 Mar 2020 17:56:19 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 3/3] iotests/138: Test leaks/corruptions fixed
 report
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200324172757.1173824-1-mreitz@redhat.com>
 <20200324172757.1173824-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <931c9b55-5a11-723b-e43b-6fbc1fe43954@redhat.com>
Date: Tue, 24 Mar 2020 12:56:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324172757.1173824-4-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
> Test that qemu-img check reports the number of leaks and corruptions
> fixed in its JSON report (after a successful run).
> 
> While touching the _unsupported_imgopts line, adjust the note on why
> data_file does not work with this test: The current comment sounds a bit
> like it is a mistake for qemu-img check not to check external data
> files' refcounts.  But there are no such refcounts, so it is no mistake.
> Just say that qemu-img check does not do much for external data files,
> and this is why this test does not work with them.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/138     | 41 ++++++++++++++++++++++++++++++++++++--
>   tests/qemu-iotests/138.out | 14 +++++++++++++
>   2 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
> index 54b01046ad..1d5b0bed6d 100755
> --- a/tests/qemu-iotests/138
> +++ b/tests/qemu-iotests/138
> @@ -41,8 +41,10 @@ _supported_fmt qcow2
>   _supported_proto file
>   _supported_os Linux
>   # With an external data file, data clusters are not refcounted
> -# (and so qemu-img check does not check their refcount)
> -_unsupported_imgopts data_file
> +# (so qemu-img check would not do much);

Works for me.

> +echo
> +# Should print the number of corruptions and leaks fixed
> +# (Filter out all JSON fields (recognizable by their four-space
> +# indentation), but keep the "-fixed" fields (by removing two spaces
> +# from their indentation))
> +# (Also filter out the L1 entry, because why not)
> +_check_test_img -r all --output=json \
> +    | sed -e 's/^  \(.*\)-fixed"/\1-fixed"/' \
> +          -e '/^    /d' \
> +          -e "s/\\([^0-9a-f]\\)$(printf %x $l1_entry)\\([^0-9a-f]\\)/\1L1_ENTRY_VALUE\2/"

It's fun to see the post-review results.  Given the limited times where 
the third -e fires in the output,

> +++ b/tests/qemu-iotests/138.out

> +Leaked cluster 0 refcount=2 reference=1
> +Repairing cluster 0 refcount=2 reference=1
> +Repairing OFLAG_COPIED L2 cluster: l1_index=0 l1_entry=L1_ENTRY_VALUE refcount=1

it could be written with less typing as:

-e "s/=$(printf %x $l1_entry) /=L1_ENTRY_VALUE /"

but that's not essential.  So either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


