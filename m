Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E7C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD3D2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYseZT90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD3D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxF4-0007FI-E0
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jIxEA-00065Q-TX
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jIxE9-0002kO-FK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:25:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jIxE9-0002kA-An
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585585529;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYCc39bvJPgwiYaAoHpsrecasJdUJg2PE7mHgSDENzs=;
 b=RYseZT90VetQ+Xkj6Rl4I6DhiWzNUM6KSXir3K2h/xS2FosvZpimKhTOOe1yuT42cTOul8
 9gTLQ6EfZ+JlmsvWG2B2X3R4ofQ4bAxGv8M2I+EIzI+fU/pC+Q3m4FHdMvCfb5KUukFs2X
 xlNsi45xUj6LqmNsL465xAAMxonomuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-Fmz9TNGuMFC0-HtWKIJSmA-1; Mon, 30 Mar 2020 12:25:14 -0400
X-MC-Unique: Fmz9TNGuMFC0-HtWKIJSmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D617D1005509;
 Mon, 30 Mar 2020 16:25:12 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 065D350C01;
 Mon, 30 Mar 2020 16:25:07 +0000 (UTC)
Date: Mon, 30 Mar 2020 17:25:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0] qga-posix: Avoid crashing process when failing
 to allocate memory
Message-ID: <20200330162505.GP236854@redhat.com>
References: <20200324194836.21539-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200324194836.21539-1-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-trivial@nongnu.org,
 qemu-stable@nongnu.org, Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 qemu-devel@nongnu.org, Sameeh Jubran <sjubran@redhat.com>,
 Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 08:48:36PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Similarly to commit 807e2b6fce0 for Windows, kindly return a
> QMP error message instead of crashing the whole process.
>=20
> Cc: qemu-stable@nongnu.org
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054

I find that bug report pretty dubious

   "The QEMU Guest Agent in QEMU is vulnerable to an integer=20
    overflow in the qmp_guest_file_read(). An attacker could=20
    exploit this by sending a crafted QMP command (including=20
    guest-file-read with a large count value) to the agent via=20
    the listening socket to trigger a g_malloc() call with a=20
    large memory chunk resulting in a segmentation fault."

"the attacker" in this case has to have access to the QEMU
chardev associated with the guest agent. IOW, in any sensible
configuration of the chardev, "the attacker" is the same person
who launched QEMU in the first place.  There's no elevation of
privilege here and any denial of service is inflicted against
themselves. Finally it doesn't cause a segmentation fault,
it causes an abort.

This is *NOT* a security bug.

In fact I'd call this NOTABUG entirely. It is just user error
to set the "count" to such a huge value that it hits OOM.

> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qga/commands-posix.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 93474ff770..8f127788e6 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -493,7 +493,13 @@ struct GuestFileRead *qmp_guest_file_read(int64_t ha=
ndle, bool has_count,
>          gfh->state =3D RW_STATE_NEW;
>      }
> =20
> -    buf =3D g_malloc0(count+1);
> +    buf =3D g_try_malloc0(count + 1);
> +    if (!buf) {
> +        error_setg(errp,
> +                   "failed to allocate sufficient memory "
> +                   "to complete the requested service");
> +        return NULL;
> +    }

So you've prevented an OOM when we call fread() on the file.

The contents of 'buf' now need to be turned into JSON which
means the buffer need to be base64 encoded. This will consume
even more memory than the original read.  So checking malloc
here has achieved nothing AFAICT.

>      read_count =3D fread(buf, 1, count, fh);
>      if (ferror(fh)) {
>          error_setg_errno(errp, errno, "failed to read file");

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


