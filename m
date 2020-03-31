Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0E8C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CD62078B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ilc9eR4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CD62078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHdy-0004ii-8H
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJHd4-0003nV-OD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJHd3-0003KV-9a
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:12:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJHd3-0003Jh-5j
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585663952;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oufbEk1H6j3OE6EP5HvuQlhQOcnlItPwArlIgcuQCS4=;
 b=Ilc9eR4qUCU3EAcb5B5Xzvw6lnYssG5dP8d845XUhBSHVLz3czc9U4yOl2RyHwnrcxLSk2
 beEcpytFrymL0n5/2lMorCJXwdyVSSOVTUxAghZxiP9vdriNI0Z5omVfnOQ9b/8Yfsst39
 6Y/8kXIgxfM0iRsEfsRLFbvzfVmlHGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-bMr3PTcTPFC8dZzBxk13Tw-1; Tue, 31 Mar 2020 10:12:18 -0400
X-MC-Unique: bMr3PTcTPFC8dZzBxk13Tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC133881295;
 Tue, 31 Mar 2020 14:12:16 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAA86608E7;
 Tue, 31 Mar 2020 14:12:08 +0000 (UTC)
Date: Tue, 31 Mar 2020 15:12:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v2 1/4] Revert "prevent crash when executing
 guest-file-read with large count"
Message-ID: <20200331141205.GI353752@redhat.com>
References: <20200331140638.16464-1-philmd@redhat.com>
 <20200331140638.16464-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331140638.16464-2-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Sameeh Jubran <sjubran@redhat.com>,
 Basil Salman <basil@daynix.com>, Dietmar Maurer <dietmar@proxmox.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 04:06:35PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> By using g_try_malloc() instead of g_malloc() the qemu-guest-agent
> Denial-of-Service attack referred in commit 807e2b6fce is reduced,
> but still triggerable:

As explained previously, I believe there is *no* denial of service
attack here. The described scenario is just a user hurting themselves
by intentionally telling QEMU not to limit the amount of data returned.

>=20
>   - bisect file size S until g_try_malloc(S) fails,
>   - use S - 1:
>     g_try_malloc(S - 1) succeeds, but g_new0() few lines later will
>     fail.
>=20
>  346     buf =3D g_try_malloc0(count + 1);
>  347     if (!buf) {
>  348         error_setg(errp,
>  349                    "failed to allocate sufficient memory "
>  350                    "to complete the requested service");
>  351         return NULL;
>  352     }
>  353     is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
>  354     if (!is_ok) {
>  355         error_setg_win32(errp, GetLastError(), "failed to read file"=
);
>  356         slog("guest-file-read failed, handle %" PRId64, handle);
>  357     } else {
>  358         buf[read_count] =3D 0;
>  359         read_data =3D g_new0(GuestFileRead, 1);
>                          ^^^^^^
>=20
> Instead we are going to put a low hard limit on 'count' in the next
> commits.
> This reverts commit 807e2b6fce022707418bc8f61c069d91c613b3d2.
>=20
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qga/commands-win32.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index b49920e201..46cea7d1d9 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -343,13 +343,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, b=
ool has_count,
>      }
> =20
>      fh =3D gfh->fh;
> -    buf =3D g_try_malloc0(count + 1);
> -    if (!buf) {
> -        error_setg(errp,
> -                   "failed to allocate sufficient memory "
> -                   "to complete the requested service");
> -        return NULL;
> -    }
> +    buf =3D g_malloc0(count + 1);
>      is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
>      if (!is_ok) {
>          error_setg_win32(errp, GetLastError(), "failed to read file");
> --=20
> 2.21.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


