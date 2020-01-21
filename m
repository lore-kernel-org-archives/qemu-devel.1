Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506DFC33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DA6217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWTjVG+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DA6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvLW-0002GM-5p
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itvKO-0001Jm-0Y
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itvKK-0007O5-G5
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:20:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54631
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itvKK-0007NC-By
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579620023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahbrrTZ02Q2AaUAhkYuLBy+pCTaOI5S3O0vnVUsKpN4=;
 b=FWTjVG+k0aoxKpAbPc5CglYqoKgehvrNF5jwuf7I+/ZlPPPvWPQjFxl8G/e6gXH6Sx2LaN
 nVIfOU9sw9F5WYMjjI2jqDWjS7FbeoYXFh0z8cOvNY7OObvatRyrK+dy93UNwpnenrj5sd
 wi7BgDqDAf6B0S9Sfkbern7KS6S3bxM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-9eh4KxHUNN-eYmpfdsAv7Q-1; Tue, 21 Jan 2020 10:20:20 -0500
Received: by mail-wm1-f72.google.com with SMTP id z2so478331wmf.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 07:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wXNmCEI39A90S89rIaNcET/H3HJfy6TVaw91xC3SIzE=;
 b=iGPidAacv6/Kk//Wq7HrPKuqcfMPvdlyW8qvZjyHefmCPDAhMF4Q9jcFR/6LPWYOsc
 c+6vwCEzNlydpuTVPnrMRk5zn7kk02FFgdxltRvs7UjXvnoEts3eeBO47KTasi2tGOE6
 YKP2hJ7Oco9p/ZlTIk3JH+lRmOhVk+XTRXO/UdMgpq9SflMJoOlWoAwbxquXWMYVYqYy
 o/XHLzarSMsEYaGeHs8R5Zjj4ZptBOirXoz22OCGXXe2voUgD7Oq0fD+qg0Tag6CYx/H
 HBWla+OiSYPHCoF6wnVbDlNUo5kcUwv+xcsesqYnVGU4Z7x9InvpBqBXP2jZTrkF3VRU
 lsaA==
X-Gm-Message-State: APjAAAX0CkW2O4fbY8uq9vS1xF/rbsh/RV+EyTqbAgQYw6jzR1sB1vBL
 euq1fy0KsQemro8dVi745BO4oQXDLjlwQxQzKa2wVa/rFVE8SjKiPWPFpLwlIUgHYJ2HJkl+JMi
 4jWM7d1ZEA34BZTs=
X-Received: by 2002:adf:fbc9:: with SMTP id d9mr5777238wrs.20.1579620018772;
 Tue, 21 Jan 2020 07:20:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzseqCKtnYe0sc+hfEDFz9zlzx70+0dfv6lH09AzqZ5+VCzOjFTRi1WMRjpl+u3t40uazSywg==
X-Received: by 2002:adf:fbc9:: with SMTP id d9mr5777202wrs.20.1579620018301;
 Tue, 21 Jan 2020 07:20:18 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 124sm4558201wmc.29.2020.01.21.07.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 07:20:17 -0800 (PST)
