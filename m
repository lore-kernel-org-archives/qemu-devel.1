Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46893C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E625A20672
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+GsFNlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E625A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iailm-0004Yr-2a
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 11:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iahg7-0000VJ-7S
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iahg2-0007cw-Dd
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:55:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iahg1-0007VH-Ms
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575039318;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OUnAYlhSWMjzS0fx2/8Ax8szUdBbalsKBKs5r9jABBg=;
 b=X+GsFNljIk1z/HAE6cIC3EO5QMx5KAWcvOO+Mz4HAyWemUTsQ9sLgBg0P3I3en/roKTzRp
 2EzgtGO3md1SPeRH1DOBU/gw5V/Cnwk7Eh/88dLdXM3K6modygnldeBDcHJvwRDoNjuGue
 lEaG9DIDYgxFih1bxjiQMzcQSAx//kE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-2FWHJCOxMC68hkqAhblbpQ-1; Fri, 29 Nov 2019 09:55:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91D2C10054E3;
 Fri, 29 Nov 2019 14:55:14 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.ams2.redhat.com [10.36.112.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C571A60BF1;
 Fri, 29 Nov 2019 14:55:12 +0000 (UTC)
Date: Fri, 29 Nov 2019 14:55:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtfs-proxy-helper: switch from libcap to libcap-ng
Message-ID: <20191129145510.GK2260471@redhat.com>
References: <20191129111632.22840-2-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191129111632.22840-2-pbonzini@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2FWHJCOxMC68hkqAhblbpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: groug@kaod.org, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 12:16:32PM +0100, Paolo Bonzini wrote:
> virtfs-proxy-helper is the only user of libcap; everyone else is using
> the simpler libcap-ng API.  Switch and remove the configure code to
> detect libcap.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                   |  18 +------
>  fsdev/virtfs-proxy-helper.c | 100 ++++++++++++++++--------------------
>  2 files changed, 46 insertions(+), 72 deletions(-)

The dockerfiles can also be updated to remove libcap-dev/devel

>=20
> diff --git a/configure b/configure
> index afe9393f04..2216662bf6 100755
> --- a/configure
> +++ b/configure
> @@ -3863,22 +3863,6 @@ else
>    mpathpersist=3Dno
>  fi
> =20
> -##########################################
> -# libcap probe
> -
> -if test "$cap" !=3D "no" ; then
> -  cat > $TMPC <<EOF
> -#include <stdio.h>
> -#include <sys/capability.h>
> -int main(void) { cap_t caps; caps =3D cap_init(); return caps !=3D NULL;=
 }
> -EOF
> -  if compile_prog "" "-lcap" ; then
> -    cap=3Dyes
> -  else
> -    cap=3Dno
> -  fi
> -fi
> -
>  ##########################################
>  # pthread probe
>  PTHREADLIBS_LIST=3D"-pthread -lpthread -lpthreadGC2"
> @@ -6204,7 +6188,7 @@ if test "$want_tools" =3D "yes" ; then
>  fi
>  if test "$softmmu" =3D yes ; then
>    if test "$linux" =3D yes; then
> -    if test "$virtfs" !=3D no && test "$cap" =3D yes && test "$attr" =3D=
 yes ; then
> +    if test "$virtfs" !=3D no && test "$cap_ng" =3D yes && test "$attr" =
=3D yes ; then
>        virtfs=3Dyes
>        tools=3D"$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
>      else
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index 6f132c5ff1..0d4de49dcf 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -13,7 +13,6 @@
>  #include <sys/resource.h>
>  #include <getopt.h>
>  #include <syslog.h>
> -#include <sys/capability.h>
>  #include <sys/fsuid.h>
>  #include <sys/vfs.h>
>  #include <sys/ioctl.h>
> @@ -21,6 +20,7 @@
>  #ifdef CONFIG_LINUX_MAGIC_H
>  #include <linux/magic.h>
>  #endif
> +#include <cap-ng.h>
>  #include "qemu-common.h"
>  #include "qemu/sockets.h"
>  #include "qemu/xattr.h"
> @@ -79,49 +79,10 @@ static void do_perror(const char *string)
>      }
>  }
> =20
> -static int do_cap_set(cap_value_t *cap_value, int size, int reset)
> -{
> -    cap_t caps;
> -    if (reset) {
> -        /*
> -         * Start with an empty set and set permitted and effective
> -         */
> -        caps =3D cap_init();
> -        if (caps =3D=3D NULL) {
> -            do_perror("cap_init");
> -            return -1;
> -        }
> -        if (cap_set_flag(caps, CAP_PERMITTED, size, cap_value, CAP_SET) =
< 0) {
> -            do_perror("cap_set_flag");
> -            goto error;
> -        }
> -    } else {
> -        caps =3D cap_get_proc();
> -        if (!caps) {
> -            do_perror("cap_get_proc");
> -            return -1;
> -        }
> -    }
> -    if (cap_set_flag(caps, CAP_EFFECTIVE, size, cap_value, CAP_SET) < 0)=
 {
> -        do_perror("cap_set_flag");
> -        goto error;
> -    }
> -    if (cap_set_proc(caps) < 0) {
> -        do_perror("cap_set_proc");
> -        goto error;
> -    }
> -    cap_free(caps);
> -    return 0;
> -
> -error:
> -    cap_free(caps);
> -    return -1;
> -}
> -
>  static int init_capabilities(void)
>  {
>      /* helper needs following capabilities only */
> -    cap_value_t cap_list[] =3D {
> +    int cap_list[] =3D {
>          CAP_CHOWN,
>          CAP_DAC_OVERRIDE,
>          CAP_FOWNER,
> @@ -130,7 +91,34 @@ static int init_capabilities(void)
>          CAP_MKNOD,
>          CAP_SETUID,
>      };
> -    return do_cap_set(cap_list, ARRAY_SIZE(cap_list), 1);
> +    int i;
> +
> +    capng_clear(CAPNG_SELECT_BOTH);
> +    for (i =3D 0; i < ARRAY_SIZE(cap_list); i++) {
> +        if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
> +                         cap_list[i]) < 0) {
> +            do_perror("capng_update");
> +            return -1;
> +        }
> +    }
> +    if (capng_apply(CAPNG_SELECT_BOTH) < 0) {
> +        do_perror("capng_apply");
> +        return -1;
> +    }
> +
> +    /* Prepare effective set for setugid.  */
> +    for (i =3D 0; i < ARRAY_SIZE(cap_list); i++) {
> +        if (cap_list[i] =3D=3D CAP_DAC_OVERRIDE) {
> +            continue;
> +        }
> +
> +        if (capng_update(CAPNG_DROP, CAPNG_EFFECTIVE,
> +                         cap_list[i]) < 0) {
> +            do_perror("capng_update");
> +            return -1;
> +        }
> +    }
> +    return 0;
>  }
> =20
>  static int socket_read(int sockfd, void *buff, ssize_t size)
> @@ -295,14 +283,6 @@ static int setugid(int uid, int gid, int *suid, int =
*sgid)
>  {
>      int retval;
> =20
> -    /*
> -     * We still need DAC_OVERRIDE because we don't change
> -     * supplementary group ids, and hence may be subjected DAC rules
> -     */
> -    cap_value_t cap_list[] =3D {
> -        CAP_DAC_OVERRIDE,
> -    };
> -
>      *suid =3D geteuid();
>      *sgid =3D getegid();
> =20
> @@ -316,11 +296,21 @@ static int setugid(int uid, int gid, int *suid, int=
 *sgid)
>          goto err_sgid;
>      }
> =20
> -    if (uid !=3D 0 || gid !=3D 0) {
> -        if (do_cap_set(cap_list, ARRAY_SIZE(cap_list), 0) < 0) {
> -            retval =3D -errno;
> -            goto err_suid;
> -        }
> +    if (uid =3D=3D 0 && gid =3D=3D 0) {
> +        /* Linux has already copied the permitted set to the effective s=
et.  */
> +        return 0;
> +    }
> +
> +    /*
> +     * All capabilities have been cleared from the effective set.  Howev=
er
> +     * we still need DAC_OVERRIDE because we don't change supplementary
> +     * group ids, and hence may be subject to DAC rules.  init_capabilit=
ies
> +     * left the set of capabilities that we want in libcap-ng's state.
> +     */
> +    if (capng_apply(CAPNG_SELECT_CAPS) < 0) {
> +        retval =3D -errno;
> +        do_perror("capng_apply");
> +        goto err_suid;
>      }
>      return 0;
> =20
> --=20
> 2.21.0
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


