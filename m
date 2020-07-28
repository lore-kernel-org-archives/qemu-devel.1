Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57BBC433EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC902053B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHXuQnTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC902053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SuQ-0007Ig-VI
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k0Std-0006sg-I9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:56:09 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k0Stb-0007rm-32
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:56:09 -0400
Received: by mail-lj1-x241.google.com with SMTP id x9so21924221ljc.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nvn7R6SfJtyV8QqDR0pA0+ttW8Cfh2YydDiV0z9ajHU=;
 b=AHXuQnTZYngCF+j3hzTtP/XnQOb1JABoDvU9C8CuJ1v8nZHiCQbLqSnH7n8UYXmoKF
 mjyXoAIgidNXWzu+vUp8ibX9Cb+V9JDfihxSZLVqnEKXU46L/61HXCtqs/dUkJ254Ik3
 PU2wES9tNH2BLGxnsvGARKGsKa3kNdtIAL1gniEpColTMKfAcVQpnCCp2PShNaNo0gHo
 QsvJLnUlGc9DhINs6lh5Pl2jOAGTIl1DTHB4Af9L8m8d39/u3r89n1qvxEhkHi8h5/ot
 dB3rNPu3mqFtsYlAhKdkPBnNt8iW3yNU7Bl8GrMDPdALjxfkKB7LIkaaHMrkeXzlM8pX
 62rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nvn7R6SfJtyV8QqDR0pA0+ttW8Cfh2YydDiV0z9ajHU=;
 b=frOI82b6gzTNmWag6k1bY8fT9ElAndJPSSBKY+NzHcp92m58PvvHbrhfytKlyestoa
 8kAk7Gr5v9OtX6j4DJY2gqnF0YGWlEZFpdQWf0d/mTsWY29Zjzk/f8D7H+VqYD3tqKtK
 FAgVVaa9k3QVs36szj3YVgAwwdcqLLbpNTxfLAFe7gawCTgAmzif4aQOntmw0OCKEu5x
 nSHeaf3aTv3Wbjg+Sssmrv6XL1Ox7EP7ZEGkUpVxiQqX8f2OY98snvmFPRkYiWBP4tjy
 deGgvMN8qC92YKa1G1IJGfwRd9KkWTXsa5DIVCE5i7czzd4L2cBwpnWErPdVJPob0miu
 kyDA==
X-Gm-Message-State: AOAM531wT0eHA792aUXRAmtxYRTRessT9x+SXl+/whAo18NRzhSs78gK
 QJc0i/ED9eGKPhWuYTfPCRU4fmQaK6UU087wwQo=
X-Google-Smtp-Source: ABdhPJwJob31tBR4OpY6S7Pi9V85ygJy6L2Sl6RQn96MAIGtzhpOtpM3StTq80SBJ1vBnW1gmRsrGHuytwOzYCJa1+E=
X-Received: by 2002:a2e:908a:: with SMTP id l10mr5329745ljg.409.1595955364151; 
 Tue, 28 Jul 2020 09:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200716103921.6605-1-ahmedkhaledkaraman@gmail.com>
 <20200716103921.6605-3-ahmedkhaledkaraman@gmail.com>
 <CAHiYmc7fWTVv7jvF6716nuXzHZ+BrSQS+eQAemoCg=1T2h_9Xw@mail.gmail.com>
In-Reply-To: <CAHiYmc7fWTVv7jvF6716nuXzHZ+BrSQS+eQAemoCg=1T2h_9Xw@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Tue, 28 Jul 2020 18:55:28 +0200
Message-ID: <CALTWKrVqYfrOUJQWNBhTNmwh_jB1ysV+nbf7==bSveovh9hSKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] scripts/performance: Add list_helpers.py script
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "philmd@redhat.com" <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 "crosa@redhat.com" <crosa@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 12:30 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
>
>
> On Thursday, July 16, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com> =
wrote:
>>
>> Python script that prints executed helpers of a QEMU invocation.
>>
>
> Hi, Ahmed.
>
> You outlined the envisioned user workflow regarding this script in your r=
eport. As I understand it, it generally goes like this:
>
> 1) The user first discovers helpers, and their performance data.
> 2) The user examines the callees of a particular helper of choice (usuall=
y, the most instruction-consuming helper).
> 3) The user perhaps further examines a callee of a particular callee of t=
he particular helper.
> 4) The user continues this way until the conclusion can be drawn, or maxi=
mal depth is reached.
>
> The procedure might be time consuming since each step requires running an=
 emulation of the test program.
