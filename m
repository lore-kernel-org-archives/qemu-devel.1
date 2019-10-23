Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B7CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FF721872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwR845OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FF721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJkW-0005cY-Ow
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iNJQV-0008HH-Os
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iNJQS-0004XT-Ct
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:23:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iNJQS-0004Wg-9G
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571847834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJ2K2GJxpKAfkNsURNC6mJmIbnmlynPVTOZpP4D4MiE=;
 b=cwR845OPMj40UrchBHb1SpZWSynKCxI6bWYGf6iPulEAo5wS2C3lXFgadRAe8vZ/HpWaoZ
 DT2DYMbx10dQobGWcMyzMYVyYzpF0JBGwihHuF/RXdJci9aq/jBWZf/TXD2ho10in6K0Vw
 nrrr8sCRO2VipfFFR0JM75HhDDr1EK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-QBd_2ebGPDS_Al5uivcLbg-1; Wed, 23 Oct 2019 12:23:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 018B01005500;
 Wed, 23 Oct 2019 16:23:50 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5160019C78;
 Wed, 23 Oct 2019 16:23:49 +0000 (UTC)
Subject: Re: [PATCH] cputlb: Fix tlb_vaddr_to_host
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191023154952.30731-1-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <82dba2ed-4ed6-7ff4-64d6-119e3eefc8fa@redhat.com>
Date: Wed, 23 Oct 2019 18:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023154952.30731-1-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: QBd_2ebGPDS_Al5uivcLbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23.10.19 17:49, Richard Henderson wrote:
> Using uintptr_t instead of target_ulong meant that, for 64-bit guest
> and 32-bit host, we truncated the guest address comparator and so may
> not hit the tlb when we should.
>=20
> Fixes: 4811e9095c0
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>=20
> Fixes aarch64 emulation on arm32 host, after our recent changes
> to tlb probing.
>=20
>=20
> r~
>=20
> ---
>   accel/tcg/cputlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 6f4194df96..5eebddcca8 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1189,7 +1189,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr =
addr,
>                           MMUAccessType access_type, int mmu_idx)
>   {
>       CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
> -    uintptr_t tlb_addr, page;
> +    target_ulong tlb_addr, page;
>       size_t elt_ofs;
>  =20
>       switch (access_type) {
>=20

probe_access() seems to be fine

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb


