Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC379C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22EE20575
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1yYxps/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22EE20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYydv-0001Y9-Ts
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 17:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYycA-0006rj-Hh
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:08:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57849
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYyc9-0005VG-G9
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589404108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJVWCD+Mf7+bwk5zvTkGUMwsGVMLBbnuJUR9+VxRuGs=;
 b=B1yYxps/GbXl4TXL9wmJJxTqn+kE/debGH4rhAvRzTKEKwebJpKBgLqytJU5AgVMPiUojp
 +JNgSrcJHKcMSzicJFe5pRc3CpO4tiE1+ljdkeMCkMXVeOfZZm3OrD+HxmlFSnKR9FAcR4
 YNnJhvL4b3VgXHn68LI95GGwUwKgfOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-44i1l9J7OkWe8yeh1ne22g-1; Wed, 13 May 2020 17:08:27 -0400
X-MC-Unique: 44i1l9J7OkWe8yeh1ne22g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 153B8835B41;
 Wed, 13 May 2020 21:08:26 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5BB250DA;
 Wed, 13 May 2020 21:08:25 +0000 (UTC)
Subject: Re: [PATCH v4 27/34] block: Use child_of_bds in remaining places
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200513110544.176672-1-mreitz@redhat.com>
 <20200513110544.176672-28-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3b34fc75-ca59-6c35-0093-a5b0230dcef3@redhat.com>
Date: Wed, 13 May 2020 16:08:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513110544.176672-28-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 6:05 AM, Max Reitz wrote:
> Replace child_file by child_of_bds in all remaining places (excluding
> tests).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c              |  3 ++-
>   block/backup-top.c   |  4 ++--
>   block/blklogwrites.c |  4 ++--
>   block/raw-format.c   | 15 +++++++++++++--
>   4 files changed, 19 insertions(+), 7 deletions(-)
> 

> @@ -448,8 +449,18 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>           return ret;
>       }
>   
> -    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
> -                               false, errp);
> +    /*
> +     * Without offset and a size limit, this driver behaves very much
> +     * like a filter.  With any such limit, it does not.
> +     */
> +    if (offset || has_size) {
> +        file_role = BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY;
> +    } else {
> +        file_role = BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY;
> +    }

I wonder if we'll hit subtle bugs where one but not the other use of raw 
breaks because of the difference in roles.  I know we have _some_ iotest 
coverage of raw with offsets, but wonder if we might need more (or a way 
to add it on top of existing images, similar to how we can easily toggle 
qcow2 options like refcount size for interesting non-default test runs).

> +
> +    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
> +                               file_role, false, errp);
>       if (!bs->file) {
>           return -EINVAL;
>       }
> 

At any rate, if we have corner-case bugs, I don't think this is making 
them worse.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


