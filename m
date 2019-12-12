Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2D0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280262073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJ/lipbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280262073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifR4t-0003yq-CJ
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ifR42-00039j-SK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ifR40-00043Q-Rq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:11:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ifR40-0003zh-NW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576167099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvVO2LDcQnLxsy8Q5Ab5ih9F47Ks92gDwt9tDyxRoso=;
 b=SJ/lipboICMqMUbAeGDKwWHAwGKz3QTPcDTBIYIrWk6aMJNTy/VakjKdbapHDo1zkSjZ/2
 OAWJ5k5DaLu9tLzublpQj403ZQ4dO5ONHyeRrWaclFnZEr87Plk/z0nNNUmarMny6fmjoc
 qs1w6/Zmf0it1q1YnoKrIC/T020Lfp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-5TCg6_aaNhewHGm7pcgSVw-1; Thu, 12 Dec 2019 11:11:37 -0500
X-MC-Unique: 5TCg6_aaNhewHGm7pcgSVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EF90801E72
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:11:36 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2496D60BF3;
 Thu, 12 Dec 2019 16:11:32 +0000 (UTC)
References: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
 <1576161021-5359-6-git-send-email-pbonzini@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] kvm: check before accessing PCMachineState fields
In-reply-to: <1576161021-5359-6-git-send-email-pbonzini@redhat.com>
Date: Thu, 12 Dec 2019 17:11:30 +0100
Message-ID: <87v9qlbk25.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  roms/SLOF         |  2 +-
>  target/i386/kvm.c | 11 +++++++++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/roms/SLOF b/roms/SLOF
> index 8ebf2f5..bcc3c4e 160000
> --- a/roms/SLOF
> +++ b/roms/SLOF
> @@ -1 +1 @@
> -Subproject commit 8ebf2f55e1ba1492b942ba4b682160e644fc0f98
> +Subproject commit bcc3c4e5c21a015f4680894c4ec978a90d4a2d69

I guess this was included by mistake.

> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ef63f3a..2ad5a94 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -49,6 +49,7 @@
>  #include "migration/blocker.h"
>  #include "exec/memattrs.h"
>  #include "trace.h"
> +#include "config-devices.h"
> =20
>  //#define DEBUG_KVM
> =20
> @@ -2172,9 +2173,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
> =20
> -    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
> +    if (
> +#ifdef CONFIG_PC
> +        kvm_check_extension(s, KVM_CAP_X86_SMM) &&
>          object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE) &&
> -        pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
> +        pc_machine_is_smm_enabled(PC_MACHINE(ms))
> +#else
> +=090
> +#endif
> +       ) {
>          smram_machine_done.notify =3D register_smram_listener;
>          qemu_add_machine_init_done_notifier(&smram_machine_done);
>      }

I'm not familiar with SMM, can we consider it a PC specific thing? If it
isn't, perhaps we should move smm to X86MachineState.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3yZrIACgkQ9GknjS8M
AjXJiw/48CcrTft+rVq4rLTkb0J9eHtXlWxndDWc8KEkgjy3CqotoV4kVa5HBu3R
A7gHN/iaEpvj4YFXdONxll3Kkd31bbL77iUBcMOhUFYrbumqPqKfzKp0Uay+cnjH
CSuzkd0LxIrv72RWZC1bbJWEU1lmemrVoPXpx5x6VTcLGnCmqdOq9gs6KturZ6Zm
NR5u7OzfythKVFSEfQAPKQ9tAzJ3vvHof0UuhP9A9hnRJXZtqk7Fv3S1jS/67jSK
g+OuU4pLL23wFFhxfu60xHS9SCuP17XB6o5D+0+RBBJ5/9oCYyQXFLyeFvEk10zf
whYICwj66QySqsZzPgEIHbCawebntel6Qo9K/ExTGDPPGEKN34/X5qvH0a77xWcN
ggF8RWFXfVJzzCMJSE2J1HvpCh6crUNF4PKIaJ0ih65+ToAoMO7Y3QpImkQFsE4y
G8OP/TJR4L+kisJpzHspKfYybv/ijHZxOJNZkoOH9qg/Tttz4hdKc6G+1oKcFRiK
CAWRW8kMvmE6GGLhbbySYn7aKulXyOvl6pVK/lV2/UpbpLN01tgcoXWPerRY+nAq
6EpJG9bVCpPQrt73K8yWOABH3hKwM4ElMd2l4HqbHNwFK5yd0ta9szTYAYHOoqEb
HG7mNNKr7aw96FiOA8wCDY/k4t23wI8Gmekh+FrUbzhObirDNw==
=sSwY
-----END PGP SIGNATURE-----
--=-=-=--


