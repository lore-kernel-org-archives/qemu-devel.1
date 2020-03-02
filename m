Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F49C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84054222C4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFfh82L9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84054222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8p0d-0007aq-NS
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8ozO-0006CP-2D
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8ozM-0007nN-9s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:36:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8ozM-0007nE-5f
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583170579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAKfhcxDCBrQteGnsJBNhOpQL0HhObrrVKAGr81+Oc0=;
 b=YFfh82L96AiPYTk0w5i7jWi+LFFu3oaSWcPm7fwLzJJqm03ONmXyLRGLDcJcklGB9HjD6b
 HJmdp4EopePXVrt793SHQ/Hp2YAdJ+1Obi5mrfWSEjsUThw3hSidB73/+Khienzl77IGv5
 3JIWYZIUiQdOEf9K5TVn9F/Ury0Py3U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-0yIyeSGBOlucmPl7ayBm7g-1; Mon, 02 Mar 2020 12:36:18 -0500
X-MC-Unique: 0yIyeSGBOlucmPl7ayBm7g-1
Received: by mail-wm1-f71.google.com with SMTP id g26so18908wmk.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UAKfhcxDCBrQteGnsJBNhOpQL0HhObrrVKAGr81+Oc0=;
 b=lpYvR8RIJC0VVtGvXwHaHHP2HoW/sIdQjToaCAdsBWQRfhau9rVGeckGgqVRptkml/
 0JCcAYux+v137jXZSWjNEwfCrJirUPPIdaKqPGGTIGym7W9xa1zTDSzTlghK4jzytGe8
 cnunJ6T36zz+clHei/72zan4BkbsNB9lc8mvGRgB2HtiZ6ALt8pJC49vge7VKMdYckA0
 vYVEciwwFTrMLXCNGgsZbMNeQAdRGpWZqgDpHUgKnaAPuIzIDeW5Q0BEJVstZ2+PEUa1
 B7wXf+mCSHXRH7huFgDHIvKNqgwzVxxNsHzg4BGF3+QUrYKP1YZ2lzIaCttdJC8tfRBa
 xdmQ==
X-Gm-Message-State: ANhLgQ25Ff7348ZMlvLVIxzvoJfQlC08ewz3kESj7hB8x0JnIZcLxZ9z
 zRnzigKpj++zB593+ZmEgVVp0whMQHCTjg8EKJDAcHoFKAEg9SiA2yxMMZNGppV9Mcr/55J2u35
 OHTX3lNz75HKZf9s=
X-Received: by 2002:a5d:5506:: with SMTP id b6mr648577wrv.94.1583170576925;
 Mon, 02 Mar 2020 09:36:16 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsWg+A9I+90tWjxKvFklZTdVaKLTZU+V8r7pCysF6A2XWDx2YC+frMo6VvNXEPrimA1mWxG5g==
X-Received: by 2002:a5d:5506:: with SMTP id b6mr648554wrv.94.1583170576638;
 Mon, 02 Mar 2020 09:36:16 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id s5sm27584468wru.39.2020.03.02.09.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 09:36:16 -0800 (PST)
Subject: Re: [PATCH v5 14/50] mutli-process: build remote command line args
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org,
 berrange@redhat.com
References: <cover.1582576372.git.jag.raman@oracle.com>
 <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <acc40fcd-2871-df80-d420-b9f12dfcf19c@redhat.com>
Date: Mon, 2 Mar 2020 18:36:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, quintela@redhat.com,
 mst@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

typo "multi" in patch subject.

