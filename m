Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AFFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6020F2068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Thlclh3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6020F2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBI1-0001Iv-KK
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyAve-0003fk-9B
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31682
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyAvc-0005qE-4t
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595409643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6oxadvl044Hn4x6BwnnpGinquRe3KiQW8/2wnjNB/U=;
 b=Thlclh3od0LTq023axT3NtlBz2kXrrg5UlvemU97XKa8YfG63JJcE0x84b3HOx8g25+jnE
 mmU6XN/b+a+v9+7fAvCe8TznIVyOkBYH+ToaDtuf127P7+b3AbvsezfWQAaoo5BVUzz9sC
 dJNMGgnQXuPzJd5nfDHyX6752RmKgTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-ZqXywG7wPCeG1dt2ndMykA-1; Wed, 22 Jul 2020 05:20:41 -0400
X-MC-Unique: ZqXywG7wPCeG1dt2ndMykA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A05C180183C
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:20:40 +0000 (UTC)
Received: from titinator (ovpn-113-160.ams2.redhat.com [10.36.113.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D94561463;
 Wed, 22 Jul 2020 09:20:33 +0000 (UTC)
References: <20200722084935.9601-1-kraxel@redhat.com>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] spice: simplify chardev setup
In-reply-to: <20200722084935.9601-1-kraxel@redhat.com>
Date: Wed, 22 Jul 2020 11:20:31 +0200
Message-ID: <lytuxzhpnk.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-07-22 at 10:49 CEST, Gerd Hoffmann wrote...
> Initialize spice before chardevs.  That allows to register the spice
> chardevs directly in the init function and removes the need to maintain
> a linked list of chardevs just for registration.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Looks good to me, but I still need to test how this integrates with my work
on putting SPICE in a module.

Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>

> ---
>  include/chardev/spice.h |  1 -
>  include/ui/qemu-spice.h |  1 -
>  chardev/spice.c         | 29 ++++++-----------------------
>  softmmu/vl.c            |  9 +++++----
>  ui/spice-core.c         |  2 --
>  5 files changed, 11 insertions(+), 31 deletions(-)
>
> diff --git a/include/chardev/spice.h b/include/chardev/spice.h
> index 1f7339b649dc..2013255f34fd 100644
> --- a/include/chardev/spice.h
> +++ b/include/chardev/spice.h
> @@ -12,7 +12,6 @@ typedef struct SpiceChardev {
>      bool                  blocked;
>      const uint8_t         *datapos;
>      int                   datalen;
> -    QLIST_ENTRY(SpiceChardev) next;
>  } SpiceChardev;
>
>  #define TYPE_CHARDEV_SPICE "chardev-spice"
> diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
> index 8c23dfe71797..d34cea2e0fcd 100644
> --- a/include/ui/qemu-spice.h
> +++ b/include/ui/qemu-spice.h
> @@ -46,7 +46,6 @@ int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
>  #else
>  #define SPICE_NEEDS_SET_MM_TIME 0
>  #endif
> -void qemu_spice_register_ports(void);
>
>  #else  /* CONFIG_SPICE */
>
> diff --git a/chardev/spice.c b/chardev/spice.c
> index bf7ea1e2940d..9733f0671699 100644
> --- a/chardev/spice.c
> +++ b/chardev/spice.c
> @@ -14,9 +14,6 @@ typedef struct SpiceCharSource {
>      SpiceChardev       *scd;
>  } SpiceCharSource;
>
> -static QLIST_HEAD(, SpiceChardev) spice_chars =
> -    QLIST_HEAD_INITIALIZER(spice_chars);
> -
>  static int vmc_write(SpiceCharDeviceInstance *sin, const uint8_t *buf, int len)
>  {
>      SpiceChardev *scd = container_of(sin, SpiceChardev, sin);
> @@ -216,8 +213,6 @@ static void char_spice_finalize(Object *obj)
>
>      vmc_unregister_interface(s);
>
> -    QLIST_SAFE_REMOVE(s, next);
> -
>      g_free((char *)s->sin.subtype);
>      g_free((char *)s->sin.portname);
>  }
> @@ -256,8 +251,6 @@ static void chr_open(Chardev *chr, const char *subtype)
>
>      s->active = false;
>      s->sin.subtype = g_strdup(subtype);
> -
> -    QLIST_INSERT_HEAD(&spice_chars, s, next);
>  }
>
>  static void qemu_chr_open_spice_vmc(Chardev *chr,
> @@ -310,28 +303,18 @@ void qemu_chr_open_spice_port(Chardev *chr,
>          return;
>      }
>
> +    if (!using_spice) {
> +        error_setg(errp, "spice not enabled");
> +        return;
> +    }
> +
>      chr_open(chr, "port");
>
>      *be_opened = false;
>      s = SPICE_CHARDEV(chr);
>      s->sin.portname = g_strdup(name);
>
> -    if (using_spice) {
> -        /* spice server already created */
> -        vmc_register_interface(s);
> -    }
> -}
> -
> -void qemu_spice_register_ports(void)
> -{
> -    SpiceChardev *s;
> -
> -    QLIST_FOREACH(s, &spice_chars, next) {
> -        if (s->sin.portname == NULL) {
> -            continue;
> -        }
> -        vmc_register_interface(s);
> -    }
> +    vmc_register_interface(s);
>  }
>
>  static void qemu_chr_parse_spice_vmc(QemuOpts *opts, ChardevBackend *backend,
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index f476ef89edb7..bc0dcc4f58bd 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4125,6 +4125,11 @@ void qemu_init(int argc, char **argv, char **envp)
>      page_size_init();
>      socket_init();
>
> +    /* spice needs the timers to be initialized by this point */
> +    /* spice must initialize before audio as it changes the default auiodev */
> +    /* spice must initialize before chardevs (for spicevmc and spiceport) */
> +    qemu_spice_init();
> +
>      qemu_opts_foreach(qemu_find_opts("object"),
>                        user_creatable_add_opts_foreach,
>                        object_create_initial, &error_fatal);
> @@ -4139,10 +4144,6 @@ void qemu_init(int argc, char **argv, char **envp)
>                        fsdev_init_func, NULL, &error_fatal);
>  #endif
>
> -    /* spice needs the timers to be initialized by this point */
> -    /* spice must initialize before audio as it changes the default auiodev */
> -    qemu_spice_init();
> -
>      /*
>       * Note: we need to create audio and block backends before
>       * machine_set_property(), so machine properties can refer to
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index ecc2ec2c55c2..37dd68f2aba2 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -813,8 +813,6 @@ void qemu_spice_init(void)
>      g_free(x509_cert_file);
>      g_free(x509_cacert_file);
>
> -    qemu_spice_register_ports();
> -
>  #ifdef HAVE_SPICE_GL
>      if (qemu_opt_get_bool(opts, "gl", 0)) {
>          if ((port != 0) || (tls_port != 0)) {


--
Cheers,
Christophe de Dinechin (IRC c3d)


