Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01108C55179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDA9206CB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODeubZ5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDA9206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafD0-0008TT-3z
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kafBF-0007ew-4a
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kafBC-0004yE-TJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604582392;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yufJ1SOiAwG/m0d83XaULBWTFeXmsfD2/LbTgPMhwIA=;
 b=ODeubZ5mm0HUCT43hE4zzDU77eyzK677wDB3G7quB7CgMJDcAjCDFlGYHLVvXu3g8xU2nJ
 iKpJvYjTj7nlJrqJcaSOk9J417hSTbov8siRlNRtzliCsLWIjbSgoWU07R/iCtGlnumIVz
 k6tfdJwrhCQa/QwQWVRS0dVLAFyUATM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-I_ABeJKuMv6t2avgYTLOeg-1; Thu, 05 Nov 2020 08:19:50 -0500
X-MC-Unique: I_ABeJKuMv6t2avgYTLOeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BE44188C122;
 Thu,  5 Nov 2020 13:19:49 +0000 (UTC)
Received: from redhat.com (ovpn-115-13.ams2.redhat.com [10.36.115.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 285AA7512B;
 Thu,  5 Nov 2020 13:19:41 +0000 (UTC)
Date: Thu, 5 Nov 2020 13:19:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 0/6] eBPF RSS support for virtio-net
Message-ID: <20201105131938.GK630142@redhat.com>
References: <20201102185115.7425-1-andrew@daynix.com>
 <0164a42f-4542-6f3e-bd71-3319dfaae190@redhat.com>
 <CAOEp5Oe3btwgPcOA6v=kK9s2to=x2Hg6Qw2iCFXOOWZs49s=-Q@mail.gmail.com>
 <caa38709-88f1-bd6d-3ff9-61e64c3aa51f@redhat.com>
 <20201104093155.GB565323@redhat.com>
 <cc53c09c-9b3c-63e1-6df3-b5fc949e626c@redhat.com>
 <20201105100109.GE630142@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201105100109.GE630142@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 05, 2020 at 10:01:09AM +0000, Daniel P. Berrangé wrote:
> On Thu, Nov 05, 2020 at 11:46:18AM +0800, Jason Wang wrote:
> > 
> > On 2020/11/4 下午5:31, Daniel P. Berrangé wrote:
> > > On Wed, Nov 04, 2020 at 10:07:52AM +0800, Jason Wang wrote:
> > > > On 2020/11/3 下午6:32, Yuri Benditovich wrote:
> > > > > 
> > > > > On Tue, Nov 3, 2020 at 11:02 AM Jason Wang <jasowang@redhat.com
> > > > > <mailto:jasowang@redhat.com>> wrote:
> > > > > 
> > > > > 
> > > > >      On 2020/11/3 上午2:51, Andrew Melnychenko wrote:
> > > > >      > Basic idea is to use eBPF to calculate and steer packets in TAP.
> > > > >      > RSS(Receive Side Scaling) is used to distribute network packets
> > > > >      to guest virtqueues
> > > > >      > by calculating packet hash.
> > > > >      > eBPF RSS allows us to use RSS with vhost TAP.
> > > > >      >
> > > > >      > This set of patches introduces the usage of eBPF for packet steering
> > > > >      > and RSS hash calculation:
> > > > >      > * RSS(Receive Side Scaling) is used to distribute network packets to
> > > > >      > guest virtqueues by calculating packet hash
> > > > >      > * eBPF RSS suppose to be faster than already existing 'software'
> > > > >      > implementation in QEMU
> > > > >      > * Additionally adding support for the usage of RSS with vhost
> > > > >      >
> > > > >      > Supported kernels: 5.8+
> > > > >      >
> > > > >      > Implementation notes:
> > > > >      > Linux TAP TUNSETSTEERINGEBPF ioctl was used to set the eBPF program.
> > > > >      > Added eBPF support to qemu directly through a system call, see the
> > > > >      > bpf(2) for details.
> > > > >      > The eBPF program is part of the qemu and presented as an array
> > > > >      of bpf
> > > > >      > instructions.
> > > > >      > The program can be recompiled by provided Makefile.ebpf(need to
> > > > >      adjust
> > > > >      > 'linuxhdrs'),
> > > > >      > although it's not required to build QEMU with eBPF support.
> > > > >      > Added changes to virtio-net and vhost, primary eBPF RSS is used.
> > > > >      > 'Software' RSS used in the case of hash population and as a
> > > > >      fallback option.
> > > > >      > For vhost, the hash population feature is not reported to the guest.
> > > > >      >
> > > > >      > Please also see the documentation in PATCH 6/6.
> > > > >      >
> > > > >      > I am sending those patches as RFC to initiate the discussions
> > > > >      and get
> > > > >      > feedback on the following points:
> > > > >      > * Fallback when eBPF is not supported by the kernel
> > > > > 
> > > > > 
> > > > >      Yes, and it could also a lacking of CAP_BPF.
> > > > > 
> > > > > 
> > > > >      > * Live migration to the kernel that doesn't have eBPF support
> > > > > 
> > > > > 
> > > > >      Is there anything that we needs special treatment here?
> > > > > 
> > > > > Possible case: rss=on, vhost=on, source system with kernel 5.8
> > > > > (everything works) -> dest. system 5.6 (bpf does not work), the adapter
> > > > > functions, but all the steering does not use proper queues.
> > > > 
> > > > Right, I think we need to disable vhost on dest.
> > > > 
> > > > 
> > > > > 
> > > > > 
> > > > >      > * Integration with current QEMU build
> > > > > 
> > > > > 
> > > > >      Yes, a question here:
> > > > > 
> > > > >      1) Any reason for not using libbpf, e.g it has been shipped with some
> > > > >      distros
> > > > > 
> > > > > 
> > > > > We intentionally do not use libbpf, as it present only on some distros.
> > > > > We can switch to libbpf, but this will disable bpf if libbpf is not
> > > > > installed
> > > > 
> > > > That's better I think.
> > > > 
> > > > 
> > > > >      2) It would be better if we can avoid shipping bytecodes
> > > > > 
> > > > > 
> > > > > 
> > > > > This creates new dependencies: llvm + clang + ...
> > > > > We would prefer byte code and ability to generate it if prerequisites
> > > > > are installed.
> > > > 
> > > > It's probably ok if we treat the bytecode as a kind of firmware.
> > > That is explicitly *not* OK for inclusion in Fedora. They require that
> > > BPF is compiled from source, and rejected my suggestion that it could
> > > be considered a kind of firmware and thus have an exception from building
> > > from source.
> > 
> > 
> > Please refer what it was done in DPDK:
> > 
> > http://git.dpdk.org/dpdk/tree/doc/guides/nics/tap.rst#n235
> > 
> > I don't think what proposed here makes anything different.
> 
> I'm not convinced that what DPDK does is acceptable to Fedora either
> based on the responses I've received when asking about BPF handling
> during build.  I wouldn't suprise me, however, if this was simply
> missed by reviewers when accepting DPDK into Fedora, because it is
> not entirely obvious unless you are looking closely.

FWIW, I'm pushing back against the idea that we have to compile the
BPF code from master source, as I think it is reasonable to have the
program embedded as a static array in the source code similar to what
DPDK does.  It doesn't feel much different from other places where apps
use generated sources, and don't build them from the original source
every time. eg "configure" is never re-generated from "configure.ac"
by Fedora packagers, they just use the generated "configure" script
as-is.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


