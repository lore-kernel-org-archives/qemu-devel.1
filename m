Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD3FC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E9A2087D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJUNwbf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E9A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kITPV-0003cn-QJ
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kITOo-0002fW-6K
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:06:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45352
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kITOm-0002kJ-07
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600247202;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gBd8qguWWtxgsxjei28LteD9dthNyGL1uqpsLP0wrjQ=;
 b=BJUNwbf60+n560hlPFTQ0MDyLpgwQbcvFTtkSjYZDcYmVKJmhaWPWScvHYYWimU4aq6A6x
 APSh1PQvKscRkd0RcAIUOuYhNW6CDN51rVUbcJ5Vq7MeC1ZKKp/Va7yWiHj90EUbzk5qob
 XAYcIkH57+hs54dXr9Gn7fzwAowHzlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-Dneh-gsOMaagkNwGOg1SWA-1; Wed, 16 Sep 2020 05:06:40 -0400
X-MC-Unique: Dneh-gsOMaagkNwGOg1SWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A1C51021D4F
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 09:06:33 +0000 (UTC)
Received: from redhat.com (ovpn-113-248.ams2.redhat.com [10.36.113.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 230635DE46;
 Wed, 16 Sep 2020 09:06:31 +0000 (UTC)
Date: Wed, 16 Sep 2020 10:06:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 1/2] spice: simplify chardev setup
Message-ID: <20200916090629.GH1535709@redhat.com>
References: <20200916083913.11902-1-kraxel@redhat.com>
 <20200916083913.11902-2-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200916083913.11902-2-kraxel@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 10:39:12AM +0200, Gerd Hoffmann wrote:
> Initialize spice before chardevs.  That allows to register the spice
> chardevs directly in the init function and removes the need to maintain
> a linked list of chardevs just for registration.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/chardev/spice.h |  1 -
>  include/ui/qemu-spice.h |  1 -
>  chardev/spice.c         | 29 ++++++-----------------------
>  softmmu/vl.c            |  9 +++++----
>  ui/spice-app.c          | 17 +++++++++--------
>  ui/spice-core.c         |  2 --
>  6 files changed, 20 insertions(+), 39 deletions(-)
> 
> diff --git a/include/chardev/spice.h b/include/chardev/spice.h
> index 99f26aedde54..543b93d38ce3 100644
> --- a/include/chardev/spice.h
> +++ b/include/chardev/spice.h
> @@ -13,7 +13,6 @@ struct SpiceChardev {
>      bool                  blocked;
>      const uint8_t         *datapos;
>      int                   datalen;
> -    QLIST_ENTRY(SpiceChardev) next;
>  };
>  typedef struct SpiceChardev SpiceChardev;
>  
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
> index f7b103467c02..062468d76178 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4121,6 +4121,11 @@ void qemu_init(int argc, char **argv, char **envp)
>      page_size_init();
>      socket_init();
>  
> +    /* spice needs the timers to be initialized by this point */
> +    /* spice must initialize before audio as it changes the default auiodev */
> +    /* spice must initialize before chardevs (for spicevmc and spiceport) */
> +    qemu_spice_init();
> +

I don't think we should be putting this before the '-object' processing too.
We really want -object to be the first thing processed in general.

>      qemu_opts_foreach(qemu_find_opts("object"),
>                        user_creatable_add_opts_foreach,
>                        object_create_initial, &error_fatal);
> @@ -4133,10 +4138,6 @@ void qemu_init(int argc, char **argv, char **envp)
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

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


