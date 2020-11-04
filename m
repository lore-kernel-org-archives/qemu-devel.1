Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FE7C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F382067C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwBgoG7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F382067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNiU-0007xc-Q6
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaNhA-0007Oj-UX
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaNh6-0001Tp-29
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kOwr8XM6QAzasWVNtPLf3Iv9W22fZAwOXzdnlC9Bwgk=;
 b=PwBgoG7pf0bDYWJNarK+JWiAz5hEbRscyUG+apb3E6AFmlkk5eSOrxdgek3rShjeOoRaNF
 2dy+Sd5N3i9KihfDcjXsHUlOx0T38tGS5uqyO5iMWXqes1n5l/H4VFxPKvNPkNqQsZKOeL
 ZovhocY8Zp+uksDuHVhEPve7fO+99p0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-0QDGFrtWMRmIZjUak7tvWw-1; Wed, 04 Nov 2020 13:39:34 -0500
X-MC-Unique: 0QDGFrtWMRmIZjUak7tvWw-1
Received: by mail-wm1-f70.google.com with SMTP id p7so925959wma.9
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kOwr8XM6QAzasWVNtPLf3Iv9W22fZAwOXzdnlC9Bwgk=;
 b=qvgdXFDfpao7AB3A7KooX/BTc4JKz2jmA5V9Z2LY5Q8Aoi2yTyYDkwL9t4AiLAps0q
 3+wmHXNcW9XtpK0cGQvsmWPVUd87E5HFt+CY5mSClJUqz5/zWqp3Frij4jYf6OgYFQlS
 W04wa9eLh9I2CTe0EIT7PCmjxASEHW+Z9UIlVP5zaj3tXQrhXgaeAFUTUWkaqbqA5TRP
 cfEEA3EtlUFt4w7K+5vByDgrMURx7SUcwZIichSk5GewZp3cEEWrk4EhmED/SYadxqVr
 EeHkPUP/IXn55TzO59opdPZzGsNIZXM6nKRyD1efh1ZucrwNizKHSLWoGlbWAY5M11Yv
 oCag==
X-Gm-Message-State: AOAM531TbRkHrvWXVK01IA1LRQ6DNx+gz8e8A/VCpd9Q4hJkFriYQp5F
 ddeUfPxaaN71EAd6Y7VHbQxNgzABy6IvY3JJefSBH7QIdXFAtMwOcVSKqOluta6MQUmFKRkLKQi
 acmK2pVvgs1X/D5A=
X-Received: by 2002:adf:b190:: with SMTP id q16mr34850764wra.288.1604515173617; 
 Wed, 04 Nov 2020 10:39:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyug6n83S1ozCj3zc61pNtn+AjJ16rubJW0sgmND2wLR0fkUsbo9iCj1QTrhwTENIEG//5r/w==
X-Received: by 2002:adf:b190:: with SMTP id q16mr34850718wra.288.1604515173388; 
 Wed, 04 Nov 2020 10:39:33 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y2sm4018666wrh.0.2020.11.04.10.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 10:39:32 -0800 (PST)
Subject: Re: [PATCH v11 19/19] multi-process: add configure and usage
 information
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
 <c0c67a48b6ebba7ecb2661d4775c105d2753eebd.1602784930.git.jag.raman@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <58bb4805-03bd-bfe6-f8a3-4578f8a6870a@redhat.com>
Date: Wed, 4 Nov 2020 19:39:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <c0c67a48b6ebba7ecb2661d4775c105d2753eebd.1602784930.git.jag.raman@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, quintela@redhat.com,
 mst@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jagannathan,

On 10/15/20 8:05 PM, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Documentation is scarce ;)

> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS                |  2 ++
>  docs/multi-process.rst     | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  scripts/mpqemu-launcher.py | 49 +++++++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+)
>  create mode 100644 docs/multi-process.rst
>  create mode 100755 scripts/mpqemu-launcher.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a911e0..d12aba7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3118,6 +3118,8 @@ F: include/hw/pci/memory-sync.h
>  F: hw/i386/remote-iohub.c
>  F: include/hw/i386/remote-iohub.h
>  F: docs/devel/multi-process.rst
> +F: scripts/mpqemu-launcher.py
> +F: scripts/mpqemu-launcher-perf-mode.py

This one was in v7, Stefan asked about it, then the script
disappeared in v8 =)
https://www.mail-archive.com/qemu-devel@nongnu.org/msg718984.html

