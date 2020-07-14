Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8753DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509EA217D8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iueBlpO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509EA217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHWZ-0007KQ-L1
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvHVz-0006rT-NR
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:46:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvHVx-00032r-LY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594719976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x3uMT+vyI58q59fGQgAWJwSZazD5TzwgzDG1KUvJg+c=;
 b=iueBlpO8/8E/72F9fO57h9CPi0asM7pkHBGK8NG2cxy4/GvWT7KOHGSoZjCk8gsog08SaO
 uoK/h3cNvshOR4AzdrnPEUWWELYHYJX9DcNxk2U24HpjKRWGgOYLsAG+MyIHcXr6TPKFPv
 BD+1B1xPXqeqQfflnAsAIUxb+ZCmOtk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-hizY7nnYNi61W36VdmJauQ-1; Tue, 14 Jul 2020 05:46:12 -0400
X-MC-Unique: hizY7nnYNi61W36VdmJauQ-1
Received: by mail-wr1-f69.google.com with SMTP id y16so20897748wrr.20
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=x3uMT+vyI58q59fGQgAWJwSZazD5TzwgzDG1KUvJg+c=;
 b=TQXaFwFBx2YqN/FWbmqFS6YZqp7fgxsJOSWHN/4qmJ1yQ6sNQx9cNNLSn6Shnw2cLz
 q/7nJvVL/XylxnVZJcMdECZz/IdKhM04vqHfmDNp15k8RjDAiQT5o4XFt3uJgVstaNjR
 hcqbpDOgmNDCQnGqpBV48cUNNTRoNmzZ44Gv8HrglaQgqHkpkNo9GeL36owo0GTbWqMY
 +rMdIvmj0QOekOUFmIcKlRPu28r9GqLUmZ3DKP6fMsOlIkM/11m7aqMbCHamGLEAx4qW
 ntq2h9C0fqAH+5y/fX2w3FtzhNrz+waBtzL+1+QmmBA3au/pziUZmJYy3RZ98S5yd3D6
 7qsQ==
X-Gm-Message-State: AOAM530NnonJhQgArvTf4NCnvOf4jv/0k4fYK5hgFfbE4bzJSwVIrZBn
 ahNxcFDhIS/zULYTMhNdLyLPo3hHbiPyTb7SJGpTcL1VP4e0UYuIqO4bUwXHeRMOKJSSnRoXYNn
 mscb+YmF/txIQuSs=
X-Received: by 2002:a1c:7416:: with SMTP id p22mr3436204wmc.32.1594719971404; 
 Tue, 14 Jul 2020 02:46:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1FTz1TGp6WeemjGdpyAy/UMengeRO/qbBGk/z1HQrtdvwNCHLhUDTK62tMz4uwjQAcPzS2Q==
X-Received: by 2002:a1c:7416:: with SMTP id p22mr3436170wmc.32.1594719971117; 
 Tue, 14 Jul 2020 02:46:11 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id b10sm3355872wmj.30.2020.07.14.02.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:46:10 -0700 (PDT)
Date: Tue, 14 Jul 2020 05:46:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH 0/1] MAINTAINERS: add security quotient field
Message-ID: <20200714053258-mutt-send-email-mst@kernel.org>
References: <20200714083631.888605-1-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200714083631.888605-1-ppandit@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 02:06:30PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Hello,
> 
> QEMU supports numerous virtualisation and emulation use cases.
> It offers many features to support guest's function(s).
> 
> All of these use cases and features are not always security relevant.
> Because some maybe used in trusted environments only. Some may still
> be in experimental stage. While other could be very old and not
> used or maintained actively.
> 
> Recently we received multiple security issue reports against VVFAT
> and VirtFS host directory sharing system. After discussing with the
> respective maintainers, it turned out that
> 
> * VVFAT -> https://bugs.launchpad.net/qemu/+bug/1883083
>   VVFAT is quite old and is available for testing purposes only.
>   Ie. It is not suitable for production environments.
> 
> * VirtFS/9pfs -> https://wiki.qemu.org/Documentation/9psetup
>   VirtFS implementation though better, it is most commonly used for
>   automated testing under sand-boxed server environments, ie. no
>   malicious party there. It is also not mature enough for cloud services.
>   It is supported on 'Odd Fixes' basis atm.
> 
> So these turned out to be issues which can be fixed as regular bugs.
> 
> For security bug analysis we generally consider use cases wherein
> QEMU is used in conjunction with the KVM hypervisor, which enables
> guest to use hardware processor's virtualisation features.
> 
> This patch introduces the CVE (or Security or Trust) Quotient field
> in the MAINTAINERS file. It tries to capture the security sensitivity
> pertaining to a feature or section of the QEMU's code base.
> 
> It indicates whether a potential issue should be treated as a security
> one OR it could be fixed as a regular non-security bug.
> 
>     If Quotient == High, triage issues as potential security ones.
>     if Quotient == Low,  triage issues as regular non-security bugs.
> 
> I have tagged each section in the MAINTAINERS file as High or Low on best
> guess basis. I request respective maintainers to kindly review it please.
> 
> If you have any inputs/suggestions, I'd really appreciate them.
> 
> Thank you.

So this attempts to specify a security aspect of specific files.
Which works for some use-cases (e.g. devices) but not others
(common utility functions).

I'd like to propose add a flag that limits QEMU to a secured subset
of functionality at runtime instead.
Then we can just tell security researchers "reproduce this with
-security=high or it's not a security issue".


> --
> Prasad J Pandit (1):
>   MAINTAINERS: introduce cve or security quotient field
> 
>  MAINTAINERS | 324 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 324 insertions(+)
> 
> --
> 2.26.2


