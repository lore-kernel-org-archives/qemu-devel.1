Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5FAC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758F6223AB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu3jIuEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758F6223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX1jg-0005QC-Fb
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX1f1-0002Bn-Hv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX1ey-0005te-Gz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603715494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Rb6H5JYtsVQJe30HW9m0txpkk72okPV8dXKaPgRTL4=;
 b=Tu3jIuEmVhSMYoCD3FyJ6cSluBz60nBBV3/i7i3ww9+vrTInGnwair8l+vaKhCXOMoQjY2
 UrSssfuZULmFc+VBCqyjOjfFuBAcsk5YgIgyW3KrGQPtT7vpUosXyz0q8GOHO36TDaAmrY
 YVtGufPCFei0TxXXdbkliVa6mJ9sdAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-jkfT8FkxMJyDbOO2pPu68w-1; Mon, 26 Oct 2020 08:31:30 -0400
X-MC-Unique: jkfT8FkxMJyDbOO2pPu68w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB1A3804B9C;
 Mon, 26 Oct 2020 12:31:29 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EAC65577F;
 Mon, 26 Oct 2020 12:31:25 +0000 (UTC)
Subject: Re: [PATCH v5 11/12] nbd: Expose actual depth in qemu:allocation-depth
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-12-eblake@redhat.com>
 <909e397b-ebee-7380-717c-7800c32195ce@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f3652fe4-4233-3ecc-ed1d-c23046d26396@redhat.com>
Date: Mon, 26 Oct 2020 07:31:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <909e397b-ebee-7380-717c-7800c32195ce@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com,
 qemu-block@nongnu.org, rjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/20 4:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> 23.10.2020 21:36, Eric Blake wrote:
>> Preserve the tri-state encoding in the low bits, as that still remains
>> a valuable way to utilize qemu-img map with x-dirty-bitmap for
>> accessing quick information without needing a third-party NBD client.
> 
> Hmm.. that doesn't sound as a good reason for redundant information in
> the protocol. Previously good reason was additional effort needed to
> implement sever part, but you've implemented it. And if we export depth
> anyway, it seems better to hack a bit nbd_client_co_block_status to
> convert extent.flags appropriately if metadata context is
> "qemu:allocation-depth" (to keep x-dirty-bitmap working), than have a
> workaround at the protocol layer.

I'm happy to respin this to expose JUST a depth rather than redundant
information, but time is short if we want it in 5.2 (as soft freeze is
this week).  I'll see what I can get to today; I'll rearrange the series
to put multiple bitmap exports first (as that appears ready), while
saving 'qemu-nbd -A' until we're happy with the qemu:allocation-depth
semantics.  After all, once we release something, we've committed to
that user interface.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