>  
>  Build and test automation
>  -------------------------
> diff --git a/docs/multi-process.rst b/docs/multi-process.rst
> new file mode 100644
> index 0000000..c4b022c
> --- /dev/null
> +++ b/docs/multi-process.rst
> @@ -0,0 +1,67 @@
> +Multi-process QEMU
> +==================
> +
> +This document describes how to configure and use multi-process qemu.
> +For the design document refer to docs/devel/qemu-multiprocess.
> +
> +1) Configuration
> +----------------
> +
> +To enable support for multi-process add --enable-mpqemu
> +to the list of options for the "configure" script.
> +
> +
> +2) Usage
> +--------
> +
> +Multi-process QEMU requires an orchestrator to launch. Please refer to a
> +light-weight python based orchestrator for mpqemu in
> +scripts/mpqemu-launcher.py to lauch QEMU in multi-process mode.
> +
> +Following is a description of command-line used to launch mpqemu.
> +
> +* Orchestrator:
> +
> +  - The Orchestrator creates a unix socketpair
> +
> +  - It launches the remote process and passes one of the
> +    sockets to it via command-line.
> +
> +  - It then launches QEMU and specifies the other socket as an option
> +    to the Proxy device object
> +
> +* Remote Process:
> +
> +  - QEMU can enter remote process mode by using the "remote" machine
> +    option.
> +
> +  - The orchestrator creates a "remote-object" with details about
> +    the device and the file descriptor for the device
> +
> +  - The remaining options are no different from how one launches QEMU with
> +    devices.
> +
> +  - Example command-line for the remote process is as follows:
> +
> +      /usr/bin/qemu-system-x86_64                                        \
> +      -machine x-remote                                                  \
> +      -device lsi53c895a,id=lsi0                                         \
> +      -drive id=drive_image2,file=/build/ol7-nvme-test-1.qcow2           \
> +      -device scsi-hd,id=drive2,drive=drive_image2,bus=lsi0.0,scsi-id=0  \
> +      -object x-remote-object,id=robj1,devid=lsi1,fd=4,
> +
> +* QEMU:
> +
> +  - Since parts of the RAM are shared between QEMU & remote process, a
> +    memory-backend-memfd is required to facilitate this, as follows:
> +
> +    -object memory-backend-memfd,id=mem,size=2G
> +
> +  - A "x-pci-proxy-dev" device is created for each of the PCI devices emulated
> +    in the remote process. A "socket" sub-option specifies the other end of
> +    unix channel created by orchestrator. The "id" sub-option must be specified
> +    and should be the same as the "id" specified for the remote PCI device
> +
> +  - Example commandline for QEMU is as follows:
> +
> +      -device x-pci-proxy-dev,id=lsi0,socket=3
> diff --git a/scripts/mpqemu-launcher.py b/scripts/mpqemu-launcher.py
> new file mode 100755
> index 0000000..6e0ef22
> --- /dev/null
> +++ b/scripts/mpqemu-launcher.py
> @@ -0,0 +1,49 @@
> +#!/usr/bin/env python3
> +import socket
> +import os
> +import subprocess
> +import time
> +
> +PROC_QEMU='/usr/bin/qemu-system-x86_64'

If this is a (multiarch) test, then ...

> +
> +proxy, remote = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
> +
> +remote_cmd = [ PROC_QEMU,                                                      \
> +               '-machine', 'x-remote',                                         \
> +               '-device', 'lsi53c895a,id=lsi1',                                \

... I'd move it to tests/integration/multiproc-x86-lsi53c895a.py ...

> +               '-drive', 'id=drive_image1,file=/build/ol7-nvme-test-1.qcow2',  \

... use avocado.utils.vmimage (see tests/acceptance/boot_linux.py)
to download a prebuilt image, ...

> +               '-device', 'scsi-hd,id=drive1,drive=drive_image1,bus=lsi1.0,'   \
> +                              'scsi-id=0',                                     \
> +               '-object',                                                      \
> +               'x-remote-object,id=robj1,devid=lsi1,fd='+str(remote.fileno()), \
> +               '-nographic',                                                   \
> +             ]
> +
> +proxy_cmd = [ PROC_QEMU,                                                       \
> +              '-name', 'OL7.4',                                                \
> +              '-machine', 'q35,accel=kvm',                                     \
> +              '-smp', 'sockets=1,cores=1,threads=1',                           \
> +              '-m', '2048',                                                    \
> +              '-object', 'memory-backend-memfd,id=sysmem-file,size=2G',        \
> +              '-numa', 'node,memdev=sysmem-file',                              \
> +              '-device', 'virtio-scsi-pci,id=virtio_scsi_pci0',                \
> +              '-drive', 'id=drive_image1,if=none,format=qcow2,'                \
> +                            'file=/home/ol7-hdd-1.qcow2',                      \
> +              '-device', 'scsi-hd,id=image1,drive=drive_image1,'               \
> +                             'bus=virtio_scsi_pci0.0',                         \
> +              '-boot', 'd',                                                    \
> +              '-vnc', ':0',                                                    \
> +              '-device', 'x-pci-proxy-dev,id=lsi1,fd='+str(proxy.fileno()),    \
> +            ]
> +
> +
> +pid = os.fork();
> +
> +if pid:
> +    # In Proxy
> +    print('Launching QEMU with Proxy object');
> +    process = subprocess.Popen(proxy_cmd, pass_fds=[proxy.fileno()])
> +else:
> +    # In remote
> +    print('Launching Remote process');
> +    process = subprocess.Popen(remote_cmd, pass_fds=[remote.fileno()])
> 

... and do something within the guest to be sure MultiProc works :)

Regards,

Phil.


