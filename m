Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66962C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBC42137B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4AyLL7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBC42137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFOAl-0004e5-1i
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFO8r-0003HC-SR
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:53:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFO8p-00064L-0K
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:53:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id a9so15230055wmm.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Pl1p/mTLw7jTvifnnyJGRWhdSVRadLp1r39282Cd7eg=;
 b=l4AyLL7wUTUPgLwCroJuI8jM3x6gF12JWk+ILgKCm5wuj9fJ72PU41st8FJIWYpClK
 8dKLJggwRLhAEghPGncE3mSNGICJCG3Zn4PS8+LM/PGlKlvszfRuoQM0/OoOnN8PnjVZ
 Nm/lKE0ShGTVwklIgPW/n8Nh6BmTdtOokDrBk4ndUaY1Xs6mUNjrXo1yiB/W9KVi50pK
 1K8OcY5LZi7A/iX9madAqsV677V8PlhheNwZXV37xcCTlSm4rSqeT9Fnw7UFeRH8acnJ
 RQVRzSuhRuP10fWRf3VemWG0xVtNFsyACUxmk2kgA+7aMhIa8fafxrXQC3WT6txhW2U1
 hSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Pl1p/mTLw7jTvifnnyJGRWhdSVRadLp1r39282Cd7eg=;
 b=c0ee/YkH53OVUuSI0W7fWM57lZXNEfdgLd2EXMKs0uq3bk22z5JgUkvosAXmEm985r
 TlPKeO2D02pq3BxZWaWJQpu/X0Sh/LYupT9DZRzjlfZsaVqMZnM6wCZNMalP4i8M7tmw
 OIuO8Eiyakyafol5MQ7BZqSfxZ/FT2aBhQqcKS9AS3fMm6kTVnKuCrVKNMbFi5uucwCi
 1WT8HJwValuNkHxjGv1PYo2LLOgGWK4jE60PQlhOOadhfkAFZv3/EfBHwYEcJyBpvjNK
 aCzgPGt5rcUU4bMKbWvX/+46FLJdIb8xRKIPHDFbQYypSPIcbiJs1JtrQJzlGlAjUcMH
 T1LQ==
X-Gm-Message-State: AOAM530mDcYkcKay2PCm13PQ+pV6FZ/JPa7j24HTN/dreVS9YqRl0s/I
 aEdwek640azb3Zfm4MVsJc3NPec9HyITzh9Kox+N1Ly1
X-Google-Smtp-Source: ABdhPJxYfjsmqYON9SSZylJ/KmYAELK+YDFrUswqeTHFvDf5BMdY7MMVEGAVzXOJxF67las7QOZT1l/C+RXjlns5S24=
X-Received: by 2002:a1c:1bc2:: with SMTP id b185mr1123639wmb.168.1599512009488; 
 Mon, 07 Sep 2020 13:53:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c351:0:0:0:0:0 with HTTP;
 Mon, 7 Sep 2020 13:53:29 -0700 (PDT)
In-Reply-To: <20200828104102.4490-3-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-3-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 7 Sep 2020 22:53:29 +0200
Message-ID: <CAHiYmc5-Xia=BcHWBwFxZLeoakwmrr9ucb=UeMn_gwPNH+ithw@mail.gmail.com>
Subject: [PATCH 2/9] scripts/performance: Refactor topN_callgrind.py
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000023be5a05aebf69d8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@redhat.com" <philmd@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000023be5a05aebf69d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, August 28, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
wrote:

>     - Apply pylint and flake8 formatting rules to the script.
>     - Use 'tempfile' instead of '/tmp' for creating temporary files.
>
>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reply
Reply all
Forward
View Gmail in: *Mobile* | Older version
<https://mail.google.com/mail/mu/mp/966/#> | Desktop
<https://mail.google.com/mail/mu/mp/966/#>
=C2=A9 2020 Google


