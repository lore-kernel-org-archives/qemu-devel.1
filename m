Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657D4C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994E2206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0fQ2Ild"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994E2206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafFJ-0001sz-En
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kafE0-0001KY-7V
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:22:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kafDy-000614-Q1
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604582565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/yGcvo99I9tYvl6MbZINUG7SstpPuxp3hUoKYWY3Wo=;
 b=W0fQ2Ild9ChviZSHTVqHuy7AJqUHCemnvwir+WdrmB7+RHJlEjYTLyR62dlxBq+F6oCil1
 UU0sbePr0Lr0YikALAYWQjt2Vp6uEDUffDt6R8GJ4rrkcCDdMyrF3Us8J4Nc2J7LDzf3YP
 xa1oDotWRMLjeYGDce2dJSX3Eqydz5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-Up8hCfMiM8-o_0Uzc-17Mg-1; Thu, 05 Nov 2020 08:22:39 -0500
X-MC-Unique: Up8hCfMiM8-o_0Uzc-17Mg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 814D96D584;
 Thu,  5 Nov 2020 13:22:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-31.ams2.redhat.com
 [10.36.114.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36F171002C3E;
 Thu,  5 Nov 2020 13:22:16 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: make bdrv_drop_intermediate() less wrong
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20201031123502.4558-1-vsementsov@virtuozzo.com>
 <20201031123502.4558-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <384f5bfc-238e-6b7f-473b-6aa5cd93ef52@redhat.com>
Date: Thu, 5 Nov 2020 14:22:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201031123502.4558-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31.10.20 13:35, Vladimir Sementsov-Ogievskiy wrote:
> First, permission update loop tries to do iterations transactionally,
> but the whole update is not transactional: nobody roll-back successful
> loop iterations when some iteration fails.

Indeed.  Another thing that should be noted:

bdrv_check_update_perm() doc:
 > Needs to be followed by a call to either bdrv_set_perm()
 > or bdrv_abort_perm_update().

And besides rolling back on error, we don’t commit on success either.

> Second, in the iteration we have nested permission update:
> c->klass->update_filename may point to bdrv_child_cb_update_filename()
> which calls bdrv_backing_update_filename(), which may do node reopen to
> RW.
> 
> Permission update system is not prepared to nested updates, at least it
> has intermediate permission-update state stored in BdrvChild
> structures: has_backup_perm, backup_perm and backup_shared_perm.
> 
> So, let's first do bdrv_replace_node() (which is more transactional
> than open-coded update in bdrv_drop_intermediate()) and then call
> update_filename() in separate. We still do not rollback changes in case
> of update_filename() failure but it's not much worse than pre-patch
> behavior.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block.c | 36 +++++++++++++++---------------------
>   1 file changed, 15 insertions(+), 21 deletions(-)

And it’s also much simpler and clearer now.

Reviewed-by: Max Reitz <mreitz@redhat.com>


