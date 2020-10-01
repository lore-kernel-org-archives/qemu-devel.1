Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDC0C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 05:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF6B221E8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 05:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bY9pyMSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF6B221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNqrM-0002iL-QY
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 01:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNqqH-0002AH-Al
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 01:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNqqF-0004Vt-LD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 01:09:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601528957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9lCOsKD2b4dh8GnAReuq9vVLCVB81CtqawkVpAhRsc=;
 b=bY9pyMSYSii5GdTmPmJxQ85fqJSQlITojPlp4QtDatM4X1cPptfstHG0BhA6FuQDeHmMdi
 ILsYhy+/6EfdHB0f96HrLBH0fUIFLcX+4mLb6RwTKOXE0BGB1IjKvHzwGR8QxuX0cyCiu2
 iXsah6JBQ11jf6VqGNJgrHlqiZf0Gv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-cgAPHMM2NqGHoKTfyDiZuw-1; Thu, 01 Oct 2020 01:09:15 -0400
X-MC-Unique: cgAPHMM2NqGHoKTfyDiZuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3225E7A1E3;
 Thu,  1 Oct 2020 05:09:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D60307880B;
 Thu,  1 Oct 2020 05:09:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 53096113864A; Thu,  1 Oct 2020 07:09:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 11/11] qapi: Restrict code generated for user-mode
References: <20200930164949.1425294-1-philmd@redhat.com>
 <20200930164949.1425294-12-philmd@redhat.com>
Date: Thu, 01 Oct 2020 07:09:12 +0200
In-Reply-To: <20200930164949.1425294-12-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 30 Sep 2020 18:49:49
 +0200")
Message-ID: <87mu164jnr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 00:27:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> A lot of QAPI generated code is never used by user-mode.
>
> Split out qapi_system_modules and qapi_system_or_tools_modules
> from the qapi_all_modules array. We now have 3 groups:
> - always used
> - use by system-mode or tools (usually by the block layer)
> - only used by system-mode
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Resetting due to Meson update:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  qapi/meson.build | 51 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
>
> diff --git a/qapi/meson.build b/qapi/meson.build
> index 7c4a89a882..ba9677ba97 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -14,39 +14,60 @@ util_ss.add(files(
>  ))
> =20
>  qapi_all_modules =3D [
> +  'common',
> +  'introspect',
> +  'misc',
> +]
> +
> +qapi_system_modules =3D [
>    'acpi',
>    'audio',
> +  'dump',
> +  'machine-target',
> +  'machine',
> +  'migration',
> +  'misc-target',
> +  'net',
> +  'pci',
> +  'qdev',
> +  'rdma',
> +  'rocker',
> +  'tpm',
> +  'trace',
> +]
> +
> +# system or tools
> +qapi_block_modules =3D [
>    'authz',
>    'block-core',
>    'block',
>    'char',
> -  'common',
>    'control',
>    'crypto',
> -  'dump',
>    'error',
> -  'introspect',
>    'job',
> -  'machine',
> -  'machine-target',
> -  'migration',
> -  'misc',
> -  'misc-target',
> -  'net',
>    'pragma',
> -  'qdev',
> -  'pci',
>    'qom',
> -  'rdma',
> -  'rocker',
>    'run-state',
>    'sockets',
> -  'tpm',
> -  'trace',
>    'transaction',
>    'ui',
>  ]

Most of these aren't "block modules".  Name the thing
qapi_system_or_tools_modules?

> +if have_system
> +  qapi_all_modules +=3D qapi_system_modules
> +elif have_user
> +  # Temporary kludge because X86CPUFeatureWordInfo is not
> +  # restricted to system-mode. This should be removed (along
> +  # with target/i386/feature-stub.c) once target/i386/cpu.c
> +  # has been cleaned.
> +  qapi_all_modules +=3D ['machine-target']
> +endif
> +
> +if have_block

Aha, precedence for using "block" as an abbreviation of "system or
tools".  I find that confusing.

> +  qapi_all_modules +=3D qapi_block_modules
> +endif
> +
>  qapi_storage_daemon_modules =3D [
>    'block-core',
>    'char',


