Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE05C04E84
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 06:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C6220862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 06:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C6220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQnmi-00059k-6s
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 02:53:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQnih-0001gL-10
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQnZ9-0006rX-H1
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:39:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:14924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hQnZ9-0006jE-4t
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:39:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 May 2019 23:39:00 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga005.jf.intel.com with ESMTP; 14 May 2019 23:38:59 -0700
Date: Wed, 15 May 2019 14:38:27 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190515063827.GB11845@richard>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-3-richardw.yang@linux.intel.com>
	<0eb5e5a5-593e-f4a2-7e2d-a9fed481ab6c@gmail.com>
	<20190426005133.GB25513@richard> <20190514151813.GL2753@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514151813.GL2753@work-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH 2/4] migration/savevm: use
 migration_is_blocked to validate
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: quintela@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
	Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 04:18:14PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> 
>> Well, when you look into the source side of migration:
>> 
>> qmp_migrate
>>   migrate_prepare
>>     migration_is_blocked
>> 
>> This means if migration_is_blocked fails, the source will not start migration.
>> And it is the same as save_snapshot.
>> 
>> From my understanding, when we load a vm, it should check the same
>> requirement.
>
>I've been thinking about this, and I think I agree with Daniel on this.
>The 'migration_blockers' list tells you that something about the
>*current* state of a device means that it can't be migrated - e.g.
>a 9pfs with a mounted filesystem can't be migrated.
>
>If we're about to reload the state from a snapshot, then the saved
>snapshot's state must have been migratable, so that's OK.
>

The situation is on a vm with 'migration_blockers' still could reload from a
snapshot.

This sounds reasonable. Thanks :-)

>(Whether all the device code is actually OK about being reset in
>that state is a different question; but I think it should be).
>
>Dave
>
>> -- 
>> Wei Yang
>> Help you, Help me
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

