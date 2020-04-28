Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01769C83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 21:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA152072A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 21:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDFkKIms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA152072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTXQk-0004Kn-QW
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 17:06:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTXPm-0003ad-5H
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 17:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTXPj-0005A1-G9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 17:05:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTXPi-00057h-Ti
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 17:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588107909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OFTRDtNrdkjxDmRddmTJfEbWLBqsdHI0olWXI9mAAKQ=;
 b=CDFkKImsULOt3fZ3Kn0Dkmep84c6AiotNG2IQ9Bi2iDgy23T/RY0lP3vwwYVMrjpthX5wn
 VzQPEkBYKi1D+ByuJSF4tv9S4c2+q8EbyGMYPh1FmVmP0WZw2CO1ouT6hl7nqh7pTmVM1H
 8pL2WcRO69FpTcCnzlrmjU90AIERk7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-k5olZ4oVMr2rmwET7RS1-Q-1; Tue, 28 Apr 2020 17:05:05 -0400
X-MC-Unique: k5olZ4oVMr2rmwET7RS1-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A9F2800D24;
 Tue, 28 Apr 2020 21:05:04 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 500BC1002388;
 Tue, 28 Apr 2020 21:05:01 +0000 (UTC)
Subject: Re: [PATCH v22 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-4-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <463f9afa-e4d7-cb29-7f35-67250b6ba918@redhat.com>
Date: Tue, 28 Apr 2020 16:05:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428200013.24474-4-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 3:00 PM, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of the compression ratio in comparison with
> zlib, which, at the moment, is the only compression
> method available.
> 
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
> 
> The test was conducted with brd disk to reduce the influence
> of disk subsystem to the test results.
> The results is given in seconds.
> 
> compress cmd:
>    time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
>                    src.img [zlib|zstd]_compressed.img
> decompress cmd
>    time ./qemu-img convert -O qcow2
>                    [zlib|zstd]_compressed.img uncompressed.img
> 
>             compression               decompression
>           zlib       zstd           zlib         zstd
> ------------------------------------------------------------
> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
> user     65.0       15.8            5.3          2.5
> sys       3.3        0.2            2.0          2.0
> 
> Both ZLIB and ZSTD gave the same compression ratio: 1.57
> compressed image size in both cases: 1.4G
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> QAPI part:
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---

> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    ssize_t ret;
> +    size_t zstd_ret;
> +    ZSTD_outBuffer output = {
> +        .dst = dest,
> +        .size = dest_size,
> +        .pos = 0
> +    };

> +
> +    /* make sure we can safely return compressed buffer size with ssize_t */
> +    assert(output.pos <= SSIZE_MAX);

Seems rather vague, since we know that .pos won't exceed .size which was 
initialized by dest_size which is <= 2M.  A tighter assertion:

assert(output.pos <= dest_size)

seems like it is more realistic to your real constraint (namely, that 
zstd did not overflow dest).

> +    ret = output.pos;
> +out:
> +    ZSTD_freeCCtx(cctx);
> +    return ret;
> +}
> +

> +++ b/slirp
> @@ -1 +1 @@
> -Subproject commit 2faae0f778f818fadc873308f983289df697eb93
> +Subproject commit 55ab21c9a36852915b81f1b41ebaf3b6509dd8ba

Umm, you definitely don't want that.

A maintainer could touch up both of those, but I'm not sure which block 
maintainer will be accepting this series.  Maybe wait for that question 
to be answered before trying to post a v23.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


