Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBBEC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0826820801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7KQlOal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0826820801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4T1Q-0004ru-7N
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4T0Y-0004RY-5T
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4T0V-0006YU-Pq
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:19:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4T0V-0006Xr-LJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582132770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOfBFTqjFMuBLDFINQiAEGyMp1ECsOMNTzozfQpZ4kg=;
 b=K7KQlOalgTAa289UJmSUviA5wef5jhlLYj/swSa/LDBt2xLMXJ+dXS049OnYkb6bjD615M
 yGg5VHPP0nB9yXBF1ZFG1AyBEynX2qfN+8G3tVHNhq80kZPsjSmVgeITreRnpIFzF9rcob
 4VLfbn111vC0Nr2fgS5dzoa1TmZifdY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-ikDK_J6cMHecQbFibcrsoA-1; Wed, 19 Feb 2020 12:19:24 -0500
Received: by mail-qv1-f69.google.com with SMTP id v19so669216qvk.16
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 09:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dK5oOLaqiDs2fEfuCHWpgQxQmx/QeSFAmRxrjHBhE/s=;
 b=Bbt8irwsav88zfLe27mTAZFzvHLhxa+p3oEYdVH8wgt3zBjVdBikVicRn2crbZthbi
 lmjBm/mvGJr6YYxtbmp9YjiV4H91kOHjBYZVISJG6NCnObtIAF6Rz5kxtLIuTAsNjq+m
 JYjmZa7CsyTzCTO2UgLF+Fl77uiH570p2BDVxNCrGQ3ReLtpy3HQCbIIN6qzU8Dh1PFw
 USQT13b9ZaJ9FSOWz8hagNXLLA4ThK8yYqI4r8QNxOlCEimwBOtOm1S2YGp9XYZ9kjly
 W25doucuNhgfAzlRlmeDjZxMWuiKgV5WTV2xoynHiOO95DbzT1qZKoxtMfdEqoPdQrui
 Cv0A==
X-Gm-Message-State: APjAAAVolEqT1WE0oqCXzUmKKIBL9ofsYGNe/IpU2wzwkRAi2KTUAuFI
 On0sZJPegoQ57tRquix1Te3Hik7RxT9a94Qo3Bp2KNb++mkQHpBsOSWx/dJEMKoK6Yi3o5RiN63
 GfXyHqaiA6aYMebY=
X-Received: by 2002:a05:620a:63b:: with SMTP id
 27mr23161557qkv.159.1582132763765; 
 Wed, 19 Feb 2020 09:19:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjcYtGtErtygtf/94adebcA0XUns/LqaLGr58X6868SWjYDieDU8xN3zP9HIa6rCVTekPAxw==
X-Received: by 2002:a05:620a:63b:: with SMTP id
 27mr23161535qkv.159.1582132763441; 
 Wed, 19 Feb 2020 09:19:23 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id z21sm131280qka.122.2020.02.19.09.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 09:19:22 -0800 (PST)
Date: Wed, 19 Feb 2020 12:19:19 -0500
From: Peter Xu <peterx@redhat.com>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
Message-ID: <20200219171919.GA34517@xz-x1>
References: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
 <20200218174311.GE1408806@xz-x1>
 <B2D15215269B544CADD246097EACE7474BAFF835@DGGEMM528-MBX.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7474BAFF835@DGGEMM528-MBX.china.huawei.com>
X-MC-Unique: ikDK_J6cMHecQbFibcrsoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Wed, Feb 19, 2020 at 01:19:08PM +0000, Zhoujian (jay) wrote:
> Hi Peter,
>=20
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Wednesday, February 19, 2020 1:43 AM
> > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Cc: kvm@vger.kernel.org; qemu-devel@nongnu.org; pbonzini@redhat.com;
> > dgilbert@redhat.com; quintela@redhat.com; Liujinsong (Paul)
> > <liu.jinsong@huawei.com>; linfeng (M) <linfeng23@huawei.com>; wangxin (=
U)
> > <wangxinxin.wang@huawei.com>; Huangweidong (C)
> > <weidong.huang@huawei.com>
> > Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
> >=20
> > On Tue, Feb 18, 2020 at 01:13:47PM +0000, Zhoujian (jay) wrote:
> > > Hi all,
> > >
> > > We found that the guest will be soft-lockup occasionally when live
> > > migrating a 60 vCPU, 512GiB huge page and memory sensitive VM. The
> > > reason is clear, almost all of the vCPUs are waiting for the KVM MMU
> > > spin-lock to create 4K SPTEs when the huge pages are write protected.=
 This