Subject: Re: [PATCH v2 093/109] virtiofsd: add man page
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-94-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <188a43db-d9e3-c6ff-f4d5-453407babcc3@redhat.com>
Date: Tue, 21 Jan 2020 16:20:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121122433.50803-94-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: 9eh4KxHUNN-eYmpfdsAv7Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 1:24 PM, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> with additions by:
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   Makefile                       |   7 +++
>   tools/virtiofsd/virtiofsd.texi | 104 +++++++++++++++++++++++++++++++++
>   2 files changed, 111 insertions(+)
>   create mode 100644 tools/virtiofsd/virtiofsd.texi
>=20
> diff --git a/Makefile b/Makefile
> index 2375a1f81c..ba7e2e5ebc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -353,6 +353,9 @@ DOCS+=3D$(MANUAL_BUILDDIR)/index.html
>   ifdef CONFIG_VIRTFS
>   DOCS+=3Dfsdev/virtfs-proxy-helper.1
>   endif
> +ifdef CONFIG_LINUX
> +DOCS+=3Dtools/virtiofsd/virtiofsd.1
> +endif
>   ifdef CONFIG_TRACE_SYSTEMTAP
>   DOCS+=3Dscripts/qemu-trace-stap.1
>   endif
> @@ -857,6 +860,9 @@ ifdef CONFIG_VIRTFS
>   =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
>   =09$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man=
1"
>   endif
> +ifdef CONFIG_LINUX
> +=09$(INSTALL_DATA) tools/virtiofsd/virtiofsd.1 "$(DESTDIR)$(mandir)/man1=
"
> +endif
>  =20
>   install-datadir:
>   =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
> @@ -1065,6 +1071,7 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monito=
r.texi qemu-monitor-info.texi
>   qemu.1: qemu-option-trace.texi
>   qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
>   fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
> +tools/virtiofsd/virtiofsd.1: tools/virtiofsd/virtiofsd.texi
>   qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
>   docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
>   docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
> diff --git a/tools/virtiofsd/virtiofsd.texi b/tools/virtiofsd/virtiofsd.t=
exi
> new file mode 100644
> index 0000000000..d7a2528f7d
> --- /dev/null
> +++ b/tools/virtiofsd/virtiofsd.texi
> @@ -0,0 +1,104 @@
> +@example
> +@c man begin SYNOPSIS
> +@command{virtiofsd} [OPTION] @option{--socket-path=3D}@var{path}|@option=
{--fd=3D}@var{fdnum} @option{-o source=3D}@var{path}
> +@c man end
> +@end example
> +
> +@c man begin DESCRIPTION
> +
> +Share a host directory tree with a guest through a virtio-fs device.  Th=
is
> +program is a vhost-user backend that implements the virtio-fs device.  E=
ach
> +virtio-fs device instance requires its own virtiofsd process.
> +
> +This program is designed to work with QEMU's @code{--device vhost-user-f=
s-pci}
> +but should work with any virtual machine monitor (VMM) that supports
> +vhost-user.  See the EXAMPLES section below.
> +
> +This program must be run as the root user.  Upon startup the program wil=
l
> +switch into a new file system namespace with the shared directory tree a=
s its
> +root.  This prevents "file system escapes" due to symlinks and other fil=
e
> +system objects that might lead to files outside the shared directory.  T=
he
> +program also sandboxes itself using seccomp(2) to prevent ptrace(2) and =
other
> +vectors that could allow an attacker to compromise the system after gain=
ing
> +control of the virtiofsd process.
> +
> +@c man end
> +
> +@c man begin OPTIONS
> +@table @option
> +@item -h, --help
> +Print help.
> +@item -V, --version
> +Print version.
> +@item -d, -o debug
> +Enable debug output.
> +@item --syslog
> +Print log messages to syslog instead of stderr.
> +@item -o flock|no_flock
> +enable/disable flock.
> +The default is @var{no_flock}.
> +@item -o log_level=3D@var{level}
> +Print only log messages matching @var{level} or more severe.  @var{level=
} is
> +one of @code{err}, @code{warn}, @code{info}, or @code{debug}.  The defau=
lt is
> +@var{info}.
> +@item -o norace
> +Disable racy fallback.
> +The default is false.
> +@item -o posix_lock|no_posix_lock
> +Enable/Disable remote posix lock.
> +The default is @var{posix_lock}.
> +@item -o readdirplus|no_readdirplus
> +Enable/Disable readdirplus.
> +The default is @var{readdirplus}
> +@item -o source=3D@var{path}
> +Share host directory tree located at @var{path}.  This option is require=
d.
> +@item -o timeout=3D<number>
> +I/O timeout (second).
> +The default depends on cache=3D option.
> +@item -o writeback|no_writeback
> +Enable/Disable writeback cache. The cache alows the FUSE client
> +to buffer and merge write requests.
> +The default is @var{no_writeback}.
> +@item -o xattr|no_xattr
> +Enable/Disable Extended attributes (xattr) of the files and directories.
> +The default is @var{no_xattr}.
> +@item --socket-path=3D@var{path}, -o vhost_user_socket=3D@var{path}
> +Listen on vhost-user UNIX domain socket at @var{path}.
> +@item --fd=3D@var{fdnum}
> +Accept connections from vhost-user UNIX domain socket file descriptor @v=
ar{fdnum}.  The file descriptor must already be listening for connections.
> +@item --thread-pool-size=3D@var{num}
> +Restrict the number of worker threads per request queue to @var{num}.  T=
he default is 64.
> +@item --cache=3D@code{none}|@code{auto}|@code{always}
> +Select the desired trade-off between coherency and performance.  @code{n=
one}
> +forbids the FUSE client from caching to achieve best coherency at the co=
st of
> +performance.  @code{auto} acts similar to NFS with a 1 second metadata c=
ache
> +timeout.  @code{always} sets a long cache lifetime at the expense of coh=
erency.
> +@end table
> +@c man end
> +
> +@c man begin EXAMPLES
> +Export @code{/var/lib/fs/vm001/} on vhost-user UNIX domain socket @code{=
/var/run/vm001-vhost-fs.sock}:
> +
> +@example
> +host# virtiofsd --socket-path=3D/var/run/vm001-vhost-fs.sock -o source=
=3D/var/lib/fs/vm001
> +host# qemu-system-x86_64 \
> +    -chardev socket,id=3Dchar0,path=3D/var/run/vm001-vhost-fs.sock \
> +    -device vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs \
> +    -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,s=
hare=3Don \
> +    -numa node,memdev=3Dmem \
> +    ...
> +guest# mount -t virtio_fs myfs /mnt
> +@end example
> +@c man end
> +
> +@ignore
> +@setfilename virtiofsd
> +@settitle QEMU virtio-fs shared file system daemon
> +
> +@c man begin COPYRIGHT
> +Copyright (C) 2019-2020 Red Hat, Inc.
> +
> +This is free software; see the source for copying conditions.  There is =
NO
> +warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE.
> +@c man end
> +@end ignore
>=20