>
> This makes me think that the faster and easier tool for the user (but, to=
 some, not that great, extent, harder for you) would be improved list_helpe=
rs.py (and list_fn_calees.py) that provides list of all callees for all hel=
pers, in the tree form (so, callees of callees, callees of callees of calle=
es, etc.), rather than providing just a list of immediate callees, like it =
currently does.
>
> I think you can provide such functionality relatively easily using recurs=
ion. See, let's say:
>
> https://realpython.com/python-thinking-recursively/
>
> Perhaps you can have a switch (let's say, --tree <yes|no>) that specifies=
 whether the script outputs just immediate callee list, or entire callee tr=
ee.

I have to say, this is a very nice suggestion. I will start working on it!

>
> Thanks,
> Aleksandar
>
>>
>> Syntax:
>> list_helpers.py [-h] -- \
>>                <qemu executable> [<qemu executable options>] \
>>                <target executable> [<target executable options>]
>>
>> [-h] - Print the script arguments help message.
>>
>> Example of usage:
>> list_helpers.py -- qemu-mips coulomb_double-mips -n10
>>
>> Example output:
>>  Total number of instructions: 108,933,695
>>
>>  Executed QEMU Helpers:
>>
>>  No. Ins     Percent  Calls Ins/Call Helper Name             Source File
>>  --- ------- ------- ------ -------- --------------------    -----------=
----
>>    1 183,021  0.168%  1,305      140 helper_float_sub_d      <qemu>/targ=
et/mips/fpu_helper.c
>>    2 177,111  0.163%    770      230 helper_float_madd_d     <qemu>/targ=
et/mips/fpu_helper.c
>>    3 171,537  0.157%  1,014      169 helper_float_mul_d      <qemu>/targ=
et/mips/fpu_helper.c
>>    4 157,298  0.144%  2,443       64 helper_lookup_tb_ptr    <qemu>/acce=
l/tcg/tcg-runtime.c
>>    5 138,123  0.127%    897      153 helper_float_add_d      <qemu>/targ=
et/mips/fpu_helper.c
>>    6  47,083  0.043%    207      227 helper_float_msub_d     <qemu>/targ=
et/mips/fpu_helper.c
>>    7  24,062  0.022%    487       49 helper_cmp_d_lt         <qemu>/targ=
et/mips/fpu_helper.c
>>    8  22,910  0.021%    150      152 helper_float_div_d      <qemu>/targ=
et/mips/fpu_helper.c
>>    9  15,497  0.014%    321       48 helper_cmp_d_eq         <qemu>/targ=
et/mips/fpu_helper.c
>>   10   9,100  0.008%     52      175 helper_float_trunc_w_d  <qemu>/targ=
et/mips/fpu_helper.c
>>   11   7,059  0.006%     10      705 helper_float_sqrt_d     <qemu>/targ=
et/mips/fpu_helper.c
>>   12   3,000  0.003%     40       75 helper_cmp_d_ule        <qemu>/targ=
et/mips/fpu_helper.c
>>   13   2,720  0.002%     20      136 helper_float_cvtd_w     <qemu>/targ=
et/mips/fpu_helper.c
>>   14   2,477  0.002%     27       91 helper_swl              <qemu>/targ=
et/mips/op_helper.c
>>   15   2,000  0.002%     40       50 helper_cmp_d_le         <qemu>/targ=
et/mips/fpu_helper.c
>>   16   1,800  0.002%     40       45 helper_cmp_d_un         <qemu>/targ=
et/mips/fpu_helper.c
>>   17   1,164  0.001%     12       97 helper_raise_exception_ <qemu>/targ=
et/mips/op_helper.c
>>   18     720  0.001%     10       72 helper_cmp_d_ult        <qemu>/targ=
et/mips/fpu_helper.c
>>   19     560  0.001%    140        4 helper_cfc1             <qemu>/targ=
et/mips/fpu_helper.c
>>
>> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>> ---
>>  scripts/performance/list_helpers.py | 207 ++++++++++++++++++++++++++++
>>  1 file changed, 207 insertions(+)
>>  create mode 100755 scripts/performance/list_helpers.py
>>
>> diff --git a/scripts/performance/list_helpers.py b/scripts/performance/l=
ist_helpers.py
>> new file mode 100755
>> index 0000000000..a97c7ed4fe
>> --- /dev/null
>> +++ b/scripts/performance/list_helpers.py
>> @@ -0,0 +1,207 @@
>> +#!/usr/bin/env python3
>> +
>> +#  Print the executed helpers of a QEMU invocation.
>> +#
>> +#  Syntax:
>> +#  list_helpers.py [-h] -- \
>> +#                 <qemu executable> [<qemu executable options>] \
>> +#                 <target executable> [<target executable options>]
>> +#
>> +#  [-h] - Print the script arguments help message.
>> +#
>> +#  Example of usage:
>> +#  list_helpers.py -- qemu-mips coulomb_double-mips
>> +#
>> +#  This file is a part of the project "TCG Continuous Benchmarking".
>> +#
>> +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>> +#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail=
.com>
>> +#
>> +#  This program is free software: you can redistribute it and/or modify
>> +#  it under the terms of the GNU General Public License as published by
>> +#  the Free Software Foundation, either version 2 of the License, or
>> +#  (at your option) any later version.
>> +#
>> +#  This program is distributed in the hope that it will be useful,
>> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> +#  GNU General Public License for more details.
>> +#
>> +#  You should have received a copy of the GNU General Public License
>> +#  along with this program. If not, see <https://www.gnu.org/licenses/>=
.
>> +
>> +import argparse
>> +import os
>> +import subprocess
>> +import sys
>> +import tempfile
>> +
>> +
>> +def find_JIT_line(callgrind_data):
>> +    """
>> +    Search for the line with the JIT call in the callgrind_annotate
>> +    output when ran using --tre=3Dcalling.
>> +    All the helpers should be listed after that line.
>> +
>> +    Parameters:
>> +    callgrind_data (list): callgrind_annotate output
>> +
>> +    Returns:
>> +    (int): Line number of JIT call
>> +    """
>> +    line =3D -1
>> +    for i in range(len(callgrind_data)):
>> +        split_line =3D callgrind_data[i].split()
>> +        if len(split_line) > 2 and \
>> +                split_line[1] =3D=3D "*" and \
>> +                split_line[-1] =3D=3D "[???]":
>> +            line =3D i
>> +            break
>> +    return line
>> +
>> +
>> +def get_helpers(JIT_line, callgrind_data):
>> +    """
>> +    Get all helpers data given the line number of the JIT call.
>> +
>> +    Parameters:
>> +    JIT_line (int): Line number of the JIT call
>> +    callgrind_data (list): callgrind_annotate output
>> +
>> +    Returns:
>> +    (list):[[number_of_instructions(int), helper_name(str),
>> +             number_of_calls(int), source_file(str)]]
>> +    """
>> +    helpers =3D []
>> +    next_helper =3D JIT_line + 1
>> +    while (callgrind_data[next_helper] !=3D "\n"):
>> +        split_line =3D callgrind_data[next_helper].split()
>> +        number_of_instructions =3D int(split_line[0].replace(",", ""))
>> +        source_file =3D split_line[2].split(":")[0]
>> +        callee_name =3D split_line[2].split(":")[1]
>> +        number_of_calls =3D int(split_line[3][1:-2])
>> +        helpers.append([number_of_instructions, callee_name,
>> +                        number_of_calls, source_file])
>> +        next_helper +=3D 1
>> +    return sorted(helpers, reverse=3DTrue)
>> +
>> +
>> +def main():
>> +    # Parse the command line arguments
>> +    parser =3D argparse.ArgumentParser(
>> +        usage=3D"list_helpers.py [-h] -- "
>> +        "<qemu executable> [<qemu executable options>] "
>> +        "<target executable> [<target executable options>]")
>> +
>> +    parser.add_argument("command", type=3Dstr, nargs=3D"+", help=3Dargp=
arse.SUPPRESS)
>> +
>> +    args =3D parser.parse_args()
>> +
>> +    # Extract the needed variables from the args
>> +    command =3D args.command
>> +
>> +    # Insure that valgrind is installed
>> +    check_valgrind =3D subprocess.run(
>> +        ["which", "valgrind"], stdout=3Dsubprocess.DEVNULL)
>> +    if check_valgrind.returncode:
>> +        sys.exit("Please install valgrind before running the script.")
>> +
>> +    # Save all intermediate files in a temporary directory
>> +    with tempfile.TemporaryDirectory() as tmpdirname:
>> +        # callgrind output file path
>> +        data_path =3D os.path.join(tmpdirname, "callgrind.data")
>> +        # callgrind_annotate output file path
>> +        annotate_out_path =3D os.path.join(tmpdirname, "callgrind_annot=
ate.out")
>> +
>> +        # Run callgrind
>> +        callgrind =3D subprocess.run((["valgrind",
>> +                                     "--tool=3Dcallgrind",
>> +                                     "--callgrind-out-file=3D" + data_p=
ath]
>> +                                    + command),
>> +                                   stdout=3Dsubprocess.DEVNULL,
>> +                                   stderr=3Dsubprocess.PIPE)
>> +        if callgrind.returncode:
>> +            sys.exit(callgrind.stderr.decode("utf-8"))
>> +
>> +        # Save callgrind_annotate output
>> +        with open(annotate_out_path, "w") as output:
>> +            callgrind_annotate =3D subprocess.run(
>> +                ["callgrind_annotate", data_path,
>> +                    "--threshold=3D100", "--tree=3Dcalling"],
>> +                stdout=3Doutput,
>> +                stderr=3Dsubprocess.PIPE)
>> +            if callgrind_annotate.returncode:
>> +                sys.exit(callgrind_annotate.stderr.decode("utf-8"))
>> +
>> +        # Read the callgrind_annotate output to callgrind_data[]
>> +        callgrind_data =3D []
>> +        with open(annotate_out_path, "r") as data:
>> +            callgrind_data =3D data.readlines()
>> +
>> +        # Line number with the total number of instructions
>> +        total_instructions_line_number =3D 20
>> +        # Get the total number of instructions
>> +        total_instructions_line_data =3D \
>> +            callgrind_data[total_instructions_line_number]
>> +        total_instructions =3D total_instructions_line_data.split()[0]
>> +
>> +        print("Total number of instructions: {}\n".format(total_instruc=
tions))
>> +
>> +        # Remove commas and convert to int
>> +        total_instructions =3D int(total_instructions.replace(",", ""))
>> +
>> +        # Line number with the JIT call
>> +        JIT_line =3D find_JIT_line(callgrind_data)
>> +        if JIT_line =3D=3D -1:
>> +            sys.exit("Couldn't locate the JIT call ... Exiting")
>> +
>> +        # Get helpers
>> +        helpers =3D get_helpers(JIT_line, callgrind_data)
>> +
>> +        print("Executed QEMU Helpers:\n")
>> +
>> +        # Print table header
>> +        print("{:>4}  {:>15}  {:>10}  {:>15}  {:>10}  {:<25}  {}".
>> +              format(
>> +                  "No.",
>> +                  "Instructions",
>> +                  "Percentage",
>> +                  "Calls",
>> +                  "Ins/Call",
>> +                  "Helper Name",
>> +                  "Source File")
>> +              )
>> +
>> +        print("{:>4}  {:>15}  {:>10}  {:>15}  {:>10}  {:<25}  {}".
>> +              format(
>> +                  "-" * 4,
>> +                  "-" * 15,
>> +                  "-" * 10,
>> +                  "-" * 15,
>> +                  "-" * 10,
>> +                  "-" * 25,
>> +                  "-" * 30)
>> +              )
>> +
>> +        for (index, callee) in enumerate(helpers, start=3D1):
>> +            instructions =3D callee[0]
>> +            percentage =3D (callee[0] / total_instructions) * 100
>> +            calls =3D callee[2]
>> +            instruction_per_call =3D int(callee[0] / callee[2])
>> +            helper_name =3D callee[1]
>> +            source_file =3D callee[3]
>> +            # Print extracted data
>> +            print("{:>4}  {:>15}  {:>9.3f}%  {:>15}  {:>10}  {:<25}  {}=
".
>> +                  format(
>> +                      index,
>> +                      format(instructions, ","),
>> +                      round(percentage, 3),
>> +                      format(calls, ","),
>> +                      format(instruction_per_call, ","),
>> +                      helper_name,
>> +                      source_file)
>> +                  )
>> +
>> +
>> +if __name__ =3D=3D "__main__":
>> +    main()
>> --
>> 2.17.1
>>

Best regards,
Ahmed Karaman

