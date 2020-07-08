Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD12C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F82206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HX5GVc5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F82206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIGZ-0002O1-1H
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtHph-0004e0-Fj
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:42:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtHpe-0003wX-W8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X3S2hgYZJD8TgY+qlSRB3Hf+ANxv77a1Pb4edm2LrSk=;
 b=HX5GVc5yBETLtT3M+IN/Hwbd2WdpvZ0YR7Sp3dV1JQoY1Ov1+243nWSEjqFMoae0ujIm/p
 ndGRPGC4xpAMqzcjQuKFeNkFCJjWb2esZijEItG1xMSnMfKmLGty3Zo51Dp7H0kyyqVS+Q
 Pa4Bax755EqoIXmud1ktD2mp6pQQee8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-5YOOEDSwOpSrQdcn_C_Pww-1; Wed, 08 Jul 2020 11:41:23 -0400
X-MC-Unique: 5YOOEDSwOpSrQdcn_C_Pww-1
Received: by mail-wm1-f69.google.com with SMTP id c124so3399167wme.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 08:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X3S2hgYZJD8TgY+qlSRB3Hf+ANxv77a1Pb4edm2LrSk=;
 b=PMzfv/51qDzAar9c6Uf+jF2pmbEp/p0qBQ0vEWWGglRD56sg5u3PIykmzsqWgDrpDD
 XPzwRlcEMu7funvFVK7pE+hobE8p0JpRNr8qsEVR5VOuplEuscH8vmqR2foaU0jy/J8q
 LNoy6jMAhONgBQ3YlmUB3Hyvm32/tmcVd0gIXmF1w1GPPjhwZ83qZqh5/hsS99yDoGMP
 XrsQhaaPaXHJmwA2VhVAGZt6YFIg7XoPV1Js3jtDuEziS8DRF0xixZr+GCddGeu5umYm
 rrvUkvL9MgWzf/kevrFRdVzgFiiUcJC2DEUCAkQMoQwtzgGo9K6o4Lady2Glt1gotLNu
 3QpQ==
X-Gm-Message-State: AOAM532bujgHpaC3/idlEOFESP6ebgMKt4t9u+b1+N5PxGVc8LOAaQMA
 3R2B+Uh5qgqTFmTIOo29k+oeKKF83w1ScZYY17lk6zZAhNb0gaa5+rk+lrywn2ANtA8GjQU9QQu
 Fap6NgbP1qtWNrEo=
X-Received: by 2002:a1c:2392:: with SMTP id j140mr9767448wmj.6.1594222882046; 
 Wed, 08 Jul 2020 08:41:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxOUBy5I+ASSHiXw1DK8e6mXn8mNdFU+UOoumIQmHB4Wt+CdLeHrHYsDuSMCD+LCXPEj5tzg==
X-Received: by 2002:a1c:2392:: with SMTP id j140mr9767421wmj.6.1594222881757; 
 Wed, 08 Jul 2020 08:41:21 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id p29sm161802wmi.43.2020.07.08.08.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 08:41:21 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] scripts/performance: Add dissect.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org, rth@twiddle.net,
 eblake@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
References: <20200702142942.4887-1-ahmedkhaledkaraman@gmail.com>
 <20200702142942.4887-2-ahmedkhaledkaraman@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <1d5cb8cc-888a-8d12-739d-e4f162fbbc31@redhat.com>
Date: Wed, 8 Jul 2020 17:41:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200702142942.4887-2-ahmedkhaledkaraman@gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ahmed,

