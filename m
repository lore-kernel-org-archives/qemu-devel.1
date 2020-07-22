Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F19C433E8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6992065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOkO3tSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6992065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHgH-000760-6Z
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyHdN-0003uz-MN
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:30:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27897
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyHdK-0006bF-SK
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595435416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cS/lt1qXDDaTsd2CE87X8FGrpENz2sZrNI+8hcvnVHI=;
 b=hOkO3tSl6f7F/jKveHfarY55kNfDBahf8qIMzXcdleyhfxlR0OH/K5x4viv8J+ktFr6jnT
 4OLGXCLZ8GN2wNydpzu/4CkR2gcJ/WdZzS6vvJWL4u/81xnwRb5UzIooiH8K42j5DoBev4
 O5OpmNkR1Ro6Aee7G4dfcUWj7DktJEQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-z-XXfGHZP3W0rPBn6SRNKw-1; Wed, 22 Jul 2020 12:30:14 -0400
X-MC-Unique: z-XXfGHZP3W0rPBn6SRNKw-1
Received: by mail-qv1-f71.google.com with SMTP id ed5so1771405qvb.9
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cS/lt1qXDDaTsd2CE87X8FGrpENz2sZrNI+8hcvnVHI=;
 b=N9sb5hKoJ1vhv6xvDjDPBXpWPm3ESQM5EVYfap385SwBKzd0sG+hDm/wxDL52skG06
 QdnL466rs1f7sB7vgPKZxOYSLUQUApyZaYTi19B6+iNIN0Ke5DQymg/LetpjgjBYX2t9
 bpz86ihdkmjJApmpjCmY1UgJ8ar9/lu3/78WB4T5FFS1FkIMtyvkp3MYICqIlK8ajbFf
 fy9v9Sb1I5/teyCTKcrl9KJS8QiVapFdjjEtlNX9tAjSKBHFEpAuqprX441Hl2bwpFjF
 abR66AgHPOo8c4H6DAosNeQShGdF7EM9iEL6xTKGQNqHhs6fGC9yiL4ogs+BtbwcPWOP
 KcRg==
X-Gm-Message-State: AOAM531LKVOGzZJ1eh0LK9mHW2+VCCAM9KNUu01vLPCbtZzb8BusjFAB
 zV5dLoNDUS+ohkF4iI/Jxs/9J/HufzAsX5g06uSs3/iSl6KYq6jIFYBEi/c7y6joyTwg4njaGRq
 IN2FC0e9/sP8FkWo=
X-Received: by 2002:a05:6214:a72:: with SMTP id
 ef18mr818641qvb.166.1595435413395; 
 Wed, 22 Jul 2020 09:30:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJEQCMV0nFc2fbws2rEfDhGcfaLW7iaPV5PoiJqXZLNiRJA/3iTOkzPUSEB0qiUoE9nITJZw==
X-Received: by 2002:a05:6214:a72:: with SMTP id
 ef18mr818604qvb.166.1595435413114; 
 Wed, 22 Jul 2020 09:30:13 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id 94sm115283qtc.88.2020.07.22.09.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 09:30:12 -0700 (PDT)
Date: Wed, 22 Jul 2020 12:30:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 0/4] background snapshot
Message-ID: <20200722163009.GA535743@xz-x1>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722145034.GZ535743@xz-x1>
 <8146768f-7804-e239-41a0-3f7997f6b75d@virtuozzo.com>
 <bf3fd4f4-31a1-9d13-94b0-e3b026edb6b1@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <bf3fd4f4-31a1-9d13-94b0-e3b026edb6b1@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
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
Cc: quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, den@openvz.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 06:47:44PM +0300, Denis Plotnikov wrote:
> 
> 
> On 22.07.2020 18:42, Denis Plotnikov wrote:
> > 
> > 
> > On 22.07.2020 17:50, Peter Xu wrote:
> > > Hi, Denis,
> > Hi, Peter
> > > ...
> > > > How to use:
> > > > 1. enable background snapshot capability
> > > >     virsh qemu-monitor-command vm --hmp migrate_set_capability
> > > > background-snapshot on
> > > > 
> > > > 2. stop the vm
> > > >     virsh qemu-monitor-command vm --hmp stop
> > > > 
> > > > 3. Start the external migration to a file
> > > >     virsh qemu-monitor-command cent78-bs --hmp migrate exec:'cat
> > > > > ./vm_state'
> > > > 
> > > > 4. Wait for the migration finish and check that the migration
> > > > has completed state.
> > > Thanks for continued working on this project! I have two high level
> > > questions
> > > before dig into the patches.
> > > 
> > > Firstly, is step 2 required?  Can we use a single QMP command to
> > > take snapshots
> > > (which can still be a "migrate" command)?
> > 
> > With this series it is required, but steps 2 and 3 should be merged into
> > a single one.

I'm not sure whether you're talking about the disk snapshot operations, anyway
yeah it'll be definitely good if we merge them into one in the next version.

> > > 
> > > Meanwhile, we might also want to check around the type of backend
> > > RAM.  E.g.,
> > > shmem and hugetlbfs are still not supported for uffd-wp (which I'm still
> > > working on).  I didn't check explicitly whether we'll simply fail
> > > the migration
> > > for those cases since the uffd ioctls will fail for those kinds of
> > > RAM.  It
> > > would be okay if we handle all the ioctl failures gracefully,
> > 
> > The ioctl's result is processed but the patch has a flaw - it ignores
> > the result of ioctl check. Need to fix it.
> 
> It happens here:
> 
> +int ram_write_tracking_start(void)
> +{
> +    if (page_fault_thread_start()) {
> +        return -1;
> +    }
> +
> +    ram_block_list_create();
> +    ram_block_list_set_readonly(); << this returns -1 in case of failure but I just ignore it here
> +
> +    return 0;
> +}
> 
> > > or it would be
> > > even better if we directly fail when we want to enable live snapshot
> > > capability
> > > for a guest who contains other types of ram besides private
> > > anonymous memories.
> > 
> > I agree, but to know whether shmem or hugetlbfs are supported by the
> > current kernel we should
> > execute the ioctl for all memory regions on the capability enabling.

Yes, that seems to be a better solution, so we don't care about the type of ram
backend anymore but check directly with the uffd ioctls.  With these checks,
it'll be even fine to ignore the above retcode, or just assert, because we've
already checked that before that point.

Thanks,

-- 
Peter Xu