>     Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  scripts/performance/topN_callgrind.py | 169 +++++++++++++-------------
>  1 file changed, 87 insertions(+), 82 deletions(-)
>
> diff --git a/scripts/performance/topN_callgrind.py
> b/scripts/performance/topN_callgrind.py
> index 67c59197af..f8a554f393 100755
> --- a/scripts/performance/topN_callgrind.py
> +++ b/scripts/performance/topN_callgrind.py
> @@ -1,113 +1,122 @@
>  #!/usr/bin/env python3
>
> -#  Print the top N most executed functions in QEMU using callgrind.
> -#  Syntax:
> -#  topN_callgrind.py [-h] [-n] <number of displayed top functions>  -- \
> -#           <qemu executable> [<qemu executable options>] \
> -#           <target executable> [<target execurable options>]
> -#
> -#  [-h] - Print the script arguments help message.
> -#  [-n] - Specify the number of top functions to print.
> -#       - If this flag is not specified, the tool defaults to 25.
> -#
> -#  Example of usage:
> -#  topN_callgrind.py -n 20 -- qemu-arm coulomb_double-arm
> -#
> -#  This file is a part of the project "TCG Continuous Benchmarking".
> -#
> -#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> -#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.=
c
> om>
> -#
> -#  This program is free software: you can redistribute it and/or modify
> -#  it under the terms of the GNU General Public License as published by
> -#  the Free Software Foundation, either version 2 of the License, or
> -#  (at your option) any later version.
> -#
> -#  This program is distributed in the hope that it will be useful,
> -#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> -#  GNU General Public License for more details.
> -#
> -#  You should have received a copy of the GNU General Public License
> -#  along with this program. If not, see <https://www.gnu.org/licenses/>.
> +"""
> +Print the top N most executed functions in QEMU using callgrind.
> +
> +Syntax:
> +topN_callgrind.py [-h] [-n <number of displayed top functions>] -- \
> +         <qemu executable> [<qemu executable options>] \
> +         <target executable> [<target execurable options>]
> +
> +[-h] - Print the script arguments help message.
> +[-n] - Specify the number of top functions to print.
> +     - If this flag is not specified, the tool defaults to 25.
> +
> +Example of usage:
> +topN_callgrind.py -n 20 -- qemu-arm coulomb_double-arm
> +
> +This file is a part of the project "TCG Continuous Benchmarking".
> +
> +Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com=
>
> +
> +This program is free software: you can redistribute it and/or modify
> +it under the terms of the GNU General Public License as published by
> +the Free Software Foundation, either version 2 of the License, or
> +(at your option) any later version.
> +
> +This program is distributed in the hope that it will be useful,
> +but WITHOUT ANY WARRANTY; without even the implied warranty of
> +MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +GNU General Public License for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with this program. If not, see <https://www.gnu.org/licenses/>.
> +"""
>
>  import argparse
>  import os
>  import subprocess
>  import sys
> +import tempfile
>
>
>  # Parse the command line arguments
> -parser =3D argparse.ArgumentParser(
> -    usage=3D'topN_callgrind.py [-h] [-n] <number of displayed top
> functions>  -- '
> +PARSER =3D argparse.ArgumentParser(
> +    usage=3D'topN_callgrind.py [-h] [-n] <number of displayed top
> functions> -- '
>            '<qemu executable> [<qemu executable options>] '
>            '<target executable> [<target executable options>]')
>
> -parser.add_argument('-n', dest=3D'top', type=3Dint, default=3D25,
> +PARSER.add_argument('-n', dest=3D'top', type=3Dint, default=3D25,
>                      help=3D'Specify the number of top functions to print=
.')
>
> -parser.add_argument('command', type=3Dstr, nargs=3D'+',
> help=3Dargparse.SUPPRESS)
> +PARSER.add_argument('command', type=3Dstr, nargs=3D'+',
> help=3Dargparse.SUPPRESS)
>
> -args =3D parser.parse_args()
> +ARGS =3D PARSER.parse_args()
>
>  # Extract the needed variables from the args
> -command =3D args.command
> -top =3D args.top
> +COMMAND =3D ARGS.command
> +TOP =3D ARGS.top
>
>  # Insure that valgrind is installed
> -check_valgrind_presence =3D subprocess.run(["which", "valgrind"],
> -                                         stdout=3Dsubprocess.DEVNULL)
> -if check_valgrind_presence.returncode:
> +CHECK_VALGRIND_PRESENCE =3D subprocess.run(["which", "valgrind"],
> +                                         stdout=3Dsubprocess.DEVNULL,
> +                                         check=3DFalse)
> +if CHECK_VALGRIND_PRESENCE.returncode:
>      sys.exit("Please install valgrind before running the script!")
>
> -# Run callgrind
> -callgrind =3D subprocess.run((
> -    ["valgrind", "--tool=3Dcallgrind", "--callgrind-out-file=3D/tmp/cal
> lgrind.data"]
> -    + command),
> -    stdout=3Dsubprocess.DEVNULL,
> -    stderr=3Dsubprocess.PIPE)
> -if callgrind.returncode:
> -    sys.exit(callgrind.stderr.decode("utf-8"))
> -
> -# Save callgrind_annotate output to /tmp/callgrind_annotate.out
> -with open("/tmp/callgrind_annotate.out", "w") as output:
> -    callgrind_annotate =3D subprocess.run(["callgrind_annotate",
> -                                         "/tmp/callgrind.data"],
> -                                        stdout=3Doutput,
> -                                        stderr=3Dsubprocess.PIPE)
> -    if callgrind_annotate.returncode:
> -        os.unlink('/tmp/callgrind.data')
> -        output.close()
> -        os.unlink('/tmp/callgrind_annotate.out')
> -        sys.exit(callgrind_annotate.stderr.decode("utf-8"))
> -
> -# Read the callgrind_annotate output to callgrind_data[]
> -callgrind_data =3D []
> -with open('/tmp/callgrind_annotate.out', 'r') as data:
> -    callgrind_data =3D data.readlines()
> +# Run callgrind and save all intermediate files in a temporary directory
> +with tempfile.TemporaryDirectory() as tmpdir:
> +    CALLGRIND_DATA_PATH =3D os.path.join(tmpdir, "callgrind.data")
> +    ANNOTATE_OUT_PATH =3D os.path.join(tmpdir, "callgrind_annotate.out")
> +
> +    # Run callgrind
> +    CALLGRIND =3D subprocess.run((["valgrind",
> +                                 "--tool=3Dcallgrind",
> +                                 "--callgrind-out-file=3D"+CALLG
> RIND_DATA_PATH]
> +                                + COMMAND),
> +                               stdout=3Dsubprocess.DEVNULL,
> +                               stderr=3Dsubprocess.PIPE,
> +                               check=3DFalse)
> +    if CALLGRIND.returncode:
> +        sys.exit(CALLGRIND.stderr.decode("utf-8"))
> +
> +    with open(ANNOTATE_OUT_PATH, "w") as output:
> +        CALLGRIND_ANNOTATE =3D subprocess.run(["callgrind_annotate",
> +                                             CALLGRIND_DATA_PATH],
> +                                            stdout=3Doutput,
> +                                            stderr=3Dsubprocess.PIPE,
> +                                            check=3DFalse)
> +        if CALLGRIND_ANNOTATE.returncode:
> +            sys.exit(CALLGRIND_ANNOTATE.stderr.decode("utf-8"))
> +
> +    # Read the callgrind_annotate output to CALLGRIND_DATA[]
> +    CALLGRIND_DATA =3D []
> +    with open(ANNOTATE_OUT_PATH, 'r') as data:
> +        CALLGRIND_DATA =3D data.readlines()
>
>  # Line number with the total number of instructions
> -total_instructions_line_number =3D 20
> +TOTAL_INSTRUCTIONS_LINE_NO =3D 20
>
>  # Get the total number of instructions
> -total_instructions_line_data =3D callgrind_data[total_instructi
> ons_line_number]
> -total_number_of_instructions =3D total_instructions_line_data.split(' ')=
[0]
> -total_number_of_instructions =3D int(
> -    total_number_of_instructions.replace(',', ''))
> +TOTAL_INSTRUCTIONS_LINE_DATA =3D CALLGRIND_DATA[TOTAL_INSTRUCTIONS_LINE_=
NO]
> +TOTAL_NUMBER_OF_INSTRUCTIONS =3D TOTAL_INSTRUCTIONS_LINE_DATA.split(' ')=
[0]
> +TOTAL_NUMBER_OF_INSTRUCTIONS =3D int(
> +    TOTAL_NUMBER_OF_INSTRUCTIONS.replace(',', ''))
>
>  # Line number with the top function
> -first_func_line =3D 25
> +FIRST_FUNC_LINE =3D 25
>
>  # Number of functions recorded by callgrind, last two lines are always
> empty
> -number_of_functions =3D len(callgrind_data) - first_func_line - 2
> +NUMBER_OF_FUNCTIONS =3D len(CALLGRIND_DATA) - FIRST_FUNC_LINE - 2
>
>  # Limit the number of top functions to "top"
> -number_of_top_functions =3D (top if number_of_functions >
> -                           top else number_of_functions)
> +NUMBER_OF_TOP_FUNCTIONS =3D (TOP if NUMBER_OF_FUNCTIONS >
> +                           TOP else NUMBER_OF_FUNCTIONS)
>
>  # Store the data of the top functions in top_functions[]
> -top_functions =3D callgrind_data[first_func_line:
> -                               first_func_line + number_of_top_functions=
]
> +TOP_FUNCTIONS =3D CALLGRIND_DATA[FIRST_FUNC_LINE:
> +                               FIRST_FUNC_LINE + NUMBER_OF_TOP_FUNCTIONS=
]
>
>  # Print table header
>  print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
> @@ -121,12 +130,12 @@ print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}
> {}'.format('No.',
>                                                           ))
>
>  # Print top N functions
> -for (index, function) in enumerate(top_functions, start=3D1):
> +for (index, function) in enumerate(TOP_FUNCTIONS, start=3D1):
>      function_data =3D function.split()
>      # Calculate function percentage
>      function_instructions =3D float(function_data[0].replace(',', ''))
>      function_percentage =3D (function_instructions /
> -                           total_number_of_instructions)*100
> +                           TOTAL_NUMBER_OF_INSTRUCTIONS)*100
>      # Get function name and source files path
>      function_source_file, function_name =3D function_data[1].split(':')
>      # Print extracted data
> @@ -134,7 +143,3 @@ for (index, function) in enumerate(top_functions,
> start=3D1):
>
>  round(function_percentage, 3),
>                                                  function_name,
>                                                  function_source_file))
> -
> -# Remove intermediate files
> -os.unlink('/tmp/callgrind.data')
> -os.unlink('/tmp/callgrind_annotate.out')
> --
> 2.17.1
>
>