On 7/2/20 4:29 PM, Ahmed Karaman wrote:
> Python script that dissects QEMU execution into three main phases:
> code generation, JIT execution and helpers execution.
> 
> Syntax:
> dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
>                  <target executable> [<target executable options>]
> 
> [-h] - Print the script arguments help message.
> 
> Example of usage:
> dissect.py -- qemu-arm coulomb_double-arm
> 
> Example output:
> Total Instructions:        4,702,865,362
> 
> Code Generation:             115,819,309	 2.463%
> JIT Execution:             1,081,980,528	23.007%
> Helpers:                   3,505,065,525	74.530%
> 
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  scripts/performance/dissect.py | 165 +++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100755 scripts/performance/dissect.py
> 
> diff --git a/scripts/performance/dissect.py b/scripts/performance/dissect.py
> new file mode 100755
> index 0000000000..8c2967d082
> --- /dev/null
> +++ b/scripts/performance/dissect.py
> @@ -0,0 +1,165 @@
> +#!/usr/bin/env python3
> +
> +#  Print the percentage of instructions spent in each phase of QEMU
> +#  execution.
> +#
> +#  Syntax:
> +#  dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
> +#                   <target executable> [<target executable options>]
> +#
> +#  [-h] - Print the script arguments help message.
> +#
> +#  Example of usage:
> +#  dissect.py -- qemu-arm coulomb_double-arm
> +#
> +#  This file is a part of the project "TCG Continuous Benchmarking".
> +#
> +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
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
> +def get_JIT_line(callgrind_data):
> +    """
> +    Search for the first instance of the JIT call in
> +    the callgrind_annotate output when ran using --tree=caller
> +    This is equivalent to the self number of instructions of JIT.
> +
> +    Parameters:
> +    callgrind_data (list): callgrind_annotate output
> +
> +    Returns:
> +    (int): Line number
> +   """

Alignment off by 1 ;)

> +    line = -1
> +    for i in range(len(callgrind_data)):
> +        if callgrind_data[i].strip('\n') and \
> +                callgrind_data[i].split()[-1] == "[???]":
> +            line = i
> +            break
> +    if line == -1:
> +        sys.exit("Couldn't locate the JIT call ... Exiting.")
> +    return line
> +
> +
> +def main():
> +    # Parse the command line arguments
> +    parser = argparse.ArgumentParser(
> +        usage='dissect.py [-h] -- '
> +        '<qemu executable> [<qemu executable options>] '
> +        '<target executable> [<target executable options>]')
> +
> +    parser.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
> +
> +    args = parser.parse_args()
> +
> +    # Extract the needed variables from the args
> +    command = args.command
> +
> +    # Insure that valgrind is installed
> +    check_valgrind = subprocess.run(
> +        ["which", "valgrind"], stdout=subprocess.DEVNULL)
> +    if check_valgrind.returncode:
> +        sys.exit("Please install valgrind before running the script.")
> +
> +    # Run callgrind
> +    callgrind = subprocess.run((["valgrind",
> +                                 "--tool=callgrind",
> +                                 "--callgrind-out-file=/tmp/callgrind.data"]

Maybe "/path/to/callgrind.data" in the help?

> +                                + command),
> +                               stdout=subprocess.DEVNULL,
> +                               stderr=subprocess.PIPE)
> +    if callgrind.returncode:
> +        sys.exit(callgrind.stderr.decode("utf-8"))
> +
> +    # Save callgrind_annotate output to /tmp/callgrind_annotate.out

1/ You use these files multiples time, please use a variable for each.
2/ This won't work on Windows
3/ This bypass the TMPDIR envirnoment variable
  a/ Darwin sets it to /var/folders/$user/$random/
  b/ Some users prefer to set TMPDIR on dedicated fast memory support

This is more portable:

  import tempfile

  annotated_path = os.path.join(tempfile.gettempdir(),
                                "callgrind_annotate.out")
  data_path = os.path.join(tempfile.gettempdir(), "callgrind.data")

Now, apparently both are temporary, so you can use a context manager
to get a temporary directory, and the context manager will remove it
when you are done.

Something like:

       with tempfile.TemporaryDirectory() as tmpdirname:
           annotated_path = os.path.join(tmpdirname,
                                         "callgrind_annotate.out")
           data_path = os.path.join(tmpdirname, "callgrind.data")

           with open(annotated_path, "w") as output:
                ....

