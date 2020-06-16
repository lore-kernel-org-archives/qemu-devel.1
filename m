Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9361B206F1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sqo9Qeq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9361B206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlHnu-0005YF-QD
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 16:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlHn3-0004Zt-7T
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 16:02:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37711
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlHn1-00035C-KS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 16:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592337754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WYX1/1mNdGCc1Kps0v3AG2Uh7kizc+V5v7nXgpC/zA8=;
 b=Sqo9Qeq6m6rKKfZDhb02WlxmE9q3xb0BESgsAqEC1twM4on2di6cjhN76cEL/CW8GACSX5
 IDnho8aqNTpbsu1qQD2Q13QMwHHocmMl5XN/WxBJcbbeuBG2c6tjbRVvtuxg9VlwajjTsG
 Fh1KOdz+kslAdYxO0tE4C7JVBxHvR4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-2-jlLF4UOqqx5rwF1rDMkQ-1; Tue, 16 Jun 2020 16:02:32 -0400
X-MC-Unique: 2-jlLF4UOqqx5rwF1rDMkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8537A80331F;
 Tue, 16 Jun 2020 20:02:31 +0000 (UTC)
Received: from [10.3.112.27] (ovpn-112-27.phx2.redhat.com [10.3.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67DA55C1BD;
 Tue, 16 Jun 2020 20:02:30 +0000 (UTC)
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-2-jsnow@redhat.com>
 <20200604090140.GB4512@linux.fritz.box>
 <bb9a31cf-99e0-ef35-3739-bb3ff270735d@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <aef43939-63eb-8e48-e3ad-dfc12d1f3d21@redhat.com>
Date: Tue, 16 Jun 2020 15:02:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bb9a31cf-99e0-ef35-3739-bb3ff270735d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
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
Cc: pkrempa@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, vsementsov@virtuozzo.com,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 2:46 PM, Eric Blake wrote:

>>> +BlockJob *bitpop_job_create(
> 
>>> +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
>>> +        return NULL;
>>> +    }
>>
>> What does this protect? And why does BACKUP_SOURCE describe acccurately
>> what this job does?
> 
> I'm less certain what the BLOCK_OP_TYPE_* constants are supposed to 
> block, or if this is just copy/paste from backup.c. Does BlockOpType in 
> block.h need a new entry?

As it is, our code base has slowly moved away from op_blockers.  We no 
longer have any explicit bdrv_op_block() except when blocking 
everything, then immediately followed up with unblocking a mere subset 
of all of the defined op types:

block.c:    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_COMMIT_TARGET,
block.c:    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_STREAM,
block.c:    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_SOURCE,
block.c:    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_TARGET,
block/replication.c:        bdrv_op_unblock(top_bs, 
BLOCK_OP_TYPE_DATAPLANE, s->blocker);
blockjob.c:    bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);

Are we at the point where we can ditch op_blockers altogether in favor 
of the block permissions system?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


