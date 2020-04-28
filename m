Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A7AC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A628C20730
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g7xBq1WK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A628C20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTT6S-0000yT-L3
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:29:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jTT4X-0007ds-3M
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jTT0w-0003AD-2H
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:27:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1jTT0v-00039t-Ei
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:23:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SGNDEt087171;
 Tue, 28 Apr 2020 16:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fu9XqBUFwJtggq1Pe6rAuXbVGfQoFH4gBOUNcb/3HFY=;
 b=g7xBq1WK0HMqx9cyMEYUw6DB1Vr31KmkTZmwqSn4LQlZtnaOKDSSwlfNYt3WWlMobsf4
 j7wZEyrGhy0uv8aJFKz4YqcFfW/PLlJj+eKQH22C3c3uIfgiCG9LqOGcbwKpvlH7vOad
 9fP3U/TRX+STlCDlpVtSXAMm6g+HAFS+vuRiwrdprHMojlTEvk0EX6UQ2IcweZ4qZ0w7
 uJkcXfDOxsKE6R9Ktyehh/ApULdT4ftXNf8JHHn1qGj4qxDGx63lseckakuTahgoSiI3
 j1gEWk8DVtf5AIdWCAAblGRDSk3qbrKI1JjVEn8wOROBMz/OFX/grpS2/LZqmaPy4tn7 Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 30p01nqhy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 16:23:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SGMfOr179153;
 Tue, 28 Apr 2020 16:23:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 30mxpgdc7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 16:23:11 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SGNA7A007518;
 Tue, 28 Apr 2020 16:23:10 GMT
Received: from [10.175.178.2] (/10.175.178.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 28 Apr 2020 09:23:09 -0700
Subject: Re: [PATCH v2 3/3] configure: add libdaxctl support
To: Jingqi Liu <jingqi.liu@intel.com>
References: <20200415033538.43329-1-jingqi.liu@intel.com>
 <20200415033538.43329-4-jingqi.liu@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <7b6a53cb-7591-26dd-2bdc-8d6a0bbb0338@oracle.com>
Date: Tue, 28 Apr 2020 17:23:06 +0100
MIME-Version: 1.0
In-Reply-To: <20200415033538.43329-4-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280128
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=joao.m.martins@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 11:32:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 4:35 AM, Jingqi Liu wrote:
> Add a pair of configure options --{enable,disable}-libdaxctl to control
> whether QEMU is compiled with libdaxctl [1]. Libdaxctl is a utility
> library for managing the device dax subsystem.
> 
> QEMU uses mmap(2) to maps vNVDIMM backends and aligns the mapping
> address to the page size (getpagesize(2)) by default. However, some
> types of backends may require an alignment different than the page
> size. The 'align' option is provided to memory-backend-file to allow
> users to specify the proper alignment.
> 
> For device dax (e.g., /dev/dax0.0), the 'align' option needs to match
> the alignment requirement of the device dax, which can be fetched
> through the libdaxctl APIs.
> 
> [1] Libdaxctl is a part of ndctl project.
> The project's repository is: https://github.com/pmem/ndctl
> 
> For more information about libdaxctl APIs, you can refer to the
> comments in source code of: pmem/ndctl/daxctl/lib/libdaxctl.c.
> 
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>  configure | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/configure b/configure
> index e225a1e3ff..df1752cf08 100755
> --- a/configure
> +++ b/configure
> @@ -509,6 +509,7 @@ libpmem=""
>  default_devices="yes"
>  plugins="no"
>  fuzzing="no"
> +libdaxctl=""
>  
>  supported_cpu="no"
>  supported_os="no"
> @@ -1601,6 +1602,10 @@ for opt do
>    ;;
>    --gdb=*) gdb_bin="$optarg"
>    ;;
> +  --enable-libdaxctl) libdaxctl=yes
> +  ;;
> +  --disable-libdaxctl) libdaxctl=no
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1894,6 +1899,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    debug-mutex     mutex debugging support
>    libpmem         libpmem support
>    xkbcommon       xkbcommon support
> +  libdaxctl       libdaxctl support
>  
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> @@ -6190,6 +6196,25 @@ if test "$libpmem" != "no"; then
>  	fi
>  fi
>  
> +##########################################
> +# check for libdaxctl
> +
> +if test "$libdaxctl" != "no"; then
> +	if $pkg_config --exists "libdaxctl"; then
> +		libdaxctl="yes"
> +		libdaxctl_libs=$($pkg_config --libs libdaxctl)
> +		libdaxctl_cflags=$($pkg_config --cflags libdaxctl)
> +		libs_softmmu="$libs_softmmu $libdaxctl_libs"
> +		QEMU_CFLAGS="$QEMU_CFLAGS $libdaxctl_cflags"
> +	else
> +		if test "$libdaxctl" = "yes" ; then
> +			feature_not_found "libdaxctl" "Install libdaxctl"
> +		fi

Region iteration APIs, align and path getter routines are only available since
libdaxctl v56/v57 (the latest is v68).

Not sure how likely this happens in today's distros but if we care about systems
with < v57 we should probably check that
daxctl_region_foreach/daxctl_region_get_align/daxctl_region_get_path symbols
exist? Or alternatively requiring v57 or up which serves as a bandage, but more
long term ... any usage of newer daxctl APIs will require the former.

> +		libdaxctl="no"
> +	fi
> +fi
> +
> +
>  ##########################################
>  # check for slirp
>  
> @@ -6767,6 +6792,7 @@ echo "parallels support $parallels"
>  echo "sheepdog support  $sheepdog"
>  echo "capstone          $capstone"
>  echo "libpmem support   $libpmem"
> +echo "libdaxctl support $libdaxctl"
>  echo "libudev           $libudev"
>  echo "default devices   $default_devices"
>  echo "plugin support    $plugins"
> @@ -7590,6 +7616,10 @@ if test "$libpmem" = "yes" ; then
>    echo "CONFIG_LIBPMEM=y" >> $config_host_mak
>  fi
>  
> +if test "$libdaxctl" = "yes" ; then
> +  echo "CONFIG_LIBDAXCTL=y" >> $config_host_mak
> +fi
> +
>  if test "$bochs" = "yes" ; then
>    echo "CONFIG_BOCHS=y" >> $config_host_mak
>  fi
> 

