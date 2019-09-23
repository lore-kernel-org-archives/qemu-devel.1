Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59C8C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F8320835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F8320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCMR0-0003wb-RP
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 07:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCMPV-000339-T8
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCMPT-0002Hj-3L
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:21:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCMPS-0002Gt-Rg
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:21:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3265230917EF;
 Mon, 23 Sep 2019 11:21:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DD9610018F8;
 Mon, 23 Sep 2019 11:21:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C1695113864E; Mon, 23 Sep 2019 13:21:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
Subject: Re: [Qemu-devel] Is network backend netmap worth keeping?
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
 <695325d7-a0c3-73c1-97ab-f62fb345c622@unipi.it>
 <87blwzho1y.fsf@dusky.pond.sub.org>
 <2fb98b77-efab-6092-dd5a-fa50c3c4b3f9@redhat.com>
 <58e7895e-4910-4d4c-79d8-dead7de69ab7@unipi.it>
 <87blvocpq2.fsf@dusky.pond.sub.org>
 <df94280b-13f6-1df3-f594-5eb0a614777d@unipi.it>
Date: Mon, 23 Sep 2019 13:21:28 +0200
In-Reply-To: <df94280b-13f6-1df3-f594-5eb0a614777d@unipi.it> (Giuseppe
 Lettieri's message of "Mon, 16 Sep 2019 16:45:43 +0200")
Message-ID: <874l13qmvb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 23 Sep 2019 11:21:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Giuseppe Lettieri <giuseppe.lettieri@unipi.it> writes:

> Il 13/09/19 15:04, Markus Armbruster ha scritto:
>>
>> What happens when I build with --enable-netmap=system on host A, then
>> run the resulting binary on some host B that doesn't have netmap
>> installed?
>>
>
> Qemu will fail at startup, complaining that /dev/netmap does not exists.
>
>
>>
>> Yes.  We default to netmap=system, though.  If you break things by
>> passing arcane arguments to configure, you get to keep the pieces :)
>>
>>> If the option is only useful for developers to check that some qemu
>>> change does not break anything, then probably it should be enabled in
>>> some other, less visible way. What do you think?
>>
>> I think an --enable-netmap patterned after --enable-capstone and
>> --enable-slirp has sufficiently low visibility as long as the default is
>> sane.
>>
>> We clearly want configure to pick netmap=system when the system provides
>> netmap.
>>
>> What shall configure pick when the system doesn't provide it?  If you
>> think netmap=git is too dangerous for general audience, consider
>> disabling netmap then.  Experts can still compile-test with
>> --enable-netmap=git.  Our CI certainly should.
>>
>
> OK, sounds reasonable. The attached patch will select system if netmap
> is available, and git only if explicitly requested.
>
> Cheers,
> Giuseppe
>
> -- 
> Dr. Ing. Giuseppe Lettieri
> Dipartimento di Ingegneria della Informazione
> Universita' di Pisa
> Largo Lucio Lazzarino 1, 56122 Pisa - Italy
> Ph. : (+39) 050-2217.649 (direct) .599 (switch)
> Fax : (+39) 050-2217.600
> e-mail: g.lettieri@iet.unipi.it
>
>>From 4e93b5cc3ad68d92bc3562df3745e1d10dc08fc0 Mon Sep 17 00:00:00 2001
> From: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
> Date: Mon, 2 Sep 2019 17:35:33 +0200
> Subject: [PATCH] netmap: support git-submodule build otption
>
> With this patch, netmap support can be enabled with
> the following options to the configure script:
>
>   --enable-netmap[=system]
>
> 	Use the host system netmap installation.
> 	Fail if not found.
>
>   --enable-netmap=git
>
> 	clone the official netmap repository on
> 	github (mostly useful for CI)
>
> system will also be automatically used if no option is
> passed and netmap is available in the host system.
>
> Signed-off-by: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
> ---
>  .gitmodules |  3 +++
>  configure   | 68 ++++++++++++++++++++++++++++++++++++++++++++---------
>  netmap      |  1 +
>  3 files changed, 61 insertions(+), 11 deletions(-)
>  create mode 160000 netmap
>
> diff --git a/.gitmodules b/.gitmodules
> index c5c474169d..bf75dbc5e3 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -58,3 +58,6 @@
>  [submodule "roms/opensbi"]
>  	path = roms/opensbi
>  	url = 	https://git.qemu.org/git/opensbi.git
> +[submodule "netmap"]
> +	path = netmap
> +	url = https://github.com/luigirizzo/netmap.git
> diff --git a/configure b/configure
> index 30aad233d1..5cb924985c 100755
> --- a/configure
> +++ b/configure
> @@ -1133,6 +1133,10 @@ for opt do
>    ;;
>    --enable-netmap) netmap="yes"
>    ;;
> +  --enable-netmap=git) netmap="git"
> +  ;;
> +  --enable-netmap=system) netmap="system"
> +  ;;
>    --disable-xen) xen="no"
>    ;;
>    --enable-xen) xen="yes"
> @@ -3314,8 +3318,9 @@ fi
>  # a minor/major version number. Minor new features will be marked with values up
>  # to 15, and if something happens that requires a change to the backend we will
>  # move above 15, submit the backend fixes and modify this two bounds.
> -if test "$netmap" != "no" ; then
> -  cat > $TMPC << EOF
> +case "$netmap" in
> +    "" | yes | system)
> +      cat > $TMPC << EOF
>  #include <inttypes.h>
>  #include <net/if.h>
>  #include <net/netmap.h>
> @@ -3325,15 +3330,56 @@ if test "$netmap" != "no" ; then
>  #endif
>  int main(void) { return 0; }
>  EOF
> -  if compile_prog "" "" ; then
> -    netmap=yes
> -  else
> -    if test "$netmap" = "yes" ; then
> -      feature_not_found "netmap"
> +      if compile_prog "" "" ; then
> +        netmap_system=yes
> +      else
> +        netmap_system=no
> +      fi
> +      ;;
> +esac

