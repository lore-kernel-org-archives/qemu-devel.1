Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B6FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11B32072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJlbXXrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11B32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAa6o-0000K3-1n
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAa6H-0008Cm-95
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:39:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAa6E-0006Ou-GJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598366336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tALCQ3PsjOdmInqhL9ZrAflIDcBWDW4wqyl6WNhqCqg=;
 b=ZJlbXXrnweLCotgGjKKKWybwxaXCP6lTT0IuBl64TDquCLAgstRRVG6WqswowW+71yqDyD
 j4nXEEAH63zVvcZQHC6ia/hDNUOn1fjuoyiFQxEcTonSU3NTYTZA45MW+U+yCzpE7gJJK4
 lXtpz1whQpj03MDUuFOkEmNnqYQWQM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-xErENIxIOMulHIOhi85ikw-1; Tue, 25 Aug 2020 10:38:52 -0400
X-MC-Unique: xErENIxIOMulHIOhi85ikw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5F13100746A;
 Tue, 25 Aug 2020 14:38:51 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C45341002382;
 Tue, 25 Aug 2020 14:38:47 +0000 (UTC)
Date: Tue, 25 Aug 2020 16:38:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200825163846.10185087@redhat.com>
In-Reply-To: <20200825081504.GA2646@work-vm>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200824184112.GB2688@work-vm>
 <f602852c-b6af-694e-3e32-47974722e144@amd.com>
 <20200825081504.GA2646@work-vm>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 09:15:04 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Babu Moger (babu.moger@amd.com) wrote:
> > Hi Dave,
> > 
> > On 8/24/20 1:41 PM, Dr. David Alan Gilbert wrote:  
> > > * Babu Moger (babu.moger@amd.com) wrote:  
> > >> To support some of the complex topology, we introduced EPYC mode apicid decode.
> > >> But, EPYC mode decode is running into problems. Also it can become quite a
> > >> maintenance problem in the future. So, it was decided to remove that code and
> > >> use the generic decode which works for majority of the topology. Most of the
> > >> SPECed configuration would work just fine. With some non-SPECed user inputs,
> > >> it will create some sub-optimal configuration.
> > >> Here is the discussion thread.
> > >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-1d84-a6e7-e468-d5b437c1b254%40amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C74d90724af9c4adcc75008d8485d4d16%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637338912853492167&amp;sdata=GTsMKcpeYXAA0CvpLTirPHKdNSdlJE3RuPjCtSyWtGQ%3D&amp;reserved=0
> > >>
> > >> This series removes all the EPYC mode specific apicid changes and use the generic
> > >> apicid decode.  
> > > 
> > > Hi Babu,
> > >   This does simplify things a lot!
> > > One worry, what happens about a live migration of a VM from an old qemu
> > > that was using the node-id to a qemu with this new scheme?  
> > 
> > The node_id which we introduced was only used internally. This wasn't
> > exposed outside. I don't think live migration will be an issue.  
> 
> Didn't it become part of the APIC ID visible to the guest?

Daniel asked similar question wrt hard error on start up,
when CLI is not sufficient to create EPYC cpu.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg728536.html

Migration might fall into the same category.
Also looking at the history, 5.0 commit 
  247b18c593ec29 target/i386: Enable new apic id encoding for EPYC based cpus models
silently broke APIC ID (without versioning), for all EPYC models (that's were 1 new and 1 old one).

(I'm not aware of somebody complaining about it)

Another commit ed78467a21459, changed CPUID_8000_001E without versioning as well.


With current EPYC apicid code, if all starts align (no numa or 1 numa node only on
CLI and no -smp dies=) it might produce a valid CPU (apicid+CPUID_8000_001E).
No numa is gray area, since EPYC spec implies that it has to be numa machine in case of real EPYC cpus.
Multi-node configs would be correct only if user assigns cpus to numa nodes
by duplicating internal node_id algorithm that this series removes.

There might be other broken cases that I don't recall anymore
(should be mentioned in previous versions of this series)


To summarize from migration pov (ignoring ed78467a21459 change):

 1) old qemu pre-5.0 ==>  qemu 5.0, 5.1 - broken migration
 2) with this series (lets call it qemu 5.2)
     pre-5.0 ==> qemu 5.2 - should work as series basically rollbacks current code to pre-5.0
     qemu 5.0, 5.1 ==> qemu 5.2 - broken

It's all about picking which poison to choose,
I'd preffer 2nd case as it lets drop a lot of complicated code that
doesn't work as expected.

PS:
 I didn't review it yet, but with this series we aren't
 making up internal node_ids that should match user provided numa node ids somehow.
 It seems series lost the patch that would enforce numa in case -smp dies>1,
 but otherwise it heads in the right direction.

> 
> Dave
> 


