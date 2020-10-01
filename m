Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C033C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824F6206A1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uf5VTgaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824F6206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0ns-000178-7R
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kO0jE-0004Ro-D8
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:42:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kO0jB-0004H2-5B
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:42:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091Fd98C038087;
 Thu, 1 Oct 2020 15:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=YlHduj9Zy7EmZSaNb/IUMUZJPZhicT//8k8I+eUTBss=;
 b=uf5VTgaR/eiZDQyYVdtYJCPGA5k/bZX0muSXgW+9UTK+hMThm/0f1bZKEwFcm8nth/E6
 myF7BOIQTOBfjRlutWp5GW2nh8EjwDmMiixIEdI9KbqZEM6A3TpUJYjuIDtENZ+odh4w
 XJbx2pwsIjyWb18+vPnIDBKtUX9WnjlM4Vj3RreQn66FqrYZx1V+TnDNmJiuNrhV6Azr
 DwclLVVtu+uZQ9Bk1Ifoq8LxnVMTz7/Ud0yEJ+lMg+MzrH7VDZJVnppg8XR3CBLUhdVF
 kYeedPEYlfbRH8olDeSzcbHd9+oUwfTxshTEXD2ZK0w8W1bXHFLsNWBxJt6i1RB/g+3v HA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33sx9neqrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 01 Oct 2020 15:42:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091FL16o093476;
 Thu, 1 Oct 2020 15:40:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 33uv2h3gay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Oct 2020 15:40:37 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 091FeZwD018693;
 Thu, 1 Oct 2020 15:40:35 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 01 Oct 2020 08:40:35 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id E196918EE5DB; Thu,  1 Oct 2020 16:40:31 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 11/16] scripts/oss-fuzz: Add general-fuzzer build script
In-Reply-To: <20200921022506.873303-12-alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-12-alxndr@bu.edu>
Date: Thu, 01 Oct 2020 16:40:31 +0100
Message-ID: <m2blhm6jkg.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=2 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=2
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010133
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 11:29:20
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Sunday, 2020-09-20 at 22:25:01 -04, Alexander Bulekov wrote:
> This parses a yaml file containing general-fuzzer configs and builds a
> separate oss-fuzz wrapper binary for each one, changing some
> preprocessor macros for each configuration. To avoid dealing with
> escaping and stringifying, convert each string into a byte-array
> representation
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  scripts/oss-fuzz/build_general_fuzzers.py | 69 +++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100755 scripts/oss-fuzz/build_general_fuzzers.py
>
> diff --git a/scripts/oss-fuzz/build_general_fuzzers.py b/scripts/oss-fuzz/build_general_fuzzers.py
> new file mode 100755
> index 0000000000..918f1143a5
> --- /dev/null
> +++ b/scripts/oss-fuzz/build_general_fuzzers.py
> @@ -0,0 +1,69 @@
> +#!/usr/bin/env python3
> +# -*- coding: utf-8 -*-
> +
> +"""
> +This script creates wrapper binaries that invoke the general-device-fuzzer with
> +configurations specified in a yaml config file.
> +"""
> +import sys
> +import os
> +import yaml
> +import tempfile
> +
> +CC = ""
> +TEMPLATE_FILENAME = "target_template.c"
> +TEMPLATE_PATH = ""
> +
> +
> +def usage():
> +    print("Usage: CC=COMPILER {} CONFIG_PATH \
> +OUTPUT_PATH_PREFIX".format(sys.argv[0]))

The indentation of this seems off.

Python will concatenate 2 or more strings that appear one after the
other, so it might be cleaner to write them like:

    print("Usage: CC=COMPILER {} CONFIG_PATH "
          "OUTPUT_PATH_PREFIX".format(sys.argv[0]))

There is no need for the backslash at the end due to the use of the
braces '()' here.


> +    sys.exit(0)
> +
> +
> +def str_to_c_byte_array(s):
> +    """
> +    Convert strings to byte-arrays so we don't worry about formatting
> +    strings to play nicely with cc -DQEMU_FUZZARGS etc
> +    """
> +    return ','.join('0x{:02x}'.format(ord(x)) for x in s)
> +
> +
> +def compile_wrapper(cfg, path):
> +    os.system('$CC -DQEMU_FUZZ_ARGS="{fuzz_args}" \
> +               -DQEMU_FUZZ_OBJECTS="{fuzz_objs}" \
> +               {wrapper_template} -o {output_bin}'.format(
> +                   fuzz_args=str_to_c_byte_array(cfg["args"].replace("\n", " ")),
> +                   fuzz_objs=str_to_c_byte_array(cfg["objects"].replace("\n", " ")),
> +                   wrapper_template=TEMPLATE_PATH,
> +                   output_bin=path))
> +

Similarly here, it might look better as:

    os.system('$CC -DQEMU_FUZZ_ARGS="{fuzz_args}" '
              '-DQEMU_FUZZ_OBJECTS="{fuzz_objs}" '
              '{wrapper_template} -o {output_bin}'.format(
                   fuzz_args=str_to_c_byte_array(cfg["args"].replace("\n", " ")),
                   fuzz_objs=str_to_c_byte_array(cfg["objects"].replace("\n", " ")),
                   wrapper_template=TEMPLATE_PATH,
                   output_bin=path))

> +
> +
> +def main():
> +    global CC
> +    global TEMPLATE_PATH
> +    global OUTPUT_BIN_NAME
> +
> +    if len(sys.argv) != 3:
> +        usage()
> +
> +    cfg_path = sys.argv[1]
> +    out_path = sys.argv[2]
> +
> +    CC = os.getenv("CC", default="cc")
> +    TEMPLATE_PATH = os.path.join(os.path.dirname(__file__), TEMPLATE_FILENAME)
> +    if not os.path.exists(TEMPLATE_PATH):
> +        print("Error {} doesn't exist".format(TEMPLATE_PATH))
> +        sys.exit(1)
> +
> +    with open(cfg_path, "r") as f:
> +        configs = yaml.load(f)["configs"]

Just in case, the use of .get("config". []) might work better here.

But also check if yaml.load() could possibly throw an exception if the
file, despite existing isn't able to be parsed.

Thanks,

Darren.

