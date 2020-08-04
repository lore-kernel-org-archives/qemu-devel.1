Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4268CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA3A22B45
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxbxh0vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA3A22B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2u2H-0001G1-BE
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k2u1k-0000qz-EL
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:18:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38832
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k2u1i-00081M-VL
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596536313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92DR/mqsC2c6GKY57LMZDKCkykGG6P0veZQXZlBvqBc=;
 b=gxbxh0vNqJ0+jdrPsWq1HG4MJXdlF3v+YsHGSX34TZ7y0XiKVaMmtBeWyeWx+QoTtaflqM
 QVnd5w57vFZkwfckgyyUpR/ACW02G7AzblyyIS1X26iksmeRrLcMZ/I0eImubDfhGhoTYy
 MGien98JTYwJOzJXiHF0otshckqVzJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-m9X-JF2GMgOF0TDMwHspag-1; Tue, 04 Aug 2020 06:18:31 -0400
X-MC-Unique: m9X-JF2GMgOF0TDMwHspag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD2588064DE;
 Tue,  4 Aug 2020 10:18:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9A417178F;
 Tue,  4 Aug 2020 10:18:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0BDFD16E0A; Tue,  4 Aug 2020 12:18:21 +0200 (CEST)
Date: Tue, 4 Aug 2020 12:18:21 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 7/7] spice: Call qemu spice functions indirectly
Message-ID: <20200804101821.dufg7fqeuodoiswf@sirius.home.kraxel.org>
References: <20200723174615.2370096-1-dinechin@redhat.com>
 <20200723174615.2370096-8-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723174615.2370096-8-dinechin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

These stubs (picked two examples) ...

> -static inline int qemu_spice_set_passwd(const char *passwd,
> -                                        bool fail_if_connected,
> -                                        bool disconnect_if_connected)
> -{
> -    return -1;
> -}

> -static inline void qemu_spice_display_init(void)
> -{
> -    /* This must never be called if CONFIG_SPICE is disabled */
> -    error_report("spice support is disabled");
> -    abort();
> -}

... can simply be moved to this place ...

> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -173,6 +173,30 @@ int icount_align_option;
>  QemuUUID qemu_uuid;
>  bool qemu_uuid_set;
>  
> +static bool qemu_is_not_using_spice(void)
> +{
> +    return 0;
> +}
> +
> +static void qemu_spice_init_no_op(void)
> +{
> +}

(I'd suggest to name this qemu_spice_display_init_stub)

> +
> +/*
> + * Only two fields are initialized, that can be used even when SPICE
> + * is not configured or not loaded. Other functions are protected by
> + * checking if using_spice.
> + */
> +QemuSpiceOps qemu_spice = {
> +    .in_use             = qemu_is_not_using_spice,
> +    .init               = qemu_spice_init_no_op,

... and hooked up here, i.e.

       .init               = qemu_spice_display_init_stub,
       .set_passwd         = qemu_spice_set_passwd_stub,
       [ ... ]

Also I'd suggest to place the code in a new file (maybe named
ui/spice-ops.c, or ui/spice-stubs.c) which is compiled into qemu
unconditionally.

take care,
  Gerd


