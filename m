Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A37C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEDD24688
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilLEznLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEDD24688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7LSk-0008KU-IO
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7LS4-0007vE-UC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7LS3-0004Iu-Ri
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:51:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28845
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7LS3-0004IK-Ny
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582818711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a16YuaciQPm4ecwVOPrr3gpEl5wiqm1Rb7nV0ll7nuE=;
 b=ilLEznLiJG7w/spJzAD5M/FcUQ2E4rY0I6ddr3M73TVNHF1wMBZrHkGj/bIfdEplV2K+kk
 VBUh90PCC/WKa2Ur011Kgajq+ASjA7zL4tSEJYF58Ed0R7r/cVzDv+mRaeAAgxOpenqZs5
 kN0fy3Mn+XIVEv+dyx7W1zmyju51MUU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-5VTSCtkMO_OLAglmOtrGEA-1; Thu, 27 Feb 2020 10:51:49 -0500
X-MC-Unique: 5VTSCtkMO_OLAglmOtrGEA-1
Received: by mail-qt1-f199.google.com with SMTP id e8so4093802qtg.9
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6voEl47h0qUJuDEvWkZ8K6roWnRlX6NIRzGor7yz+UE=;
 b=exCLf6FivzNsPNrtGPOM3YnkOFa6LsYbI/nHWhJZWq1UnlWQg3pRRY6TIeiPqEBue9
 4o9inuHThbw6pYNgdIiX5jzzWSKkj2eL+O45i7M3RtJvZnCCK5GrA47ZTeb9TTCDNIO6
 U75aZk3MCK6IhntCiERPj5A2YQlmyoaLxRGomJg/DpBBHNdrYMO1qqXFmlF5NEyyNKvr
 BSPAFKTrqPuShvMbOwFC6ITjscHOt+QC3AxSFai7TS+qHA80D5PK1nUlDnI01LGh3Fkg
 iZqdEZbAJeAf5/fZC/u216NlZC3+FKq1piTvGOt/vHB+z58tE1iN25xAlP8aDC27Vek6
 /cqA==
X-Gm-Message-State: APjAAAX9P7CERrAWGV6IUHSxe6P+otRAd4pSMhW9qThEQomku34NuYPW
 maJl1QMCIa7xuOV+8ipZazYyN2iOlJR+HX/YmWAsdNpjDe2WiVgGbG8wBAneZbgu4KvjL9fVsYq
 9u8WWObbGwkdCVhE=
X-Received: by 2002:ac8:3ac3:: with SMTP id x61mr5776822qte.25.1582818708711; 
 Thu, 27 Feb 2020 07:51:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+zJYaZKb52+T4GbhTLOt6T50qVhbvSXEQA/qyRuz0IBfk0t/AnbLML+kgSA9lLfMwz8MrRA==
X-Received: by 2002:ac8:3ac3:: with SMTP id x61mr5776794qte.25.1582818708410; 
 Thu, 27 Feb 2020 07:51:48 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id e130sm3340260qkb.72.2020.02.27.07.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 07:51:47 -0800 (PST)
Date: Thu, 27 Feb 2020 10:51:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 0/5] vfio/pci: Fix up breakage against split irqchip and
 INTx
Message-ID: <20200227155146.GD180973@xz-x1>
References: <20200226225048.216508-1-peterx@redhat.com>
 <bd685da9-bc50-f901-bfec-a1cd18832307@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bd685da9-bc50-f901-bfec-a1cd18832307@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 04:32:24PM +0100, Auger Eric wrote:
> Hi Peter,

Hi, Eric,

>=20
> On 2/26/20 11:50 PM, Peter Xu wrote:
> > VFIO INTx is not working with split irqchip.  On new kernels KVM_IRQFD
> > will directly fail with resamplefd attached so QEMU will automatically
> > fallback to the INTx slow path.  However on old kernels it's still
> > broken.
> I think you should quote the commit that changes the behavior:
> 654f1f13ea56  kvm: Check irqchip mode before assign irqfd?
> so that one can understand what it fixed.

Right I should mention that.

Actually I mentioned it in an old cover letter but unluckily something
wrong happened with git-publish and merely my whole cover letter is
gone...  So what you saw is actually a simplified version and I think
I must have lost something like this... :(

Thanks for bringing that up.

>=20
> So on kernels that do not feature that commit, the ioctl succeeds and we
> pretend the resamplefd was properly attached whereas in practice it was
> never triggered.

Right.  Another thing I just noticed is that we must _not_ attach the
resamplefd to the KVM_IRQFD ioctl when we registered this in the
userspace.  One thing is it's for sure not needed at all.  More
importantly, on new kernels (after commit 654f1f13ea56) the KVM_IRQFD
could fail (because it sees both split irqchip and resamplefd) and
QEMU will fallback again to the slow path even if the fast path can
work.

Thanks,

--=20
Peter Xu


