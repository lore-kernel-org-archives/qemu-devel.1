Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC552C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0899E21D46
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUncmRUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0899E21D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO5Pw-00023h-6H
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 16:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO5Oj-0001Yx-Aa
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 16:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO5Oc-0003Rx-QM
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 16:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601584905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5T2U5x5H5W7L5kES0UDZoruMP/4hIIQyAVdhoUsieG0=;
 b=WUncmRUuj07QJoNDA7wn/REMeV+HEdl0QRr42YRY5Ue0xjsOEjl9O59EdJEF38xcN7gC+o
 dJqdWRzvMhOKGDGjHnqTpLdIx3I/VUuBoPJZq1XY1DJqURRI0/wC3nJgBsj70Lhu5IFK5v
 VgIz7Ll0ecSm3yZRoXokMrCMU3grj+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-XgtUui85PwaeLumXrgOufQ-1; Thu, 01 Oct 2020 16:41:41 -0400
X-MC-Unique: XgtUui85PwaeLumXrgOufQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AE9A803659;
 Thu,  1 Oct 2020 20:41:40 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEC8260BFA;
 Thu,  1 Oct 2020 20:41:38 +0000 (UTC)
Subject: Re: [PATCH 1/9] scripts/performance: Refactor topN_perf.py
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, philmd@redhat.com, alex.bennee@linaro.org,
 eblake@redhat.com, ldoktor@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 crosa@redhat.com
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-2-ahmedkhaledkaraman@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ec6e7528-0281-9bdc-5afc-4b9c8a541f13@redhat.com>
Date: Thu, 1 Oct 2020 16:41:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200828104102.4490-2-ahmedkhaledkaraman@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

I realize this review comes well after you are no longer being paid to 
work on this, so I am offering my time to help polish your patches if 
you would like.

On 8/28/20 6:40 AM, Ahmed Karaman wrote:
> - Apply pylint and flake8 formatting rules to the script.
> - Use 'tempfile' instead of '/tmp' for creating temporary files.
> 

I had meant to maybe consider using some helper functions so that you 
didn't need to rename the globals, for instance:

> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>   scripts/performance/topN_perf.py | 174 +++++++++++++++----------------
>   1 file changed, 87 insertions(+), 87 deletions(-)
> 
> diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_perf.py
> index 07be195fc8..56b100da87 100755
> --- a/scripts/performance/topN_perf.py
> +++ b/scripts/performance/topN_perf.py
> @@ -1,72 +1,77 @@
>   #!/usr/bin/env python3
>   
> -#  Print the top N most executed functions in QEMU using perf.
> -#  Syntax:
> -#  topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
> -#           <qemu executable> [<qemu executable options>] \
> -#           <target executable> [<target execurable options>]
> -#
> -#  [-h] - Print the script arguments help message.
> -#  [-n] - Specify the number of top functions to print.
> -#       - If this flag is not specified, the tool defaults to 25.
> -#
> -#  Example of usage:
> -#  topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
> -# > -#  This file is a part of the project "TCG Continuous Benchmarking".
> -#
> -#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> -#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
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
> +Print the top N most executed functions in QEMU using perf.
> +
> +Syntax:
> +topN_perf.py [-h] [-n <number of displayed top functions>] -- \
> +         <qemu executable> [<qemu executable options>] \
> +         <target executable> [<target execurable options>]
> +
> +[-h] - Print the script arguments help message.
> +[-n] - Specify the number of top functions to print.
> +     - If this flag is not specified, the tool defaults to 25.
> +
> +Example of usage:
> +topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
> +

Based on discussion we've had upstream since you sent this, I think we 
will be keeping license and authorship information out of the 
docstrings, so this part can stay a comment.

