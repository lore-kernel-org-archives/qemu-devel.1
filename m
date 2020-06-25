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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14722C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3642206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVduAoWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3642206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOax-0000mU-3v
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joOaN-0000L0-RU
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:54:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joOaL-00083l-VT
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:54:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id o11so5156121wrv.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tHWnnkiw5IKcdeCus+FD7wTg4ouC3WwYpTI3eDOYnNE=;
 b=BVduAoWwUJuoaGmnz8e4bY/aIDCJQxEkL8FrUhwJKSwAz6VxsUQ7rf62vCjV/gQtna
 n3s6dHxsX0b1pEwfP0FJWX26LryYYYaCe4fWt6mH1b4D1s7oDUP1g3Qks9sx7NCO+pfo
 EiD8GbGDxDMp8xM52c9Gc5+Y4quQ7VoZsubHaIJ8adwFwKueG0pbzvR3qu4n9jLrxP8e
 qYhW2UeqdgVQBLKOJYMzWntoQUWA6zii+83fTym//pUtf2mH+U+YhOXsDyG/mxsg6X4H
 kdhN5731Nj7ID30T+n2bhhT4M/kZlYtKQFdVV/PEHWWNLoMAy5XRm/StRlXSTWMJjr6e
 hrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tHWnnkiw5IKcdeCus+FD7wTg4ouC3WwYpTI3eDOYnNE=;
 b=lk23W20Qg7gjL8BKNw4SzFI8HNHtiASPveic1PvsrzV0wO7hZzIeRHw9raJDfDnyHd
 DmplaIeRK3KdzLkiTnEY41sAt3qjE3jspmjyK+BdED6G2CzK8/HaZjln8sVZw4u86kne
 w592sDkOemCErNjC7C7VALTJlhOT0sNTQtdwEAd55npreR+5XH19mmxtHm1UuqlmpBUB
 UBw68OeJyaRkK9b/0C7QqRhDzWqe33TSatfAL1wUVpzTY7g9YBWXMy6dA9cEpbW7v50b
 gAc/fCF1m+esLA1J0VMW0UR6NNyTSaMcF/inBU7gUlqeAJVW5Y309STzRfGiKFA8XqnC
 n/wA==
X-Gm-Message-State: AOAM531qySXEbEh/RixXTKak/PWa1MXDzm8CoPFV+wIynJP5tHKr+HgT
 /Zm2DckjKhbsoLYIH3NMNC9lhm6+9dPg6dDLQvk=
X-Google-Smtp-Source: ABdhPJzlmebyvF3LnZ5WTS+cxT+ot13t707dINiQPD1hEcQcBYA6URKn/WFqRO/KomryPgFErCAsep/nTmSvRP8n2Y8=
X-Received: by 2002:adf:8462:: with SMTP id 89mr20701894wrf.420.1593078860366; 
 Thu, 25 Jun 2020 02:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200624153142.13247-1-ahmedkhaledkaraman@gmail.com>
 <20200624153142.13247-3-ahmedkhaledkaraman@gmail.com>
In-Reply-To: <20200624153142.13247-3-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 25 Jun 2020 11:54:08 +0200
Message-ID: <CAHiYmc5HpabBjHOCuaii8qe-fb6-NbimT9v1NiBtDrZOQDUjgQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] scripts/performance: Add topN_callgrind.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
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
> Python script that prints the top N most executed functions in QEMU
> using callgrind.
>
> Syntax:
> topN_callgrind.py [-h] [-n] <number of displayed top functions>  -- \
>                       <qemu executable> [<qemu executable options>] \
>                       <target executable> [<target execurable options>]
>
> [-h] - Print the script arguments help message.
> [-n] - Specify the number of top functions to print.
>      - If this flag is not specified, the tool defaults to 25.
>
> Example of usage:
> topN_callgrind.py -n 20 -- qemu-arm coulomb_double-arm
>
> Example Output:
> No.  Percentage Name                  Source File
> ----  --------- ------------------    ------------------------------
>    1    24.577% 0x00000000082db000    ???
>    2    20.467% float64_mul           <qemu>/fpu/softfloat.c
>    3    14.720% float64_sub           <qemu>/fpu/softfloat.c
>    4    13.864% float64_add           <qemu>/fpu/softfloat.c
>    5     4.876% helper_mulsd          <qemu>/target/i386/ops_sse.h
>    6     3.767% helper_subsd          <qemu>/target/i386/ops_sse.h
>    7     3.549% helper_addsd          <qemu>/target/i386/ops_sse.h
>    8     2.185% helper_ucomisd        <qemu>/target/i386/ops_sse.h
>    9     1.667% helper_lookup_tb_ptr  <qemu>/include/exec/tb-lookup.h
>   10     1.662% f64_compare           <qemu>/fpu/softfloat.c
>   11     1.509% helper_lookup_tb_ptr  <qemu>/accel/tcg/tcg-runtime.c
>   12     0.635% helper_lookup_tb_ptr  <qemu>/include/exec/exec-all.h
>   13     0.616% float64_div           <qemu>/fpu/softfloat.c
>   14     0.502% helper_pand_xmm       <qemu>/target/i386/ops_sse.h
>   15     0.502% float64_mul           <qemu>/include/fpu/softfloat.h
>   16     0.476% helper_lookup_tb_ptr  <qemu>/target/i386/cpu.h
>   17     0.437% float64_compare_quiet <qemu>/fpu/softfloat.c
>   18     0.414% helper_pxor_xmm       <qemu>/target/i386/ops_sse.h
>   19     0.353% round_to_int          <qemu>/fpu/softfloat.c
>   20     0.347% helper_cc_compute_all <qemu>/target/i386/cc_helper.c
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  scripts/performance/topN_callgrind.py | 139 ++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100755 scripts/performance/topN_callgrind.py
>
> diff --git a/scripts/performance/topN_callgrind.py b/scripts/performance/=
topN_callgrind.py
> new file mode 100755
> index 0000000000..6136f72a74
> --- /dev/null
> +++ b/scripts/performance/topN_callgrind.py
> @@ -0,0 +1,139 @@
> +#!/usr/bin/env python3
> +
> +#  Print the top N most executed functions in QEMU using callgrind.
> +#  Syntax:
> +#  topN_callgrind.py [-h] [-n] <number of displayed top functions>  -- \
> +#           <qemu executable> [<qemu executable options>] \
> +#           <target executable> [<target execurable options>]
> +#
> +#  [-h] - Print the script arguments help message.
> +#  [-n] - Specify the number of top functions to print.
> +#       - If this flag is not specified, the tool defaults to 25.
> +#
> +#  Example of usage:
> +#  topN_callgrind.py -n 20 -- qemu-arm coulomb_double-arm
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
> +    usage=3D'topN_callgrind.py [-h] [-n] <number of displayed top functi=
ons>  -- '
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
> +# Insure that valgrind is installed
> +check_valgrind =3D subprocess.run(

check_valgrind_presence is better that check_valgrind.

> +    ["which", "valgrind"], stdout=3Dsubprocess.DEVNULL)
> +if check_valgrind.returncode:
> +    sys.exit("Please install valgrind before running the script!")
> +
> +# Run callgrind
> +callgrind =3D subprocess.run((["valgrind", "--tool=3Dcallgrind",
> +                             "--callgrind-out-file=3Dcallgrind.data"] + =
command),
> +                           stdout=3Dsubprocess.DEVNULL, stderr=3Dsubproc=
ess.PIPE)