No need to unlink/rmdir.

> +    with open("/tmp/callgrind_annotate.out", "w") as output:
> +        callgrind_annotate = subprocess.run(
> +            ["callgrind_annotate", "/tmp/callgrind.data", "--tree=caller"],
> +            stdout=output,
> +            stderr=subprocess.PIPE)
> +        if callgrind_annotate.returncode:
> +            os.unlink('/tmp/callgrind.data')

Maybe display a hint to the user? "Something went wrong. Is
callgrind_annotate installed?"

> +            output.close()

You used a context manager (with open ...) so no need to call close(),
it will be called when you are done with the context.

> +            os.unlink('/tmp/callgrind_annotate.out')
> +            sys.exit(callgrind_annotate.stderr.decode("utf-8"))
> +
> +    # Read the callgrind_annotate output to callgrind_data[]
> +    callgrind_data = []
> +    with open('/tmp/callgrind_annotate.out', 'r') as data:
> +        callgrind_data = data.readlines()

Here you didn't call close(), good :)

> +
> +    # Line number with the total number of instructions
> +    total_instructions_line_number = 20
> +    # Get the total number of instructions
> +    total_instructions_line_data = \
> +        callgrind_data[total_instructions_line_number]
> +    total_instructions = total_instructions_line_data.split()[0]
> +    total_instructions = int(total_instructions.replace(',', ''))
> +
> +    # Line number with the JIT self number of instructions
> +    JIT_self_instructions_line_number = get_JIT_line(callgrind_data)
> +    # Get the JIT self number of instructions
> +    JIT_self_instructions_line_data = \
> +        callgrind_data[JIT_self_instructions_line_number]
> +    JIT_self_instructions = JIT_self_instructions_line_data.split()[0]
> +    JIT_self_instructions = int(JIT_self_instructions.replace(',', ''))
> +
> +    # Line number with the JIT self + inclusive number of instructions
> +    # It's the line above the first JIT call when running with --tree=caller
> +    JIT_total_instructions_line_number = JIT_self_instructions_line_number - 1
> +    # Get the JIT self + inclusive number of instructions
> +    JIT_total_instructions_line_data = \
> +        callgrind_data[JIT_total_instructions_line_number]
> +    JIT_total_instructions = JIT_total_instructions_line_data.split()[0]
> +    JIT_total_instructions = int(JIT_total_instructions.replace(',', ''))
> +
> +    # Calculate number of instructions in helpers and code generation
> +    helpers_instructions = JIT_total_instructions - JIT_self_instructions
> +    code_generation_instructions = total_instructions - JIT_total_instructions
> +
> +    # Print results (Insert commas in large numbers)
> +    # Print total number of instructions
> +    print('{:<20}{:>20}\n'.
> +          format("Total Instructions:",
> +                 format(total_instructions, ',')))
> +    # Print code generation instructions and percentage
> +    print('{:<20}{:>20}\t{:>6.3f}%'.
> +          format("Code Generation:",
> +                 format(code_generation_instructions, ","),
> +                 (code_generation_instructions / total_instructions) * 100))
> +    # Print JIT instructions and percentage
> +    print('{:<20}{:>20}\t{:>6.3f}%'.
> +          format("JIT Execution:",
> +                 format(JIT_self_instructions, ","),
> +                 (JIT_self_instructions / total_instructions) * 100))
> +    # Print helpers instructions and percentage
> +    print('{:<20}{:>20}\t{:>6.3f}%'.
> +          format("Helpers:",
> +                 format(helpers_instructions, ","),
> +                 (helpers_instructions/total_instructions)*100))
> +
> +    # Remove intermediate files
> +    os.unlink('/tmp/callgrind.data')
> +    os.unlink('/tmp/callgrind_annotate.out')

No need for these unlink if using tempfile.TemporaryDirectory().

Regards,

Phil.

> +
> +
> +if __name__ == "__main__":
> +    main()
> 


