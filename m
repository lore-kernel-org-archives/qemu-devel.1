Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9FFC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE5021655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhzrKug0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE5021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifmOo-0003wb-9Y
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifmNR-0002g5-9o
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifmNQ-00054t-8C
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:57:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifmNQ-00053c-3N
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576249027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpMupe09tevne8RdSH2quVBnDLdQlpbW126C70GDjlk=;
 b=BhzrKug0SJ/XmQ6ZN2Ty6/thGNV3ToEncx1ta8Ph41tdNnoQq+DVBokdjhfbpQc4lhxNRs
 HebP2/ggHOcekEHTsAT987FNX/uXGPx3Jq7Ev9AoCTDnwv6Kxacscjp5QrrgR7Th0S3TeO
 xJetbWGR/a+UFoOiWrCTWrS5Jf29xpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-BDoexXR5MJSgUFwj8oyRTQ-1; Fri, 13 Dec 2019 09:57:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 015811800D63
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 14:57:05 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3482E5D9C9;
 Fri, 13 Dec 2019 14:57:04 +0000 (UTC)
Date: Fri, 13 Dec 2019 14:57:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] memory: use RCU_READ_LOCK_GUARD
Message-ID: <20191213145701.GF3713@work-vm>
References: <1576246112-23406-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1576246112-23406-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: BDoexXR5MJSgUFwj8oyRTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/exec/memory.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e499dc2..e42a9d7 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2165,7 +2165,7 @@ MemTxResult address_space_read(AddressSpace *as, hw=
addr addr,
> =20
>      if (__builtin_constant_p(len)) {
>          if (len) {
> -            rcu_read_lock();
> +            RCU_READ_LOCK_GUARD();
>              fv =3D address_space_to_flatview(as);
>              l =3D len;
>              mr =3D flatview_translate(fv, addr, &addr1, &l, false, attrs=
);
> @@ -2176,7 +2176,6 @@ MemTxResult address_space_read(AddressSpace *as, hw=
addr addr,
>                  result =3D flatview_read_continue(fv, addr, attrs, buf, =
len,
>                                                  addr1, l, mr);
>              }
> -            rcu_read_unlock();
>          }
>      } else {
>          result =3D address_space_read_full(as, addr, attrs, buf, len);
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