As I described in my comments for perf-related script, it is better to
use /tmp/callgrind.data, rather than just callgrind.data.

> +if callgrind.returncode:
> +    sys.exit(callgrind.stderr.decode("utf-8"))
> +
> +# Save callgrind_annotate output to callgrind_annotate.out
> +with open("callgrind_annotate.out", "w") as output:

/tmp/callgrind_annotate.out

> +    callgrind_annotate =3D subprocess.run(
> +        ["callgrind_annotate", "callgrind.data"],
> +        stdout=3Doutput,
> +        stderr=3Dsubprocess.PIPE)
> +    if callgrind_annotate.returncode:
> +        os.unlink('callgrind.data')
> +        output.close()
> +        os.unlink('callgrind_annotate.out')
> +        sys.exit(callgrind_annotate.stderr.decode("utf-8"))
> +
> +
> +# Read the callgrind_annotate output to callgrind_data[]
> +callgrind_data =3D []
> +with open('callgrind_annotate.out', 'r') as data:
> +    callgrind_data =3D data.readlines()
> +
> +# Line number with the total number of instructions
> +total_instructions_line_number =3D 20
> +
> +# Get the total number of instructions
> +total_instructions_line_data =3D callgrind_data[total_instructions_line_=
number]
> +total_number_of_instructions =3D total_instructions_line_data.split(' ')=
[0]
> +total_number_of_instructions =3D int(
> +    total_number_of_instructions.replace(',', ''))
> +
> +# Line number with the top function
> +first_func_line =3D 25
> +
> +# Number of functions recorded by callgrind, last two lines are always e=
mpty
> +number_of_functions =3D len(callgrind_data) - first_func_line - 2
> +
> +# Limit the number of top functions to "top"
> +number_of_top_functions =3D (top if number_of_functions >
> +                           top else number_of_functions)
> +
> +# Store the data of the top functions in top_functions[]
> +top_functions =3D callgrind_data[first_func_line:
> +                               first_func_line + number_of_top_functions=
]
> +
> +# Print table header
> +print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
> +                                                         'Percentage',
> +                                                         'Name',

Function Name

> +                                                         'Source File',
> +                                                         '-' * 4,
> +                                                         '-' * 10,
> +                                                         '-' * 30,
> +                                                         '-' * 30,
> +                                                         ))
> +
> +# Print top N functions
> +for (index, function) in enumerate(top_functions, start=3D1):
> +    function_data =3D function.split()
> +    # Calculate function percentage
> +    function_instructions =3D float(function_data[0].replace(',', ''))
> +    function_percentage =3D (function_instructions /
> +                           total_number_of_instructions)*100
> +    # Get function name and source files path
> +    function_source_path, function_name =3D function_data[1].split(':')

Please replace 'function_source_path' with more accurate 'function_source_f=
ile'.

> +    # Print extracted data
> +    print('{:>4}  {:>9.3f}%  {:<30}  {}'.format(index,
> +                                                round(function_percentag=
e, 3),
> +                                                function_name,
> +                                                function_source_path))
> +
> +# Remove intermediate files
> +os.unlink('callgrind.data')
> +os.unlink('callgrind_annotate.out')

os.unlink('/tmp/callgrind.data')
os.unlink('/tmp/callgrind_annotate.out')

Thanks,
Aleksandar

> --
> 2.17.1
>

