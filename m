Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7506C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B56E2065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BM1G2eEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B56E2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYxqm-0003Xa-K7
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYxq9-00032w-Il
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:18:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50945
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYxq8-0003FT-Mt
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589401131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+HvIvrl9bEh6QJTEsuuP87oUWocHjVZq5Y85mFRkbU=;
 b=BM1G2eEfaID3+7ieJ3gQNvfthsaKGYNI6ca4wUl3hrovTb5cgCzfo39kLOeUgFKcUr2k9s
 WUA4xBQ+6tv8HXkJr+tDl1/8uc0WroDzFbei6w+4s+FbAapktRqd3qbga38u9T3g+DYDo1
 ljrUbGi/Xvc31f3Rejqk6aWqMaNBz/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-0MF9Il8ROKmk7zP3YClGIg-1; Wed, 13 May 2020 16:18:50 -0400
X-MC-Unique: 0MF9Il8ROKmk7zP3YClGIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 382AA107ACCA;
 Wed, 13 May 2020 20:18:49 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA6725D9F1;
 Wed, 13 May 2020 20:18:48 +0000 (UTC)
Subject: Re: [PATCH v4 11/34] block: Use bdrv_inherited_options()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200513110544.176672-1-mreitz@redhat.com>
 <20200513110544.176672-12-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4cf685bb-fc8e-1420-ded6-79280136c040@redhat.com>
Date: Wed, 13 May 2020 15:18:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513110544.176672-12-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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
> Let child_file's, child_format's, and child_backing's .inherit_options()
> implementations fall back to bdrv_inherited_options() to show that it
> would really work for all of these cases, if only the parents passed the
> appropriate BdrvChildRole and parent_is_format values.
> 
> (Also, make bdrv_open_inherit(), the only place to explicitly call
> bdrv_backing_options(), call bdrv_inherited_options() instead.)
> 
> This patch should incur only two visible changes, both for child_format
> children, both of which are effectively bug fixes:
> 
> First, they no longer have discard=unmap set by default.  This reason it
> was set is because bdrv_inherited_fmt_options() fell through to
> bdrv_protocol_options(), and that set it because "format drivers take
> care to send flushes and respect unmap policy".  None of the drivers
> that use child_format for their children (quorum and blkverify) are
> format drivers, though, so this reasoning does not apply here.
> 
> Second, they no longer have BDRV_O_NO_IO force-cleared.  child_format
> was used solely for children that do not store any metadata and as such
> will not be accessed by their parents as long as those parents do not
> receive I/O themselves.  Thus, such children should inherit
> BDRV_O_NO_IO.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 71 +++++++++++++++------------------------------------------
>   1 file changed, 19 insertions(+), 52 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


