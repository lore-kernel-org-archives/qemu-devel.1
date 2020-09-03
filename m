Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B80C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA35206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yU/ND2rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA35206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlMg-0007kN-Br
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlLA-0006LB-3Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:15:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlL8-0007J7-4b
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:15:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839FR7j044623;
 Thu, 3 Sep 2020 09:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=l9/8fo04VJA/spdZ9VQ3U1mLC2OhSqa9kRUO7RBuCrk=;
 b=yU/ND2rnHSe4P80RUALLvAePoX4uk/q14+8ByPNw+BmKlvnVLZGgFR7ThAh6/du1+nZz
 odkSUhSvnNHRszKZCr39Q2QNfvRQa0Jhkoh6PoxHxvoWEr92b9iQ8otKEGuWVbQxmBvt
 4fIYGBawpGyW1C/z+nTN/kNK/UWuy3ovuqXRGx2SoovGLaI7qgRhdPkb+A5lQGy0vr6U
 4tlzE9EjlVmdO6uYKHH9eZNdVAAzVXltDTGEXxWAL9+/rzPWCixTcotbV2TV9ARoPfkV
 CHBDByR5FNVJBWJpNoAcSMSDLt/7DoDiS5fxqQZW87qAGimT3RswJ6ukfgsVWa77XDrB dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 337eer7n6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 09:15:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839B6sW110490;
 Thu, 3 Sep 2020 09:15:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 3380svr8k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 09:15:26 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0839FPoP030937;
 Thu, 3 Sep 2020 09:15:25 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 02:15:25 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id EADC2134FD7F; Thu,  3 Sep 2020 10:15:21 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 11/15] scripts/oss-fuzz: Add general-fuzzer build script
In-Reply-To: <20200819061110.1320568-12-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-12-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 10:15:21 +0100
Message-ID: <m2blinrzkm.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030085
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:48:18
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
Cc: Thomas Huth <thuth@redhat.com>, f4bug@amsat.org,
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-08-19 at 02:11:06 -04, Alexander Bulekov wrote:
> This parses a yaml file containing general-fuzzer configs and builds a
> separate oss-fuzz wrapper binary for each one, changing some
> preprocessor macros for each configuration. To avoid dealing with
> escaping and stringifying, convert each string into a byte-array
> representation
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  scripts/oss-fuzz/build_general_fuzzers.py | 62 +++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100755 scripts/oss-fuzz/build_general_fuzzers.py
>
> diff --git a/scripts/oss-fuzz/build_general_fuzzers.py b/scripts/oss-fuzz/build_general_fuzzers.py
> new file mode 100755
> index 0000000000..79f4664117
> --- /dev/null
> +++ b/scripts/oss-fuzz/build_general_fuzzers.py
> @@ -0,0 +1,62 @@
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
> +TEMPLATE = ""
> +
> +
> +def usage():
> +    print("Usage: CC=COMPILER {} CONFIG_PATH \
> +OUTPUT_PATH_PREFIX".format(sys.argv[0]))
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
> +    os.system('$CC -DQEMU_FUZZ_ARGS="{}" -DQEMU_FUZZ_OBJECTS="{}" \
> +                {} -o {}'.format(
> +                    str_to_c_byte_array(cfg["args"].replace("\n", " ")),
> +                    str_to_c_byte_array(cfg["objects"].replace("\n", " ")),
> +                    TEMPLATE, path))

NIT: When using multiple placeholders, it is nicer to use names for
them, so that reordering, or adding new ones is easier too.

> +
> +
> +def main():
> +    global CC
> +    global TEMPLATE
> +
> +    if len(sys.argv) != 3:
> +        usage()
> +
> +    cfg_path = sys.argv[1]
> +    out_path = sys.argv[2]
> +
> +    CC = os.getenv("CC")

Maybe provide a fall-back/default value if someone is calling it directly?

> +    TEMPLATE = os.path.join(os.path.dirname(__file__), "target.c")

No harm to double-check this exists, but also I would suggest that the
string "target.c" should be defined as a global value.

> +
> +    with open(cfg_path, "r") as f:
> +        configs = yaml.load(f)["configs"]
> +    for cfg in configs:
> +        assert "name" in cfg
> +        assert "args" in cfg
> +        assert "objects" in cfg
> +        compile_wrapper(cfg, out_path + cfg["name"])
> +
> +
> +if __name__ == '__main__':
> +    main()
> -- 
> 2.27.0

Thanks,

Darren.


