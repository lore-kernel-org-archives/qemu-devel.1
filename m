Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D37C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CAD4206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAD4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIF0c-0003lO-PR
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iI58Z-0001TU-0e
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iI58X-0005tF-OF
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:07:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:13581)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iI58X-0005rJ-Gj
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:07:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 23:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; d="scan'208";a="205649977"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga002.jf.intel.com with ESMTP; 08 Oct 2019 23:07:45 -0700
Date: Wed, 9 Oct 2019 14:07:28 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 3/3] migration/postcopy: handle POSTCOPY_INCOMING_RUNNING
 corner case properly
Message-ID: <20191009060728.GA14892@richard>
References: <20191001100122.17730-1-richardw.yang@linux.intel.com>
 <20191001100122.17730-4-richardw.yang@linux.intel.com>
 <20191008164046.GF3441@work-vm> <20191009010204.GC26203@richard>
 <20191009041225.GF10750@xz-x1> <20191009050756.GA9616@richard>
 <20191009053633.GA1039@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009053633.GA1039@xz-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 09, 2019 at 01:36:34PM +0800, Peter Xu wrote:
>On Wed, Oct 09, 2019 at 01:07:56PM +0800, Wei Yang wrote:
>> On Wed, Oct 09, 2019 at 12:12:25PM +0800, Peter Xu wrote:
>> >On Wed, Oct 09, 2019 at 09:02:04AM +0800, Wei Yang wrote:
>> >> On Tue, Oct 08, 2019 at 05:40:46PM +0100, Dr. David Alan Gilbert wrote:
>> >> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> >> >> Currently, we set PostcopyState blindly to RUNNING, even we found the
>> >> >> previous state is not LISTENING. This will lead to a corner case.
>> >> >> 
>> >> >> First let's look at the code flow:
>> >> >> 
>> >> >> qemu_loadvm_state_main()
>> >> >>     ret = loadvm_process_command()
>> >> >>         loadvm_postcopy_handle_run()
>> >> >>             return -1;
>> >> >>     if (ret < 0) {
>> >> >>         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING)
>> >> >>             ...
>> >> >>     }
>> >> >> 
>> >> >> From above snippet, the corner case is loadvm_postcopy_handle_run()
>> >> >> always sets state to RUNNING. And then it checks the previous state. If
>> >> >> the previous state is not LISTENING, it will return -1. But at this
>> >> >> moment, PostcopyState is already been set to RUNNING.
>> >> >> 
>> >> >> Then ret is checked in qemu_loadvm_state_main(), when it is -1
>> >> >> PostcopyState is checked. Current logic would pause postcopy and retry
>> >> >> if PostcopyState is RUNNING. This is not what we expect, because
>> >> >> postcopy is not active yet.
>> >> >> 
>> >> >> This patch makes sure state is set to RUNNING only previous state is
>> >> >> LISTENING by introducing an old_state parameter in postcopy_state_set().
>> >> >> New state only would be set when current state equals to old_state.
>> >> >> 
>> >> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> >
>> >> >OK, it's a shame to use a pointer there, but it works.
>> >> 
>> >> You mean second parameter of postcopy_state_set()?
>> >> 
>> >> I don't have a better idea. Or we introduce a new state
>> >> POSTCOPY_INCOMING_NOCHECK. Do you feel better with this?
>> >
>> >Maybe simply fix loadvm_postcopy_handle_run() to set the state after
>> >the POSTCOPY_INCOMING_LISTENING check?
>> >
>> 
>> Set state back to ps if ps is not POSTCOPY_INCOMING_LISTENING?
>> 
>> Sounds like another option.
>
>Even simpler?
>
>  ps = postcopy_state_get();
>  if (ps != INCOMING)
>    return -1;
>  postcopy_state_set(RUNNING);
>

Looks good to me.

Dave,

Do you feel good with it?

>Thanks,
>
>-- 
>Peter Xu

-- 
Wei Yang
Help you, Help me

