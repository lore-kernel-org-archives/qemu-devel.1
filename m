Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1FBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C8C20738
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9JqHmW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C8C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsota-0007Dp-90
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 10:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsosQ-00067Y-8k
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 10:47:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54002
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsosM-0007m0-FE
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 10:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594133232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IO343SM0kWitS75vuoEF09RzcVckBgtH67BuOlTr2h0=;
 b=P9JqHmW1Z4H1P2VCMmvHcb+m9dUUdoub89mXpPaft8sZCiJ3+A4WoufNN80273yj53N3t5
 T3tJhB2ZVolSj2XewASKVNM21yDDquWB8la0x9tILcRo1ddu0uNJquuFxMSSSoG3AM+ch/
 jhMItUOCr2IZWGHduj43eswqv1KTrYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-UzdBBxiZOwCGbBIFicH0TA-1; Tue, 07 Jul 2020 10:47:08 -0400
X-MC-Unique: UzdBBxiZOwCGbBIFicH0TA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E90CF804003;
 Tue,  7 Jul 2020 14:47:07 +0000 (UTC)
Received: from [10.3.113.97] (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94D901001901;
 Tue,  7 Jul 2020 14:47:07 +0000 (UTC)
Subject: Re: [PATCH for-5.1] file-posix: Mitigate file fragmentation with
 extent size hints
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200707142329.48303-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7080e331-fa75-bc5c-1406-e4a772411ea2@redhat.com>
Date: Tue, 7 Jul 2020 09:47:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707142329.48303-1-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 9:23 AM, Kevin Wolf wrote:
> Espeically when O_DIRECT is used with image files so that the page cache

Especially

> indirection can't cause a merge of allocating requests, the file will
> fragment on the file system layer, with a potentially very small
> fragment size (this depends on the requests the guest sent).
> 
> On Linux, fragmentation can be reduced by setting an extent size hint
> when creating the file (at least on XFS, it can't be set any more after
> the first extent has been allocated), basically giving raw files a
> "cluster size" for allocation.
> 
> This adds an create option to set the extent size hint, and changes the
> default from not setting a hint to setting it to 1 MB. The main reason
> why qcow2 defaults to smaller cluster sizes is that COW becomes more
> expensive, which is not an issue with raw files, so we can choose a
> larger file. The tradeoff here is only potentially wasted disk space.
> 
> For qcow2 (or other image formats) over file-posix, the advantage should
> even be greater because they grow sequentially without leaving holes, so
> there won't be wasted space. Setting even larger extent size hints for
> such images may make sense. This can be done with the new option, but
> let's keep the default conservative for now.
> 
> The effect is very visible with a test that intentionally creates a
> badly fragmented file with qemu-img bench (the time difference while
> creating the file is already remarkable) and then looks at the number of
> extents and the take a simple "qemu-img map" takes.

Cool!

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json      | 11 ++++++----
>   include/block/block_int.h |  1 +
>   block/file-posix.c        | 42 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 50 insertions(+), 4 deletions(-)
> 

> +#ifdef FS_IOC_FSSETXATTR
> +    /*
> +     * Try to set the extent size hint. Failure is not fatal, and a warning is
> +     * only printed if the option was explicitly specified.
> +     */
> +    {
> +        struct fsxattr attr;
> +        result = ioctl(fd, FS_IOC_FSGETXATTR, &attr);
> +        if (result == 0) {
> +            attr.fsx_xflags |= FS_XFLAG_EXTSIZE;
> +            attr.fsx_extsize = file_opts->extent_size_hint;
> +            result = ioctl(fd, FS_IOC_FSSETXATTR, &attr);
> +        }
> +        if (result < 0 && file_opts->has_extent_size_hint) {
> +            warn_report("Failed to set extent size hint: %s",
> +                        strerror(errno));
> +        }
> +    }
> +#endif

That's a neat ioctl to learn.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


