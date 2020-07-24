Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56334C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A18206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flUZ3pWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A18206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0cm-0006jP-Es
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jz0bQ-0005s1-73
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:31:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jz0bN-0000CX-3t
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595608275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JG0z7+mzM45PB8AVPSFIH1ReKSHFVpG5+/sjbh2wPbI=;
 b=flUZ3pWj4hmIV+oUJxRYn+hjaVcWTW1ssVLoalKWvkuZY9Y5mczdREo1Xjo6H8okm1iuCs
 5x+YSa5johG46kLfl/vjO+4MgiF+0eY9AuSRoUphrM7azmkR1wtFtprHc9oplItZT/2WZH
 Ii5sU2uKbTgzs5Dia/4CHtpSw355qnI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-tCvv7I9wOjWrDIwXNt5fxQ-1; Fri, 24 Jul 2020 12:31:11 -0400
X-MC-Unique: tCvv7I9wOjWrDIwXNt5fxQ-1
Received: by mail-qv1-f69.google.com with SMTP id dl10so6156285qvb.20
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JG0z7+mzM45PB8AVPSFIH1ReKSHFVpG5+/sjbh2wPbI=;
 b=VbkC/OAAEyyiHXFrLQ3FIKA+GKHQ1Yhc1r0y7HseHibqDkLp/X/7VLMCDWbpEVXLWL
 O/hL8/T3E1VBjkL2F0zuwdhidSSxLoGhZbdkszLVVVUqef0c2sBV72O8qzdNIaFEku8d
 qbL9XGlqDN+OhT4D5tKr1IVO7enmcUQWqhr7Beh1SP6glBpTvyswcRCbiNot+lLAzAYm
 WsmV3Pd8+CTtPyEY/XEjf7zCND7qoLViGWKj+lHFH3QIiq6NQh/a4pu9WkcuD/thqiCe
 tji5f1tRp+gWGbmJUY7nMQxfi3zb+dh7SjJrl29vwzmsJ2rQVCLcfGmGTg6uNJAf5Kql
 G3qQ==
X-Gm-Message-State: AOAM531oASu7fIFJ0Lo8n0BBsUnEPc0XdePK+f8AcnaudINrYV+rz61H
 MZ1LdzlrZyM/GvcrwZ8n0mk//AygLWmDq+Pu1N7JKx4b2xFAO1FvRel4ehen0agxSV+Sb7pn305
 A/A9Sek8QLzovqdA=
X-Received: by 2002:ac8:1788:: with SMTP id o8mr9641502qtj.330.1595608271288; 
 Fri, 24 Jul 2020 09:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO0RMVoi15neInB2I8sQ5MZDdTQYNvNy70uE+nhMWhzVvysWovuB7m2P8MazbQxMyzSGIiuQ==
X-Received: by 2002:ac8:1788:: with SMTP id o8mr9641480qtj.330.1595608271017; 
 Fri, 24 Jul 2020 09:31:11 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id y49sm1951631qtc.23.2020.07.24.09.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 09:31:10 -0700 (PDT)
Date: Fri, 24 Jul 2020 12:31:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 0/4] background snapshot
Message-ID: <20200724163108.GB865413@xz-x1>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722145034.GZ535743@xz-x1>
 <8146768f-7804-e239-41a0-3f7997f6b75d@virtuozzo.com>
 <bf3fd4f4-31a1-9d13-94b0-e3b026edb6b1@virtuozzo.com>
 <20200722163009.GA535743@xz-x1>
 <a34af0de-a6ce-59f1-13bf-4f99e0e41c55@virtuozzo.com>
 <20200723173952.GB831087@xz-x1>
 <8e289570-8fe3-0511-5404-6ad0c0e2df35@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <8e289570-8fe3-0511-5404-6ad0c0e2df35@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 24, 2020 at 11:06:17AM +0300, Denis Plotnikov wrote:
> 
> 
> On 23.07.2020 20:39, Peter Xu wrote:
> > On Thu, Jul 23, 2020 at 11:03:55AM +0300, Denis Plotnikov wrote:
> > > 
> > > On 22.07.2020 19:30, Peter Xu wrote:
> > > > On Wed, Jul 22, 2020 at 06:47:44PM +0300, Denis Plotnikov wrote:
> > > > > On 22.07.2020 18:42, Denis Plotnikov wrote:
> > > > > > On 22.07.2020 17:50, Peter Xu wrote:
> > > > > > > Hi, Denis,
> > > > > > Hi, Peter
> > > > > > > ...
> > > > > > > > How to use:
> > > > > > > > 1. enable background snapshot capability
> > > > > > > >       virsh qemu-monitor-command vm --hmp migrate_set_capability
> > > > > > > > background-snapshot on
> > > > > > > > 
> > > > > > > > 2. stop the vm
> > > > > > > >       virsh qemu-monitor-command vm --hmp stop
> > > > > > > > 
> > > > > > > > 3. Start the external migration to a file
> > > > > > > >       virsh qemu-monitor-command cent78-bs --hmp migrate exec:'cat
> > > > > > > > > ./vm_state'
> > > > > > > > 4. Wait for the migration finish and check that the migration
> > > > > > > > has completed state.
> > > > > > > Thanks for continued working on this project! I have two high level
> > > > > > > questions
> > > > > > > before dig into the patches.
> > > > > > > 
> > > > > > > Firstly, is step 2 required?  Can we use a single QMP command to
> > > > > > > take snapshots
> > > > > > > (which can still be a "migrate" command)?
> > > > > > With this series it is required, but steps 2 and 3 should be merged into
> > > > > > a single one.
> > > > I'm not sure whether you're talking about the disk snapshot operations, anyway
> > > > yeah it'll be definitely good if we merge them into one in the next version.
> > > After thinking for a while, I remembered why I split these two steps.
> > > The vm snapshot consists of two parts: disk(s) snapshot(s) and vmstate.
> > > With migrate command we save the vmstate only. So, the steps to save
> > > the whole vm snapshot is the following:
> > > 
> > > 2. stop the vm
> > >      virsh qemu-monitor-command vm --hmp stop
> > > 
> > > 2.1. Make a disk snapshot, something like
> > >      virsh qemu-monitor-command vm --hmp snapshot_blkdev drive-scsi0-0-0-0 ./new_data
> > > 3. Start the external migration to a file
> > >      virsh qemu-monitor-command vm --hmp migrate exec:'cat ./vm_state'
> > > 
> > > In this example, vm snapshot consists of two files: vm_state and the disk file. new_data will contain all new disk data written since [2.1.] executing.
> > But that's slightly different to the current interface of savevm and loadvm
> > which only requires a snapshot name, am I right?
> 
> Yes
> > Now we need both a snapshot
> > name (of the vmstate) and the name of the new snapshot image.
> 
> Yes
> > 
> > I'm not familiar with qemu image snapshots... my understanding is that current
> > snapshot (save_snapshot) used internal image snapshots, while in this proposal
> > you want the live snapshot to use extrenal snapshots.
> Correct, I want to add ability to make a external live snapshot. (live =
> asyn ram writing)
> >    Is there any criteria on
> > making this decision/change?
> Internal snapshot is supported by qcow2 and sheepdog (I never heard of
> someone using the later).
> Because of qcow2 internal snapshot design, it's quite complex to implement
> "background" snapshot there.
> More details here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg705116.html
> So, I decided to start with external snapshot to implement and approve the
> memory access intercepting part firstly.
> Once it's done for external snapshot we can start to approach the internal
> snapshots.

Fair enough.  Let's start with external snapshot then.  Thanks,

-- 
Peter Xu


