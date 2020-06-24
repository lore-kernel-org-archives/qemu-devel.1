Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B42C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1625C20823
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hj0/SYSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1625C20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joBlo-00052k-9u
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 16:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joBjZ-0002tV-4X
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:11:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joBjX-000630-ID
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593029458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RYb8msjN/iyLKgWJvfjxMC7d0fUKwpQ/7vNFTLcsHI=;
 b=Hj0/SYSpMdAZjHSXB9FkcYsewO0LcIV2icWggvKTrwMntq5TFjMNe9QkBIWKkpMnkM+U2D
 +wWa6XyqErUDPDkfeu9qe1Vj0KUckUILl47tn3E1UC+GSOTdOeBSP2r3LPSYjgqhJVDQjI
 o0UcLbwyATJbPh148q0fs0nToDhPxSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-PJv5Hx6YNaip6sbf7Kqm1A-1; Wed, 24 Jun 2020 16:10:49 -0400
X-MC-Unique: PJv5Hx6YNaip6sbf7Kqm1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27742EC1A0;
 Wed, 24 Jun 2020 20:10:48 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C846512FE;
 Wed, 24 Jun 2020 20:10:47 +0000 (UTC)
Subject: Re: [PATCH 18/46] qemu-option: Smooth error checking manually
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-19-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <09ff9918-ac64-e9cc-96b3-b0e4aed5800f@redhat.com>
Date: Wed, 24 Jun 2020 15:10:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624164344.3778251-19-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 11:43 AM, Markus Armbruster wrote:
> When foo(..., &err) is followed by error_propagate(errp, err), we can
> often just as well do foo(..., errp).  The previous commit did that
> for simple cases with Coccinelle.  Do it for a few more manually.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block.c             | 2 +-
>   block/gluster.c     | 8 ++++----
>   block/parallels.c   | 2 +-
>   block/quorum.c      | 2 +-
>   block/replication.c | 2 +-
>   block/vxhs.c        | 4 ++--
>   hw/net/virtio-net.c | 4 ++--
>   7 files changed, 12 insertions(+), 12 deletions(-)
> 

> +++ b/block/gluster.c
> @@ -523,7 +523,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>   
>       /* create opts info from runtime_json_opts list */
>       opts = qemu_opts_create(&runtime_json_opts, NULL, 0, &error_abort);
> -    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
> +    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
>           goto out;
>       }

This function also has a few error_setg(&local_err) that could be 
cleaned up to error_setg(errp); but the ones that use 
error_append_hint() immediately after (and thus the 
error_propagate(errp, local_err) in the out: label) still have to 
remain, until we have Vladimir's macro in place.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


