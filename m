Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A462FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FFDD205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWI9ddzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFDD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4fD-00025D-Jy
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1if4ZK-0006uL-Dh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1if4ZI-0002Rw-JH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:10:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30192
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1if4ZI-0002P5-Bq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576080626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yjBXsnZNpmLos/o+u92Iqwk8Z3NNdwfCG33TcKRXJY=;
 b=MWI9ddzDYqoZNmD26M7ZxjDq69f7B4X4bXV/cam8YH5zrZvmxQTynVdDnKAYVckxcXf1ma
 FIbUJXmNi6AYuHVQz2lb9A/fWI8dVJ72Ak2dq3BlPFcdTtCD298CKHdBqh0opI5PIQreqv
 whTcPKp2jsv3IbZFQ79UvZYvHauqVEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-ca_seIu5PDmqmSTooJ24DQ-1; Wed, 11 Dec 2019 11:10:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEEBB18B9FCD;
 Wed, 11 Dec 2019 16:10:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FF461001B0B;
 Wed, 11 Dec 2019 16:10:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B746511386A7; Wed, 11 Dec 2019 17:10:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] monitor: fix maybe-uninitialized
References: <1576074210-52834-5-git-send-email-pbonzini@redhat.com>
Date: Wed, 11 Dec 2019 17:10:17 +0100
In-Reply-To: <1576074210-52834-5-git-send-email-pbonzini@redhat.com> (Paolo
 Bonzini's message of "Wed, 11 Dec 2019 15:23:26 +0100")
Message-ID: <87y2viu9li.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ca_seIu5PDmqmSTooJ24DQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ../monitor/misc.c: In function =E2=80=98mon_get_cpu_sync=E2=80=99:
> /home/elmarco/src/qq/include/sysemu/hw_accel.h:22:9: error: =E2=80=98cpu=
=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-unini=
tialized]
>    22 |         kvm_cpu_synchronize_state(cpu);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../monitor/misc.c:397:15: note: =E2=80=98cpu=E2=80=99 was declared here
>   397 |     CPUState *cpu;
>       |               ^~~
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  monitor/misc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 3baa15f..a74cff3 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -394,7 +394,7 @@ int monitor_set_cpu(int cpu_index)
>  /* Callers must hold BQL. */
>  static CPUState *mon_get_cpu_sync(bool synchronize)
>  {
> -    CPUState *cpu;
> +    CPUState *cpu =3D NULL;
> =20
>      if (cur_mon->mon_cpu_path) {
>          cpu =3D (CPUState *) object_resolve_path_type(cur_mon->mon_cpu_p=
ath,
> @@ -411,6 +411,7 @@ static CPUState *mon_get_cpu_sync(bool synchronize)
>          monitor_set_cpu(first_cpu->cpu_index);
>          cpu =3D first_cpu;
>      }
> +    assert(cpu !=3D NULL);
>      if (synchronize) {
>          cpu_synchronize_state(cpu);
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>


