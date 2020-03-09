Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F07C18E5A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CD4208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fp7pNEeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CD4208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKiH-0006Ks-6w
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1jBKNN-0006xL-UD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1jBKNM-0003M4-Cv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:31:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27876
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1jBKNM-0003L4-7t
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583767887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ALQ3sNsJiJuS1w47j1oQuwf6tOOmGJFXBCVSVh2DfM=;
 b=Fp7pNEeAGHMUiIecTp1p1HEZTbyswTSYlXGL11eHxth6Px7TiuL1KKGTy3Hqs4fWDOuhFB
 wzeWvXaLaIYAvc7Z2Mu08J3int4HTh1hAZSGa/KGKeriReZkKnrdHhM5vzKRQqe7+9PpZC
 mbOWIPvLYtUfOIPKM17AIxl8RtlcU2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-XEXg8x13OOCzGOO1_lccSw-1; Mon, 09 Mar 2020 11:31:25 -0400
X-MC-Unique: XEXg8x13OOCzGOO1_lccSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F3B2107B26F;
 Mon,  9 Mar 2020 15:31:24 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-65.ams2.redhat.com [10.36.117.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F5E35D9C5;
 Mon,  9 Mar 2020 15:31:21 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id BCC683E04B8; Mon,  9 Mar 2020 16:31:19 +0100 (CET)
Date: Mon, 9 Mar 2020 16:31:19 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 4/4] qemu-img: Deprecate use of -b without -F
Message-ID: <20200309153119.GA20640@paraplu>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-5-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200306225121.3199279-5-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 06, 2020 at 04:51:21PM -0600, Eric Blake wrote:
> Creating an image that requires format probing of the backing image is
> inherently unsafe (we've had several CVEs over the years based on
> probes leaking information to the guest on a subsequent boot, although
> these days tools like libvirt are aware of the issue enough to prevent
> the worst effects).  However, if our probing algorithm ever changes,
> or if other tools like libvirt determine a different probe result than
> we do, then subsequent use of that backing file under a different
> format will present corrupted data to the guest.  Start a deprecation
> clock so that future qemu-img can refuse to create unsafe backing
> chains that would rely on probing.  The warnings are intentionally
> emitted from the block layer rather than qemu-img (thus, all paths
> into image creation or rewriting perform the check).

I happily welcome this change.  I'm going around and fixing various docs
of differnt projects that create overlays without explicitly spelling
out backing files.  (FWIW, I also make sure to mention this, in context,
in all QEMU-related talks I give publicliy.)

This proactive action from QEMU will definitely help.

> However, there is one time where probing is safe: if we probe raw,
> then it is safe to record that implicitly in the image (but we still
> warn, as it's better to teach the user to supply -F always than to
> make them guess when it is safe).
>=20
> iotest 114 specifically wants to create an unsafe image for later
> amendment rather than defaulting to our new default of recording a
> probed format, so it needs an update.  While touching it, expand it to
> cover all of the various warnings enabled by this patch.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/system/deprecated.rst | 19 +++++++++++++++++++
>  block.c                    | 21 ++++++++++++++++++++-
>  qemu-img.c                 |  2 +-
>  tests/qemu-iotests/114     | 11 +++++++++++
>  tests/qemu-iotests/114.out |  8 ++++++++
>  5 files changed, 59 insertions(+), 2 deletions(-)

Before (with: qemu-4.2.0-2.fc30):

    $> qemu-img create -f qcow2 -b ./base.raw ./overlay1.qcow2
    Formatting './overlay1.qcow2', fmt=3Dqcow2 size=3D4294967296 backing_fi=
le=3D./base.raw cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6

After (with the patch series applied to QEMU Git):

    $> git describe
    v4.2.0-2204-gd6c7830114

    # Create; *without* specifying "-F raw"
    $> ~/build/qemu/qemu-img create -f qcow2 -b ./base.raw ./overlay2.qcow2
    qemu-img: warning: Deprecated use of backing file without explicit back=
ing format (detected format of raw)
    Formatting './overlay2.qcow2', fmt=3Dqcow2 size=3D4294967296 backing_fi=
le=3D./base.raw backing_fmt=3Draw cluster_size=3D65536 lazy_refcounts=3Doff=
 refcount_bits=3D16

    # Rebase; *without* specifying "-F raw"
    $> ~/build/qemu/qemu-img rebase -b base.raw overlay1.qcow2
    qemu-img: warning: Deprecated use of backing file without explicit back=
ing format, use of this image requires potentially unsafe format probing


However, for the "Convert" case, is it correct that no warning is thrown
for the below?

    $> ~/build/qemu/qemu-img info overlay1.qcow2=20
    image: overlay1.qcow2
    file format: qcow2
    virtual size: 4 GiB (4294967296 bytes)
    disk size: 196 KiB
    cluster_size: 65536
    backing file: base.raw
    Format specific information:
        compat: 1.1
        lazy refcounts: false
        refcount bits: 16
        corrupt: false
   =20
   =20
    $> ~/build/qemu/qemu-img convert -f qcow2 -O qcow2 overlay1.qcow2 flatt=
ened.raw

    $> echo $?
    0

> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 6c1d9034d9e3..a8ffacf54a52 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -376,6 +376,25 @@ The above, converted to the current supported format=
::
>  Related binaries
>  ----------------
>=20
> +qemu-img backing file without format (since 5.0.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The use of ``qemu-img create``, ``qemu-img rebase``, ``qemu-img
> +convert``, or ``qemu-img amend`` to create or modify an image that
> +depends on a backing file now recommends that an explicit backing
> +format be provided.  This is for safety: if qemu probes a different
> +format than what you thought, the data presented to the guest will be
> +corrupt; similarly, presenting a raw image to a guest allows a
> +potential security exploit if a future probe sees a non-raw image
> +based on guest writes.  To avoid the warning message, or even future
> +refusal to create an unsafe image, you must pass ``-o backing_fmt=3D``
> +(or the shorthand ``-F`` during create) to specify the intended
> +backing format.  You may use ``qemu-img rebase -u`` to retroactively
> +add a backing format to an existing image.  However, be aware that
> +there are already potential security risks to blindly using ``qemu-img
> +info`` to probe the format of an untrusted backing image, when
> +deciding what format to add into an existing image.

Nit: s/qemu/QEMU/g/

Ultra Nit: should this paragraph be broken down into two?  Experience
tells people usually feel deterred read "substantial paragraphs" :-)

I'll report back the Amend case.  (And once I get clarification on the
Convert scenario, I'll be happy to give Tested-by.)

[...]

--=20
/kashyap