--00000000000023be5a05aebf69d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, August 28, 2020, Ahmed Karaman &lt;<a href=3D"mailto:ahm=
edkhaledkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</=
a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">=C2=A0 =C2=A0 - Apply pylin=
t and flake8 formatting rules to the script.<br>
=C2=A0 =C2=A0 - Use &#39;tempfile&#39; instead of &#39;/tmp&#39; for creati=
ng temporary files.<br>
<br></blockquote><div><br></div><div><div id=3D"cv_" class=3D" Xg  " style=
=3D"width:320px;height:auto"><div class=3D"Zg" style=3D"width:320px;overflo=
w-y:auto"><div class=3D"Rg"><div class=3D"Li"><div class=3D"yj"><div class=
=3D"Ph"><div id=3D"cvcmsg_1744e012f27314c1" class=3D"yh" style=3D"border-to=
p-left-radius:0px;border-top-right-radius:0px;margin-bottom:11px"><div clas=
s=3D"Vh" id=3D"cvcfullmsg_1744e012f27314c1"><div id=3D"cvcmsgbod_1744e012f2=
7314c1" class=3D"aj"><div class=3D"Ni"><div class=3D"ni pi " dir=3D"ltr"><d=
iv>Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.d=
evel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@gmail.c<wbr>om</a>&=
gt;<br></div><div style=3D"clear:both"></div></div><div style=3D"clear:both=
"></div><div><div class=3D"M j T b hc Aj S" tabindex=3D"0"><div class=3D"V =
j hf"></div></div></div><div style=3D"clear:both"></div></div></div></div><=
/div></div><div class=3D"Pj"></div><div id=3D"cvcfb" class=3D"Cj"><div clas=
s=3D"Dj" style=3D"width:300px"><div class=3D"Ej"><div class=3D"M j T b hc F=
j Mi S" tabindex=3D"0"><div class=3D"V j vd Hj"></div><div class=3D"V j Y L=
j">Reply</div></div></div><div class=3D"Gj" style=3D"background-size:initia=
l"></div><div id=3D"cvcfra" class=3D"Ej"><div class=3D"M j T b hc Fj Mi S" =
tabindex=3D"0"><div class=3D"V j ud Hj"></div><div class=3D"V j Y Lj">Reply=
 all</div></div></div><div id=3D"cvcfrab" class=3D"Gj" style=3D"background-=
