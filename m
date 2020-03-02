Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C07C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2684E21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSu2o5+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2684E21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kG6-0006PM-BM
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j8kFI-0005hY-RQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j8kFH-00064k-UD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:32:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j8kFH-000646-Qf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583152346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ZYlFsjgZkWhr6ABExReOoPa5md/+qAKcLtQu3csC/w=;
 b=KSu2o5+S1rU9eXV9G7reYYumOU2XxdnXh5Cptd/RyDrDhx2e6F2qcCb2nBz+NQJNWYp8LV
 YSq2DOUaTmsYHfbNWHECP9Q9q4wwTQVtqaDeZKW9cJonSon3TAL67I2xF5d6RuKWcziv9A
 9CffO+zzACiBDqKBlImhSUNusNvvwjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-ZKdfylv9MG-_YRDxcWGe7A-1; Mon, 02 Mar 2020 07:32:25 -0500
X-MC-Unique: ZKdfylv9MG-_YRDxcWGe7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1D35800D6C;
 Mon,  2 Mar 2020 12:32:23 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C128C91D6C;
 Mon,  2 Mar 2020 12:32:21 +0000 (UTC)
Date: Mon, 2 Mar 2020 12:32:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [edk2-devel] A problem with live migration of UEFI virtual
 machines
Message-ID: <20200302123219.GE2798@work-vm>
References: <tencent_BC7FD00363690990994E90F8@qq.com>
 <87sgjhxbtc.fsf@zen.linaroharston>
 <20200224152810.GX635661@redhat.com>
 <8b0ec286-9322-ee00-3729-6ec7ee8260a6@redhat.com>
 <3E8BB07B-8730-4AB8-BCB6-EA183FB589C5@apple.com>
 <465a5a84-cac4-de39-8956-e38771807450@redhat.com>
 <8F42F6F1-A65D-490D-9F2F-E12746870B29@apple.com>
 <6666a886-720d-1ead-8f7e-13e65dcaaeb4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6666a886-720d-1ead-8f7e-13e65dcaaeb4@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: berrange@redhat.com, devel@edk2.groups.io, Andrew Fish <afish@apple.com>,
 qemu-devel@nongnu.org, zhoujianjay <zhoujianjay@gmail.com>,
 discuss <discuss@edk2.groups.io>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 wuchenye1995 <wuchenye1995@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laszlo Ersek (lersek@redhat.com) wrote:

> The interesting question is, what happens when you power down the VM on
> the destination host (=3D post migration), and launch it again there, fro=
m
> zero. In that case, the firmware executable file comes from the
> *destination host* (it was never persistently migrated from the source
> host, i.e. never written out on the dst). It simply comes from the OVMF
> package that had been installed on the destination host, by the
> sysadmin. However, the varstore pflash does reflect the permanent result
> of the previous migration. So this is where things can fall apart, if
> both firmware binaries (on the src host and on the dst host) don't agree
> about the internal structure of the varstore pflash.

My guess is that overtime we're going to need to find a way to handle
this, otherwise we're going to find people having to maintain old
versions of OVMF just to keep variable store compatiiblity.

Dave

> Thanks
> Laszlo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


