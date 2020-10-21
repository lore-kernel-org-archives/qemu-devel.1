Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B931DC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADB2208B6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aqbt34uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADB2208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBoI-00049k-Lk
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVBn9-0002qd-B8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVBn5-0001S2-Af
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603277782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e9VClox/aMCbAsLb4snmDtm5g6PADUs/vI3pUaAose0=;
 b=Aqbt34ujBv/Sdls1CRiWrtgPKUfb7ozbQGEAHejLjllCHr94T2m3dF72nVJ+Hcz/ne1oIX
 EWZ+sualSanUW2wQsMccnjKBgS13p2r3nPrHb2/xMeMMQGECkRQ1A+Wcb2KqlfnhAOXqp6
 dfGXlfdXiDBDFZXQjvGsaU0UHV68dPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-2nRaOjyaPNa4CphwqGwwGg-1; Wed, 21 Oct 2020 06:56:18 -0400
X-MC-Unique: 2nRaOjyaPNa4CphwqGwwGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 516611074659;
 Wed, 21 Oct 2020 10:56:17 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B62D55784;
 Wed, 21 Oct 2020 10:56:14 +0000 (UTC)
Date: Wed, 21 Oct 2020 12:56:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Subject: Re: RFC: tracking valid backing chain issue
Message-ID: <20201021105612.GB8958@merkur.fritz.box>
References: <3b99657c-2016-78cb-4314-27aacb30ca3c@virtuozzo.com>
 <20201020085029.GC4452@merkur.fritz.box>
 <a996a3cc-387a-8847-17b8-72a714d47776@virtuozzo.com>
 <3fe1dd27-7720-2846-2658-e4aadab9a9ff@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <3fe1dd27-7720-2846-2658-e4aadab9a9ff@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.10.2020 um 12:29 hat Nikolay Shirokovskiy geschrieben:
> 
> 
> On 20.10.2020 13:23, Nikolay Shirokovskiy wrote:
> > 
> > 
> > On 20.10.2020 11:50, Kevin Wolf wrote:
> >> Am 20.10.2020 um 10:21 hat Nikolay Shirokovskiy geschrieben:
> >>> Hi, all.
> >>>
> >>> I recently found a corner case when it is impossible AFAIK to find out valid
> >>> backing chain after block commit operation. Imagine committing top image. After
> >>> commit ready state pivot is sent and then mgmt crashed. So far so good. Upon
> >>> next start mgmt can either check block job status for non-autodissmised job or
> >>> inspect backing chain to infer was pivot was successful or not in case of older
> >>> qemu.
> >>>
> >>> But imagine after mgmt crash qemu process was destroyed too. In this case there
> >>> is no option to know now what is valid backing chain. Yeah libvirt starts qemu
> >>> process with -no-shutdown flags so process is not destroyed in case of shutdown
> >>> but still process can crash.
> >>
> >> I don't think this is a problem.
> >>
> >> Between completion of the job and finalising it, both the base node and
> >> the top node are equivalent. You can access either and you'll always get
> >> the same data.
> >>
> >> So if libvirt didn't save that the job was already completed, it will
> >> use the old image file, and it's fine. And if libvirt already sent the
> >> job-finalize command, it will first have saved that the job was
> >> completed and therefore use the new image, and it's fine, too.
> > 
> > So finalizing can't fail? Otherwise libvirt can save that job is completed and
> > graph is changed while is was really wasn't
> 
> Hmm, it is even not the matter of qemu. Libvirt can save that job is completed
> and then crash before sending command to finalize to qemu. So after qemu crash
> and libvirt start libvirt would think that valid backing chain is without
> top image which is not true.

Why not? During this time the top and base image are equally valid to be
used as the active image.

If QEMU hadn't switched from top to base yet when it crashed, it's still
no problem if libvirt does the switch when restarting QEMU.

Kevin


