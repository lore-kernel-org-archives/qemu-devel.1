Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23558C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E1E24125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA9NspJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E1E24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46ud-0005xY-2r
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j46u3-0005V4-V6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j46u2-0000Mx-OG
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:43:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44779
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j46u2-0000MW-KP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582047801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQeF9z9dwjlreuri/J/M4KA555f5ty9mmMZNrXTOea8=;
 b=RA9NspJqsLS+Eg1upFvJ61iE4SjZjOchcyiLspZ8y9PCOdM1p4qc1yixkBVXLRr+dL207W
 KObWwRWVPhZkBLW9yBZFto2I5CRtuDnVgGRg8jBURFvCsuRMeQrxZjH0h0qnIkqjB5Om08
 e7DtVfX12bIAW+AHgRZuS+zXP7lioio=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-LhxYnWftMbCyKfOEv-LScA-1; Tue, 18 Feb 2020 12:43:13 -0500
Received: by mail-qv1-f72.google.com with SMTP id j15so12812493qvp.21
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TfYhihsaYpl3SkYCARZ0aqJoWgwAg50MspLeC6Tkzks=;
 b=qf86IoRextmqv9OKu/Vm6m7mFKaVzuLjTPFBk6C1P1+YmuxrsCDwsPjnvev9sZnFrd
 C7O34iyo83ICmIXcRqD7Z+/fqs5hNobzl1DBju6mY1K9kt+ZkIYFPD4/31PBXNH0eYLc
 9T/unplF9LGn0U5qnu4baYHdSb8fakJa0svXxf3KNlZq6MqnnVmsDJvzneNSwmKfhaU0
 /jNgb7t8V7hDgGXIOHBmYUggoPLUSP0NdklwaHk0pwj2MpUuKlY10BoLUTbH/xDCasyB
 DbTAoMm8ojkRjVt9mOgLL8qx9oQCil5PcdOhgmCOn1JddLrugSxQjrSTndnvEbiP45lT
 huEw==
X-Gm-Message-State: APjAAAUDVHL79X9ZTXKfTpJcS45atjedqu+sE5Eqn7ntxt+Eij1zbSIa
 /pY1FnfZFXTZa6jv5h5dmxPmCPMZCs4zPde+MZzf9/thrJhpdZLz6+pBRG+7mDII4SDSCHNK8C3
 Iw5ZniIxZ6n5oBgk=
X-Received: by 2002:a05:620a:31b:: with SMTP id
 s27mr19105400qkm.105.1582047793368; 
 Tue, 18 Feb 2020 09:43:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEfUwxeApmuqHCYNkA6PIzorHdByG7gaY1ai/ZL45FYYxc67zZuAe9vAnHLOPrvPwIAM0r+w==
X-Received: by 2002:a05:620a:31b:: with SMTP id
 s27mr19105379qkm.105.1582047793149; 
 Tue, 18 Feb 2020 09:43:13 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id j58sm2246253qtk.27.2020.02.18.09.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:43:12 -0800 (PST)
Date: Tue, 18 Feb 2020 12:43:11 -0500
From: Peter Xu <peterx@redhat.com>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
Message-ID: <20200218174311.GE1408806@xz-x1>
References: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
X-MC-Unique: LhxYnWftMbCyKfOEv-LScA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Liujinsong \(Paul\)" <liu.jinsong@huawei.com>,
 "linfeng \(M\)" <linfeng23@huawei.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "wangxin \(U\)" <wangxinxin.wang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 01:13:47PM +0000, Zhoujian (jay) wrote:
> Hi all,
>=20
> We found that the guest will be soft-lockup occasionally when live migrat=
ing a 60 vCPU,
> 512GiB huge page and memory sensitive VM. The reason is clear, almost all=
 of the vCPUs
> are waiting for the KVM MMU spin-lock to create 4K SPTEs when the huge pa=
ges are
> write protected. This phenomenon is also described in this patch set:
> https://patchwork.kernel.org/cover/11163459/
> which aims to handle page faults in parallel more efficiently.
>=20
> Our idea is to use the migration thread to touch all of the guest memory =
in the
> granularity of 4K before enabling dirty logging. To be more specific, we =
split all the
> PDPE_LEVEL SPTEs into DIRECTORY_LEVEL SPTEs as the first step, and then s=
plit all
> the DIRECTORY_LEVEL SPTEs into PAGE_TABLE_LEVEL SPTEs as the following st=
ep.

IIUC, QEMU will prefer to use huge pages for all the anonymous
ramblocks (please refer to ram_block_add):

        qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGE=
PAGE);

Another alternative I can think of is to add an extra parameter to
QEMU to explicitly disable huge pages (so that can even be
MADV_NOHUGEPAGE instead of MADV_HUGEPAGE).  However that should also
drag down the performance for the whole lifecycle of the VM.  A 3rd
option is to make a QMP command to dynamically turn huge pages on/off
for ramblocks globally.  Haven't thought deep into any of them, but
seems doable.

Thanks,

--=20
Peter Xu


