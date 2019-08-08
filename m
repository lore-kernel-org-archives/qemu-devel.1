Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E1BC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 01:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0471217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 01:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0471217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvWnf-0004QI-VX
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 21:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43265)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hvWml-0003tu-3K
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 21:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hvWmk-00016g-3B
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 21:00:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:60472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hvWmj-000102-RQ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 21:00:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Aug 2019 17:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; d="scan'208";a="374675020"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2019 17:59:57 -0700
Date: Thu, 8 Aug 2019 08:59:35 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190808005935.GA3084@richard>
References: <20190805053146.32326-1-richardw.yang@linux.intel.com>
 <20190807183534.GN27871@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807183534.GN27871@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH v3] migration/postcopy: use mis->bh instead
 of allocating a QEMUBH
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 07:35:34PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> For migration incoming side, it either quit in precopy or postcopy. It
>> is safe to use the mis->bh for both instead of allocating a dedicated
>> QEMUBH for postcopy.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>Hi Wei,
>  Can you check this, the patchew tests came back with a failure which
>seems bh related; I've not tried it, but can you just see if you can
>reproduce it?

Hmm... the error message in mail is a little confusion.

I see following error, but have no idea about what it is.

==8174==ERROR: AddressSanitizer: heap-use-after-free on address 0x61200002c7f0 at pc 0x5566916cbf76 bp 0x7fc74f4b8680 sp 0x7fc74f4b8678
WRITE of size 1 at 0x61200002c7f0 thread T9
==8179==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
PASS 3 ahci-test /x86_64/ahci/pci_enable
==8192==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
    #0 0x5566916cbf75 in aio_notify /tmp/qemu-test/src/util/async.c:351:9
    #1 0x5566916cdbab in qemu_bh_schedule /tmp/qemu-test/src/util/async.c:167:9
    #2 0x5566916d0db0 in aio_co_schedule /tmp/qemu-test/src/util/async.c:464:5
---
  Right alloca redzone:    cb
  Shadow gap:              cc
==8174==ABORTING
ERROR - too few tests run (expected 40, got 18)
make: *** [/tmp/qemu-test/src/tests/Makefile.include:904: check-unit] Error 1
make: *** Waiting for unfinished jobs....
PASS 4 ahci-test /x86_64/ahci/hba_spec

I am trying to reproduce it. I guess docker should be used. Would you mind
sharing some link on setup the environment.

Thanks

-- 
Wei Yang
Help you, Help me

