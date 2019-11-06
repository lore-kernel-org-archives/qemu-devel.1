Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B9EC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2862173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhdBW/cW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2862173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSRYt-0002Ii-Mg
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 15:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ghook@redhat.com>) id 1iSRY0-0001ie-Jh
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ghook@redhat.com>) id 1iSRXz-0002va-9G
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:04:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60618
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ghook@redhat.com>) id 1iSRXy-0002tv-Vb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573070692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICRpuhrFvPAa2fS1tFH/hDoTb0i8Ub62xn/RCru9sIY=;
 b=bhdBW/cWSJr8FbuykSoMkG5H4nlv2cy6DgnmMv4+yFkWCJTZsNaIH0yGFGWcha14zD6CmR
 3mzg72+vzu2TUdw++66J0DR8HRBTPF3Lra/HEzUaKNUlZEsYxFlO+anyTQSllarLaxuseN
 PsLB6bQHdHz61RSAVSg3F8maL/7PAlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-STKmQ6ryNpmZW-sO6oY9ew-1; Wed, 06 Nov 2019 15:04:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B9C41005500;
 Wed,  6 Nov 2019 20:04:49 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 801C060BF4;
 Wed,  6 Nov 2019 20:04:49 +0000 (UTC)
Received: from zmail22.collab.prod.int.phx2.redhat.com
 (zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 6AAF318089CE;
 Wed,  6 Nov 2019 20:04:49 +0000 (UTC)
Date: Wed, 6 Nov 2019 15:04:49 -0500 (EST)
From: Gary R Hook <ghook@redhat.com>
To: rhvirt-patches@redhat.com
Message-ID: <1283370532.16619835.1573070689394.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190410000803.1744-3-ghook@redhat.com>
References: <20190410000803.1744-1-ghook@redhat.com>
 <20190410000803.1744-3-ghook@redhat.com>
Subject: Re: [RHEL-8.1 virt 2/2] target/i386: sev: Do not pin the ram device
 memory region
MIME-Version: 1.0
X-Originating-IP: [10.3.116.62, 10.4.195.28]
Thread-Topic: target/i386: sev: Do not pin the ram device memory region
Thread-Index: D72yeV//c/qZ5eVo7GQU8T3vvgN5Eg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: STKmQ6ryNpmZW-sO6oY9ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Gary R Hook" <ghook@redhat.com>
> To: rhvirt-patches@redhat.com
> Cc: qemu-devel@nongnu.org, "Paolo Bonzini" <pbonzini@redhat.com>, ghook@r=
edhat.com, "Eduardo Habkost"
> <ehabkost@redhat.com>, "Richard Henderson" <rth@twiddle.net>
> Sent: Tuesday, April 9, 2019 7:08:03 PM
> Subject: [RHEL-8.1 virt 2/2] target/i386: sev: Do not pin the ram device=
=09memory region
>=20
> BZ: 1667249
> Branch: rhel-8.1.0
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1667249
> Upstream Status: 4.0.0-rc1
> Build Info:
> https://brewweb.engineering.redhat.com/brew/taskinfo?taskID=3D20980582
> Conflicts: None
>=20
> commit cedc0ad539afbbb669dba9e73dfad2915bc1c25b
> Author: Singh, Brijesh <brijesh.singh@amd.com>
> Date:   Mon Feb 4 22:23:40 2019 +0000
>=20
>     target/i386: sev: Do not pin the ram device memory region
>=20
>     The RAM device presents a memory region that should be handled
>     as an IO region and should not be pinned.
>=20
>     In the case of the vfio-pci, RAM device represents a MMIO BAR
>     and the memory region is not backed by pages hence
>     KVM_MEMORY_ENCRYPT_REG_REGION fails to lock the memory range.
>=20
>     Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1667249
>     Cc: Alex Williamson <alex.williamson@redhat.com>
>     Cc: Paolo Bonzini <pbonzini@redhat.com>
>     Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>     Message-Id: <20190204222322.26766-3-brijesh.singh@amd.com>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org

NACKed-by: Gary R Hook <ghook@redhat.com>

> ---
>  target/i386/sev.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 2395171acf..b8009b001a 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -130,6 +130,17 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host,
> size_t size)
>  {
>      int r;
>      struct kvm_enc_region range;
> +    ram_addr_t offset;
> +    MemoryRegion *mr;
> +
> +    /*
> +     * The RAM device presents a memory region that should be treated
> +     * as IO region and should not be pinned.
> +     */
> +    mr =3D memory_region_from_host(host, &offset);
> +    if (mr && memory_region_is_ram_device(mr)) {
> +=09return;
> +    }
> =20
>      range.addr =3D (__u64)(unsigned long)host;
>      range.size =3D size;
> --
> 2.18.1
>=20
>=20


