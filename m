Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1286EC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 08:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04492076D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 08:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DD8axfKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04492076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jURUf-00043i-Vf
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 04:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jURU6-0003eI-QB
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jURU5-00078d-Fl
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:57:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jURU4-00078S-VR
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588323443;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnidDmyfM6nxfN5EvwiY6v/vjmAm/9NeonnfIJuWltU=;
 b=DD8axfKLEHrXTkZuyUK9sSFbj2bahCFjB3dAAHIIPsrjNtq/15AIfgFArULIFecxdZ9yon
 WvjFHXnBGqFuUq8SOsR3l2UNXyAo8FRknvVqoVBd5GURPxey1cp+DA14ZKK4i9mNsIwzwa
 QXMSaY9G07M4b9W6rMH3A/o/JazA8gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-a1wcu8ulOHK8rTRM9BJ5EA-1; Fri, 01 May 2020 04:57:15 -0400
X-MC-Unique: a1wcu8ulOHK8rTRM9BJ5EA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08CD61800D42;
 Fri,  1 May 2020 08:57:14 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E20456A95B;
 Fri,  1 May 2020 08:57:11 +0000 (UTC)
Date: Fri, 1 May 2020 09:57:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] hostmem: don't use mbind() if host-nodes is epmty
Message-ID: <20200501085708.GA2203114@redhat.com>
References: <20200430154606.6421-1-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200430154606.6421-1-imammedo@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 04:28:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: pbonzini@redhat.com, mhohmann@physnet.uni-hamburg.de,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 11:46:06AM -0400, Igor Mammedov wrote:
> Since 5.0 QEMU uses hostmem backend for allocating main guest RAM.
> The backend however calls mbind() which is typically NOP
> in case of default policy/absent host-nodes bitmap.
> However when runing in container with black-listed mbind()
> syscall, QEMU fails to start with error
>  "cannot bind memory to host NUMA nodes: Operation not permitted"
> even when user hasn't provided host-nodes to pin to explictly
> (which is the case with -m option)
>=20
> To fix issue, call mbind() only in case when user has provided
> host-nodes explicitly (i.e. host_nodes bitmap is not empty).
> That should allow to run QEMU in containers with black-listed
> mbind() without memory pinning. If QEMU provided memory-pinning
> is required user still has to white-list mbind() in container
> configuration.
>=20
> Reported-by: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: berrange@redhat.com
> CC: ehabkost@redhat.com
> CC: pbonzini@redhat.com
> CC: mhohmann@physnet.uni-hamburg.de
> CC: qemu-stable@nongnu.org
> ---
>  backends/hostmem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 327f9eebc3..0efd7b7bd6 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -383,8 +383,10 @@ host_memory_backend_memory_complete(UserCreatable *u=
c, Error **errp)
>          assert(sizeof(backend->host_nodes) >=3D
>                 BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
>          assert(maxnode <=3D MAX_NODES);
> -        if (mbind(ptr, sz, backend->policy,
> -                  maxnode ? backend->host_nodes : NULL, maxnode + 1, fla=
gs)) {
> +
> +        if (maxnode &&
> +            mbind(ptr, sz, backend->policy, backend->host_nodes, maxnode=
 + 1,
> +                  flags)) {
>              if (backend->policy !=3D MPOL_DEFAULT || errno !=3D ENOSYS) =
{
>                  error_setg_errno(errp, errno,
>                                   "cannot bind memory to host NUMA nodes"=
);

personally I would have found this code clearer if the
check had been  "if (backend->policy !=3D MPOL_DEFAULT && ..."
as I had to read quite a few lines to understand that the
'maxnode' is zero if-and-only-if  policy =3D=3D MPOL_DEFAULT

Regardless though, this is functionally correct so

   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


