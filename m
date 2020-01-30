Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E01C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B2320661
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B2320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDrk-0001df-Ty
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ixDr8-00018h-9Y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ixDr4-0005xW-Pu
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:43:53 -0500
Received: from relay68.bu.edu ([128.197.228.73]:36013)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ixDr4-0005wr-MI
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:43:50 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 00UHglmN011016
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 30 Jan 2020 12:42:50 -0500
Date: Thu, 30 Jan 2020 12:42:46 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v8 13/21] main: keep rcu_atfork callback enabled for qtest
Message-ID: <20200130174246.fd4dcs7gntoyzx5i@mozz.bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-14-alxndr@bu.edu>
 <20200130144224.GC180311@stefanha-x1.localdomain>
 <4bc49889-081e-6016-b8d5-a5d1fd615830@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bc49889-081e-6016-b8d5-a5d1fd615830@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x
X-Received-From: 128.197.228.73
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200130 1824, Paolo Bonzini wrote:
> On 30/01/20 15:42, Stefan Hajnoczi wrote:
> >> +
> >> +    /*
> >> +     * If QTest is enabled, keep the rcu_atfork enabled, since system processes
> >> +     * may be forked testing purposes (e.g. fork-server based fuzzing)
> >> +     */
> >> +    if (!qtest_enabled()) {
> >> +        rcu_disable_atfork();
> >> +    }
> > I haven't reviewed the details of whether resources are leaked across
> > fork but in general it makes sense that we want an RCU thread in the
> > fork child:
> 
> Note that there is a possible deadlock between fork and synchronize_rcu
> (see commit 73c6e40, "rcu: completely disable pthread_atfork callbacks
> as soon as possible", 2016-01-27):
> 
> - the CPU thread is inside a RCU critical section and wants to take the
> BQL in order to do MMIO
> 
> - the I/O thread, which is owning the BQL, forks and calls
> rcu_init_lock, which tries to take the rcu_sync_lock
> 
> - the call_rcu thread has taken rcu_sync_lock in synchronize_rcu, but
> synchronize_rcu needs the CPU thread to end the critical section before
> returning.
> 
> Therefore it would be best if the fork server could fork before a single
> CPU instruction is executed, and then rcu_disable_atfork could be moved
> right after the fork server is started (just like right now we do it
> right after os_daemonize).  We probably talked about this before, but
> how do you ensure that the fork server is started before threads are
> created (apart from the RCU thread)?

With QTest, is this still a concern, since there are no CPU instructions
involved? Sometimes the fork-server starts after some I/O has already
occured (eg mapping BARs and setting up VQs for virtio-net). I know we
briefly talked about threads at some point, and it seems that iothreads
may be a concern, if any are started before fork. Other than that, since
there is no TCG/CPU thread, are there any other threads that could be
a concern?
-Alex

> Paolo
> 




