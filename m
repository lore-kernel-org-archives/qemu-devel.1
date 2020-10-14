Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E5020BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGnXIbhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E5020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kScBh-0003TJ-DW
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kScAF-0002TN-Bb
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kScAC-0008Vc-Sb
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602664175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ay2KiFfdQQ+ULyuVIu9EMCKBauoiTeJO7YqRn+3s6dY=;
 b=TGnXIbhWrHL284tqBREYU7Tlm0+NCDL5pTOmhCOdxq9gAyIl0HDsmNrIDx2NhR1hTyBnLj
 kW4cteozbjSa/dTgVEXqs9+71fOmB8R4Nhmqc79ut5Y1j7wkQo6VqWjvziw/GBHLQ9j15a
 Ewep7uF7k9S/QgkS5fwd9s49AtD1bLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-GaK5RsY_NDu5mWnq1vJ9EQ-1; Wed, 14 Oct 2020 04:29:34 -0400
X-MC-Unique: GaK5RsY_NDu5mWnq1vJ9EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC47D879528;
 Wed, 14 Oct 2020 08:29:32 +0000 (UTC)
Received: from starship (unknown [10.35.206.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF131610F3;
 Wed, 14 Oct 2020 08:29:24 +0000 (UTC)
Message-ID: <a4f3816dab09f4e28e33c66b8ff8273147415567.camel@redhat.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
From: Maxim Levitsky <mlevitsk@redhat.com>
To: harry harry <hiharryharryharry@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>
Date: Wed, 14 Oct 2020 11:29:23 +0300
In-Reply-To: <CA+-xGqOMKRh+_5vYXeLOiGnTMw4L_gUccqdQ+HGSOzuTosp6tw@mail.gmail.com>
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
 <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
 <20201013045245.GA11344@linux.intel.com>
 <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
 <CA+-xGqMMa-DB1SND5MRugusDafjNA9CVw-=OBK7q=CK1impmTQ@mail.gmail.com>
 <a163c2d8-d8a1-dc03-6230-a2e104e3b039@redhat.com>
 <CA+-xGqOMKRh+_5vYXeLOiGnTMw4L_gUccqdQ+HGSOzuTosp6tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PLING_QUERY=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: libvir-list@redhat.com, mathieu.tarral@protonmail.com,
 qemu-devel@nongnu.org, stefanha@redhat.com, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-10-13 at 16:36 -0400, harry harry wrote:
> Hi Paolo and Sean,
> 
> Thanks much for your prompt replies and clear explanations.
> 
> On Tue, Oct 13, 2020 at 2:43 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > No, the logic to find the HPA with a given HVA is the same as the
> > hardware logic to translate HVA -> HPA.  That is it uses the host
> > "regular" page tables, not the nested page tables.
> > 
> > In order to translate GPA to HPA, instead, KVM does not use the nested
> > page tables.
> 
> I am curious why KVM does not directly use GPAs as HVAs and leverage
> nested page tables to translate HVAs (i.e., GPAs) to HPAs? Is that
> because 1) the hardware logic of ``GPA -> [extended/nested page
> tables] -> HPA[*]'' is different[**] from the hardware logic of ``HVA
> -> [host regular page tables] -> HPA''; 2) if 1) is true, it is
> natural to reuse Linux's original functionality to translate HVAs to
> HPAs through regular page tables.
I would like to emphisise again. The HVA space is not fully free when a guest starts,
since it contains qemu's heap, code, data, and whatever qemu needs. However guest't
GPA address space must be allocated fully. E.g if qemu heap starts at 0x40000,
then guest can't have physical memory at 0x40000 following your suggestion, which
is wrong. It can be in theory done by blacklisting these areas via ACPI/BIOS provided
memory map, but that would be very very difficult to maintain and not worth it.

Best regards,
	Maxim Levitsky

> 
> [*]: Here, the translation means the last step for MMU to translate a
> GVA's corresponding GPA to an HPA through the extended/nested page
> tables.
> [**]: To my knowledge, the hardware logic of ``GPA -> [extended/nested
> page tables] -> HPA'' seems to be the same as the hardware logic of
> ``HVA -> [host regular page tables] -> HPA''. I appreciate it if you
> could point out the differences I ignored. Thanks!
> 
> Best,
> Harry
> 



