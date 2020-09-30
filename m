Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C24FC47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A3A2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKFsfmQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A3A2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZK8-0003hy-B9
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kNZ8p-0005nl-G4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kNZ8m-0006C9-TI
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:15:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601460913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ks/aJ9dfs4yeOquUSsUVXAu7XHSkkkV+oVkr8iCTLCE=;
 b=fKFsfmQNcDzdV8pyHjotIa4lOLJY6wD8fBdMsqjyIOOIc7wevsK+wLD/44LSOMtYjgZQI1
 SIJV4keopxX6E4bYcbH2AMX7C/fSRTjjtr5Vf0Wh3L4trgdKgsNiGGWqe+NukipjYEpffZ
 trBGul0pQQYpz++YpDYeBxdmTHj2Fw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-0YZIjiTqMgGFg1yu_K5Hrg-1; Wed, 30 Sep 2020 06:14:29 -0400
X-MC-Unique: 0YZIjiTqMgGFg1yu_K5Hrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 754551DE02;
 Wed, 30 Sep 2020 10:14:27 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 887F160C05;
 Wed, 30 Sep 2020 10:14:16 +0000 (UTC)
Date: Wed, 30 Sep 2020 15:44:13 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] pci: check bus pointer before dereference
In-Reply-To: <20200930084559.6796bbd0@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2009301535480.699166@xnncv>
References: <20200827114917.1851111-1-ppandit@redhat.com>
 <CAKXe6SJNio2cy05ecr_DyB0Z6WjxHN_X8ZiOU5By0jwdRq12fg@mail.gmail.com>
 <b0859f8a-1224-66d0-7e32-091caa5cfcbe@redhat.com>
 <nycvar.YSQ.7.78.906.2009161152040.10832@xnncv>
 <CAFEAcA8Y+sJkapmrjNOdWP4xXa9kWTmSyXpthkvdb6QgUyDh5Q@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2009281616200.10832@xnncv>
 <nycvar.YSQ.7.78.906.2009301029460.10832@xnncv>
 <20200930084559.6796bbd0@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Ruhr-University <bugs-syssec@rub.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Wed, 30 Sep 2020, Igor Mammedov wrote --+
| 'dest' is offset into MemoryRegion, so far I don't see how it could break 
| into QEMU stack. Do you have a simple reproducer?

Please see:
  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Flsi_nullptr1

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


