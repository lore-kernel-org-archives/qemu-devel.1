Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A71C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3530120936
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiadMN74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3530120936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN6fF-0005TF-7n
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 23:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kN6eY-0004vX-9g
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kN6eV-0004Ls-W6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:50:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601351406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iEmfgCSa2/cfGOnDBcc0Qq53X6A1RbXfAkDvON98i6o=;
 b=DiadMN74IGVu+MPIyLsUlRb9PbUIZwDe844m2BEr2nUMVT5Qae4BMCiQY45tgo29zsYsjT
 nTUyDhO+MDCU5Fr0xvGtn194CJLNzO8KxfNNcLMwa3y/dbs44jZCIjDnM+ilkflD7kzxU3
 sS8yMOJUhimnP2kK+65HJX20zWMs/c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-twANpK5ZPsySI8AXka-4Ew-1; Mon, 28 Sep 2020 23:45:00 -0400
X-MC-Unique: twANpK5ZPsySI8AXka-4Ew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF0D6801AE3;
 Tue, 29 Sep 2020 03:44:58 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C3C8277DB;
 Tue, 29 Sep 2020 03:44:58 +0000 (UTC)
Date: Mon, 28 Sep 2020 23:44:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Kang, Luwei" <luwei.kang@intel.com>
Subject: Re: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Message-ID: <20200929034456.GH3717385@habkost.net>
References: <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200925165415.GT3717385@habkost.net>
 <036ba624-670c-d6b7-721c-ad5c9d648c1f@redhat.com>
 <20200925202956.GV3717385@habkost.net>
 <db31a0fa-c6cf-4730-6d64-f81228948d30@redhat.com>
 <CY4PR11MB1447C4CA6B6D455EE33F724D80350@CY4PR11MB1447.namprd11.prod.outlook.com>
 <d85a3245-c774-5098-5d14-2e3b3a2eda18@redhat.com>
 <CY4PR11MB1447BB55E8AF4915CD56655980350@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200928141228.GW3717385@habkost.net>
 <CY4PR11MB1447410A5DFEDEEEC51A2A9780320@CY4PR11MB1447.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB1447410A5DFEDEEEC51A2A9780320@CY4PR11MB1447.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Strong,
 Beeman" <beeman.strong@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 02:28:48AM +0000, Kang, Luwei wrote:
> > > > >>>> No, it's not possible.  KVM doesn't have a say on what the
> > > > >>>> processor writes in the tracing packets.
> > > > >>> Can KVM refuse to enable packet generation if CSbase is not zero
> > > > >>> and CPUID.(EAX=14H,ECX=0)[bit 31] seen by guest is different from
> > host?
> > > > >>
> > > > >> Yes, but the processor could change operating mode (and hence
> > > > >> CSbase) while tracing is active.  This is very unlikely, since it
> > > > >> would require nonzero CS-base and a 32-bit host, but in principle
> > > > >> not impossible (could be a firmware call, for example).
> > > > >>
> > > > >> The only solution is for KVM to accept both, and for QEMU to
> > > > >> refuse a setting that does not match the host.
> > > > >>
> > > > >
> > > > > So I need to add a patch in KVM to disabled the Intel PT when the
> > > > > CSbase is not zero and the guest LIP different from the host. And
> > > > > this limitation in qemu (disabled the PT when LIP is enabled in
> > > > > the host) can be remove. Is that right?
> > > >
> > > > No, if a feature cannot be emulated, that means it cannot be enabled
> > > > unless it matches the host.  That's generally not a problem since
> > > > Intel PT is usually used only with "-cpu host".
> > > >
> > >
> > > The limitation of LIP in qemu will mask off the Intel PT in KVM guest
> > > even with "-cpu host". e.g. This bit will be set in SnowRidge HW and
> > > later.
> > 
> > This behavior can and should be changed.
> > 
> > >
> > > How about "-cpu cpu_model, +intel-pt" use case? The current value of
> > > Intel PT CPUID is a constant. Can we make the ICX CPUID as basic
> > > inforation(LIP is 0) and using "+intel-pt-lip"
> > > to make Intel PT work on the CPU which LIP is 1 on the host? As you
> > > mentioned before, Intel PT cannot be enabled in guest unless it
> > > matches the host.
> > 
> > This makes sense, but you can also make each CPU model set a default for the
> > LIP bit.  "-cpu SnowRidge,+intel-pt" could set
> > LIP=1 by default.
> 
> I have a question on how to set LIP=1 in SnowRidge by default. 
> 1. Set LIP in "builtin_x86_defs[]" SnowRidge CPU model. The LIP included in CPUID.(eax=14x,ecx=0)ecx[bit31] and a new leaf needs to be added.
> 2. Checking the CPU model in the later software flow and set the LIP bit if the CPU model is Snowridge. And we also need to add more CPU model's checking for new CPUs.
> 
> What is your opinion?
> 

1 is preferred.  Any CPU-model-specific data should be
represented as data inside builtin_x86_defs, not code.

-- 
Eduardo


