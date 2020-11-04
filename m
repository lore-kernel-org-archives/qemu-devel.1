Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B689FC388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2102F21734
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQwaob0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2102F21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHXp-0004OA-W3
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaHWj-0003tm-Bq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:04:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaHWg-0006bZ-7m
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604491467;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MI4HWzozLrw5rMkkfrDETj6QGfsH+m2yXliyHO4l6aY=;
 b=SQwaob0wdgf7BFShaVuBJma4iBVOwO73sGlhelj2W62Ti2aaVR513iaoFD4+R+dQVY5qGM
 wClDBiwrubPpJXTW3noIrv99dO+pYvDYtBEfX34dChWr/aa+OISlLD1KlLuTArevpOAbJ4
 h4FmiUfRv4/1CeHC5R6uaNEhi9VNGqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-rMTZ9MLdNyysYIZK_e0zrg-1; Wed, 04 Nov 2020 07:04:26 -0500
X-MC-Unique: rMTZ9MLdNyysYIZK_e0zrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B04E58015FB;
 Wed,  4 Nov 2020 12:04:24 +0000 (UTC)
Received: from redhat.com (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 517865B4AE;
 Wed,  4 Nov 2020 12:04:19 +0000 (UTC)
Date: Wed, 4 Nov 2020 12:04:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [RFC PATCH 0/6] eBPF RSS support for virtio-net
Message-ID: <20201104120415.GH565323@redhat.com>
References: <20201102185115.7425-1-andrew@daynix.com>
 <0164a42f-4542-6f3e-bd71-3319dfaae190@redhat.com>
 <CAOEp5Oe3btwgPcOA6v=kK9s2to=x2Hg6Qw2iCFXOOWZs49s=-Q@mail.gmail.com>
 <caa38709-88f1-bd6d-3ff9-61e64c3aa51f@redhat.com>
 <CAOEp5OciCLsKtnZ=mYavaFbePBwh7VWVg9NyFrns6zy18YKC=w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OciCLsKtnZ=mYavaFbePBwh7VWVg9NyFrns6zy18YKC=w@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 04, 2020 at 01:49:05PM +0200, Yuri Benditovich wrote:
> On Wed, Nov 4, 2020 at 4:08 AM Jason Wang <jasowang@redhat.com> wrote:
> 
> >
> > On 2020/11/3 下午6:32, Yuri Benditovich wrote:
> > >
> > >
> > > On Tue, Nov 3, 2020 at 11:02 AM Jason Wang <jasowang@redhat.com
> > > <mailto:jasowang@redhat.com>> wrote:
> > >
> > >
> > >     On 2020/11/3 上午2:51, Andrew Melnychenko wrote:
> > >     > Basic idea is to use eBPF to calculate and steer packets in TAP.
> > >     > RSS(Receive Side Scaling) is used to distribute network packets
> > >     to guest virtqueues
> > >     > by calculating packet hash.
> > >     > eBPF RSS allows us to use RSS with vhost TAP.
> > >     >
> > >     > This set of patches introduces the usage of eBPF for packet
> > steering
> > >     > and RSS hash calculation:
> > >     > * RSS(Receive Side Scaling) is used to distribute network packets
> > to
> > >     > guest virtqueues by calculating packet hash
> > >     > * eBPF RSS suppose to be faster than already existing 'software'
> > >     > implementation in QEMU
> > >     > * Additionally adding support for the usage of RSS with vhost
> > >     >
> > >     > Supported kernels: 5.8+
> > >     >
> > >     > Implementation notes:
> > >     > Linux TAP TUNSETSTEERINGEBPF ioctl was used to set the eBPF
> > program.
> > >     > Added eBPF support to qemu directly through a system call, see the
> > >     > bpf(2) for details.
> > >     > The eBPF program is part of the qemu and presented as an array
> > >     of bpf
> > >     > instructions.
> > >     > The program can be recompiled by provided Makefile.ebpf(need to
> > >     adjust
> > >     > 'linuxhdrs'),
> > >     > although it's not required to build QEMU with eBPF support.
> > >     > Added changes to virtio-net and vhost, primary eBPF RSS is used.
> > >     > 'Software' RSS used in the case of hash population and as a
> > >     fallback option.
> > >     > For vhost, the hash population feature is not reported to the
> > guest.
> > >     >
> > >     > Please also see the documentation in PATCH 6/6.
> > >     >
> > >     > I am sending those patches as RFC to initiate the discussions
> > >     and get
> > >     > feedback on the following points:
> > >     > * Fallback when eBPF is not supported by the kernel
> > >
> > >
> > >     Yes, and it could also a lacking of CAP_BPF.
> > >
> > >
> > >     > * Live migration to the kernel that doesn't have eBPF support
> > >
> > >
> > >     Is there anything that we needs special treatment here?
> > >
> > > Possible case: rss=on, vhost=on, source system with kernel 5.8
> > > (everything works) -> dest. system 5.6 (bpf does not work), the
> > > adapter functions, but all the steering does not use proper queues.
> >
> >
> > Right, I think we need to disable vhost on dest.
> >
> >
> Is this acceptable to disable vhost at time of migration?
> 
> 
> > >
> > >
> > >
> > >     > * Integration with current QEMU build
> > >
> > >
> > >     Yes, a question here:
> > >
> > >     1) Any reason for not using libbpf, e.g it has been shipped with some
> > >     distros
> > >
> > >
> > > We intentionally do not use libbpf, as it present only on some distros.
> > > We can switch to libbpf, but this will disable bpf if libbpf is not
> > > installed
> >
> >
> > That's better I think.
> >
> 
> We think the preferred way is to have an eBPF code built-in in QEMU (not
> distribute it as a separate file).
> 
> Our initial idea was to not use the libbpf because it:
> 1. Does not create additional dependency during build time and during
> run-time
> 2. Gives us smaller footprint of loadable eBPF blob inside qemu
> 3. Do not add too much code to QEMU
> 
> We can switch to libbpf, in this case:
> 1. Presence of dynamic library is not guaranteed on the target system

Again if a distro or users wants to use this feature in
QEMU they should be expected build the library.

> 2. Static library is large

QEMU doesn't support static linking for system emulators.  It may
happen to work at times but there's no expectations in this respect.

> 3. libbpf uses eBPF ELF which is significantly bigger than just the array
> or instructions (May be we succeed to reduce the ELF to some suitable size
> and still have it built-in)
> 
> Please let us know whether you still think libbpf is better and why.

It looks like both CLang and GCC compilers for BPF are moving towards
a world where they use BTF to get compile once, run everywhere portability
for the compiled bytecode. IIUC the libbpf is what is responsible for
processing the BTF data when loading it into the running kernel. This
all looks like a good thing in general. 

If we introduce BPF to QEMU without using libbpf, and then later decide
we absolutely need libbpf features, it creates an upgrade back compat
issue for existing deployments. It is better to use libbpf right from
the start, so we're set up to take full advantage of what it offers
long term.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


