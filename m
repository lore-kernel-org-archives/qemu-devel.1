Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EA820707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8rOk/UC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EA820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAunS-0007wA-AP
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAumA-00071M-FU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:43:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAum7-0007fV-VM
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598445814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48iTfCsmqYeUjjHc3t/Lks1+tm5QTgbcpCAUc6ByBCU=;
 b=H8rOk/UCHsDvExxXZ+3DM8S1ZrHo/x8owHtk90n6tSLBpFEcWBzG88Bf0WZd7v0YahWS/5
 K69utAzqpLxrdvLY6L1qtGD/86yDlswmJSzbPOjqy6AsaP6/CtpPUd0k89ltebOFztEQ6Y
 eiSEy+lhqWPpiizmGYmbdCmjHCZQ09I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-80MJdFpnMEOKCyAF_J2owA-1; Wed, 26 Aug 2020 08:43:31 -0400
X-MC-Unique: 80MJdFpnMEOKCyAF_J2owA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A14F81074646;
 Wed, 26 Aug 2020 12:43:30 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4827550B3F;
 Wed, 26 Aug 2020 12:43:26 +0000 (UTC)
Date: Wed, 26 Aug 2020 14:43:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200826144324.56335302@redhat.com>
In-Reply-To: <20200825152521.GA3574@work-vm>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200824184112.GB2688@work-vm>
 <f602852c-b6af-694e-3e32-47974722e144@amd.com>
 <20200825081504.GA2646@work-vm>
 <20200825163846.10185087@redhat.com>
 <20200825152521.GA3574@work-vm>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 16:25:21 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Igor Mammedov (imammedo@redhat.com) wrote:
> > On Tue, 25 Aug 2020 09:15:04 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >   
> > > * Babu Moger (babu.moger@amd.com) wrote:  
> > > > Hi Dave,
> > > > 
> > > > On 8/24/20 1:41 PM, Dr. David Alan Gilbert wrote:    
> > > > > * Babu Moger (babu.moger@amd.com) wrote:    
> > > > >> To support some of the complex topology, we introduced EPYC mode apicid decode.
> > > > >> But, EPYC mode decode is running into problems. Also it can become quite a
> > > > >> maintenance problem in the future. So, it was decided to remove that code and
> > > > >> use the generic decode which works for majority of the topology. Most of the
> > > > >> SPECed configuration would work just fine. With some non-SPECed user inputs,
> > > > >> it will create some sub-optimal configuration.
> > > > >> Here is the discussion thread.
> > > > >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-1d84-a6e7-e468-d5b437c1b254%40amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C74d90724af9c4adcc75008d8485d4d16%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637338912853492167&amp;sdata=GTsMKcpeYXAA0CvpLTirPHKdNSdlJE3RuPjCtSyWtGQ%3D&amp;reserved=0
> > > > >>
> > > > >> This series removes all the EPYC mode specific apicid changes and use the generic
> > > > >> apicid decode.    
> > > > > 
> > > > > Hi Babu,
> > > > >   This does simplify things a lot!
> > > > > One worry, what happens about a live migration of a VM from an old qemu
> > > > > that was using the node-id to a qemu with this new scheme?    
> > > > 
> > > > The node_id which we introduced was only used internally. This wasn't
> > > > exposed outside. I don't think live migration will be an issue.    
> > > 
> > > Didn't it become part of the APIC ID visible to the guest?  
> > 
> > Daniel asked similar question wrt hard error on start up,
> > when CLI is not sufficient to create EPYC cpu.
> > 
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg728536.html
> > 
> > Migration might fall into the same category.
> > Also looking at the history, 5.0 commit 
> >   247b18c593ec29 target/i386: Enable new apic id encoding for EPYC based cpus models
> > silently broke APIC ID (without versioning), for all EPYC models (that's were 1 new and 1 old one).
> > 
> > (I'm not aware of somebody complaining about it)
> > 
> > Another commit ed78467a21459, changed CPUID_8000_001E without versioning as well.
> > 
> > 
> > With current EPYC apicid code, if all starts align (no numa or 1 numa node only on
> > CLI and no -smp dies=) it might produce a valid CPU (apicid+CPUID_8000_001E).
> > No numa is gray area, since EPYC spec implies that it has to be numa machine in case of real EPYC cpus.
> > Multi-node configs would be correct only if user assigns cpus to numa nodes
> > by duplicating internal node_id algorithm that this series removes.
> > 
> > There might be other broken cases that I don't recall anymore
> > (should be mentioned in previous versions of this series)
> > 
> > 
> > To summarize from migration pov (ignoring ed78467a21459 change):
> > 
> >  1) old qemu pre-5.0 ==>  qemu 5.0, 5.1 - broken migration  
> 
> Oh ....
> 
> >  2) with this series (lets call it qemu 5.2)
> >      pre-5.0 ==> qemu 5.2 - should work as series basically rollbacks current code to pre-5.0
> >      qemu 5.0, 5.1 ==> qemu 5.2 - broken
> > 
> > It's all about picking which poison to choose,
> > I'd preffer 2nd case as it lets drop a lot of complicated code that
> > doesn't work as expected.  
> 
> I think that would make our lives easier for other reasons; so I'm happy
> to go with that.

to make things less painful for users, me wonders if there is a way
to block migration if epyc and specific QEMU versions are used?

> > PS:
> >  I didn't review it yet, but with this series we aren't
> >  making up internal node_ids that should match user provided numa node ids somehow.
> >  It seems series lost the patch that would enforce numa in case -smp dies>1,
> >  but otherwise it heads in the right direction.  
> 
> Dave
> 
> > > 
> > > Dave
> > >   
> >   


