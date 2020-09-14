Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3213AC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1B62192A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M45VUHqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1B62192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHj40-0002XN-Bt
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kHj3P-0001vZ-CA
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:37:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kHj3N-0004NH-DG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600069051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uAKxmxcTcfDfRJ5phFHr202VyC9PLeR98RvrHSc+Ze4=;
 b=M45VUHqB6w86VbNS+nN5TnnGbpISSHQE1VpOVGNdAtrLlUaT9KFNNlnPIDCKNo6qyoSYE3
 S5LaOBM8hqLng0VTQskHd+Q5A/VBPIUIO2D9Rup1j43ZIF7xqi85TkgPl98/v5MdRwLM7T
 /lxxHj7bFzhDuJtEdqdTT28NPUwPrd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-HHJoRZcdMNi5L-UOu2tbNw-1; Mon, 14 Sep 2020 03:37:30 -0400
X-MC-Unique: HHJoRZcdMNi5L-UOu2tbNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2779B1074644;
 Mon, 14 Sep 2020 07:37:29 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E70B77513A;
 Mon, 14 Sep 2020 07:37:21 +0000 (UTC)
Date: Mon, 14 Sep 2020 09:37:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, pbonzini@redhat.com
Subject: Re: [PATCH] smp: drop support for deprecated (invalid topologies)
Message-ID: <20200914093720.6c3583c7@redhat.com>
In-Reply-To: <20200911110407-mutt-send-email-mst@kernel.org>
References: <20200911133202.938754-1-imammedo@redhat.com>
 <20200911110407-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
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
Cc: libvir-list@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 11:04:47 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Sep 11, 2020 at 09:32:02AM -0400, Igor Mammedov wrote:
> > it's was deprecated since 3.1
> > 
> > Support for invalid topologies is removed, the user must ensure
> > that topologies described with -smp include all possible cpus,
> > i.e. (sockets * cores * threads) == maxcpus or QEMU will
> > exit with error.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Acked-by: 
> 
> memory tree I guess?

It would be better for Paolo to take it since he has
queued numa deprecations, due to context confilict in
deprecated.rst.

Paolo,
can you queue this patch as well?

> 
> > ---
> >  docs/system/deprecated.rst | 26 +++++++++++++-------------
> >  hw/core/machine.c          | 16 ++++------------
> >  hw/i386/pc.c               | 16 ++++------------
> >  3 files changed, 21 insertions(+), 37 deletions(-)
> > 
> > diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> > index 122717cfee..d737728fab 100644
> > --- a/docs/system/deprecated.rst
> > +++ b/docs/system/deprecated.rst
> > @@ -47,19 +47,6 @@ The 'file' driver for drives is no longer appropriate for character or host
> >  devices and will only accept regular files (S_IFREG). The correct driver
> >  for these file types is 'host_cdrom' or 'host_device' as appropriate.
> >  
> > -``-smp`` (invalid topologies) (since 3.1)
> > -'''''''''''''''''''''''''''''''''''''''''
> > -
> > -CPU topology properties should describe whole machine topology including
> > -possible CPUs.
> > -
> > -However, historically it was possible to start QEMU with an incorrect topology
> > -where *n* <= *sockets* * *cores* * *threads* < *maxcpus*,
> > -which could lead to an incorrect topology enumeration by the guest.
> > -Support for invalid topologies will be removed, the user must ensure
> > -topologies described with -smp include all possible cpus, i.e.
> > -*sockets* * *cores* * *threads* = *maxcpus*.
> > -
> >  ``-vnc acl`` (since 4.0.0)
> >  ''''''''''''''''''''''''''
> >  
> > @@ -618,6 +605,19 @@ New machine versions (since 5.1) will not accept the option but it will still
> >  work with old machine types. User can check the QAPI schema to see if the legacy
> >  option is supported by looking at MachineInfo::numa-mem-supported property.
> >  
> > +``-smp`` (invalid topologies) (removed 5.2)
> > +'''''''''''''''''''''''''''''''''''''''''''
> > +
> > +CPU topology properties should describe whole machine topology including
> > +possible CPUs.
> > +
> > +However, historically it was possible to start QEMU with an incorrect topology
> > +where *n* <= *sockets* * *cores* * *threads* < *maxcpus*,
> > +which could lead to an incorrect topology enumeration by the guest.
> > +Support for invalid topologies is removed, the user must ensure
> > +topologies described with -smp include all possible cpus, i.e.
> > +*sockets* * *cores* * *threads* = *maxcpus*.
> > +
> >  Block devices
> >  -------------
> >  
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index ea26d61237..09aee4ea52 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -754,23 +754,15 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
> >              exit(1);
> >          }
> >  
> > -        if (sockets * cores * threads > ms->smp.max_cpus) {
> > -            error_report("cpu topology: "
> > -                         "sockets (%u) * cores (%u) * threads (%u) > "
> > -                         "maxcpus (%u)",
> > +        if (sockets * cores * threads != ms->smp.max_cpus) {
> > +            error_report("Invalid CPU topology: "
> > +                         "sockets (%u) * cores (%u) * threads (%u) "
> > +                         "!= maxcpus (%u)",
> >                           sockets, cores, threads,
> >                           ms->smp.max_cpus);
> >              exit(1);
> >          }
> >  
> > -        if (sockets * cores * threads != ms->smp.max_cpus) {
> > -            warn_report("Invalid CPU topology deprecated: "
> > -                        "sockets (%u) * cores (%u) * threads (%u) "
> > -                        "!= maxcpus (%u)",
> > -                        sockets, cores, threads,
> > -                        ms->smp.max_cpus);
> > -        }
> > -
> >          ms->smp.cpus = cpus;
> >          ms->smp.cores = cores;
> >          ms->smp.threads = threads;
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index d071da787b..fbde6b04e6 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -746,23 +746,15 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
> >              exit(1);
> >          }
> >  
> > -        if (sockets * dies * cores * threads > ms->smp.max_cpus) {
> > -            error_report("cpu topology: "
> > -                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) > "
> > -                         "maxcpus (%u)",
> > +        if (sockets * dies * cores * threads != ms->smp.max_cpus) {
> > +            error_report("Invalid CPU topology deprecated: "
> > +                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) "
> > +                         "!= maxcpus (%u)",
> >                           sockets, dies, cores, threads,
> >                           ms->smp.max_cpus);
> >              exit(1);
> >          }
> >  
> > -        if (sockets * dies * cores * threads != ms->smp.max_cpus) {
> > -            warn_report("Invalid CPU topology deprecated: "
> > -                        "sockets (%u) * dies (%u) * cores (%u) * threads (%u) "
> > -                        "!= maxcpus (%u)",
> > -                        sockets, dies, cores, threads,
> > -                        ms->smp.max_cpus);
> > -        }
> > -
> >          ms->smp.cpus = cpus;
> >          ms->smp.cores = cores;
> >          ms->smp.threads = threads;
> > -- 
> > 2.27.0  
> 


