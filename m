Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AF7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 19:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F84205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 19:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEgsdsEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F84205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaORk-0001OQ-Mg
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 14:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kaOQf-0000x4-7B
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 14:26:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kaOQd-0007vD-9n
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 14:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604518001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1v4/PXs02iy8pvLWYcGOcDhi0RB9148RdCLtsEIbOZs=;
 b=hEgsdsEiU+c9/z1Q7UYPUQ6JP/MBFCyQgpdEMoX/ujqIyRikaAsznB2FPu2zJ/Y+OvUZvA
 sp/iplPUXDUereOX11DAR5RPdmM9b9Z5CbvWIY1g+T6Z3f1bVufrXskS6lFtBVV4NeORN1
 eISYE/8tfshS9njF+n6TbMR6/MVolhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-URSTrjwgOzyUuKUe9nHBLg-1; Wed, 04 Nov 2020 14:26:25 -0500
X-MC-Unique: URSTrjwgOzyUuKUe9nHBLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C08D057202;
 Wed,  4 Nov 2020 19:26:24 +0000 (UTC)
Received: from [10.3.114.103] (ovpn-114-103.phx2.redhat.com [10.3.114.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F93317511;
 Wed,  4 Nov 2020 19:26:24 +0000 (UTC)
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
References: <1604332203-435466-1-git-send-email-steven.sistare@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH V2] vl: pause option
Message-ID: <d93b83ea-f31d-4e6b-2350-c6d4c9b71448@redhat.com>
Date: Wed, 4 Nov 2020 13:26:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604332203-435466-1-git-send-email-steven.sistare@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 9:50 AM, Steve Sistare wrote:
> Provide the -pause command-line parameter and the QEMU_PAUSE environment
> variable to pause QEMU during process startup using SIGSTOP and allow a
> developer to attach a debugger, or observe the process using tools such as
> strace.  Useful when the QEMU has been launched with some other entity, such
> as libvirt.  QEMU_PAUSE is checked in a constructor at the highest priority,
> and can be used to debug other constructors.  The -pause option is checked
> later, during argument processing in main, but is useful if passing an
> environment variable from a launcher to qemu is awkard.
> 
> Usage: qemu -pause, or QEMU_PAUSE=1
> After attaching a debugger, send SIGCONT to the qemu process to continue.

Changing behavior via a new environment variable is awkward.  What
happens, for example, if libvirt inherits this variable set, but is not
aware of its impact to alter how qemu starts up?  Can we get by with
ONLY a command line option?

Also, how does this option differ from what we already have with qemu
--preconfig?

> 
> Example:
> 
> $ QEMU_PAUSE=1 qemu-system-x86_64 ...
> QEMU pid 18371 is stopped.
> [1]+  Stopped
>                                  $ gdb -p 18371
>                                  (gdb)
> $ kill -cont 18371
>                                  (gdb) break rcu_init
>                                  (gdb) continue
>                                  Program received signal SIGCONT, Continued.
>                                  (gdb) continue
>                                  Breakpoint 1, rcu_init () at util/rcu.c:380
> 
> Thanks to Daniel P. Berrange <berrange@redhat.com> for suggesting SIGSTOP.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qemu-options.hx | 14 ++++++++++++++
>  softmmu/vl.c    | 23 +++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 708583b..42edd70 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3668,6 +3668,20 @@ SRST
>      option is experimental.
>  ERST
>  
> +DEF("pause", 0, QEMU_OPTION_pause, \
> +    "-pause          pause the qemu process in main using SIGSTOP.\n"
> +    "                to pause earlier, before constructors are run, set the\n"
> +    "                environment variable QEMU_PAUSE=1 before starting qemu.\n",
> +    QEMU_ARCH_ALL)
> +
> +SRST
> +``-pause``
> +    Pause the qemu process in main using SIGSTOP.  This is useful for attaching
> +    a debugger after QEMU has been launched by some other entity.  After
> +    attaching, send SIGCONT to continue.  To pause earlier, before constructors
> +    are run, set the environment variable QEMU_PAUSE=1 before starting qemu.
> +ERST

Isn't it always possible to provide a wrapper qemu process to be invoked
by whatever third-party management app (like libvirt), where your
wrapper then starts the real qemu under gdb to begin with, rather than
having to hack qemu itself to have a special start-up mode?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


