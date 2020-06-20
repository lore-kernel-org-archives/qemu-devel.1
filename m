Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD4DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 10:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A65D23AF8
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 10:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJk+T1im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A65D23AF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmaKO-0003E5-Pr
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 06:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmaJK-0001Kq-9L
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 06:01:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmaJH-00057J-Te
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 06:01:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so11927005wrr.10
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=KDrDI44Xn1/uqB57rbz2pbb4jMhLxRp4houc92re78Y=;
 b=VJk+T1imtU0+/EH2tsXgz3jRU4y5OoAADAmMlVlDmjU6QF2yq6t4ZQoPCajQ5TxZ/4
 lAl6Ufiy1aDlKldARrgTUtrbSivXd0rxBWt3o8j/tiR0/dfhADaTt8UBVaBmCtITWv6H
 JByzVyMoll32JvzSg45VreXQvaTu9K9r0vPvIwASrpoLV/rtKDIhYxE0J5HNAvCGAaoX
 NCrih4Tf4B5Yhuz2kcMZqKSRBtCcg7bN0VbPohyfJAm+9vNlVjhADt/jLCNZhCPiJmpC
 jU1ZFKuWY+mrgGKpVknOqLjRBEs4nEW2FOHTuTovkZsvLyQVJZEQDihvHaVZZfUqt8LR
 2R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=KDrDI44Xn1/uqB57rbz2pbb4jMhLxRp4houc92re78Y=;
 b=ZtDCTiDjObRd9fytD3rQhQ9t1uFjZyTqLyc3/9+/J3LMkLMO0DeZID5I7QNKq/sgmK
 GJGKeGvx/hSZKVZJO6uPB3Sd7RyCKr5t3oXQeZhooeqG+A/sNiWZmDZU6iOaNQ/i49JS
 W5qQlBFX/3YLQYYqPit4e1r9y5lSxjlitgAtEtt05XkQctF8/+GqKmmUDpzCrxhA8UE7
 TJ7ougZrYvg5aoaI3Yzl711CigeZg3Vj0/Z81Pyhdt+TX/u+Ff3erXbNai2ZpyYJ7ZjN
 ZNcu3uZmotPyTph2mvs3B3gGgvzDZUGSBeWm4sCay3bA6mHaDbAfJZruTFhO2L7gF2vt
 5ZGQ==
X-Gm-Message-State: AOAM5307PaMY471lJTj4k/s78DKli+TXCV9f5MxuYIW27XefFE4mRy3M
 lj3yOzUlAwWVLDDBwz20QAYTIPFNe0/hSnU18gU=
X-Google-Smtp-Source: ABdhPJy8inu29WojpyS8Au2UvHxsDmz/NVCUtMmPXwxmg45zDA4NushTmiGzkUm2j462HhABUtKzE9P5KZR9a6squhw=
X-Received: by 2002:adf:a283:: with SMTP id s3mr7982471wra.147.1592647273875; 
 Sat, 20 Jun 2020 03:01:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Sat, 20 Jun 2020 03:01:13 -0700 (PDT)
In-Reply-To: <20200619153632.1365-2-ahmedkhaledkaraman@gmail.com>
References: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
 <20200619153632.1365-2-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 20 Jun 2020 12:01:13 +0200
Message-ID: <CAHiYmc6=WZqKBr=Rri4s2iHgN-FOLDfxvDOX+5Nnj6gnthrJYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] scripts/performance: Add topN_perf.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000030bd705a8811701"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, PDS_OTHER_BAD_TLD=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "crosa@redhat.com" <crosa@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000030bd705a8811701
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=B5=D1=82=D0=B0=D0=BA, 19. =D1=98=D1=83=D0=BD 2020., Ahmed Karaman=
 <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> Python script that prints the top N most executed functions in QEMU
