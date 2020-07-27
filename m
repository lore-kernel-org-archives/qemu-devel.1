Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02834C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C141B20719
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USwvhyi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C141B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k06Um-0001Mp-3M
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k06Tr-0000qA-7C
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:00:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60529
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k06Tn-0000GC-Er
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595869197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvzM6jVwFjDkOhkWkFVD6D5/DBGUnksaj7wsP6lKiJk=;
 b=USwvhyi82DjU9Xrb+zrQ6unnENp4lqhUjC+c4lYg81wlcBHzmbP/ufDRyaWCjCOTjvAO1y
 H9NkAflddXlkOjseo9hPj1hrZgsaMdO48OuMm8ECLEHataq0uyQ8gNIHJcBVVOZdxFDfjO
 +ZRlgRpdX5LU8lyqvp0asan6SG2Toe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-pzGsIOb0OJSWzx215abtrw-1; Mon, 27 Jul 2020 12:59:55 -0400
X-MC-Unique: pzGsIOb0OJSWzx215abtrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D38B800597;
 Mon, 27 Jul 2020 16:59:54 +0000 (UTC)
Received: from work-vm (ovpn-114-135.ams2.redhat.com [10.36.114.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F4F91972B;
 Mon, 27 Jul 2020 16:59:38 +0000 (UTC)
Date: Mon, 27 Jul 2020 17:59:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, david@redhat.com,
 zhang.zhanghailiang@huawei.com
Subject: Re: [PATCH v0 0/4] background snapshot
Message-ID: <20200727165935.GS3040@work-vm>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
> Currently where is no way to make a vm snapshot without pausing a vm
> for the whole time until the snapshot is done. So, the problem is
> the vm downtime on snapshoting. The downtime value depends on the vmstate
> size, the major part of which is RAM and the disk performance which is
> used for the snapshot saving.
> 
> The series propose a way to reduce the vm snapshot downtime. This is done
> by saving RAM, the major part of vmstate, in the background when the vm
> is running.
> 
> The background snapshot uses linux UFFD write-protected mode for memory
> page access intercepting. UFFD write-protected mode was added to the linux v5.7.
> If UFFD write-protected mode isn't available the background snapshot rejects to
> run.

Hi Denis,
  I see Peter has responded to most of your patches, but just anted to
say thank you; but also to cc in a couple of other people;
David Hildenbrand (who is interested in unusual memory stuff) and
zhanghailiang who works on COLO which also does snapshotting and had
long wanted to use WP.

  2/4 was a bit big for my liking; please try and do it in smaller
chunks!

Dave

> How to use:
> 1. enable background snapshot capability
>    virsh qemu-monitor-command vm --hmp migrate_set_capability background-snapshot on
> 
> 2. stop the vm
>    virsh qemu-monitor-command vm --hmp stop
> 
> 3. Start the external migration to a file
>    virsh qemu-monitor-command cent78-bs --hmp migrate exec:'cat > ./vm_state'
> 
> 4. Wait for the migration finish and check that the migration has completed state.
> 
> Denis Plotnikov (4):
>   bitops: add some atomic versions of bitmap operations
>   migration: add background snapshot capability
>   migration: add background snapshot
>   background snapshot: add trace events for page fault processing
> 
>  qapi/migration.json     |   7 +-
>  include/exec/ramblock.h |   8 +
>  include/exec/ramlist.h  |   2 +
>  include/qemu/bitops.h   |  25 ++
>  migration/migration.h   |   1 +
>  migration/ram.h         |  19 +-
>  migration/savevm.h      |   3 +
>  migration/migration.c   | 142 +++++++++-
>  migration/ram.c         | 582 ++++++++++++++++++++++++++++++++++++++--
>  migration/savevm.c      |   1 -
>  migration/trace-events  |   2 +
>  11 files changed, 771 insertions(+), 21 deletions(-)
> 
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


