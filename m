Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE30C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CD02075B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bf2wAZjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CD02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgwtE-00084u-T0
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 16:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jgwsV-0007et-2P
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:54:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21713
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jgwsP-0003A2-Os
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591304051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tnCgk4zuHWYJDP3RnNCax34/Masi6pk4ifg41i/aYfQ=;
 b=Bf2wAZjYbqYziU6Yfu/XAGMc4rBM2/pW4hh+TzlLtOkE/7+bq3ccdzpOt/ufmaTWnm97De
 jADWepKJtTOV/rcwiy8bUbTWu6X1zr4NPN1fQozpCWxK7URz6KnBruF3058OrxJ4zBSIN2
 vDot2FQBJKPcFgLKPeOwPb4mRa4hn/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-ByKIoHGaMMaRSFkDcDjLDA-1; Thu, 04 Jun 2020 16:54:09 -0400
X-MC-Unique: ByKIoHGaMMaRSFkDcDjLDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFAAB464;
 Thu,  4 Jun 2020 20:54:07 +0000 (UTC)
Received: from localhost (ovpn-113-102.phx2.redhat.com [10.3.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F02A600FC;
 Thu,  4 Jun 2020 20:54:01 +0000 (UTC)
Date: Thu, 4 Jun 2020 16:54:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v13 1/5] i386: Add support for CPUID_8000_001E for AMD
Message-ID: <20200604205400.GE2366737@habkost.net>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
 <1528498581-131037-2-git-send-email-babu.moger@amd.com>
 <20200602175212.GH577771@habkost.net>
 <b6e22360-5fa0-9ade-624d-9de1f76b360b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e22360-5fa0-9ade-624d-9de1f76b360b@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "geoff@hostfission.com" <geoff@hostfission.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "kash@tripleback.net" <kash@tripleback.net>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 09:06:27AM -0500, Babu Moger wrote:
> 
> 
> > -----Original Message-----
> > From: Eduardo Habkost <ehabkost@redhat.com>
> > Sent: Tuesday, June 2, 2020 12:52 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> > rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com; Dr. David
> > Alan Gilbert <dgilbert@redhat.com>
> > Subject: Re: [PATCH v13 1/5] i386: Add support for CPUID_8000_001E for AMD
> > 
> > On Fri, Jun 08, 2018 at 06:56:17PM -0400, Babu Moger wrote:
> > > Add support for cpuid leaf CPUID_8000_001E. Build the config that closely
> > > match the underlying hardware. Please refer to the Processor Programming
> > > Reference (PPR) for AMD Family 17h Model for more details.
> > >
> > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > [...]
> > > +    case 0x8000001E:
> > > +        assert(cpu->core_id <= 255);
> > 
> > It is possible to trigger this assert using:
> > 
> > $ qemu-system-x86_64 -machine q35,accel=kvm,kernel-irqchip=split -device
> > intel-iommu,intremap=on,eim=on -smp
> > 1,maxcpus=258,cores=258,threads=1,sockets=1 -cpu
> > qemu64,xlevel=0x8000001e -device qemu64-x86_64-cpu,apic-id=257
> > qemu-system-x86_64: warning: Number of hotpluggable cpus requested (258)
> > exceeds the recommended cpus supported by KVM (240)
> > qemu-system-x86_64:
> > /home/ehabkost/rh/proj/virt/qemu/target/i386/cpu.c:5888: cpu_x86_cpuid:
> > Assertion `cpu->core_id <= 255' failed.
> > Aborted (core dumped)
> > 
> > See bug report and discussion at
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.
> > redhat.com%2Fshow_bug.cgi%3Fid%3D1834200&amp;data=02%7C01%7Cbabu.
> > moger%40amd.com%7C8a2724729b914bc9b53d08d8071db392%7C3dd8961fe4
> > 884e608e11a82d994e183d%7C0%7C0%7C637267171438806408&amp;sdata=ib
> > iGlF%2FF%2FVtYQLf7fe988kxFsLhj4GrRiTOq4LUuOT8%3D&amp;reserved=0
> > 
> > Also, it looks like encode_topo_cpuid8000001e() assumes core_id
> > has only 3 bits, so the existing assert() is not even sufficient.
> > We need to decide what to do if the user requests nr_cores > 8.
> > 
> > Probably omitting CPUID[0x8000001E] if the VCPU topology is
> > incompatible with encode_topo_cpuid8000001e() (and printing a
> > warning) is the safest thing to do right now.
> 
> Eduardo,  We need to generalize the encode_topo_cpuid8000001e decoding.
> We will have to remove 3 bit limitation there. It will not scale with
> latest configurations. I will take a look that.
> 
> For now, best option I think is to(like you mentioned in bug 1834200),
> declaring nr_cores > 256 as never supported (or deprecated); and throw
> warning.
> 
> What do you think?

I believe we can declare nr_cores > 256 as never supported to
address the assert failure.  Other CPUID functions also look
broken when nr_cores is too large: encode_cache_cpuid4() seems to
assume nr_cores is 128 or less.

But we still need to make nr_cores > 8 safe while
encode_topo_cpuid8000001e() is not generalized yet.

> > 
> > 
> > 
> > > +        encode_topo_cpuid8000001e(cs, cpu,
> > > +                                  eax, ebx, ecx, edx);
> > > +        break;
> > >      case 0xC0000000:
> > >          *eax = env->cpuid_xlevel2;
> > >          *ebx = 0;
> > > --
> > > 1.8.3.1
> > >
> > 
> > --
> > Eduardo
> 

-- 
Eduardo


