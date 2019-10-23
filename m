Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F44CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E36205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBpMqmDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E36205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPHV-00083y-TY
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iNPGR-0006au-TV
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iNPGQ-0007vm-Ah
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:37:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iNPGO-0007uQ-87
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571870273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+frFHN/I5MnLlXmlyHUcpwNQOqMfXTiWIg/vC/xEAo=;
 b=QBpMqmDapxY40qJetKFRPkDLZo/4pN18s6Jl40YsgTKA2YlgliAPMV2e71ml0Yzu+1p45d
 eMIRoglLHBcL75q/VlKEufcy1IRw4k2FDzcrHfkojpIoS2rps+3eluMGJmOW+K6x9BOvbT
 SWpGzjRDpLVgnbR51chxFL55ENdeNoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-su_NwtugPZm6OqmkAdnFPQ-1; Wed, 23 Oct 2019 18:37:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F072107AD31;
 Wed, 23 Oct 2019 22:37:47 +0000 (UTC)
Received: from ptitpuce (ovpn-116-97.ams2.redhat.com [10.36.116.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA9366061E;
 Wed, 23 Oct 2019 22:37:44 +0000 (UTC)
References: <20190908104816.20713-1-laurent@vivier.eu>
 <20190908104816.20713-2-laurent@vivier.eu>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH v2 2/2] linux-user: manage binfmt-misc
 preserve-arg[0] flag
Message-ID: <m1tv7zt8c4.fsf@redhat.com>
In-reply-to: <20190908104816.20713-2-laurent@vivier.eu>
Date: Thu, 24 Oct 2019 00:37:39 +0200
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: su_NwtugPZm6OqmkAdnFPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier writes:

> Add --preserve-arg0 in qemu-binfmt-conf.sh to configure the preserve-arg0
> flag.

There is an inconsistency below, where some parts use preserve-argv0
and others preserve-arg0 (no v)

Frankly, I would accept both ;-)

>
> Now, if QEMU is started with -0 or QEMU_ARGV0 and an empty parameter
> argv[0] (the full pathname provided by binfmt-misc) is removed and
> replaced by argv[1] (the original argv[0] provided by binfmt-misc when
> 'P'/preserve-arg[0] is set)
>
> For instance:
>
>   $ sudo QEMU_ARGV0=3D chroot m68k-chroot sh -c 'echo $0'
>   sh
>
> without this patch:
>
>   $ sudo chroot m68k-chroot sh -c 'echo $0'
>   /usr/bin/sh
>
> QEMU can be forced to always use preserve-argv[0] at configuration
> time with --force-preserve-argv0

Example of 'argv0' case

