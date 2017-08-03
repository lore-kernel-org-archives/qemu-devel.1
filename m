Received: from eggs.gnu.org ([2001:4830:134:3::10]:55603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddJTM-0003eE-JY
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddJTB-0001HN-DQ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ddJT9-0001AT-Cl
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:59:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 381D47EA94
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 16:59:29 +0000 (UTC)
References: <20170728121040.631-1-otubo@redhat.com>
	<20170728121040.631-4-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <87e5a327-83d0-d6d8-83d6-c98d0b939b30@redhat.com>
Date: Thu, 3 Aug 2017 18:59:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170728121040.631-4-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/6] seccomp: add elevateprivileges
 argument to command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, pbonzini@redhat.com

On 28.07.2017 14:10, Eduardo Otubo wrote:
> This patch introduces the new argument
> [,elevateprivileges=3Dallow|deny|children] to the `-sandbox on'. It all=
ows
> or denies Qemu process to elevate its privileges by blacklisting all
> set*uid|gid system calls. The 'children' option will let forks and
> execves run unprivileged.
>=20
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  1 +
>  qemu-options.hx          |  9 ++++++---
>  qemu-seccomp.c           | 29 +++++++++++++++++++++++++++++
>  vl.c                     | 22 ++++++++++++++++++++++
>  4 files changed, 58 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> index 7a7bde246b..e6e78d85ce 100644
> --- a/include/sysemu/seccomp.h
> +++ b/include/sysemu/seccomp.h
> @@ -16,6 +16,7 @@
>  #define QEMU_SECCOMP_H
> =20
>  #define OBSOLETE    0x0001
> +#define PRIVILEGED  0x0010
> =20
>  #include <seccomp.h>
> =20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 54e492f36a..34d33a812e 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4004,17 +4004,20 @@ Old param mode (ARM only).
>  ETEXI
> =20
>  DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
> -    "-sandbox on[,obsolete=3Dallow]  Enable seccomp mode 2 system call=
 filter (default 'off').\n" \
> -    "                obsolete: Allow obsolete system calls\n",
> +    "-sandbox on[,obsolete=3Dallow][,elevateprivileges=3Dallow|deny|ch=
ildren]  Enable seccomp mode 2 system call filter (default 'off').\n" \

Most other boolean-like options use "on|off" as possible values ...
maybe it would be nicer to use "on|off" instead of "allow|deny" here, too=
?

> +    "                obsolete: Allow obsolete system calls\n"
> +    "                elevateprivileges: allows or denies Qemu process =
to elevate its privileges by blacklisting all set*uid|gid system calls. '=
children' will deny set*uid|gid system calls for main Qemu process but wi=
ll allow forks and execves to run unprivileged\n",

Correct spelling is "QEMU" with all capital letters, not "Qemu"

>      QEMU_ARCH_ALL)
>  STEXI
> -@item -sandbox @var{arg}[,obsolete=3D@var{string}]
> +@item -sandbox @var{arg}[,obsolete=3D@var{string}][,elevateprivileges=3D=
@var{string}]
>  @findex -sandbox
>  Enable Seccomp mode 2 system call filter. 'on' will enable syscall fil=
tering and 'off' will
>  disable it.  The default is 'off'.
>  @table @option
>  @item obsolete=3D@var{string}
>  Enable Obsolete system calls
> +@item elevateprivileges=3D@var{string}
> +Disable set*uid|gid systema calls

s/systema/system/

 Thomas
