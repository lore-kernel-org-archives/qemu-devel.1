Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933F9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607BA2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5wTGaFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607BA2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAG2O-0000yi-Lx
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kAG1l-000091-E3
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:13:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kAG1j-0004pJ-F7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598289178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NC5qYPYiyP0tehpCBxqvdzftI220iTsHxzhT4zXN0a8=;
 b=b5wTGaFsMHPeH05CPwe/qr2Lm8QsPLCqCeAZ5DxrC9/hEFRXHqC2wWiWodUzccQzv+aE/2
 Q9dly3Hq/DF/lqVF4F3WeXFhgQYzxArCnW/tk3WMWbUwug8CKMUztXbmP7g2cAT3EvPgfc
 wA+BUvd+8jvspPlPY/660qvxDzDFJhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-HHyDbFATObSnxwOVzR1e2g-1; Mon, 24 Aug 2020 13:12:55 -0400
X-MC-Unique: HHyDbFATObSnxwOVzR1e2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54E0E10ABDA6;
 Mon, 24 Aug 2020 17:12:54 +0000 (UTC)
Received: from [10.3.112.126] (ovpn-112-126.phx2.redhat.com [10.3.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C18FF1001B2B;
 Mon, 24 Aug 2020 17:12:53 +0000 (UTC)
Subject: Re: [PATCH 2/2] nbd: disable signals and forking on Windows builds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200824170218.106255-1-berrange@redhat.com>
 <20200824170218.106255-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9655e35a-7c0e-0be9-dd7f-a1e7bde7f634@redhat.com>
Date: Mon, 24 Aug 2020 12:12:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824170218.106255-3-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 03:41:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/20 12:02 PM, Daniel P. Berrangé wrote:
> Disabling these parts are sufficient to get the qemu-nbd program
> compiling in a Windows build.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   meson.build |  7 ++-----
>   qemu-nbd.c  | 10 +++++++++-
>   2 files changed, 11 insertions(+), 6 deletions(-)

Feels a bit hacky at what it supports, but certainly better than nothing ;)

> 
> diff --git a/meson.build b/meson.build
> index df5bf728b5..1071871605 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1074,12 +1074,9 @@ if have_tools
>                dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
>     qemu_io = executable('qemu-io', files('qemu-io.c'),
>                dependencies: [block, qemuutil], install: true)
> -  qemu_block_tools += [qemu_img, qemu_io]
> -  if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
> -    qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
> +  qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
>                  dependencies: [block, qemuutil], install: true)

Conflicts with this patch:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg05546.html

but this one gets rid of the need for that one.

> -    qemu_block_tools += [qemu_nbd]
> -  endif
> +  qemu_block_tools += [qemu_img, qemu_io, qemu_nbd]
>   
>     subdir('storage-daemon')
>     subdir('contrib/rdmacm-mux')
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index b102874f0f..c6fd6524d3 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -155,12 +155,13 @@ QEMU_COPYRIGHT "\n"
>       , name);
>   }
>   
> +#ifndef WIN32
>   static void termsig_handler(int signum)
>   {
>       atomic_cmpxchg(&state, RUNNING, TERMINATE);
>       qemu_notify_event();
>   }
> -
> +#endif

How does one terminate a long-running server on Windows if there is no 
SIGTERM handler?  I guess Ctrl-C does something, but without the state 
notification from a signal handler, you are getting less-clean 
shutdowns, which may explain the hangs you were seeing in testing?  But 
incremental progress is fine, and I see no reason to not take this patch 
as-is.

Reviewed-by: Eric Blake <eblake@redhat.com>

I'm happy to queue this series through my NBD tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