>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>
> Notes:
>     v2: add --force-preserve-argv0 configure option
>
>  configure                   |  8 +++++++
>  linux-user/main.c           | 24 +++++++++++++++++++-
>  scripts/qemu-binfmt-conf.sh | 44 +++++++++++++++++++++++--------------
>  3 files changed, 58 insertions(+), 18 deletions(-)
>
> diff --git a/configure b/configure
> index 95134c0180b2..3568e192776c 100755
> --- a/configure
> +++ b/configure
> @@ -498,6 +498,7 @@ libxml2=3D""
>  docker=3D"no"
>  debug_mutex=3D"no"
>  libpmem=3D""
> +force_preserve_argv0=3D"no"
>  default_devices=3D"yes"
>
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
> @@ -1543,6 +1544,8 @@ for opt do
>    ;;
>    --disable-libpmem) libpmem=3Dno
>    ;;
> +  --force-preserve-argv0) force_preserve_argv0=3Dyes
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1740,6 +1743,8 @@ Advanced options (experts only):
>    --enable-profiler        profiler support
>    --enable-debug-stack-usage
>                             track the maximum stack usage of stacks creat=
ed by qemu_alloc_stack
> +  --force-preserve-argv0   for linux-user only, force the use of binfmt_=
misc 'P'
> +                           flag (preserve-argv[0])
>
>  Optional features, enabled with --enable-FEATURE and
>  disabled with --disable-FEATURE, default is enabled if available:
> @@ -7736,6 +7741,9 @@ if test "$target_user_only" =3D "yes" ; then
>  fi
>  if test "$target_linux_user" =3D "yes" ; then
>    echo "CONFIG_LINUX_USER=3Dy" >> $config_target_mak
> +  if test "$force_preserve_argv0" =3D "yes" ; then
> +    echo "CONFIG_FORCE_PRESERVE_ARGV0=3Dy" >> $config_target_mak
> +  fi
>  fi
>  list=3D""
>  if test ! -z "$gdb_xml_files" ; then
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 28f0065b6ddf..02354d58e866 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -605,6 +605,7 @@ int main(int argc, char **argv, char **envp)
>      int i;
>      int ret;
>      int execfd;
> +    bool preserve_argv0;
>
>      error_init(argv[0]);
>      module_call_init(MODULE_INIT_TRACE);
> @@ -653,6 +654,9 @@ int main(int argc, char **argv, char **envp)
>
>      init_qemu_uname_release();
>
> +    /*
> +     * Manage binfmt-misc open-binary flag
> +     */
>      execfd =3D qemu_getauxval(AT_EXECFD);
>      if (execfd =3D=3D 0) {
>          execfd =3D open(exec_path, O_RDONLY);
> @@ -662,6 +666,24 @@ int main(int argc, char **argv, char **envp)
>          }
>      }
>
> +     /*
> +      * argv0 with an empty string will set argv[optind + 1]
> +      * as target_argv[0]
> +      */
> +#ifdef CONFIG_FORCE_PRESERVE_ARGV0
> +    preserve_argv0 =3D true;
> +#else
> +    preserve_argv0 =3D (argv0 !=3D NULL && argv0[0] =3D=3D 0);
> +#endif
> +    /*
> +     * Manage binfmt-misc preserve-arg[0] flag
> +     *    argv[optind]     full path to the binary
> +     *    argv[optind + 1] original argv[0]
> +     */
> +    if (optind + 1 < argc && preserve_argv0) {
> +        optind++;
> +    }
> +
>      if (cpu_model =3D=3D NULL) {
>          cpu_model =3D cpu_get_model(get_elf_eflags(execfd));
>      }
> @@ -766,7 +788,7 @@ int main(int argc, char **argv, char **envp)
>       * argv[0] pointer with the given one.
>       */
>      i =3D 0;
> -    if (argv0 !=3D NULL) {
> +    if (argv0 !=3D NULL && argv0[0] !=3D 0) {
>          target_argv[i++] =3D strdup(argv0);
>      }
>      for (; i < target_argc; i++) {
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index b5a16742a149..7c9a4609c232 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -170,25 +170,27 @@ usage() {
>  Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>                             [--help][--credential yes|no][--exportdir PAT=
H]
>                             [--persistent yes|no][--qemu-suffix SUFFIX]
> +                           [--preserve-arg0 yes|no]

Example of arg0 case

>
>         Configure binfmt_misc to use qemu interpreter
>
> -       --help:        display this usage
> -       --qemu-path:   set path to qemu interpreter ($QEMU_PATH)
> -       --qemu-suffix: add a suffix to the default interpreter name
> -       --debian:      don't write into /proc,
> -                      instead generate update-binfmts templates
> -       --systemd:     don't write into /proc,
> -                      instead generate file for systemd-binfmt.service
> -                      for the given CPU. If CPU is "ALL", generate a
> -                      file for all known cpus
> -       --exportdir:   define where to write configuration files
> -                      (default: $SYSTEMDDIR or $DEBIANDIR)
> -       --credential:  if yes, credential and security tokens are
> -                      calculated according to the binary to interpret
> -       --persistent:  if yes, the interpreter is loaded when binfmt is
> -                      configured and remains in memory. All future uses
> -                      are cloned from the open file.
> +       --help:          display this usage
> +       --qemu-path:     set path to qemu interpreter ($QEMU_PATH)
> +       --qemu-suffix:   add a suffix to the default interpreter name
> +       --debian:        don't write into /proc,
> +                        instead generate update-binfmts templates
> +       --systemd:       don't write into /proc,
> +                        instead generate file for systemd-binfmt.service
> +                        for the given CPU. If CPU is "ALL", generate a
> +                        file for all known cpus
> +       --exportdir:     define where to write configuration files
> +                        (default: $SYSTEMDDIR or $DEBIANDIR)
> +       --credential:    if yes, credential and security tokens are
> +                        calculated according to the binary to interpret
> +       --persistent:    if yes, the interpreter is loaded when binfmt is
> +                        configured and remains in memory. All future use=
s
> +                        are cloned from the open file.
> +       --preserve-arg0  preserve arg[0]
>
>      To import templates with update-binfmts, use :
>
> @@ -261,6 +263,9 @@ qemu_generate_register() {
>      if [ "$PERSISTENT" =3D "yes" ] ; then
>          flags=3D"${flags}F"
>      fi
> +    if [ "$PRESERVE_ARG0" =3D "yes" ] ; then
> +        flags=3D"${flags}P"
> +    fi
>
>      echo ":qemu-$cpu:M::$magic:$mask:$qemu:$flags"
>  }
> @@ -322,9 +327,10 @@ DEBIANDIR=3D"/usr/share/binfmts"
>  QEMU_PATH=3D/usr/local/bin
>  CREDENTIAL=3Dno
>  PERSISTENT=3Dno
> +PRESERVE_ARG0=3Dno
>  QEMU_SUFFIX=3D""
>
> -options=3D$(getopt -o ds:Q:S:e:hc:p: -l debian,systemd:,qemu-path:,qemu-=
suffix:,exportdir:,help,credential:,persistent: -- "$@")
> +options=3D$(getopt -o ds:Q:S:e:hc:p:0: -l debian,systemd:,qemu-path:,qem=
u-suffix:,exportdir:,help,credential:,persistent:,preserve-arg0: -- "$@")
>  eval set -- "$options"
>
>  while true ; do
> @@ -380,6 +386,10 @@ while true ; do
>          shift
>          PERSISTENT=3D"$1"
>          ;;
> +    -0|--preserve-arg0)
> +        shift
> +        PRESERVE_ARG0=3D"$1"
> +        ;;
>      *)
>          break
>          ;;


--
Cheers,
Christophe de Dinechin (IRC c3d)


