Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A40AC43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A915520B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5Lb2aTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A915520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMXx-0007du-LA
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKMVy-00067m-Pl
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKMVu-0000Q2-5Q
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600697392;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFbaDCKyhtAolPKogznx7buXOckNJ3eKUugLxLMHalA=;
 b=O5Lb2aTVOBCCvEdmRzNHhmRXOEn0kQvoo83Sg1iR87/YUu6Mg3jIcOdYSee7P5Hv230Ksh
 ZZKQBWeHScoH0K2e3oBxEFXSOehm3JqQEBsJ6DaZ7g2OnVPVMc8JyiDiXN4Y4p5rJqOS/H
 Enr+9QhdgILmgeWe6z+GwmGWrsb0znE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-RNwxcw1ZOeK_V6wfnp5bZA-1; Mon, 21 Sep 2020 10:09:50 -0400
X-MC-Unique: RNwxcw1ZOeK_V6wfnp5bZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 128B4801AE1;
 Mon, 21 Sep 2020 14:09:49 +0000 (UTC)
Received: from redhat.com (ovpn-113-113.ams2.redhat.com [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CE7210013D0;
 Mon, 21 Sep 2020 14:09:48 +0000 (UTC)
Date: Mon, 21 Sep 2020 15:09:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Lieven <pl@kamp.de>
Subject: Re: Limiting per vCPU Usage
Message-ID: <20200921140945.GO1942072@redhat.com>
References: <68336702-cedc-dc38-3d18-d153cd7652dd@kamp.de>
 <20200921082950.GF1942072@redhat.com>
 <ddc410b9-2c15-4398-86a9-df3441e62138@kamp.de>
MIME-Version: 1.0
In-Reply-To: <ddc410b9-2c15-4398-86a9-df3441e62138@kamp.de>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 03:47:56PM +0200, Peter Lieven wrote:
> Am 21.09.20 um 10:29 schrieb Daniel P. Berrangé:
> > On Sun, Sep 20, 2020 at 10:24:41PM +0200, Peter Lieven wrote:
> > > Hi Qemu folks,
> > > 
> > > 
> > > is there a BCP to limit just the maximum usage of a virtual (KVM) cpu?
> > > 
> > > I know that there are many approaches, but as far as I know they all limit the complete qemu process which is far more
> > > 
> > > than just the virtual CPUs.
> > > 
> > > Is it possible to limit just the vCPU threads and leave threads that
> > > handle the monitor, vnc, qmp, iothreads, storage backend etc.
> > Libvirt uses cgroups to achieve what you describe. A cgroup for the
> > QEMU process as a whole, then create child cgroups, one for each
> > vCPUs, and a further one for non-vCPU threads. CPU limits are then
> > applied on the child cgroups.
> 
> 
> Hi Daniel,
> 
> 
> I came up with the same solution. Is there a nice way to get the thread ids of the vCPUs?
> 
> Iterating over all thread IDs and check the names works, but the thread names are not considered
> 
> a stable API (text from original commit message).

The QMP  query-cpus  command tells you thread IDs. There is similar for
I/O threads too.  This is what libvirt uses to determine the mappings.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


