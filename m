Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A88C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 05:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4191C204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 05:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQWeeUI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4191C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kARd1-0001w0-GZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 01:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kARcS-0001MV-86
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 01:35:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kARcP-0006SR-QN
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 01:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598333736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/iBvo7Qvpf2Satl4i6QhyzLoYW8GgHyKSEUnZHPF70=;
 b=MQWeeUI6AbrlzU35hnARdegK7L8QGhdzYPqkzdh2Wg3KWIGwnFFhOKqWhZc7kWbeLRKAlN
 yOiPBrp4rvgBtqLN/tRzFmsjNqH4JkAr+wWHBD9bPqWc4Fshf3EGv+fdb+BcERWjFMwruf
 mpTxXW8t797PCEI74MiWQFJNIEnHH+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-ll731cgIPJ2Nc49YoPer3g-1; Tue, 25 Aug 2020 01:35:32 -0400
X-MC-Unique: ll731cgIPJ2Nc49YoPer3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F83880732F;
 Tue, 25 Aug 2020 05:35:31 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-152.ams2.redhat.com [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E06C6100239B;
 Tue, 25 Aug 2020 05:35:29 +0000 (UTC)
Subject: Re: [PATCH 2/2] nbd: disable signals and forking on Windows builds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200824170218.106255-1-berrange@redhat.com>
 <20200824170218.106255-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <febc3a8b-baa1-f7b0-236a-26b11a80089b@redhat.com>
Date: Tue, 25 Aug 2020 07:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200824170218.106255-3-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/08/2020 19.02, Daniel P. Berrangé wrote:
> Disabling these parts are sufficient to get the qemu-nbd program
> compiling in a Windows build.

Maybe add:
"This also enables compilation of qemu-nbd on macOS again (which got 
disabled by accident during the conversion to the meson build system)"

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   meson.build |  7 ++-----
>   qemu-nbd.c  | 10 +++++++++-
>   2 files changed, 11 insertions(+), 6 deletions(-)
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
>   
>   static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
>                                   const char *hostname)
> @@ -587,6 +588,7 @@ int main(int argc, char **argv)
>       unsigned socket_activation;
>       const char *pid_file_name = NULL;
>   
> +#ifndef WIN32
>       /* The client thread uses SIGTERM to interrupt the server.  A signal
>        * handler ensures that "qemu-nbd -v -c" exits with a nice status code.
>        */
> @@ -594,6 +596,7 @@ int main(int argc, char **argv)
>       memset(&sa_sigterm, 0, sizeof(sa_sigterm));
>       sa_sigterm.sa_handler = termsig_handler;
>       sigaction(SIGTERM, &sa_sigterm, NULL);
> +#endif
>   
>   #ifdef CONFIG_POSIX

I wonder why the CONFIG_POSIX does not simply start earlier here ... I 
think you could replace your #ifndef WIN32 with #ifdef CONFIG_POSIX that 
way?

>       signal(SIGPIPE, SIG_IGN);
> @@ -896,6 +899,7 @@ int main(int argc, char **argv)
>   #endif
>   
>       if ((device && !verbose) || fork_process) {
> +#ifndef WIN32
>           int stderr_fd[2];
>           pid_t pid;
>           int ret;
> @@ -959,6 +963,10 @@ int main(int argc, char **argv)
>                */
>               exit(errors);
>           }
> +#else /* WIN32 */
> +        error_report("Unable to fork into background on Windows hosts");
> +        exit(EXIT_FAILURE);
> +#endif /* WIN32 */
>       }
>   
>       if (device != NULL && sockpath == NULL) {
> 

  Thomas


