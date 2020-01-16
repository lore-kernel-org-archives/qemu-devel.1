Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D80AC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDB42072B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLFoYRAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDB42072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6yz-0004S5-St
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1is6xz-0003yJ-GI
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1is6xt-0005dH-Nu
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:21:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23843
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1is6xt-0005ci-J2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579188104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0XnP0kjaVIxMBxzJGP1GKem5Jwg2lXayOIExMF3I4k=;
 b=PLFoYRADuGyyVLeKN+O1WWSpGcVov5zAb1AvjAMXA6UzNTnuGZmVFglgozO4AW+kO+JJH+
 6ArEA5EhFsZqz4FOlCBT2lP+pKZa/kVaZqgkHPW/6t0LRBuZPokSPmmKiM2l0kkXzGMM1c
 NIetzEVtkdmytjgWmYHcAwXVQry3hFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-j6tBlNFxMZahJdEnWKHG5Q-1; Thu, 16 Jan 2020 10:21:43 -0500
X-MC-Unique: j6tBlNFxMZahJdEnWKHG5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C0BB8017CC
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 15:21:42 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53F00811FF;
 Thu, 16 Jan 2020 15:21:38 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-54-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 053/104] virtiofsd: Drop CAP_FSETID if client asked for it
Message-ID: <87muanwhom.fsf@redhat.com>
In-reply-to: <20191212163904.159893-54-dgilbert@redhat.com>
Date: Thu, 16 Jan 2020 16:21:35 +0100
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Vivek Goyal <vgoyal@redhat.com>
>
> If client requested killing setuid/setgid bits on file being written, drop
> CAP_FSETID capability so that setuid/setgid bits are cleared upon write
> automatically.
>
> pjdfstest chown/12.t needs this.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>   dgilbert: reworked for libcap-ng
> ---
>  tools/virtiofsd/passthrough_ll.c | 105 +++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 6a09b28608..ab318a6f36 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -201,6 +201,91 @@ static int load_capng(void)
>      return 0;
>  }
>
> +/*
> + * Helpers for dropping and regaining effective capabilities. Returns 0
> + * on success, error otherwise
> + */
> +static int drop_effective_cap(const char *cap_name, bool *cap_dropped)
> +{
> +    int cap, ret;
> +
> +    cap = capng_name_to_capability(cap_name);
> +    if (cap < 0) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "capng_name_to_capability(%s) failed:%s\n",
> +                 cap_name, strerror(errno));
> +        goto out;
> +    }
> +
> +    if (load_capng()) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "load_capng() failed\n");
> +        goto out;
> +    }
> +
> +    /* We dont have this capability in effective set already. */
> +    if (!capng_have_capability(CAPNG_EFFECTIVE, cap)) {
> +        ret = 0;
> +        goto out;
> +    }
> +
> +    if (capng_update(CAPNG_DROP, CAPNG_EFFECTIVE, cap)) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "capng_update(DROP,) failed\n");
> +        goto out;
> +    }
> +
> +    if (capng_apply(CAPNG_SELECT_CAPS)) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "drop:capng_apply() failed\n");
> +        goto out;
> +    }
> +
> +    ret = 0;
> +    if (cap_dropped) {
> +        *cap_dropped = true;
> +    }
> +
> +out:
> +    return ret;
> +}
> +
> +static int gain_effective_cap(const char *cap_name)
> +{
> +    int cap;
> +    int ret = 0;
> +
> +    cap = capng_name_to_capability(cap_name);
> +    if (cap < 0) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "capng_name_to_capability(%s) failed:%s\n",
> +                 cap_name, strerror(errno));
> +        goto out;
> +    }
> +
> +    if (load_capng()) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "load_capng() failed\n");
> +        goto out;
> +    }
> +
> +    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE, cap)) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "capng_update(ADD,) failed\n");
> +        goto out;
> +    }
> +
> +    if (capng_apply(CAPNG_SELECT_CAPS)) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "gain:capng_apply() failed\n");
> +        goto out;
> +    }
> +    ret = 0;
> +
> +out:
> +    return ret;
> +}
> +
>  static void lo_map_init(struct lo_map *map)
>  {
>      map->elems = NULL;
> @@ -1559,6 +1644,7 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t ino,
>      (void)ino;
>      ssize_t res;
>      struct fuse_bufvec out_buf = FUSE_BUFVEC_INIT(fuse_buf_size(in_buf));
> +    bool cap_fsetid_dropped = false;
>
>      out_buf.buf[0].flags = FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
>      out_buf.buf[0].fd = lo_fi_fd(req, fi);
> @@ -1570,12 +1656,31 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t ino,
>                   out_buf.buf[0].size, (unsigned long)off);
>      }
>
> +    /*
> +     * If kill_priv is set, drop CAP_FSETID which should lead to kernel
> +     * clearing setuid/setgid on file.
> +     */
> +    if (fi->kill_priv) {
> +        res = drop_effective_cap("FSETID", &cap_fsetid_dropped);
> +        if (res != 0) {
> +            fuse_reply_err(req, res);
> +            return;
> +        }
> +    }
> +
>      res = fuse_buf_copy(&out_buf, in_buf, 0);
>      if (res < 0) {
>          fuse_reply_err(req, -res);
>      } else {
>          fuse_reply_write(req, (size_t)res);
>      }
> +
> +    if (cap_fsetid_dropped) {
> +        res = gain_effective_cap("FSETID");
> +        if (res) {
> +            fuse_log(FUSE_LOG_ERR, "Failed to gain CAP_FSETID\n");
> +        }
> +    }
>  }
>
>  static void lo_statfs(fuse_req_t req, fuse_ino_t ino)

Fiddling with the capabilities for clearing setuid/setgid on a file
seems a bit weird to me, but I see this was already discussed in
https://lkml.org/lkml/2019/5/20/1229, so...

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4gf38ACgkQ9GknjS8M
AjVCHRAAjpIYLVrMAKklrl11S9mqYVs4Ka7nhZq00qmVfOf1bUqfc2DQHvNuAUrs
/wwE6OLrWoF1BgvWQlvdV2d6tWx2wxYsf2jdWx97qmNPl7ewqGyom6z+7Ar/RcU4
4ZgOVRXYAUo/1333EP70WONxBPlHb604gcQ5mmKWGWn6qSK8JOHFuJOGIC1DETld
myAtqDGeBm/3Ss8JEDqryOXsdT2JfIhANONXrD4/y7ZJ9/Q7MhUKIMEebqDZ5BS2
HpOPKFU8DeLzL5RbyZflp9gzS94/PyYuBOZjR85MEVifZYXqBhDoOD39V8H2fAz2
WbDjtyUuS5fjiv5LQXvckvHmXVlX4tmIWSjJlh5LHG0iYuvPG+jwtm1TRK9if2ts
eEkl1kkzcI+Moe4pyZg8JWTns5/I15k1kD9cRaCWxsO9s+U6fdQHbPI8zKkIbMR5
UxRxa2c49xzqPs6s5vIq5BlXIHqCxGQMUJoSfx3d7fibDaaWXb/+XW3UY0GM3TW9
c2nPbllxJy0Ld5rB0usGnJU5CGlhjS8Lr45uhNg2O1Meyy91OrkW2aFWIjzmPHUr
+nF+vRlRl8IGf/bMt5BcU3uO52kAbmVzEIS/cfdo6rc/kFrElG6TBhtXBkkEq7bH
nweOTmuvm4u+CM+Igz1FedH3ZI3BqJ5SfFTAyk1SQcqdO33q+18=
=sbgb
-----END PGP SIGNATURE-----
--=-=-=--


