Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788BCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F0E2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3qUw9HQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F0E2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3TC-0002OG-Cx
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iv3SW-0001XN-7I
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iv3SU-00037H-D5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:13:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48887
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iv3SU-00036e-5q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579889609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLXDjjSKeHl7McRay9CND9SUlvC4pHsnz6BStnRFjUM=;
 b=S3qUw9HQM+F4nHUS98b48RL7pbIGvwOVYR6hDwDF3xExGkjDMwsmKRZs7nztZqtgdzFNmQ
 /3Rx8sFwJWos+4/sjO1RMcTgdaKPh8/gLnMFYNT500NZpQGQ8eRH+B68BXTcZAzE/DeAhY
 lTiPSWcxejiRuK5rNS/WamB5HGAX8es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-pnTgzRAzPl6uD8xyjA3EyA-1; Fri, 24 Jan 2020 13:13:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C8B918FE860
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 18:13:26 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABC1C85794;
 Fri, 24 Jan 2020 18:13:24 +0000 (UTC)
Date: Fri, 24 Jan 2020 18:13:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 16/21] migration: Add support for modules
Message-ID: <20200124181322.GY2970@work-vm>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-17-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-17-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: pnTgzRAzPl6uD8xyjA3EyA-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> So we don't have to compile everything in, or have ifdefs

Can you explain to me what this is allowing us to do?

Dave

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/qemu/module.h | 2 ++
>  vl.c                  | 1 +
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 65ba596e46..907cb5c0a5 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -40,6 +40,7 @@ static void __attribute__((constructor)) do_qemu_init_ =
## function(void)    \
>  #endif
> =20
>  typedef enum {
> +    MODULE_INIT_MIGRATION,
>      MODULE_INIT_BLOCK,
>      MODULE_INIT_OPTS,
>      MODULE_INIT_QOM,
> @@ -56,6 +57,7 @@ typedef enum {
>  #define xen_backend_init(function) module_init(function, \
>                                                 MODULE_INIT_XEN_BACKEND)
>  #define libqos_init(function) module_init(function, MODULE_INIT_LIBQOS)
> +#define migration_init(function) module_init(function, MODULE_INIT_MIGRA=
TION)
> =20
>  #define block_module_load_one(lib) module_load_one("block-", lib)
>  #define ui_module_load_one(lib) module_load_one("ui-", lib)
> diff --git a/vl.c b/vl.c
> index 71d3e7eefb..f331a3921f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2873,6 +2873,7 @@ int main(int argc, char **argv, char **envp)
>      qemu_init_exec_dir(argv[0]);
> =20
>      module_call_init(MODULE_INIT_QOM);
> +    module_call_init(MODULE_INIT_MIGRATION);
> =20
>      qemu_add_opts(&qemu_drive_opts);
>      qemu_add_drive_opts(&qemu_legacy_drive_opts);
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