size:initial"></div><div class=3D"Ej"><div class=3D"M j T b hc Fj Mi S" tab=
index=3D"0"><div class=3D"V j sd Hj"></div><div class=3D"V j Y Lj">Forward<=
/div></div></div></div></div></div></div><div class=3D"Og"><div class=3D"dh=
"><div class=3D"Nh"><div class=3D"Nh">View Gmail in:=C2=A0<b>Mobile</b>=C2=
=A0|=C2=A0<a href=3D"https://mail.google.com/mail/mu/mp/966/#">Older versio=
n</a>=C2=A0|=C2=A0<a href=3D"https://mail.google.com/mail/mu/mp/966/#">Desk=
top</a></div><div class=3D"Nh Oh"><span dir=3D"ltr">=C2=A9 2020 Google</spa=
n></div></div></div></div></div></div><div class=3D"ah" style=3D"width:320p=
x"></div></div><div class=3D"Ls" style=3D"display:block"><div class=3D"As">=
<div class=3D"Bs"><div class=3D"Gs  " style=3D"font-size:13px"><div class=
=3D"Is Hs"></div></div></div></div></div></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
=C2=A0 =C2=A0 Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhale=
dkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a>&gt;<=
br>
---<br>
=C2=A0scripts/performance/topN_call<wbr>grind.py | 169 +++++++++++++-------=
------<br>
=C2=A01 file changed, 87 insertions(+), 82 deletions(-)<br>
<br>
diff --git a/scripts/performance/topN_cal<wbr>lgrind.py b/scripts/performan=
ce/topN_cal<wbr>lgrind.py<br>
index 67c59197af..f8a554f393 100755<br>
--- a/scripts/performance/topN_cal<wbr>lgrind.py<br>
+++ b/scripts/performance/topN_cal<wbr>lgrind.py<br>
@@ -1,113 +1,122 @@<br>
=C2=A0#!/usr/bin/env python3<br>
<br>
-#=C2=A0 Print the top N most executed functions in QEMU using callgrind.<b=
r>
-#=C2=A0 Syntax:<br>
-#=C2=A0 topN_callgrind.py [-h] [-n] &lt;number of displayed top functions&=
gt;=C2=A0 -- \<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;qemu executable&gt; [&lt;qem=
u executable options&gt;] \<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;target executable&gt; [&lt;t=
arget execurable options&gt;]<br>
-#<br>
-#=C2=A0 [-h] - Print the script arguments help message.<br>
-#=C2=A0 [-n] - Specify the number of top functions to print.<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0- If this flag is not specified, the tool defa=
ults to 25.<br>
-#<br>
-#=C2=A0 Example of usage:<br>
-#=C2=A0 topN_callgrind.py -n 20 -- qemu-arm coulomb_double-arm<br>
-#<br>
-#=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmarki=
ng&quot;.<br>
-#<br>
-#=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahmed=
khaledkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a>=
&gt;<br>
-#=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailto=
:aleksandar.qemu.devel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@g=
mail.c<wbr>om</a>&gt;<br>
-#<br>
-#=C2=A0 This program is free software: you can redistribute it and/or modi=
fy<br>
-#=C2=A0 it under the terms of the GNU General Public License as published =
by<br>
-#=C2=A0 the Free Software Foundation, either version 2 of the License, or<=
br>
-#=C2=A0 (at your option) any later version.<br>
-#<br>
-#=C2=A0 This program is distributed in the hope that it will be useful,<br=
>
-#=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
-#=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
-#=C2=A0 GNU General Public License for more details.<br>
-#<br>
-#=C2=A0 You should have received a copy of the GNU General Public License<=
br>
-#=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.gn=
u.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&g=
t;.<br>
+&quot;&quot;&quot;<br>
+Print the top N most executed functions in QEMU using callgrind.<br>
+<br>
+Syntax:<br>
+topN_callgrind.py [-h] [-n &lt;number of displayed top functions&gt;] -- \=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;qemu executable&gt; [&lt;qemu execut=
able options&gt;] \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;target executable&gt; [&lt;target ex=
ecurable options&gt;]<br>
+<br>
+[-h] - Print the script arguments help message.<br>
+[-n] - Specify the number of top functions to print.<br>
+=C2=A0 =C2=A0 =C2=A0- If this flag is not specified, the tool defaults to =
25.<br>
+<br>
+Example of usage:<br>
+topN_callgrind.py -n 20 -- qemu-arm coulomb_double-arm<br>
+<br>
+This file is a part of the project &quot;TCG Continuous Benchmarking&quot;=
.<br>
+<br>
+Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledka=
raman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
+Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailto:aleksan=
dar.qemu.devel@gmail.com" target=3D"_blank">aleksandar.qemu.devel@gmail.c<w=
br>om</a>&gt;<br>
+<br>
+This program is free software: you can redistribute it and/or modify<br>
+it under the terms of the GNU General Public License as published by<br>
+the Free Software Foundation, either version 2 of the License, or<br>
+(at your option) any later version.<br>
+<br>
+This program is distributed in the hope that it will be useful,<br>
+but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+GNU General Public License for more details.<br>
+<br>
+You should have received a copy of the GNU General Public License<br>
+along with this program. If not, see &lt;<a href=3D"https://www.gnu.org/li=
censes/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&gt;.<br>
+&quot;&quot;&quot;<br>
<br>
=C2=A0import argparse<br>
=C2=A0import os<br>
=C2=A0import subprocess<br>
=C2=A0import sys<br>
+import tempfile<br>
<br>
<br>
=C2=A0# Parse the command line arguments<br>
-parser =3D argparse.ArgumentParser(<br>
-=C2=A0 =C2=A0 usage=3D&#39;topN_callgrind.py [-h] [-n] &lt;number of displ=
ayed top functions&gt;=C2=A0 -- &#39;<br>
+PARSER =3D argparse.ArgumentParser(<br>
+=C2=A0 =C2=A0 usage=3D&#39;topN_callgrind.py [-h] [-n] &lt;number of displ=
ayed top functions&gt; -- &#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;&lt;qemu executable&gt; [&lt;=
qemu executable options&gt;] &#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;&lt;target executable&gt; [&l=
t;target executable options&gt;]&#39;)<br>
<br>
-parser.add_argument(&#39;-n&#39;, dest=3D&#39;top&#39;, type=3Dint, defaul=
t=3D25,<br>
+PARSER.add_argument(&#39;-n&#39;, dest=3D&#39;top&#39;, type=3Dint, defaul=
t=3D25,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0help=3D&#39;Specify the number of top functions to print.&#39;)<br>
<br>
-parser.add_argument(&#39;command&#39;<wbr>, type=3Dstr, nargs=3D&#39;+&#39=
;, help=3Dargparse.SUPPRESS)<br>
+PARSER.add_argument(&#39;command&#39;<wbr>, type=3Dstr, nargs=3D&#39;+&#39=
;, help=3Dargparse.SUPPRESS)<br>
<br>
-args =3D parser.parse_args()<br>
+ARGS =3D PARSER.parse_args()<br>
<br>
=C2=A0# Extract the needed variables from the args<br>
-command =3D args.command<br>
-top =3D args.top<br>
+COMMAND =3D ARGS.command<br>
+TOP =3D ARGS.top<br>
<br>
=C2=A0# Insure that valgrind is installed<br>
-check_valgrind_presence =3D subprocess.run([&quot;which&quot;, &quot;valgr=
ind&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
dout=3Dsubprocess.DEVNULL)<br>
-if check_valgrind_presence.return<wbr>code:<br>
+CHECK_VALGRIND_PRESENCE =3D subprocess.run([&quot;which&quot;, &quot;valgr=
ind&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
dout=3Dsubprocess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch=
eck=3DFalse)<br>
+if CHECK_VALGRIND_PRESENCE.return<wbr>code:<br>
=C2=A0 =C2=A0 =C2=A0sys.exit(&quot;Please install valgrind before running t=
he script!&quot;)<br>
<br>
-# Run callgrind<br>
-callgrind =3D subprocess.run((<br>
-=C2=A0 =C2=A0 [&quot;valgrind&quot;, &quot;--tool=3Dcallgrind&quot;, &quot=
;--callgrind-out-file=3D/tmp/cal<wbr>lgrind.data&quot;]<br>
-=C2=A0 =C2=A0 + command),<br>
-=C2=A0 =C2=A0 stdout=3Dsubprocess.DEVNULL,<br>
-=C2=A0 =C2=A0 stderr=3Dsubprocess.PIPE)<br>
-if callgrind.returncode:<br>
-=C2=A0 =C2=A0 sys.exit(callgrind.stderr.deco<wbr>de(&quot;utf-8&quot;))<br=
>
-<br>
-# Save callgrind_annotate output to /tmp/callgrind_annotate.out<br>
-with open(&quot;/tmp/callgrind_annotate.<wbr>out&quot;, &quot;w&quot;) as =
output:<br>
-=C2=A0 =C2=A0 callgrind_annotate =3D subprocess.run([&quot;callgrind_ann<w=
br>otate&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;/tmp/callgrind.data&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=
=3Doutput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr=
=3Dsubprocess.PIPE)<br>
-=C2=A0 =C2=A0 if callgrind_annotate.returncode:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(&#39;/tmp/callgrind.data<wbr>&#39;)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output.close()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(&#39;/tmp/callgrind_anno<wbr>tate.ou=
t&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(<a href=3D"http://callgrind_annotate.=
st">callgrind_annotate.st</a><wbr>derr.decode(&quot;utf-8&quot;))<br>
-<br>
-# Read the callgrind_annotate output to callgrind_data[]<br>
-callgrind_data =3D []<br>
-with open(&#39;/tmp/callgrind_annotate.<wbr>out&#39;, &#39;r&#39;) as data=
:<br>
-=C2=A0 =C2=A0 callgrind_data =3D data.readlines()<br>
+# Run callgrind and save all intermediate files in a temporary directory<b=
r>
+with tempfile.TemporaryDirectory() as tmpdir:<br>
+=C2=A0 =C2=A0 CALLGRIND_DATA_PATH =3D os.path.join(tmpdir, &quot;callgrind=
.data&quot;)<br>
+=C2=A0 =C2=A0 ANNOTATE_OUT_PATH =3D os.path.join(tmpdir, &quot;callgrind_a=
nnotate.out&quot;)<br>
+<br>
+=C2=A0 =C2=A0 # Run callgrind<br>
+=C2=A0 =C2=A0 CALLGRIND =3D subprocess.run(([&quot;valgrind&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--tool=3Dcallgrind&quot;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--callgrind-out-file=3D&=
quot;+CALLG<wbr>RIND_DATA_PATH]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + COMMAND),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stderr=3Dsubprocess.PIPE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0check=3DFalse)<br>
+=C2=A0 =C2=A0 if CALLGRIND.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(CALLGRIND.stderr.deco<wbr>de(&quot;ut=
f-8&quot;))<br>
+<br>
+=C2=A0 =C2=A0 with open(ANNOTATE_OUT_PATH, &quot;w&quot;) as output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLGRIND_ANNOTATE =3D subprocess.run([&quot;c=
allgrind_ann<wbr>otate&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0CALLGRIND_DATA_PATH],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stdout=3Doutput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stderr=3Dsubprocess.PIPE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 check=3DFalse)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if CALLGRIND_ANNOTATE.returncode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(CALLGRIND_ANNOTATE.st<w=
br>derr.decode(&quot;utf-8&quot;))<br>
+<br>
+=C2=A0 =C2=A0 # Read the callgrind_annotate output to CALLGRIND_DATA[]<br>
+=C2=A0 =C2=A0 CALLGRIND_DATA =3D []<br>
+=C2=A0 =C2=A0 with open(ANNOTATE_OUT_PATH, &#39;r&#39;) as data:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLGRIND_DATA =3D data.readlines()<br>
<br>
=C2=A0# Line number with the total number of instructions<br>
-total_instructions_line_numbe<wbr>r =3D 20<br>
+TOTAL_INSTRUCTIONS_LINE_NO =3D 20<br>
<br>
=C2=A0# Get the total number of instructions<br>
-total_instructions_line_data =3D callgrind_data[total_instructi<wbr>ons_li=
ne_number]<br>
-total_number_of_instructions =3D total_instructions_line_data.s<wbr>plit(&=
#39; &#39;)[0]<br>
-total_number_of_instructions =3D int(<br>
-=C2=A0 =C2=A0 total_number_of_instructions.r<wbr>eplace(&#39;,&#39;, &#39;=
&#39;))<br>
+TOTAL_INSTRUCTIONS_LINE_DATA =3D CALLGRIND_DATA[TOTAL_INSTRUCTI<wbr>ONS_LI=
NE_NO]<br>
+TOTAL_NUMBER_OF_INSTRUCTIONS =3D TOTAL_INSTRUCTIONS_LINE_DATA.s<wbr>plit(&=
#39; &#39;)[0]<br>
+TOTAL_NUMBER_OF_INSTRUCTIONS =3D int(<br>
+=C2=A0 =C2=A0 TOTAL_NUMBER_OF_INSTRUCTIONS.r<wbr>eplace(&#39;,&#39;, &#39;=
&#39;))<br>
<br>
=C2=A0# Line number with the top function<br>
-first_func_line =3D 25<br>
+FIRST_FUNC_LINE =3D 25<br>
<br>
=C2=A0# Number of functions recorded by callgrind, last two lines are alway=
s empty<br>
-number_of_functions =3D len(callgrind_data) - first_func_line - 2<br>
+NUMBER_OF_FUNCTIONS =3D len(CALLGRIND_DATA) - FIRST_FUNC_LINE - 2<br>
<br>
=C2=A0# Limit the number of top functions to &quot;top&quot;<br>
-number_of_top_functions =3D (top if number_of_functions &gt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0top else number_of_functions)<br>
+NUMBER_OF_TOP_FUNCTIONS =3D (TOP if NUMBER_OF_FUNCTIONS &gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0TOP else NUMBER_OF_FUNCTIONS)<br>
<br>
=C2=A0# Store the data of the top functions in top_functions[]<br>
-top_functions =3D callgrind_data[first_func_line<wbr>:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0first_func_line + number_of_top_funct=
ions]<br>
+TOP_FUNCTIONS =3D CALLGRIND_DATA[FIRST_FUNC_LINE<wbr>:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FIRST_FUNC_LINE + NUMBER_OF_TOP_FUNCT=
IONS]<br>
<br>
=C2=A0# Print table header<br>
=C2=A0print(&#39;{:&gt;4}=C2=A0 {:&gt;10}=C2=A0 {:&lt;30}=C2=A0 {}\n{}=C2=
=A0 {}=C2=A0 {}=C2=A0 {}&#39;.format(&#39;No.&#39;,<br>
@@ -121,12 +130,12 @@ print(&#39;{:&gt;4}=C2=A0 {:&gt;10}=C2=A0 {:&lt;30}=
=C2=A0 {}\n{}=C2=A0 {}=C2=A0 {}=C2=A0 {}&#39;.format(&#39;No.&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ))<br>
<br>
=C2=A0# Print top N functions<br>
-for (index, function) in enumerate(top_functions, start=3D1):<br>
+for (index, function) in enumerate(TOP_FUNCTIONS, start=3D1):<br>
=C2=A0 =C2=A0 =C2=A0function_data =3D function.split()<br>
=C2=A0 =C2=A0 =C2=A0# Calculate function percentage<br>
=C2=A0 =C2=A0 =C2=A0function_instructions =3D float(function_data[0].replac=
e<wbr>(&#39;,&#39;, &#39;&#39;))<br>
=C2=A0 =C2=A0 =C2=A0function_percentage =3D (function_instructions /<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0total_number_of_instructions)<wbr>*100<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0TOTAL_NUMBER_OF_INSTRUCTIONS)<wbr>*100<br>
=C2=A0 =C2=A0 =C2=A0# Get function name and source files path<br>
=C2=A0 =C2=A0 =C2=A0function_source_file, function_name =3D function_data[1=
].split(&#39;:&#39;)<br>
=C2=A0 =C2=A0 =C2=A0# Print extracted data<br>
@@ -134,7 +143,3 @@ for (index, function) in enumerate(top_functions, start=
=3D1):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0round(function_percentage, 3),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0function_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0function_source_file))<br>
-<br>
-# Remove intermediate files<br>
-os.unlink(&#39;/tmp/callgrind.dat<wbr>a&#39;)<br>
-os.unlink(&#39;/tmp/callgrind_ann<wbr>otate.out&#39;)<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--00000000000023be5a05aebf69d8--

