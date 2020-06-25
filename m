Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD12C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C28320679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhf4nvNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C28320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOT7-00045Z-QH
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joOSC-0003dX-5Z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:45:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joOSA-0006X3-31
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:45:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id h5so5142512wrc.7
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gx2RdgTxC8DonxgS8IFHvn1McWChqgyKeYtgr+33Msc=;
 b=fhf4nvNgBm1wtdT6CeNneM7pL0dM/BiaSgw/amL2jIFUk2GjsM8EV2Vcc7/WRth8nD
 YAHSp+IyTv6CUP4BVIgZG4syyU1EJ38Nl/yStk7v2jGhRUisEOph95byQh3Zck7FHRhS
 SXkfHX+Cx3PZQKyerZ4vqvhTPqSIgmVn1P4JnasDESmsu52kKrnvYGbqa5aM4PWutjDC
 QUn8XWNW4FNvyH7wPk6mkBC+W8ZN11O2CTjgPMln/uL/iluF/AZsSJsnmfHPQC6rHMid
 oK9rWzmczuzudkwV/bawhhdhHLV3GvEpgD0C5ypyVs7S2A+CtZPlxAQr/iM1zx7o+Yqx
 xRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gx2RdgTxC8DonxgS8IFHvn1McWChqgyKeYtgr+33Msc=;
 b=M5DIZKcWX9wvbsHN1dnMN+UQGx6rIRUye32tpMVCK+h8peIzz1T8wPmvn3AyNot3oj
 BpCY7IfRF3j0KArd7i/lr7d16//HrDjGRskBQkY01zF55fa5onG+d8BWEyAxOO8iim6R
 k8/dZoiF0wP2cKD2xzHMLyBohVm8AqEPRX4Gmqcqdr1SZwCE8rzTn9s7T5cQ6Dhqq8/m
 SOfW2BpZgNCKzLslMOHWcieo7VkLO/37N6eYrFAXQkeezloTJyisPOji7WmLtKX0XrT8
 +1WIuTHmmBLb8wPShUG3wLM01OuMpD9S83TL53M9aoGmaWIRDWDgsLRe4sSE1XL63KBs
 sBIg==
X-Gm-Message-State: AOAM531nd4zsKtubiBSpJ1Lv+o9b3ErM/Zc/dhKG2Jr4+Ba8whdG6AoI
 CZW7Qqbtwzu/oTxVqsB9s7fTJYOFL23Zr9Ay6HA=
X-Google-Smtp-Source: ABdhPJzyYyVon2RaNb1C6suCtAeRce7ls+wLBgLNBh0ebR8V5FtdsXYHwJGURlNVKUXLRc+Yp6k3fjv0GjEIrz16Y60=
X-Received: by 2002:adf:8462:: with SMTP id 89mr20666922wrf.420.1593078352654; 
 Thu, 25 Jun 2020 02:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200624153142.13247-1-ahmedkhaledkaraman@gmail.com>
 <20200624153142.13247-2-ahmedkhaledkaraman@gmail.com>
