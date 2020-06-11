Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F1DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6259720656
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cB5AQhFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6259720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjK4C-0007vd-Lf
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jjK3N-0007PE-5U
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:03:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jjK3I-0004za-QM
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:03:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05B9uVSM061429;
 Thu, 11 Jun 2020 10:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AorkxhvKJjY7nRHC5VXro0I3WeKJ+F00dpE2O0KiX9g=;
 b=cB5AQhFuwJwouqQ4tpUc3YR3izw9hDIq0A/IfxnQ9mx5g0PEyOj08cvQVnmvZ6/knP3S
 AOJXzY01UnHQTkfvmmeJb7YNbD96JHwlPjSa/QTILF11lsoddztIr8sdpRHBFBBkk1tn
 vClUlFgrXxD5r2YiqozZHU9CVQefBhIUObljH2M6K4FVNfqA3xlhRwS+qY/ARmwro2xi
 Jy+yHeNkV4QfjvEKX0es7WI2wsIckyIzrxkqhqyv31FlRkrSJIUNNcRKkugCvL9zbHK0
 zfEOmQUDMcCn7S9jjg9xZXuRse4lvXnvMrt6u6tiq7iMEvrMKCGqfUtsWLzq3Nr2L17h 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 31g3sn6uxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Jun 2020 10:03:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05B9wV3j123116;
 Thu, 11 Jun 2020 10:01:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 31gn2bubec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jun 2020 10:01:07 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05BA1595014806;
 Thu, 11 Jun 2020 10:01:05 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 11 Jun 2020 03:01:05 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 5C94B663BDE; Thu, 11 Jun 2020 11:01:01 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] fuzz: add oss-fuzz build-script
In-Reply-To: <20200611061355.31967-1-alxndr@bu.edu>
References: <20200611061355.31967-1-alxndr@bu.edu>
Date: Thu, 11 Jun 2020 11:01:01 +0100
Message-ID: <m2sgf12a76.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110077
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 06:03:11
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Thursday, 2020-06-11 at 02:13:55 -04, Alexander Bulekov wrote:
> It is neater to keep this in the QEMU repo, since any change that
> requires an update to the oss-fuzz build configuration, can make the
> necessary changes in the same series.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>
> In v3 I tried to make this build outside the oss-fuzz docker
> environment. I wasn't able to find a way to use the Makefile to install
> the pc-bios and qemu-fuzz binaries per Philippe's suggestion.
> Additionally, right now I create a separate build directory within the
> the tree for build. I am not sure whether this is a good approach, but
> we must rely on some default that will work with both oss-fuzz and on
> a developer's machine.

I'm happy that it can be used outside of OSS-Fuzz to permit creating and
testing without having to set up the whole OSS-Fuzz test environment,
especially for small changes.

Personally, I think not using the Makefile is fine for this specific
use-case - it's a very specific environment/configuration.

So, in general,

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

but there are a couple of comments below, mostly suggestions...

>
>  MAINTAINERS               |  1 +
>  scripts/oss-fuzz/build.sh | 99 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100755 scripts/oss-fuzz/build.sh
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3abe3faa4e..094a37ebb3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2336,6 +2336,7 @@ R: Bandan Das <bsd@redhat.com>
>  R: Stefan Hajnoczi <stefanha@redhat.com>
>  S: Maintained
>  F: tests/qtest/fuzz/
> +F: scripts/oss-fuzz/
>=20=20
>  Register API
>  M: Alistair Francis <alistair@alistair23.me>
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> new file mode 100755
> index 0000000000..4be6b21caf
> --- /dev/null
> +++ b/scripts/oss-fuzz/build.sh
> @@ -0,0 +1,99 @@
> +#!/bin/sh

It may be worth adding a '-e' option here, to have the script always
fail on uncaught errors.

