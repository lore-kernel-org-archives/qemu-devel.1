Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C76EC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECF620773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+3nOm/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECF620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHZM-0008Mf-8n
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kNHYK-0007Ui-MB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kNHYJ-0001QX-2n
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:28:28 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601393306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hbYGLi+iDOl/Nv2UFb4sD2gZqzualza8S+3rAAO7wec=;
 b=X+3nOm/gdcvbvlQWB4E+g/aPX+CT0ZmY95L88zLjPSoNvjZAjMLTJlqylE1uFsLSnoi98u
 BWTdepxsaklZno+zTnhaVf94CEHw4BmbVkBzHCQfncPF1Gnp2lM4KJdVkL0bn7+a+M2+bF
 F+UfcZsbcOtZ5CVHJQnrogsDGHhku6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-Q0kwzmLjO9isksFE5hsd9g-1; Tue, 29 Sep 2020 11:28:18 -0400
X-MC-Unique: Q0kwzmLjO9isksFE5hsd9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BB28801AFE;
 Tue, 29 Sep 2020 15:28:17 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-167.rdu2.redhat.com [10.10.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DE987366C;
 Tue, 29 Sep 2020 15:28:13 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 10450220203; Tue, 29 Sep 2020 11:28:13 -0400 (EDT)
Date: Tue, 29 Sep 2020 11:28:12 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] virtiofs vs 9p performance(Re: tools/virtiofs: Multi
 threading seems to hurt performance)
Message-ID: <20200929152812.GF220516@redhat.com>
References: <20200918213436.GA3520@redhat.com> <20200921153243.GK3221@work-vm>
 <20200922102531.GA2837@work-vm> <20200922174733.GD57620@redhat.com>
 <46D726A6-72F3-40FE-9382-A189513F783D@intel.com>
 <20200924221023.GB132653@redhat.com>
 <20200925124139.GJ2873@work-vm>
 <20200929131753.GB220516@redhat.com>
 <CAOssrKcVNs=uiU2U1-ScowogFan8W=iw7kyTCnaz-vL8r9gLmw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOssrKcVNs=uiU2U1-ScowogFan8W=iw7kyTCnaz-vL8r9gLmw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Venegas Munoz,
 Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, "Shinde,
 Archana M" <archana.m.shinde@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 03:49:04PM +0200, Miklos Szeredi wrote:
> On Tue, Sep 29, 2020 at 3:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > - virtiofs cache=none mode is faster than cache=auto mode for this
> >   workload.
> 
> Not sure why.  One cause could be that readahead is not perfect at
> detecting the random pattern.  Could we compare total I/O on the
> server vs. total I/O by fio?

Ran tests with auto_inval_data disabled and compared with other results.

vtfs-auto-ex-randrw     randrw-psync            27.8mb/9547kb   7136/2386
vtfs-auto-sh-randrw     randrw-psync            43.3mb/14.4mb   10.8k/3709
vtfs-auto-sh-noinval    randrw-psync            50.5mb/16.9mb   12.6k/4330
vtfs-none-sh-randrw     randrw-psync            54.1mb/18.1mb   13.5k/4649

With auto_inval_data disabled, this time I saw around 20% performance jump
in READ and is now much closer to cache=none performance.

Thanks
Vivek