> using perf.
>
> Example Usage:
> topN_perf.py -n 20 -- /path/to/qemu program -program -flags
>
> If '-n' is not specified, the default is 25.
>
>
Comments similar to the one for the previous patch apply here too.



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
>  scripts/performance/topN_perf.py | 115 +++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100755 scripts/performance/topN_perf.py
>
> diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_
> perf.py
> new file mode 100755
> index 0000000000..53fa503d8a
> --- /dev/null
> +++ b/scripts/performance/topN_perf.py
> @@ -0,0 +1,115 @@
> +#!/usr/bin/env python3
> +
> +#  Print the top N most executed functions in QEMU using perf.
> +#  Example Usage:
> +#  topN_perf.py -n 20 -- /path/to/qemu program -program -flags
> +#
> +#   If '-n' is not specified, the default is 25.
> +#
> +#  This file is a part of the project "TCG Continuous Benchmarking".
> +#
> +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.
> com>
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
> +parser =3D argparse.ArgumentParser(usage=3D'topN_perf.py [-h] [-n
> TOP_FUNCTIONS] --'
> +                                ' /path/to/qemu program -[flags
> PROGRAM_FLAGS]')
> +
> +parser.add_argument('-n', dest=3D'top', type=3Dint, default=3D25,
> +                    help=3D'Specify the number of top functions to print=
.')
> +
> +parser.add_argument('command', type=3Dstr, nargs=3D'+',
> help=3Dargparse.SUPPRESS)
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
> +
> +# Insure user has previllage to run perf
> +check_previlage =3D subprocess.run(["perf", "stat", "ls", "/"],
> +                              stdout=3Dsubprocess.DEVNULL,
> stderr=3Dsubprocess.PIPE)
> +if check_previlage.returncode:
> +    sys.exit(check_previlage.stderr.decode("utf-8") +
> +             "\nOr alternatively, you can run the script with sudo
> privileges!")
> +
> +# Run perf record
> +perf_record =3D subprocess.run((["perf", "record"] + command),
> +                             stdout=3Dsubprocess.DEVNULL,
> stderr=3Dsubprocess.PIPE)
> +if perf_record.returncode:
> +    os.unlink('perf.data')
> +    sys.exit(perf_record.stderr.decode("utf-8"))
> +
> +# Save perf report output to tmp.perf.data
> +with open("tmp.perf.data", "w") as output:
> +    perf_report =3D subprocess.run(
> +        ["perf", "report", "--stdio"], stdout=3Doutput,
> stderr=3Dsubprocess.PIPE)
> +    if perf_report.returncode:
> +        os.unlink('perf.data')
> +        output.close()
> +        os.unlink('tmp.perf.data')
> +        sys.exit(perf_report.stderr.decode("utf-8"))
> +
> +# Read the reported data to functions[]
> +functions =3D []
> +with open("tmp.perf.data", "r") as data:
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
> +# Print information headers
> +print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
> +                                                         'Percentage',
> +                                                         'Name',
> +                                                         'Caller',
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
> +    print('{:>4}  {:>10}  {:<30}  {}'.format(index,
> +                                             function_percentage,
> +                                             function_name,
> +                                             function_caller))
> +
> +# Remove intermediate files
> +os.unlink('perf.data')
> +os.unlink('tmp.perf.data')
> --
> 2.17.1
>
>

--000000000000030bd705a8811701
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=BF=D0=B5=D1=82=D0=B0=D0=BA, 19. =D1=98=D1=83=D0=BD 2020., Ahmed=
 Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhaledkar=
aman@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Python script that prin=
ts the top N most executed functions in QEMU<br>
using perf.<br>
<br>
Example Usage:<br>
topN_perf.py -n 20 -- /path/to/qemu program -program -flags<br>
<br>
If &#39;-n&#39; is not specified, the default is 25.<br>
<br></blockquote><div><br></div><div>Comments similar to the one for the pr=
evious patch apply here too.</div><div><br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
Example Output:<br>
=C2=A0No.=C2=A0 Percentage=C2=A0 Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Caller<br>
----=C2=A0 ----------=C2=A0 -------------------------=C2=A0 ---------------=
----------<br>
=C2=A0 =C2=A01=C2=A0 =C2=A0 =C2=A0 16.25%=C2=A0 float64_mul=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-x86_64<br>
=C2=A0 =C2=A02=C2=A0 =C2=A0 =C2=A0 12.01%=C2=A0 float64_sub=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-x86_64<br>
=C2=A0 =C2=A03=C2=A0 =C2=A0 =C2=A0 11.99%=C2=A0 float64_add=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-x86_64<br>
=C2=A0 =C2=A04=C2=A0 =C2=A0 =C2=A0 =C2=A05.69%=C2=A0 helper_mulsd=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-x86_64<br>
=C2=A0 =C2=A05=C2=A0 =C2=A0 =C2=A0 =C2=A04.68%=C2=A0 helper_addsd=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-x86_64<br>
=C2=A0 =C2=A06=C2=A0 =C2=A0 =C2=A0 =C2=A04.43%=C2=A0 helper_lookup_tb_ptr=
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-x86_64<br>
=C2=A0 =C2=A07=C2=A0 =C2=A0 =C2=A0 =C2=A04.28%=C2=A0 helper_subsd=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-x86_64<br>
=C2=A0 =C2=A08=C2=A0 =C2=A0 =C2=A0 =C2=A02.71%=C2=A0 f64_compare=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-x86_64<br>
=C2=A0 =C2=A09=C2=A0 =C2=A0 =C2=A0 =C2=A02.71%=C2=A0 helper_ucomisd=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-x86_64<br>
=C2=A0 10=C2=A0 =C2=A0 =C2=A0 =C2=A01.04%=C2=A0 helper_pand_xmm=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-x86_64<br>
=C2=A0 11=C2=A0 =C2=A0 =C2=A0 =C2=A00.71%=C2=A0 float64_div=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-x86_64<br>
=C2=A0 12=C2=A0 =C2=A0 =C2=A0 =C2=A00.63%=C2=A0 helper_pxor_xmm=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-x86_64<br>
=C2=A0 13=C2=A0 =C2=A0 =C2=A0 =C2=A00.50%=C2=A0 0x00007f7b7004ef95=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0[JIT] tid 491<br>
=C2=A0 14=C2=A0 =C2=A0 =C2=A0 =C2=A00.50%=C2=A0 0x00007f7b70044e83=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0[JIT] tid 491<br>
=C2=A0 15=C2=A0 =C2=A0 =C2=A0 =C2=A00.36%=C2=A0 helper_por_xmm=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-x86_64<br>
=C2=A0 16=C2=A0 =C2=A0 =C2=A0 =C2=A00.32%=C2=A0 helper_cc_compute_all=C2=A0=
 =C2=A0 =C2=A0 qemu-x86_64<br>
=C2=A0 17=C2=A0 =C2=A0 =C2=A0 =C2=A00.30%=C2=A0 0x00007f7b700433f0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0[JIT] tid 491<br>
=C2=A0 18=C2=A0 =C2=A0 =C2=A0 =C2=A00.30%=C2=A0 float64_compare_quiet=C2=A0=
 =C2=A0 =C2=A0 qemu-x86_64<br>
=C2=A0 19=C2=A0 =C2=A0 =C2=A0 =C2=A00.27%=C2=A0 soft_f64_addsub=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-x86_64<br>
=C2=A0 20=C2=A0 =C2=A0 =C2=A0 =C2=A00.26%=C2=A0 round_to_int=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-x86_64<br>
<br>
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---<br>
=C2=A0scripts/performance/topN_perf.<wbr>py | 115 +++++++++++++++++++++++++=
+++++<wbr>+<br>
=C2=A01 file changed, 115 insertions(+)<br>
=C2=A0create mode 100755 scripts/performance/topN_perf.<wbr>py<br>
<br>
diff --git a/scripts/performance/topN_<wbr>perf.py b/scripts/performance/to=
pN_<wbr>perf.py<br>
new file mode 100755<br>
index 0000000000..53fa503d8a<br>
--- /dev/null<br>
+++ b/scripts/performance/topN_<wbr>perf.py<br>
@@ -0,0 +1,115 @@<br>
+#!/usr/bin/env python3<br>
+<br>
+#=C2=A0 Print the top N most executed functions in QEMU using perf.<br>
+#=C2=A0 Example Usage:<br>
+#=C2=A0 topN_perf.py -n 20 -- /path/to/qemu program -program -flags<br>
+#<br>
+#=C2=A0 =C2=A0If &#39;-n&#39; is not specified, the default is 25.<br>
+#<br>
+#=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmarki=
ng&quot;.<br>
+#<br>
+#=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahmed=
khaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
+#=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailto=
:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&=
gt;<br>
+#<br>
+#=C2=A0 This program is free software: you can redistribute it and/or modi=
fy<br>
+#=C2=A0 it under the terms of the GNU General Public License as published =
by<br>
+#=C2=A0 the Free Software Foundation, either version 2 of the License, or<=
br>
+#=C2=A0 (at your option) any later version.<br>
+#<br>
+#=C2=A0 This program is distributed in the hope that it will be useful,<br=
>
+#=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+#=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+#=C2=A0 GNU General Public License for more details.<br>
+#<br>
+#=C2=A0 You should have received a copy of the GNU General Public License<=
br>
+#=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.gn=
u.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&g=
t;.<br>
+<br>
+import argparse<br>
+import os<br>
+import subprocess<br>
+import sys<br>
+<br>
+<br>
+# Parse the command line arguments<br>
+parser =3D argparse.ArgumentParser(usage=3D<wbr>&#39;topN_perf.py [-h] [-n=
 TOP_FUNCTIONS] --&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39; /path/to/qemu program -[flags =
PROGRAM_FLAGS]&#39;)<br>
+<br>
+parser.add_argument(&#39;-n&#39;, dest=3D&#39;top&#39;, type=3Dint, defaul=
t=3D25,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 help=
=3D&#39;Specify the number of top functions to print.&#39;)<br>
+<br>
+parser.add_argument(&#39;command&#39;<wbr>, type=3Dstr, nargs=3D&#39;+&#39=
;, help=3Dargparse.SUPPRESS)<br>
+<br>
+args =3D parser.parse_args()<br>
+<br>
+# Extract the needed variables from the args<br>
+command =3D args.command<br>
+top =3D args.top<br>
+<br>
+# Insure that perf is installed<br>
+check_perf =3D subprocess.run([&quot;which&quot;, &quot;perf&quot;], stdou=
t=3Dsubprocess.DEVNULL)<br>
+if check_perf.returncode:<br>
+=C2=A0 =C2=A0 sys.exit(&quot;Please install perf before running the script=
!&quot;)<br>
+<br>
+# Insure user has previllage to run perf<br>
+check_previlage =3D subprocess.run([&quot;perf&quot;, &quot;stat&quot;, &q=
uot;ls&quot;, &quot;/&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Dsubprocess.DEVNULL, stderr=3Dsubpr=
ocess.PIPE)<br>
+if check_previlage.returncode:<br>
+=C2=A0 =C2=A0 sys.exit(check_previlage.<wbr>stderr.decode(&quot;utf-8&quot=
;) +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\nOr alternatively, =
you can run the script with sudo privileges!&quot;)<br>
+<br>
+# Run perf record<br>
+perf_record =3D subprocess.run(([&quot;perf&quot;, &quot;record&quot;] + c=
ommand),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.DEVNULL, stderr=3Dsubpro=
cess.PIPE)<br>
+if perf_record.returncode:<br>
+=C2=A0 =C2=A0 os.unlink(&#39;perf.data&#39;)<br>
+=C2=A0 =C2=A0 sys.exit(perf_record.stderr.<wbr>decode(&quot;utf-8&quot;))<=
br>
+<br>
+# Save perf report output to tmp.perf.data<br>
+with open(&quot;tmp.perf.data&quot;, &quot;w&quot;) as output:<br>
+=C2=A0 =C2=A0 perf_report =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;perf&quot;, &quot;report&quot;, &quot;-=
-stdio&quot;], stdout=3Doutput, stderr=3Dsubprocess.PIPE)<br>
+=C2=A0 =C2=A0 if perf_report.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(&#39;perf.data&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(&#39;tmp.perf.data&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(perf_report.stderr.<wbr>decode(&quot;=
utf-8&quot;))<br>
+<br>
+# Read the reported data to functions[]<br>
+functions =3D []<br>
+with open(&quot;tmp.perf.data&quot;, &quot;r&quot;) as data:<br>
+=C2=A0 =C2=A0 # Only read lines that are not comments (comments start with=
 #)<br>
+=C2=A0 =C2=A0 # Only read lines that are not empty<br>
+=C2=A0 =C2=A0 functions =3D [line for line in data.readlines() if line and=
 line[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!=3D &#39;#&=
#39; and line[0] !=3D &quot;\n&quot;]<br>
+<br>
+# Limit the number of top functions to &quot;top&quot;<br>
+number_of_top_functions =3D top if len(functions) &gt; top else len(functi=
ons)<br>
+<br>
+# Store the data of the top functions in top_functions[]<br>
+top_functions =3D functions[:number_of_top_<wbr>functions]<br>
+<br>
+# Print information headers<br>
+print(&#39;{:&gt;4}=C2=A0 {:&gt;10}=C2=A0 {:&lt;30}=C2=A0 {}\n{}=C2=A0 {}=
=C2=A0 {}=C2=A0 {}&#39;.format(&#39;No.&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Percentage&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Name&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Caller&#39;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 10,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 30,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 25))<b=
r>
+<br>
+<br>
+# Print top N functions<br>
+for (index, function) in enumerate(top_functions, start=3D1):<br>
+=C2=A0 =C2=A0 function_data =3D function.split()<br>
+=C2=A0 =C2=A0 function_percentage =3D function_data[0]<br>
+=C2=A0 =C2=A0 function_name =3D function_data[-1]<br>
+=C2=A0 =C2=A0 function_caller =3D &#39; &#39;.join(function_data[2:-2])<br=
>
+=C2=A0 =C2=A0 print(&#39;{:&gt;4}=C2=A0 {:&gt;10}=C2=A0 {:&lt;30}=C2=A0 {}=
&#39;.format(index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0function_percentage,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0function_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0function_caller))<br>
+<br>
+# Remove intermediate files<br>
+os.unlink(&#39;perf.data&#39;)<br>
+os.unlink(&#39;tmp.perf.data&#39;)<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--000000000000030bd705a8811701--

