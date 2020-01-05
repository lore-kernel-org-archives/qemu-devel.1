Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5FEC33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 19:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94F0206F0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 19:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94F0206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioBQa-00067b-Ru
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 14:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ioBPr-0005XL-Ra
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 14:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ioBPq-0002Ee-H9
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 14:18:23 -0500
Received: from relay68.bu.edu ([128.197.228.73]:45111)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ioBPq-0002DL-DZ
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 14:18:22 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 005JHRh4004272
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 5 Jan 2020 14:17:30 -0500
Date: Sun, 5 Jan 2020 14:17:27 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v6 01/21] softmmu: split off vl.c:main() into main.c
Message-ID: <20200105191727.s6otput5ishuqlg3@mozz.bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-2-alxndr@bu.edu>
 <20200103095804.GB130240@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103095804.GB130240@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x [fuzzy]
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200103 0958, Stefan Hajnoczi wrote:
> On Fri, Nov 29, 2019 at 09:34:36PM +0000, Oleinik, Alexander wrote:
> > @@ -3853,7 +3834,7 @@ int main(int argc, char **argv, char **envp)
> >      set_memory_options(&ram_slots, &maxram_size, machine_class);
> >  
> >      os_daemonize();
> > -    rcu_disable_atfork();
> > +    /* rcu_disable_atfork(); */
> >  
> >      if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
> >          error_reportf_err(err, "cannot create PID file: ");
> 
> Did you find a solution for this?

Yes, though obviously it didn't make it into v6 :) I'm planning to just
check qtest_enabled(), since for now we are always using qtest.