In-Reply-To: <20200624153142.13247-2-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 25 Jun 2020 11:45:40 +0200
Message-ID: <CAHiYmc6vtE7VmQ-GSLqbCQxM7dEyc-e1TGBDGWYSV6CNV0wgGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] scripts/performance: Add topN_perf.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PDS_OTHER_BAD_TLD=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 24. =D1=98=D1=83=D0=BD 2020. =D1=83 17:32 Ahmed Karaman
<ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Syntax:
> topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
>                  <qemu executable> [<qemu executable options>] \
>                  <target executable> [<target execurable options>]
>
> [-h] - Print the script arguments help message.
> [-n] - Specify the number of top functions to print.
>      - If this flag is not specified, the tool defaults to 25.
>
> Example of usage:
> topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
>
> Example Output:
>  No.  Percentage  Name                       Caller
> ----  ----------  -------------------------  -------------------------
>    1      16.25%  float64_mul                qemu-x86_64
>    2      12.01%  float64_sub                qemu-x86_64
>    3      11.99%  float64_add                qemu-x86_64
>    4       5.69%  helper_mulsd               qemu-x86_64
>    5       4.68%  helper_addsd               qemu-x86_64
>    6       4.43%  helper_lookup_tb_ptr       qemu-x86_64
>    7       4.28%  helper_subsd               qemu-x86_64
>    8       2.71%  f64_compare                qemu-x86_64
>    9       2.71%  helper_ucomisd             qemu-x86_64
>   10       1.04%  helper_pand_xmm            qemu-x86_64
>   11       0.71%  float64_div                qemu-x86_64
>   12       0.63%  helper_pxor_xmm            qemu-x86_64
>   13       0.50%  0x00007f7b7004ef95         [JIT] tid 491
>   14       0.50%  0x00007f7b70044e83         [JIT] tid 491
>   15       0.36%  helper_por_xmm             qemu-x86_64
>   16       0.32%  helper_cc_compute_all      qemu-x86_64
>   17       0.30%  0x00007f7b700433f0         [JIT] tid 491
>   18       0.30%  float64_compare_quiet      qemu-x86_64
>   19       0.27%  soft_f64_addsub            qemu-x86_64
>   20       0.26%  round_to_int               qemu-x86_64
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  scripts/performance/topN_perf.py | 142 +++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100755 scripts/performance/topN_perf.py
>
> diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_=
perf.py
> new file mode 100755
> index 0000000000..d2b939c375
> --- /dev/null
> +++ b/scripts/performance/topN_perf.py
> @@ -0,0 +1,142 @@
> +#!/usr/bin/env python3
> +
> +#  Print the top N most executed functions in QEMU using perf.
> +#  Syntax:
> +#  topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
> +#           <qemu executable> [<qemu executable options>] \
> +#           <target executable> [<target execurable options>]
> +#
> +#  [-h] - Print the script arguments help message.
> +#  [-n] - Specify the number of top functions to print.
> +#       - If this flag is not specified, the tool defaults to 25.
> +#
> +#  Example of usage:
> +#  topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
> +#
> +#  This file is a part of the project "TCG Continuous Benchmarking".
> +#
> +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.=
com>
> +#
> +#  This program is free software: you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation, either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +#  GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program. If not, see <https://www.gnu.org/licenses/>.
> +
> +import argparse
> +import os
> +import subprocess
> +import sys
> +
> +
> +# Parse the command line arguments
> +parser =3D argparse.ArgumentParser(
> +    usage=3D'topN_perf.py [-h] [-n] <number of displayed top functions >=
  -- '
> +          '<qemu executable> [<qemu executable options>] '
> +          '<target executable> [<target executable options>]')
> +
> +parser.add_argument('-n', dest=3D'top', type=3Dint, default=3D25,
> +                    help=3D'Specify the number of top functions to print=
.')
> +
> +parser.add_argument('command', type=3Dstr, nargs=3D'+', help=3Dargparse.=
SUPPRESS)
> +
> +args =3D parser.parse_args()
> +
> +# Extract the needed variables from the args
> +command =3D args.command
> +top =3D args.top
> +
> +# Insure that perf is installed
> +check_perf =3D subprocess.run(["which", "perf"], stdout=3Dsubprocess.DEV=
NULL)
> +if check_perf.returncode:
> +    sys.exit("Please install perf before running the script!")

I would rename "chech_perf" to "check_perf_presence". It is more
specific, clearer.

> +
> +# Insure user has previllage to run perf
> +check_perf_executability =3D subprocess.run(["perf", "stat", "ls", "/"],
> +                           stdout=3Dsubprocess.DEVNULL, stderr=3Dsubproc=
ess.DEVNULL)
> +if check_perf_executability.returncode:
> +    sys.exit(
> +"""
> +Error:
> +You may not have permission to collect stats.
> +
> +Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> +which controls use of the performance events system by
> +unprivileged users (without CAP_SYS_ADMIN).
> +
> +  -1: Allow use of (almost) all events by all users
> +      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> +   0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
> +      Disallow raw tracepoint access by users without CAP_SYS_ADMIN
> +   1: Disallow CPU event access by users without CAP_SYS_ADMIN
> +   2: Disallow kernel profiling by users without CAP_SYS_ADMIN
> +
> +To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
> +   kernel.perf_event_paranoid =3D -1
> +"""
> +)

Very good.

> +
> +# Run perf record
> +perf_record =3D subprocess.run((["perf", "record"] + command),
> +                             stdout=3Dsubprocess.DEVNULL, stderr=3Dsubpr=
ocess.PIPE)
> +if perf_record.returncode:
> +    os.unlink('perf.data')
> +    sys.exit(perf_record.stderr.decode("utf-8"))

Here, the file "perf.data" will be created in the current working
directory. If one existed prior to script execution, it will be
overwritten.

I think such "corruption" of current working directory is not optimal.
It would be better that the script doesn't touch current working
directory at all (perhaps user wants to keep perf.data he obtained
from some experiment in the past.

Therefore, I think it would be better if you specify output of "perf
report" to be "/tmp/perf.data", not "perf.data", which is the default.
There is an option of "perf record" to specify the output file:

       -o, --output=3D
           Output file name.

> +
> +# Save perf report output to perf_report.out
> +with open("perf_report.out", "w") as output:
> +    perf_report =3D subprocess.run(
> +        ["perf", "report", "--stdio"], stdout=3Doutput, stderr=3Dsubproc=
ess.PIPE)
> +    if perf_report.returncode:
> +        os.unlink('perf.data')
> +        output.close()
> +        os.unlink('perf_report.out')
> +        sys.exit(perf_report.stderr.decode("utf-8"))

For similar reasons described above, input file should be
"/tmp/perf.data". Option of "perf report" for input file:

       -i, --input=3D
           Input file name.

Output file should be "/tmp/perf_report.out", not "perf_report.out".

> +
> +# Read the reported data to functions[]
> +functions =3D []
> +with open("perf_report.out", "r") as data:

"/tmp/perf_report.out"

> +    # Only read lines that are not comments (comments start with #)
> +    # Only read lines that are not empty
> +    functions =3D [line for line in data.readlines() if line and line[0]
> +                 !=3D '#' and line[0] !=3D "\n"]
> +
> +# Limit the number of top functions to "top"
> +number_of_top_functions =3D top if len(functions) > top else len(functio=
ns)
> +
> +# Store the data of the top functions in top_functions[]
> +top_functions =3D functions[:number_of_top_functions]
> +
> +# Print table header
> +print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
> +                                                         'Percentage',
> +                                                         'Name',

'Function Name' would be more ergonomic here.

> +                                                         'Caller',

Please replace 'Caller' with 'Invoked by'. 'Caller' implies a function
that directly calls the function in question. 'Invoked by' avoids such
confusion, and it just feels more appropriate here.

> +                                                         '-' * 4,
> +                                                         '-' * 10,
> +                                                         '-' * 30,
> +                                                         '-' * 25))
> +
> +
> +# Print top N functions
> +for (index, function) in enumerate(top_functions, start=3D1):
> +    function_data =3D function.split()
> +    function_percentage =3D function_data[0]
> +    function_name =3D function_data[-1]
> +    function_caller =3D ' '.join(function_data[2:-2])

function_invoker

> +    print('{:>4}  {:>10}  {:<30}  {}'.format(index,
> +                                             function_percentage,
> +                                             function_name,
> +                                             function_caller))

function_invoker

> +
> +# Remove intermediate files
> +os.unlink('perf.data')
> +os.unlink('perf_report.out')

os.unlink('/tmp/perf.data')
os.unlink('/tmp/perf_report.out')


> --
> 2.17.1
>