> +#
> +# OSS-Fuzz build script. See:
> +# https://google.github.io/oss-fuzz/getting-started/new-project-guide/#b=
uildsh
> +#
> +# The file is consumed by:
> +# https://github.com/google/oss-fuzz/blob/master/projects/qemu/Dockerfil=
es
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +# build project
> +# e.g.
> +# ./autogen.sh
> +# ./configure
> +# make -j$(nproc) all
> +
> +# build fuzzers
> +# e.g.
> +# $CXX $CXXFLAGS -std=3Dc++11 -Iinclude \
> +#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
> +#     $LIB_FUZZING_ENGINE /path/to/library.a
> +
> +# There seems to be a bug in clang-11 (used for builds on oss-fuzz) :
> +#   accel/tcg/cputlb.o: In function `load_memop':
> +#   accel/tcg/cputlb.c:1505: undefined reference to `qemu_build_not_reac=
hed'
> +#
> +# When building with optimization, the compiler is expected to prove tha=
t the
> +# statement cannot be reached, and remove it. For some reason clang-11 d=
oesn't
> +# remove it, resulting in an unresolved reference to qemu_build_not_reac=
hed
> +# Undefine the __OPTIMIZE__ macro which compiler.h relies on to choose w=
hether
> +# to " #define qemu_build_not_reached()  g_assert_not_reached() "
> +EXTRA_CFLAGS=3D"$CFLAGS -U __OPTIMIZE__"
> +
> +if ! { [ -e "./COPYING" ] &&
> +   [ -e "./MAINTAINERS" ] &&
> +   [ -e "./Makefile" ] &&
> +   [ -e "./docs" ] &&
> +   [ -e "./VERSION" ] &&
> +   [ -e "./linux-user" ] &&
> +   [ -e "./softmmu" ];} ; then
> +    echo "Please run the script from the top of the QEMU tree"
> +    exit

It's just a suggestion, but I've always favoured creating a specific
function to handle exits, e.g.:

fatal() {
    echo "Error: %{*}, exiting."
    exit 1
}

and then using that anywhere there is an unexpected exit, like here.

> +fi
> +
> +mkdir -p "./build-oss-fuzz/"
> +cd "./build-oss-fuzz/" || exit

fatal() also becomes useful here, to allow a meaningful exit message -
very useful later if you're looking back at logs and wondering why it
exited early.

Might also be worth adding the || fatal '..' to the mkdir line too,
which is more likely to fail first if the cd is going to fail.

> +
> +
> +if [ -z ${LIB_FUZZING_ENGINE+x} ]; then
> +    LIB_FUZZING_ENGINE=3D"-fsanitize=3Dfuzzer"
> +fi
> +
> +if [ -z ${OUT+x} ]; then
> +    DEST_DIR=3D$(realpath "./DEST_DIR")
> +else
> +    DEST_DIR=3D$OUT
> +fi
> +
> +mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
> +
> +# Build once to get the list of dynamic lib paths, and copy them over
> +../configure --disable-werror --cc=3D"$CC" --cxx=3D"$CXX" \
> +    --extra-cflags=3D"$EXTRA_CFLAGS"
> +
> +if ! make CONFIG_FUZZ=3Dy CFLAGS=3D"$LIB_FUZZING_ENGINE" "-j$(nproc)" \
> +    i386-softmmu/fuzz; then
> +    echo  "Build failed. Please specify a compiler with fuzzing support"\
> +          "using the \$CC and \$CXX environemnt variables, or specify a"\
> +          "\$LIB_FUZZING_ENGINE compatible with your compiler"
> +    echo  "For example: CC=3Dclang CXX=3Dclang++ $0"
> +    exit 0

This is more of an error condition, so probably would benefit from a
non-zero exit code, otherwise something testing this build script for
success would end up continuing when in reality it probably shouldn't.

> +fi
> +
> +for i in $(ldd ./i386-softmmu/qemu-fuzz-i386 | cut -f3 -d' '); do=20
> +    cp "$i" "$DEST_DIR/lib/"
> +done
> +rm ./i386-softmmu/qemu-fuzz-i386
> +
> +# Build a second time to build the final binary with correct rpath
> +../configure --bindir=3D"$DEST_DIR" --datadir=3D"$DEST_DIR/data/" --disa=
ble-werror \
> +    --cc=3D"$CC" --cxx=3D"$CXX" --extra-cflags=3D"$EXTRA_CFLAGS" \
> +    --extra-ldflags=3D"-Wl,-rpath,'\$\$ORIGIN/lib'"
> +make CONFIG_FUZZ=3Dy CFLAGS=3D"$LIB_FUZZING_ENGINE" "-j$(nproc)" i386-so=
ftmmu/fuzz
> +
> +# Copy over the datadir
> +cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
> +
> +# Run the fuzzer with no arguments, to print the help-string and get the=
 list
> +# of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it acc=
ording
> +# to each available fuzz target (See 05509c8e6d fuzz: select fuzz target=
 using
> +# executable name)
> +for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $=
2}');
> +do
> +    cp ./i386-softmmu/qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$t=
arget"
> +done
> +
> +echo "Done. The fuzzers are located in $DEST_DIR"

Add an 'exit 0' here.

> --=20
> 2.26.2

Thanks,

Darren.

