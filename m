Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B7F2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y4VFNSbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B7F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGkA-0008Fq-1y
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jhGca-0005t0-Cc
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:59:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jhGcX-0000at-DK
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:59:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055Hgggt114315;
 Fri, 5 Jun 2020 17:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=uDfAcGYVhUuoqLje7qv74ZmkRbFeU9jdHfSBibKlp+E=;
 b=y4VFNSbwE2HeaciCmfWRpysJ54yff1LZ3l7Vtem3YrubSL57mjgruSa7HO177E0OR0cP
 GTg5sIy07hR6hT9fK/8cKCzjowXVex432kCx326gPUu+q11hqNffoOpXwbAesNn9lj0A
 +lp0O3AwJuait2S8S4Jh1RR81Axjzgo5l02LqgYTN5nUleHAbXos4tnUeeXIOOn1gpi8
 d0ZwffUCMWbh7ATB1Rs9uthdB1Fv4HJiZFq+HONr+oZbh/Ep4JhoIqbVxAn4SaeSTVJA
 g7VhEpgQ+I+VWNv+XrvbDNKbqlwFExVD8RCnk4jNWKVqsxI6aHloR8dgInJz55C+EVOx OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 31f91dv3w5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 05 Jun 2020 17:59:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055HhTuh046709;
 Fri, 5 Jun 2020 17:59:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 31f92t3n1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jun 2020 17:59:02 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 055Hx0HI023421;
 Fri, 5 Jun 2020 17:59:00 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 05 Jun 2020 10:59:00 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 6C9A959AB4C; Fri,  5 Jun 2020 18:58:56 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] fuzz: add oss-fuzz build.sh script
In-Reply-To: <20200605175028.5626-1-alxndr@bu.edu>
References: <20200605175028.5626-1-alxndr@bu.edu>
Date: Fri, 05 Jun 2020 18:58:56 +0100
Message-ID: <m2a71hv1gf.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0
 clxscore=1015 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050132
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 13:59:05
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

From looking at another OSS Fuzz project recently (a coincidence) I
wonder if we could make this script work so that it can be run outside
of the OSS-Fuzz environment?

Specifically, for example, if $OUT is not set, then creating a subdir in
the build directory, and setting it to be that.

Similarly for some other things like $LIB_FUZZING_ENGINE?

I'm just thinking that it might help someone that is not familiar with
OSS-Fuzz to validate that the script still works without having to go
through setting up the containers, etc that would be required to
validate it.

Also, I would definitely recommend running ShellCheck against any script
to ensure that you're catching any mistakes that can so easily be put in
to shell scripts - speaking from experience here ;)

Thanks,

Darren.


On Friday, 2020-06-05 at 13:50:28 -04, Alexander Bulekov wrote:
> It is neater to keep this in the QEMU repo, since any change that
> requires an update to the oss-fuzz build configuration, can make the
> necessary changes in the same series.
>
> Suggested-by: Philippe Mathieu-Daude <f4bug@amsat.org>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>
> v2 updates the script header comment.
>
>  scripts/oss-fuzz/build.sh | 50 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100755 scripts/oss-fuzz/build.sh
>
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> new file mode 100755
> index 0000000000..e93d6f2e03
> --- /dev/null
> +++ b/scripts/oss-fuzz/build.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +#
> +# OSS-Fuzz build script. See:
> +# https://google.github.io/oss-fuzz/getting-started/new-project-guide/#buildsh
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
> +# $CXX $CXXFLAGS -std=c++11 -Iinclude \
> +#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
> +#     $LIB_FUZZING_ENGINE /path/to/library.a
> +
> +mkdir -p $OUT/lib/              # Shared libraries
> +
> +# Build once to get the list of dynamic lib paths, and copy them over
> +./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" \
> +    --extra-cflags="$CFLAGS -U __OPTIMIZE__ "
> +make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz
> +
> +for i in $(ldd ./i386-softmmu/qemu-fuzz-i386  | cut -f3 -d' '); do 
> +    cp $i $OUT/lib/
> +done
> +rm ./i386-softmmu/qemu-fuzz-i386
> +
> +# Build a second time to build the final binary with correct rpath
> +./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" \
> +    --extra-cflags="$CFLAGS -U __OPTIMIZE__" \
> +    --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
> +make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz
> +
> +# Copy over the datadir
> +cp  -r ./pc-bios/ $OUT/pc-bios
> +
> +# Run the fuzzer with no arguments, to print the help-string and get the list
> +# of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
> +# to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
> +# executable name)
> +for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
> +do
> +    cp ./i386-softmmu/qemu-fuzz-i386 $OUT/qemu-fuzz-i386-target-$target
> +done
> -- 
> 2.26.2

