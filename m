Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955EDC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607CA2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THRdGZkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607CA2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7DKf-0002Kt-KG
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 02:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j7DIk-0001Gv-CY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j7DIi-0004JA-Uz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:09:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j7DIi-0004Ej-Qz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582787379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXrvpK+mQ4hIgZcnOj5xjHUb2xnKVzFloU/96Mk6aP4=;
 b=THRdGZkKmMZG4cHD3NsqSIhAFDrk22DGkxjePNBq2a49Y5VQElN3rEx6zyNeeyNqdr9KcI
 NiB642TdCqXtbJnxHfaQ8Q1GRRxh4r34+7xILkzW88RulRkKbAotRxFjbrUGUgHiqWN7hd
 cDqi10WUS/0zkuJkK7iofC0lF95KxIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-NndmAOh6P-ydLhvncJTOzA-1; Thu, 27 Feb 2020 02:09:35 -0500
X-MC-Unique: NndmAOh6P-ydLhvncJTOzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89517800D6C;
 Thu, 27 Feb 2020 07:09:34 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-53.brq.redhat.com [10.40.204.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90C5C909FA;
 Thu, 27 Feb 2020 07:09:29 +0000 (UTC)
Date: Thu, 27 Feb 2020 08:09:25 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 3/3] qemu-img: Deprecate use of -b without -F
Message-ID: <20200227070925.GB2110@andariel.pipo.sk>
References: <20200227023928.1021959-1-eblake@redhat.com>
 <20200227023928.1021959-4-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227023928.1021959-4-eblake@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 20:39:28 -0600, Eric Blake wrote:
> Creating an image that requires format probing of the backing image is
> inherently unsafe (we've had several CVEs over the years based on
> probes leaking information to the guest on a subsequent boot).  If our
> probing algorithm ever changes, or if other tools like libvirt
> determine a different probe result than we do, then subsequent use of
> that backing file under a different format will present corrupted data
> to the guest.  Start a deprecation clock so that future qemu-img can
> refuse to create unsafe backing chains that would rely on probing.
>=20
> However, there is one time where probing is safe: if we probe raw,
> then it is safe to record that implicitly in the image (but we still
> warn, as it's better to teach the user to supply -F always than to
> make them guess when it is safe).
>=20
> iotest 114 specifically wants to create an unsafe image for later
> amendment rather than defaulting to our new default of recording a
> probed format, so it needs an update.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-deprecated.texi       | 15 +++++++++++++++
>  block.c                    | 21 ++++++++++++++++++++-
>  qemu-img.c                 |  8 +++++++-
>  tests/qemu-iotests/114     |  4 ++--
>  tests/qemu-iotests/114.out |  1 +
>  5 files changed, 45 insertions(+), 4 deletions(-)
>=20
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 66eca3a1dede..f99b49addccc 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -309,6 +309,21 @@ The above, converted to the current supported format=
:
>=20
>  @section Related binaries
>=20
> +@subsection qemu-img backing file without format (since 5.0.0)
> +
> +The use of @command{qemu-img create}, @command{qemu-img rebase},
> +@command{qemu-img convert}, or @command{qemu-img ament} to create or

s/ament/amend/

> +modify an image that depends on a backing file now recommends that an
> +explicit backing format be provided.  This is for safety - if qemu
> +probes a different format than what you thought, the data presented to
> +the guest will be corrupt; similarly, presenting a raw image to a
> +guest allows the guest a potential security exploit if a future probe
> +sees non-raw.  To avoid warning messages, or even future refusal to
> +create an unsafe image, you must pass @option{-o backing_fmt=3D} (or
> +shorthand @option{-F}) to specify the intended backing format.  You
> +may use @command{qemu-img rebase -u} to retroactively add a backing
> +format to an existing image.

I'd add a note for users who wish to fix existing images (and I need
to add it to libvirt's knowledge base too) that when the user is unsure
of the backing image format and desn't trust that the image was handled
in a trusted way, they must not use the format detected by qemu-img info
if the image specifies a backing file, unless they also trust the
backing file. (Sorry as a non-native English speaker I can't express
this in a more elegant way.).

>  @subsection qemu-img convert -n -o (since 4.2.0)
>=20
>  All options specified in @option{-o} are image creation options, so

[...]

> diff --git a/qemu-img.c b/qemu-img.c
> index b9375427404d..e75ec1bdb555 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3637,7 +3637,13 @@ static int img_rebase(int argc, char **argv)
>       * doesn't change when we switch the backing file.
>       */
>      if (out_baseimg && *out_baseimg) {
> -        ret =3D bdrv_change_backing_file(bs, out_baseimg, out_basefmt, f=
alse);
> +        if (blk_new_backing && !out_basefmt) {
> +            out_basefmt =3D blk_bs(blk_new_backing)->drv->format_name;
> +            warn_report("Deprecated use of backing file "
> +                        "without explicit backing format, using "
> +                        "detected format of %s", out_basefmt);

Isn't this a similar instance to what I've reported in the previous
version? You warn that the format is missing, but set out_basefmt to the
detected format , thus bdrv_change_backing_file will then write the
detected format into the overlay even when it previously did not?

I think this has to have the same check for raw-only as above.

> +        }
> +        ret =3D bdrv_change_backing_file(bs, out_baseimg, out_basefmt, t=
rue);

or just the above line.

>      } else {
>          ret =3D bdrv_change_backing_file(bs, NULL, NULL, false);
>      }

I feel that this deprecation will be at least partially controversial,
but in my opinion it's the correct thing to do.

Reviewed-by: Peter Krempa <pkrempa@redhat.com>

after you address the issue above.


