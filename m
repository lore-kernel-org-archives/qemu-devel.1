Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE25C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7D52073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbPiNtIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7D52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCdG-0004uz-U7
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqCcU-0004QC-IN
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:32:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqCcS-0007lc-EK
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593509519;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qauuuihELNha/F1GgD5I9Kn4EMfYLTIhDIuR7RLN7Y8=;
 b=GbPiNtIuVvMZpEo3GbgBdGi8HFjGDyPZrEyBaCjaOwelt2lhf3AWG6pSWiVEnGzgwoeu7c
 mxDxnU6EdyCG/mFdDLJaCHcQg1QIJnpN3ukb7t4qZ13TjzAgaeS6dnA1xvH7C0PmCnPorq
 FidLVFxXHDT+hPIHi4mBT+tTb3NnbOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-3dkgt2AGMXqVx8ZrnHpj2g-1; Tue, 30 Jun 2020 05:31:57 -0400
X-MC-Unique: 3dkgt2AGMXqVx8ZrnHpj2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA9CD1005512;
 Tue, 30 Jun 2020 09:31:56 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A73CC60C81;
 Tue, 30 Jun 2020 09:31:51 +0000 (UTC)
Date: Tue, 30 Jun 2020 10:31:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] net: tap: check if the file descriptor is valid before
 using it
Message-ID: <20200630093148.GF1370404@redhat.com>
References: <20200624190009.300069-1-lvivier@redhat.com>
 <20200625084835.GB1009994@redhat.com>
 <541b40c5-ee72-d37d-1c30-664775812d1b@redhat.com>
 <929203d2-20d2-7caf-e487-6bfe5b851974@redhat.com>
 <ea94fa3c-edb5-220e-e0e0-4b7fca7b90e8@redhat.com>
 <b912e24c-8dc5-7022-6ed2-cf10d72ef6e7@redhat.com>
 <20200630092318.GE1370404@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630092318.GE1370404@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 10:23:18AM +0100, Daniel P. Berrangé wrote:
> On Tue, Jun 30, 2020 at 05:21:49PM +0800, Jason Wang wrote:
> > 
> > On 2020/6/30 上午3:30, Laurent Vivier wrote:
> > > On 28/06/2020 08:31, Jason Wang wrote:
> > > > On 2020/6/25 下午7:56, Laurent Vivier wrote:
> > > > > On 25/06/2020 10:48, Daniel P. Berrangé wrote:
> > > > > > On Wed, Jun 24, 2020 at 09:00:09PM +0200, Laurent Vivier wrote:
> > > > > > > qemu_set_nonblock() checks that the file descriptor can be used and, if
> > > > > > > not, crashes QEMU. An assert() is used for that. The use of assert() is
> > > > > > > used to detect programming error and the coredump will allow to debug
> > > > > > > the problem.
> > > > > > > 
> > > > > > > But in the case of the tap device, this assert() can be triggered by
> > > > > > > a misconfiguration by the user. At startup, it's not a real problem,
> > > > > > > but it
> > > > > > > can also happen during the hot-plug of a new device, and here it's a
> > > > > > > problem because we can crash a perfectly healthy system.
> > > > > > If the user/mgmt app is not correctly passing FDs, then there's a whole
> > > > > > pile of bad stuff that can happen. Checking whether the FD is valid is
> > > > > > only going to catch a small subset. eg consider if fd=9 refers to the
> > > > > > FD that is associated with the root disk QEMU has open. We'll fail to
> > > > > > setup the TAP device and close this FD, breaking the healthy system
> > > > > > again.
> > > > > > 
> > > > > > I'm not saying we can't check if the FD is valid, but lets be clear that
> > > > > > this is not offering very much protection against a broken mgmt apps
> > > > > > passing bad FDs.
> > > > > > 
> > > > > I agree with you, but my only goal here is to avoid the crash in this
> > > > > particular case.
> > > > > 
> > > > > The punishment should fit the crime.
> > > > > 
> > > > > The user can think the netdev_del doesn't close the fd, and he can try
> > > > > to reuse it. Sending back an error is better than crashing his system.
> > > > > After that, if the system crashes, it will be for the good reasons, not
> > > > > because of an assert.
> > > > 
> > > > Yes. And on top of this we may try to validate the TAP via st_dev
> > > > through fstat[1].
> > > I agree, but the problem I have is to know which major(st_dev) we can
> > > allow to use.
> > > 
> > > Do we allow only macvtap major number?
> > 
> > 
> > Macvtap and tuntap.
> > 
> > 
> > > How to know the macvtap major number at user level?
> > > [it is allocated dynamically: do we need to parse /proc/devices?]
> > 
> > 
> > I think we can get them through fstat for /dev/net/tun and /dev/macvtapX.
> 
> Don't assume QEMU has any permission to access to these device nodes,
> only the pre-opened FDs it is given by libvirt.

Actually permissions are the least of the problem - the device nodes
won't even exist, because QEMU's almost certainly running in a private
mount namespace with a minimal /dev populated

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


