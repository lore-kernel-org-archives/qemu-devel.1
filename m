Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D14C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585F420707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O20vKIJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585F420707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqpc-00075E-J6
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAqog-0006X2-Qj
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:29:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAqoe-0007do-Sl
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598430594;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5teG5h+tB9q4xnWp1vCQZ+nJ6SSQ7zogiS5UhHA69c=;
 b=O20vKIJQ0SY0+Xp/Mh4WduWrGzyms7ue5JpDKHlSfq1MMsU5KRJguucRFeWjrDwaPD2bs4
 z3U4iSLtILe2Zb1dfLzGcBKa04RiNf4lMFL9e2nv/otP9w4kr/C183eDxviJWnTyt9nRrL
 IAd3JF5vJ15+fv9elwcvzQ1vAkSBDis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-iHrz-IDVOTWbkzna-cVhdQ-1; Wed, 26 Aug 2020 04:29:49 -0400
X-MC-Unique: iHrz-IDVOTWbkzna-cVhdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1002189E618;
 Wed, 26 Aug 2020 08:29:48 +0000 (UTC)
Received: from redhat.com (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B674E19C58;
 Wed, 26 Aug 2020 08:29:44 +0000 (UTC)
Date: Wed, 26 Aug 2020 09:29:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH v2 2/5] meson: use meson datadir instead of qemu_datadir
Message-ID: <20200826082942.GD168515@redhat.com>
References: <20200825175827.355940-1-marcandre.lureau@redhat.com>
 <20200825175827.355940-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200825175827.355940-3-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: sw@weilnetz.de, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 09:58:24PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When cross-compiling, by default qemu_datadir is 'c:\Program
> Files\QEMU', which is not recognized as being an absolute path, and
> meson will end up adding the prefix again.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-gpu/meson.build | 2 +-
>  meson.build                        | 3 ++-
>  pc-bios/descriptors/meson.build    | 2 +-
>  pc-bios/keymaps/meson.build        | 6 +++---
>  pc-bios/meson.build                | 2 +-
>  tools/virtiofsd/meson.build        | 2 +-
>  trace/meson.build                  | 2 +-
>  7 files changed, 10 insertions(+), 9 deletions(-)
> 

> diff --git a/meson.build b/meson.build
> index f0fe5f8799..20f20a7bfc 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -17,6 +17,7 @@ config_all_disas = keyval.load(meson.current_build_dir() / 'config-all-disas.mak
>  enable_modules = 'CONFIG_MODULES' in config_host
>  enable_static = 'CONFIG_STATIC' in config_host
>  build_docs = 'BUILD_DOCS' in config_host
> +qemu_datadir = get_option('datadir') + get_option('confsuffix')

This needs to be

   get_option('datadir') / get_option('confsuffix')

to add the dir separator if we're using the default meson value
for "confsuffix" which lacks a leading "/".


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


