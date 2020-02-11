Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED80C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E89D20661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjzH70fu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E89D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZgS-0007Au-CK
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j1Zdq-0004jU-Fv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j1Zdn-0003M8-Bc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:48:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52058
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j1Zdm-0003IN-Ne
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581443285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHIK+IUQ7Bhn/dm4uCHzoBDYxpQmm2w1eMkChDlMgr8=;
 b=SjzH70fumKRxFFYHQE6stX+YrENv6iniw7EKTXsFwrYreF64D435yLt+Y1CozO+n8ucStw
 z9oFeML7T5YVEm2fVzyPrihqR5vc/apCRv92u4eTT9RGzTWZJf8FivxcniT3eJROCKxTde
 9IkKagoj5F7ebkKjesALqyTrCEpaAe4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-5cZUI5QDPuWIaxAcltJ0Fw-1; Tue, 11 Feb 2020 12:48:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C1B8017CC;
 Tue, 11 Feb 2020 17:48:00 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03A6F88854;
 Tue, 11 Feb 2020 17:47:58 +0000 (UTC)
Date: Tue, 11 Feb 2020 17:47:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel Cho <danielcho@qnap.com>, chen.zhang@intel.com,
 zhang.zhanghailiang@huawei.com
Subject: Re: The issues about architecture of the COLO checkpoint
Message-ID: <20200211174756.GA2798@work-vm>
References: <CA+XQNE44kZjcw=0dtzaS4HwbPcRG6GpcQ3g3QfL5VS84EBWS_g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+XQNE44kZjcw=0dtzaS4HwbPcRG6GpcQ3g3QfL5VS84EBWS_g@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5cZUI5QDPuWIaxAcltJ0Fw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


cc'ing in COLO people:

* Daniel Cho (danielcho@qnap.com) wrote:
> Hi everyone,
>      We have some issues about setting COLO feature. Hope somebody could
> give us some advice.
>=20
> Issue 1:
>      We dynamic to set COLO feature for PVM(2 core, 16G memory),  but the
> Primary VM will pause a long time(based on memory size) for waiting SVM
> start. Does it have any idea to reduce the pause time?
>=20
>=20
> Issue 2:
>      In https://github.com/qemu/qemu/blob/master/migration/colo.c#L503,
> could we move start_vm() before Line 488? Because at first checkpoint PVM
> will wait for SVM's reply, it cause PVM stop for a while.
>=20
>      We set the COLO feature on running VM, so we hope the running VM cou=
ld
> continuous service for users.
> Do you have any suggestions for those issues?
>=20
> Best regards,
> Daniel Cho
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