> > phenomenon is also described in this patch set:
> > > https://patchwork.kernel.org/cover/11163459/
> > > which aims to handle page faults in parallel more efficiently.
> > >
> > > Our idea is to use the migration thread to touch all of the guest
> > > memory in the granularity of 4K before enabling dirty logging. To be
> > > more specific, we split all the PDPE_LEVEL SPTEs into DIRECTORY_LEVEL
> > > SPTEs as the first step, and then split all the DIRECTORY_LEVEL SPTEs=
 into
> > PAGE_TABLE_LEVEL SPTEs as the following step.
> >=20
> > IIUC, QEMU will prefer to use huge pages for all the anonymous ramblock=
s
> > (please refer to ram_block_add):
> >=20
> >         qemu_madvise(new_block->host, new_block->max_length,
> > QEMU_MADV_HUGEPAGE);
>=20
> Yes, you're right
>=20
> >=20
> > Another alternative I can think of is to add an extra parameter to QEMU=
 to
> > explicitly disable huge pages (so that can even be MADV_NOHUGEPAGE
> > instead of MADV_HUGEPAGE).  However that should also drag down the
> > performance for the whole lifecycle of the VM. =20
>=20
> From the performance point of view, it is better to keep the huge pages
> when the VM is not in the live migration state.
>=20
> > A 3rd option is to make a QMP
> > command to dynamically turn huge pages on/off for ramblocks globally.
>=20
> We're searching a dynamic method too.
> We plan to add two new flags for each memory slot, say
> KVM_MEM_FORCE_PT_DIRECTORY_PAGES and
> KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES. These flags can be set
> through KVM_SET_USER_MEMORY_REGION ioctl.
>=20
> The mapping_level which is called by tdp_page_fault in the kernel side
> will return PT_DIRECTORY_LEVEL if the
> KVM_MEM_FORCE_PT_DIRECTORY_PAGES flag of the memory slot is
> set, and return PT_PAGE_TABLE_LEVEL if the
> KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES flag is set.
> =20
> The key steps to split the huge pages in advance of enabling dirty log is
> as follows:
> 1. The migration thread in user space uses
> KVM_SET_USER_MEMORY_REGION ioctl to set the
> KVM_MEM_FORCE_PT_DIRECTORY_PAGES flag for each memory slot.
> 2. The migration thread continues to use the KVM_SPLIT_HUGE_PAGES
> ioctl (which is newly added) to do the splitting of large pages in the
> kernel side.
> 3. A new vCPU is created temporally(do some initialization but will not
> run) to help to do the work, i.e. as the parameter of the tdp_page_fault.
> 4. Collect the GPA ranges of all the memory slots with the
> KVM_MEM_FORCE_PT_DIRECTORY_PAGES flag set.
> 5. Split the 1G huge pages(collected in step 4) into 2M by calling
> tdp_page_fault, since the mapping_level will return
> PT_DIRECTORY_LEVEL. Here is the main difference from the usual
> path which is caused by the Guest side(EPT violation/misconfig etc),
> we call it directly in the hypervisor side.
> 6. Do some cleanups, i.e. free the vCPU related resources
> 7. The KVM_SPLIT_HUGE_PAGES ioctl returned to the user space side.
> 8. Using KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES instread of
> KVM_MEM_FORCE_PT_DIRECTORY_PAGES to repeat step 1 ~ step 7,
> in step 5 the 2M huge pages will be splitted into 4K pages.
> 9. Clear the KVM_MEM_FORCE_PT_DIRECTORY_PAGES and
> KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES flags for each memory slot.
> 10. Then the migration thread calls the log_start ioctl to enable the dir=
ty
> logging, and the remaining thing is the same.

I'm not sure... I think it would be good if there is a way to have
finer granularity control on using huge pages for any process, then
KVM can directly leverage that because KVM page tables should always
respect the mm configurations on these (so e.g. when huge page split,
KVM gets notifications via mmu notifiers).  Have you thought of such a
more general way?

(And I just noticed that MADV_NOHUGEPAGE is only a hint to khugepaged
 and probably won't split any huge page at all after madvise() returns..)

To tell the truth I'm still confused on how split of huge pages helped
in your case...  If I read it right the test reduced some execution
time from 9s to a few ms after your splittion of huge pages.  The
thing is I don't see how split of huge pages could solve the mmu_lock
contention with the huge VM, because IMO even if we split the huge
pages into smaller ones, those pages should still be write-protected
and need merely the same number of page faults to resolve when
accessed/written?  And I thought that should only be fixed with
solutions like what Ben has proposed with the MMU rework. Could you
show me what I've missed?

Thanks,

--=20
Peter Xu


