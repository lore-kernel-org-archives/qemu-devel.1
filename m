Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F5BC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4901C217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UkqiSEPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4901C217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKbi-0003LP-Ew
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izKaZ-0002UM-NB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izKaY-0005vr-I8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:19:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izKaY-0005u0-Bc
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:19:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015D8CHn072899;
 Wed, 5 Feb 2020 13:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to : content-transfer-encoding; s=corp-2019-08-05;
 bh=+Jb2bxZO3cM0XR+0cYUPcNGHKP8c84mxTXQzpn6R9mA=;
 b=UkqiSEPE1s4U/XLPf6zASJn2Vg8ZRTLeBSMHYkGU4KWf0Oa3rQ7FXaZwSq3KWYq6M41s
 dvuF7Q18uj4jUChJsRG3f0okUpot89JdB0EiwD+Tr7rzW7yOdX3kEvVzBzrF7e387ed8
 xyz+KhfREaeKF+eE7p8teeqKvyPEcOn188BF6D0YSJeFl1SGvUXDKy8MRa+vB74Zv2hY
 ekVxWaGdI5J8tDX9AkXAyzp8IcJUxeGHxEIiYJg7ZYPgRg37/OTwJEgMmu7HPDUR5JYP
 14Z95Hmza7a7BpnoI97E+2woazXaxa+2dGVIno+ginEv2Sg2HOPPvDB5itFED0YWpIan pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2xykbp2x80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:19:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DICVE088070;
 Wed, 5 Feb 2020 13:19:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2xykc2umm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:19:27 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015DJQ9V007801;
 Wed, 5 Feb 2020 13:19:26 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 05:19:26 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with ESMTP id DC82557DB9B2;
 Wed,  5 Feb 2020 13:19:23 +0000 (GMT)
Date: Wed, 5 Feb 2020 13:19:23 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 17/21] fuzz: add configure flag --enable-fuzzing
Message-ID: <20200205131923.iuu3ajy7e3tlqom6@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-18-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-18-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:25AM +0000, Bulekov, Alexander wrote:
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> configure | 39 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 39 insertions(+)
>
>diff --git a/configure b/configure
>index 08c3a1c1f0..1a1e57eb61 100755
>--- a/configure
>+++ b/configure
>@@ -504,6 +504,7 @@ debug_mutex=3D"no"
> libpmem=3D""
> default_devices=3D"yes"
> plugins=3D"no"
>+fuzzing=3D"no"
>
> supported_cpu=3D"no"
> supported_os=3D"no"
>@@ -634,6 +635,15 @@ int main(void) { return 0; }
> EOF
> }
>
>+write_c_fuzzer_skeleton() {
>+    cat > $TMPC <<EOF
>+#include <stdint.h>
>+#include <sys/types.h>
>+int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size);
>+int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) { return 0=
; }
>+EOF
>+}
>+
> if check_define __linux__ ; then
>   targetos=3D"Linux"
> elif check_define _WIN32 ; then
>@@ -1540,6 +1550,10 @@ for opt do
>   ;;
>   --disable-containers) use_containers=3D"no"
>   ;;
>+  --enable-fuzzing) fuzzing=3Dyes
>+  ;;
>+  --disable-fuzzing) fuzzing=3Dno
>+  ;;
>   *)
>       echo "ERROR: unknown option $opt"
>       echo "Try '$0 --help' for more information"
>@@ -5992,6 +6006,15 @@ EOF
>   fi
> fi
>
>+##########################################
>+# checks for fuzzer
>+if test "$fuzzing" =3D "yes" ; then
>+  write_c_fuzzer_skeleton
>+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress,fuzzer" "";=
 then
>+      have_fuzzer=3Dyes
>+  fi
>+fi
>+
> ##########################################
> # check for libpmem
>
>@@ -6576,6 +6599,7 @@ echo "libpmem support   $libpmem"
> echo "libudev           $libudev"
> echo "default devices   $default_devices"
> echo "plugin support    $plugins"
>+echo "fuzzing support   $fuzzing"
>
> if test "$supported_cpu" =3D "no"; then
>     echo
>@@ -7400,6 +7424,16 @@ fi
> if test "$sheepdog" =3D "yes" ; then
>   echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
> fi
>+if test "$fuzzing" =3D "yes" ; then
>+  if test "$have_fuzzer" =3D "yes"; then
>+    FUZZ_LDFLAGS=3D" -fsanitize=3Daddress,fuzzer"
>+    FUZZ_CFLAGS=3D" -fsanitize=3Daddress,fuzzer"
>+    CFLAGS=3D" -fsanitize=3Daddress,fuzzer-no-link"
>+  else
>+    error_exit "Your compiler doesn't support -fsanitize=3Daddress,fuzz=
er"
>+    exit 1
>+  fi
>+fi
>
> if test "$plugins" =3D "yes" ; then
>     echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
>@@ -7502,6 +7536,11 @@ if test "$libudev" !=3D "no"; then
>     echo "CONFIG_LIBUDEV=3Dy" >> $config_host_mak
>     echo "LIBUDEV_LIBS=3D$libudev_libs" >> $config_host_mak
> fi
>+if test "$fuzzing" !=3D "no"; then
>+    echo "CONFIG_FUZZ=3Dy" >> $config_host_mak
>+    echo "FUZZ_CFLAGS=3D$FUZZ_CFLAGS" >> $config_host_mak
>+    echo "FUZZ_LDFLAGS=3D$FUZZ_LDFLAGS" >> $config_host_mak
>+fi
>
> if test "$edk2_blobs" =3D "yes" ; then
>   echo "DECOMPRESS_EDK2_BLOBS=3Dy" >> $config_host_mak
>--=20
>2.23.0
>