> +This file is a part of the project "TCG Continuous Benchmarking".
> +
> +Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
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
>   import argparse
>   import os
>   import subprocess
>   import sys
> +import tempfile
>   
>   
>   # Parse the command line arguments
> -parser = argparse.ArgumentParser(
> -    usage='topN_perf.py [-h] [-n] <number of displayed top functions >  -- '
> +PARSER = argparse.ArgumentParser(
> +    usage='topN_perf.py [-h] [-n <number of displayed top functions>] -- '
>             '<qemu executable> [<qemu executable options>] '
>             '<target executable> [<target executable options>]')
>   

This is a little odd; generally we can avoid having such globals by 
making a main() function that defines a parser as a local instead.

e.g.,

def main():
     parser = ...
     parser.add_argument(...)

     args = parser.parse_args()

     ...

     return 0


if __name__ == '__main__':
     sys.exit(main())


> -parser.add_argument('-n', dest='top', type=int, default=25,
> +PARSER.add_argument('-n', dest='top', type=int, default=25,
>                       help='Specify the number of top functions to print.')
>   
> -parser.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
> +PARSER.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
>   
> -args = parser.parse_args()
> +ARGS = PARSER.parse_args()
>   
>   # Extract the needed variables from the args
> -command = args.command
> -top = args.top
> +COMMAND = ARGS.command
> +TOP = ARGS.top
>   
>   # Insure that perf is installed
> -check_perf_presence = subprocess.run(["which", "perf"],
> -                                     stdout=subprocess.DEVNULL)
> -if check_perf_presence.returncode:
> +CHECK_PERF_PRESENCE = subprocess.run(["which", "perf"],
> +                                     stdout=subprocess.DEVNULL,
> +                                     check=False)
> +if CHECK_PERF_PRESENCE.returncode:
>       sys.exit("Please install perf before running the script!")
>   
>   # Insure user has previllage to run perf
> -check_perf_executability = subprocess.run(["perf", "stat", "ls", "/"],
> +CHECK_PERF_EXECUTABILITY = subprocess.run(["perf", "stat", "ls", "/"],
>                                             stdout=subprocess.DEVNULL,
> -                                          stderr=subprocess.DEVNULL)
> -if check_perf_executability.returncode:
> -    sys.exit(
> -"""
> +                                          stderr=subprocess.DEVNULL,
> +                                          check=False)
> +if CHECK_PERF_EXECUTABILITY.returncode:
> +    sys.exit("""
>   Error:
>   You may not have permission to collect stats.
>   
> @@ -85,43 +90,42 @@ To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
>      kernel.perf_event_paranoid = -1
>   
>   * Alternatively, you can run this script under sudo privileges.
> -"""
> -)
> -
> -# Run perf record
> -perf_record = subprocess.run((["perf", "record", "--output=/tmp/perf.data"] +
> -                              command),
> -                             stdout=subprocess.DEVNULL,
> -                             stderr=subprocess.PIPE)
> -if perf_record.returncode:
> -    os.unlink('/tmp/perf.data')
> -    sys.exit(perf_record.stderr.decode("utf-8"))
> -
> -# Save perf report output to /tmp/perf_report.out
> -with open("/tmp/perf_report.out", "w") as output:
> -    perf_report = subprocess.run(
> -        ["perf", "report", "--input=/tmp/perf.data", "--stdio"],
> -        stdout=output,
> -        stderr=subprocess.PIPE)
> -    if perf_report.returncode:
> -        os.unlink('/tmp/perf.data')
> -        output.close()
> -        os.unlink('/tmp/perf_report.out')
> -        sys.exit(perf_report.stderr.decode("utf-8"))
> -
> -# Read the reported data to functions[]
> -functions = []
> -with open("/tmp/perf_report.out", "r") as data:
> -    # Only read lines that are not comments (comments start with #)
> -    # Only read lines that are not empty
> -    functions = [line for line in data.readlines() if line and line[0]
> -                 != '#' and line[0] != "\n"]
> -
> -# Limit the number of top functions to "top"
> -number_of_top_functions = top if len(functions) > top else len(functions)
> -
> -# Store the data of the top functions in top_functions[]
> -top_functions = functions[:number_of_top_functions]
> +""")
> +
> +# Run perf and save all intermediate files in a temporary directory
> +with tempfile.TemporaryDirectory() as tmpdir:
> +    RECORD_PATH = os.path.join(tmpdir, "record.data")
> +    REPORT_PATH = os.path.join(tmpdir, "report.txt")
> +
> +    PERF_RECORD = subprocess.run((["perf", "record", "--output="+RECORD_PATH] +
> +                                  COMMAND),
> +                                 stdout=subprocess.DEVNULL,
> +                                 stderr=subprocess.PIPE,
> +                                 check=False)
> +    if PERF_RECORD.returncode:
> +        sys.exit(PERF_RECORD.stderr.decode("utf-8"))
> +
> +    with open(REPORT_PATH, "w") as output:
> +        PERF_REPORT = subprocess.run(
> +            ["perf", "report", "--input="+RECORD_PATH, "--stdio"],
> +            stdout=output,
> +            stderr=subprocess.PIPE,
> +            check=False)
> +        if PERF_REPORT.returncode:
> +            sys.exit(PERF_REPORT.stderr.decode("utf-8"))
> +
> +    # Save the reported data to FUNCTIONS[]
> +    with open(REPORT_PATH, "r") as data:
> +        # Only read lines that are not comments (comments start with #)
> +        # Only read lines that are not empty
> +        FUNCTIONS = [line for line in data.readlines() if line and
> +                     line[0] != '#' and line[0] != "\n"]
> +
> +# Limit the number of top functions to "TOP"
> +NO_TOP_FUNCTIONS = TOP if len(FUNCTIONS) > TOP else len(FUNCTIONS)
> +
> +# Store the data of the top functions in TOP_FUNCTIONS[]
> +TOP_FUNCTIONS = FUNCTIONS[:NO_TOP_FUNCTIONS]
>   
>   # Print table header
>   print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
> @@ -134,7 +138,7 @@ print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
>                                                            '-' * 25))
>   
>   # Print top N functions
> -for (index, function) in enumerate(top_functions, start=1):
> +for (index, function) in enumerate(TOP_FUNCTIONS, start=1):
>       function_data = function.split()
>       function_percentage = function_data[0]
>       function_name = function_data[-1]
> @@ -143,7 +147,3 @@ for (index, function) in enumerate(top_functions, start=1):
>                                                function_percentage,
>                                                function_name,
>                                                function_invoker))
> -
> -# Remove intermediate files
> -os.unlink('/tmp/perf.data')
> -os.unlink('/tmp/perf_report.out')
> 