Is the indentation change intentional?

> +
> +case "$netmap" in
> +  "" | yes)
> +    if test "$netmap_system" = "yes"; then
> +      netmap=system
> +    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
> +      netmap=git
> +    elif test -e "${source_path}/netmap/configure" ; then
> +      netmap=internal
> +    elif test -z "$netmap" ; then
> +      netmap=no
> +    else
> +      feature_not_found "netmap" "Install netmap or git submodule"
>      fi
> -    netmap=no
> -  fi
> -fi
> +    ;;
> +
> +  system)
> +    if test "$netmap_system" = "no"; then
> +      feature_not_found "netmap" "Install netmap"
> +    fi
> +    ;;
> +esac
> +
> +case "$netmap" in
> +  git | internal)
> +    if test "$netmap" = git; then
> +      git_submodules="${git_submodules} netmap"
> +    fi
> +    mkdir -p netmap
> +    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/netmap/sys"
> +    ;;
> +
> +  system)
> +    ;;
> +
> +  no)
> +    ;;
> +  *)
> +    error_exit "Unknown state for netmap: $netmap"
> +    ;;
> +esac
> +
> +##########################################
>  
>  ##########################################
>  # libcap-ng library probe
> @@ -6582,7 +6628,7 @@ if test "$vde" = "yes" ; then
>    echo "CONFIG_VDE=y" >> $config_host_mak
>    echo "VDE_LIBS=$vde_libs" >> $config_host_mak
>  fi
> -if test "$netmap" = "yes" ; then
> +if test "$netmap" != "no" ; then
>    echo "CONFIG_NETMAP=y" >> $config_host_mak
>  fi
>  if test "$l2tpv3" = "yes" ; then
> diff --git a/netmap b/netmap
> new file mode 160000
> index 0000000000..137f537eae
> --- /dev/null
> +++ b/netmap
> @@ -0,0 +1 @@
> +Subproject commit 137f537eae513f02d5d6871d1f91c049e6345803

Looks reasonable to me.  Please submit it as a patch.

