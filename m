Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF4C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 00:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64022206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 00:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64022206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIMkK-00083l-JF
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 20:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iIMj1-0007XL-91
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iIMiy-0006qC-SF
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:54:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:47807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iIMiy-0006pU-Ja
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:54:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Oct 2019 17:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; d="scan'208";a="277601220"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga001.jf.intel.com with ESMTP; 09 Oct 2019 17:54:33 -0700
Date: Thu, 10 Oct 2019 08:54:16 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 3/3] migration/postcopy: handle POSTCOPY_INCOMING_RUNNING
 corner case properly
Message-ID: <20191010005416.GA24524@richard>
References: <20191001100122.17730-1-richardw.yang@linux.intel.com>
 <20191001100122.17730-4-richardw.yang@linux.intel.com>
 <20191008164046.GF3441@work-vm> <20191009010204.GC26203@richard>
 <20191009041225.GF10750@xz-x1> <20191009050756.GA9616@richard>
 <20191009053633.GA1039@xz-x1> <20191009060728.GA14892@richard>
 <20191009090842.GD2893@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009090842.GD2893@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 Peter Xu <peterx@redhat.com>, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 09, 2019 at 10:08:42AM +0100, Dr. David Alan Gilbert wrote:
>> >> >
>> >> >Maybe simply fix loadvm_postcopy_handle_run() to set the state after
>> >> >the POSTCOPY_INCOMING_LISTENING check?
>> >> >
>> >> 
>> >> Set state back to ps if ps is not POSTCOPY_INCOMING_LISTENING?
>> >> 
>> >> Sounds like another option.
>> >
>> >Even simpler?
>> >
>> >  ps = postcopy_state_get();
>> >  if (ps != INCOMING)
>
>  ^^ LISTENING
>

oops

>> >    return -1;
>> >  postcopy_state_set(RUNNING);
>> >
>> 
>> Looks good to me.
>> 
>> Dave,
>> 
>> Do you feel good with it?
>
>Yes, I think so; it's simpler.
>

I will prepare v2.

>Dave
>
>> >Thanks,
>> >
>> >-- 
>> >Peter Xu
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