On 2/24/20 9:55 PM, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>   v4 -> v5:
>    - Added "exec" suboption to get the executable's name
>    - Addressed feedback about variable names
>    - Removed redundant check for spawning a process
> 
>   hw/proxy/qemu-proxy.c         | 68 +++++++++++++++++++++++++++++++++----------
>   include/hw/proxy/qemu-proxy.h |  2 +-
>   2 files changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index 828bbd7..d792e86 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -19,19 +19,50 @@
>   
>   static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
>   
> +static int add_argv(char *opts_str, char **argv, int argc)
> +{
> +    int max_args = 64;
> +
> +    if (argc < max_args - 1) {
> +        argv[argc++] = opts_str;
> +        argv[argc] = 0;
> +    } else {
> +        return 0;
> +    }
> +
> +    return argc;
> +}
> +
> +static int make_argv(char *opts_str, char **argv, int argc)
> +{
> +    int max_args = 64;
> +
> +    char *p2 = strtok(opts_str, " ");
> +    while (p2 && argc < max_args - 1) {
> +        argv[argc++] = p2;
> +        p2 = strtok(0, " ");
> +    }
> +    argv[argc] = 0;

Is there a GLib function to do that?

> +
> +    return argc;
> +}
> +
>   static int remote_spawn(PCIProxyDev *pdev, const char *opts,
>                           const char *exec_name, Error **errp)
>   {
> -    char *args[3];
>       pid_t rpid;
>       int fd[2] = {-1, -1};
>       Error *local_error = NULL;
> +    char *argv[64];
> +    int argc = 0;
> +    char *sfd;
> +    char *exec_dir;
>       int rc = -EINVAL;
>   
>       if (pdev->managed) {
>           /* Child is forked by external program (such as libvirt). */
>           error_setg(errp, "Remote processed is managed and launched by external program");
> -        return -1;
> +        return rc;
>       }
>   
>       if (!exec_name) {
> @@ -41,32 +72,38 @@ static int remote_spawn(PCIProxyDev *pdev, const char *opts,
>   
>       if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
>           error_setg(errp, "Unable to create unix socket.");
> -        return -1;
> +        return rc;
>       }
> +    exec_dir = g_strdup_printf("%s/%s", qemu_get_exec_dir(), exec_name);
> +    argc = add_argv(exec_dir, argv, argc);
> +    sfd = g_strdup_printf("%d", fd[1]);
> +    argc = add_argv(sfd, argv, argc);
> +    argc = make_argv((char *)opts, argv, argc);
> +
>       /* TODO: Restrict the forked process' permissions and capabilities. */
>       rpid = qemu_fork(&local_error);
>   
>       if (rpid == -1) {
>           error_setg(errp, "Unable to spawn emulation program.");
>           close(fd[0]);
> -        close(fd[1]);
> -        return -1;
> +        goto fail;
>       }
>   
>       if (rpid == 0) {
>           close(fd[0]);
>   
> -        args[0] = g_strdup(exec_name);
> -        args[1] = g_strdup_printf("%d", fd[1]);
> -        args[2] = NULL;
> -        execvp(args[0], (char *const *)args);
> +        rc = execv(argv[0], (char *const *)argv);
>           exit(1);
>       }
>       pdev->remote_pid = rpid;
> +    pdev->socket = fd[0];
> +
> +    rc = 0;
>   
> +fail:
>       close(fd[1]);
>   
> -    return 0;
> +    return rc;
>   }
>   
>   static int get_proxy_sock(PCIDevice *dev)
> @@ -177,16 +214,17 @@ static void pci_proxy_dev_register_types(void)
>   type_init(pci_proxy_dev_register_types)
>   
>   static void init_proxy(PCIDevice *dev, char *command, char *exec_name,
> -                       Error **errp)
> +                       bool need_spawn, Error **errp)
>   {
>       PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
>       Error *local_error = NULL;
>   
>       if (!pdev->managed) {
> -        if (command) {
> -            remote_spawn(pdev, command, exec_name, &local_error);
> -        } else {
> -            return;
> +        if (need_spawn) {
> +            if (remote_spawn(pdev, command, exec_name, &local_error)) {
> +                error_propagate(errp, local_error);
> +                return;
> +            }
>           }
>       } else {
>           pdev->remote_pid = atoi(pdev->rid);
> diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
> index 28b0114..29fa2e9 100644
> --- a/include/hw/proxy/qemu-proxy.h
> +++ b/include/hw/proxy/qemu-proxy.h
> @@ -39,7 +39,7 @@ typedef struct PCIProxyDev {
>   
>       void (*proxy_ready) (PCIDevice *dev);
>       void (*init_proxy) (PCIDevice *dev, char *command, char *exec_name,
> -                        Error **errp);
> +                        bool need_spawn, Error **errp);
>   
>   } PCIProxyDev;
>   
> 


