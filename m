Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CC3C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 02:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E83D2067D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 02:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvaLV+w7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E83D2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz9fd-0000yp-ES
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 22:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jz9f4-0000Zf-Ev
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:11:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jz9f0-0005sq-2O
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595643096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdWRcsWh/NjfL+GzhmSud793K5sdOpPHPdfbU+cDKFw=;
 b=EvaLV+w7llk3TJAwSAQ3qMRKZ+1NzKwuHlqJOszMxz5/v4GIAo4NHX/31nCxVPLrY0F3kB
 pEINhwvX9DB2w9TFwerOpreuf/mbDNkMxnVwrBZ/P2vESZKeJM5PXkTL/fmM/VhuxaUQBh
 VmxGWKnVSLkAQzZ+/uqb5oBPX0haT8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-oAMNjtNJOJGAASu9pRo7dA-1; Fri, 24 Jul 2020 22:11:32 -0400
X-MC-Unique: oAMNjtNJOJGAASu9pRo7dA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D2261902EA0;
 Sat, 25 Jul 2020 02:11:31 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81C635D9CC;
 Sat, 25 Jul 2020 02:11:28 +0000 (UTC)
Subject: Re: [PATCH 1/1] scripts/performance: Add bisect.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, philmd@redhat.com, alex.bennee@linaro.org,
 eblake@redhat.com, ldoktor@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 crosa@redhat.com
References: <20200721231536.21604-1-ahmedkhaledkaraman@gmail.com>
 <20200721231536.21604-2-ahmedkhaledkaraman@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <11f44679-8fa0-e872-71d7-3f3feb9699fd@redhat.com>
Date: Fri, 24 Jul 2020 22:11:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721231536.21604-2-ahmedkhaledkaraman@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 22:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On 7/21/20 7:15 PM, Ahmed Karaman wrote:
> Python script that locates the commit that caused a performance
> degradation or improvement in QEMU using the git bisect command
> (binary search).
> 
> Syntax:
> bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] \
> --target TARGET --tool {perf,callgrind} -- \
> <target executable> [<target executable options>]
> 
> [-h] - Print the script arguments help message
> -s,--start START - First commit hash in the search range
> [-e,--end END] - Last commit hash in the search range
>                  (default: Latest commit)
> [-q,--qemu QEMU] - QEMU path.
>                  (default: Path to a GitHub QEMU clone)
> --target TARGET - QEMU target name
> --tool {perf,callgrind} - Underlying tool used for measurements
> 
> Example of usage:
> bisect.py --start=fdd76fecdd --qemu=/path/to/qemu --target=ppc \
> --tool=perf -- coulomb_double-ppc -n 1000
> 
> Example output:
> Start Commit Instructions:     12,710,790,060
> End Commit Instructions:       13,031,083,512
> Performance Change:            -2.458%
> 
> Estimated Number of Steps:     10
> 
> *****************BISECT STEP 1*****************
> Instructions:        13,031,097,790
> Status:              slow commit
> *****************BISECT STEP 2*****************
> Instructions:        12,710,805,265
> Status:              fast commit
> *****************BISECT STEP 3*****************
> Instructions:        13,031,028,053
> Status:              slow commit
> *****************BISECT STEP 4*****************
> Instructions:        12,711,763,211
> Status:              fast commit
> *****************BISECT STEP 5*****************
> Instructions:        13,031,027,292
> Status:              slow commit
> *****************BISECT STEP 6*****************
> Instructions:        12,711,748,738
> Status:              fast commit
> *****************BISECT STEP 7*****************
> Instructions:        12,711,748,788
> Status:              fast commit
> *****************BISECT STEP 8*****************
> Instructions:        13,031,100,493
> Status:              slow commit
> *****************BISECT STEP 9*****************
> Instructions:        12,714,472,954
> Status:              fast commit
> ****************BISECT STEP 10*****************
> Instructions:        12,715,409,153
> Status:              fast commit
> ****************BISECT STEP 11*****************
> Instructions:        12,715,394,739
> Status:              fast commit
> 
> *****************BISECT RESULT*****************
> commit 0673ecdf6cb2b1445a85283db8cbacb251c46516
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Tue May 5 10:40:23 2020 -0700
> 
>      softfloat: Inline float64 compare specializations
> 
>      Replace the float64 compare specializations with inline functions
>      that call the standard float64_compare{,_quiet} functions.
>      Use bool as the return type.
> ***********************************************
> 
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>

Howdy!

Can you run this through some python linters?
Try pylint 2.4.4+ and flake8 3.8.3+.

`pylint --disable=too-many-locals,too-many-statements bisect.py` would 
be a good target to hit; there's not too many warnings. Mostly, it wants 
you to specify the check= parameter to subprocess.run().

> ---
>   scripts/performance/bisect.py | 374 ++++++++++++++++++++++++++++++++++
>   1 file changed, 374 insertions(+)
>   create mode 100755 scripts/performance/bisect.py
> 
> diff --git a/scripts/performance/bisect.py b/scripts/performance/bisect.py
> new file mode 100755
> index 0000000000..869cc69ef4
> --- /dev/null
> +++ b/scripts/performance/bisect.py
> @@ -0,0 +1,374 @@
> +#!/usr/bin/env python3
> +

The following preamble could be a docstring:

"""

> +#  Locate the commit that caused a performance degradation or improvement in
> +#  QEMU using the git bisect command (binary search).
> +#
> +#  Syntax:
> +#  bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] \
> +#  --target TARGET --tool {perf,callgrind} -- \
> +#  <target executable> [<target executable options>]
> +#
> +#  [-h] - Print the script arguments help message
> +#  -s,--start START - First commit hash in the search range
> +#  [-e,--end END] - Last commit hash in the search range
> +#             (default: Latest commit)
> +#  [-q,--qemu QEMU] - QEMU path.
> +#              (default: Path to a GitHub QEMU clone)
> +#  --target TARGET - QEMU target name
> +#  --tool {perf,callgrind} - Underlying tool used for measurements
> +
> +#  Example of usage:
> +#  bisect.py --start=fdd76fecdd --qemu=/path/to/qemu --target=ppc --tool=perf \
> +#  -- coulomb_double-ppc -n 1000
> +#
> +#  This file is a part of the project "TCG Continuous Benchmarking".

"""

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
> +import multiprocessing
> +import tempfile
> +import os
> +import shutil
> +import subprocess
> +import sys
> +
> +
> +############################ GIT WRAPPERS ############################
> +def git_bisect(qemu_path, command, args=None):
> +    """
> +    Wrapper function for running git bisect.
> +
> +    Parameters:
> +    qemu_path (str): QEMU path.
> +    command (str):   bisect command (start|fast|slow|reset).
> +    args (list):     Optional arguments.
> +
> +    Returns:
> +    (str):           git bisect stdout.
> +    """
> +    process = ["git", "bisect", command]
> +    if args:
> +        process += args
> +    bisect = subprocess.run(process,
> +                            cwd=qemu_path,
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.PIPE)
> +    if bisect.returncode:
> +        sys.exit(bisect.stderr.decode("utf-8"))
> +    return bisect.stdout.decode("utf-8")
> +
> +
> +def git_checkout(commit, qemu_path):
> +    """
> +    Wrapper function for checking out a given git commit.
> +
> +    Parameters:
> +    commit (str):    Commit hash of a git commit.
> +    qemu_path (str): QEMU path.
> +    """
> +    checkout_commit = subprocess.run(["git",
> +                                      "checkout",
> +                                      commit],
> +                                     cwd=qemu_path,
> +                                     stdout=subprocess.DEVNULL,
> +                                     stderr=subprocess.PIPE)
> +    if checkout_commit.returncode:
> +        sys.exit(checkout_commit.stderr.decode("utf-8"))
> +
> +
> +def git_clone(qemu_path):
> +    """
> +    Wrapper function for cloning QEMU git repo from GitHub.
> +
> +    Parameters:
> +    qemu_path (str): Path to clone the QEMU repo to.
> +    """
> +    clone_qemu = subprocess.run(["git",
> +                                 "clone",
> +                                 "https://github.com/qemu/qemu.git",
> +                                 qemu_path],
> +                                stderr=subprocess.STDOUT)
> +    if clone_qemu.returncode:
> +        sys.exit("Failed to clone QEMU!")
> +######################################################################
> +
> +
> +def check_requirements(tool):
> +    """
> +    Verify that all script requirements are installed (perf|callgrind & git).
> +
> +    Parameters:
> +    tool (str): Tool used for the measurement (perf or callgrind).
> +    """
> +    if tool == "perf":
> +        check_perf_installation = subprocess.run(["which", "perf"],
> +                                                 stdout=subprocess.DEVNULL)
> +        if check_perf_installation.returncode:
> +            sys.exit("Please install perf before running the script.")
> +
> +        # Insure user has previllage to run perf
> +        check_perf_executability = subprocess.run(["perf", "stat", "ls", "/"],
> +                                                  stdout=subprocess.DEVNULL,
> +                                                  stderr=subprocess.DEVNULL)
> +        if check_perf_executability.returncode:
> +            sys.exit("""
> +        Error:
> +        You may not have permission to collect stats.
> +        Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> +        which controls use of the performance events system by
> +        unprivileged users (without CAP_SYS_ADMIN).
> +        -1: Allow use of (almost) all events by all users
> +            Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> +        0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
> +            Disallow raw tracepoint access by users without CAP_SYS_ADMIN
> +        1: Disallow CPU event access by users without CAP_SYS_ADMIN
> +        2: Disallow kernel profiling by users without CAP_SYS_ADMIN
> +        To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
> +        kernel.perf_event_paranoid = -1
> +
> +        *Alternatively, you can run this script under sudo privileges.
> +        """)
> +    elif tool == "callgrind":
> +        check_valgrind_installation = subprocess.run(["which", "valgrind"],
> +                                                     stdout=subprocess.DEVNULL)
> +        if check_valgrind_installation.returncode:
> +            sys.exit("Please install valgrind before running the script.")
> +
> +    # Insure that git is installed
> +    check_git_installation = subprocess.run(["which", "git"],
> +                                            stdout=subprocess.DEVNULL)
> +    if check_git_installation.returncode:
> +        sys.exit("Please install git before running the script.")
> +
> +
> +def make(qemu_build_path):
> +    """
> +    Build QEMU by running the Makefile.
> +
> +    Parameters:
> +    qemu_build_path (str): Path to the build directory with configuration files.
> +    """

Instead of annotating types using plaintext in the docstring, have you 
considered using mypy?

I've been using it to clean up ./python/qemu and /tests/qemu-iotests, 
and for simple python scripts where you are not using highly dynamic 
data types, it seems to work pretty well.

(I'm not insisting you do that for this patch, but since you went 
through the trouble to annotate it, I thought I'd mention it.)

> +    run_make = subprocess.run(["make",
> +                               "-j",
> +                               str(multiprocessing.cpu_count())],
> +                              cwd=qemu_build_path,
> +                              stdout=subprocess.DEVNULL,
> +                              stderr=subprocess.PIPE)
> +    if run_make.returncode:
> +        sys.exit(run_make.stderr.decode("utf-8"))
> +
> +
> +def measure_instructions(tool, qemu_exe_path, command):

e.x.

def measure_instructions(tool: str,
                          qemu_exe_path: str,
                          command: str) -> int:

> +    """
> +    Measure the number of instructions when running an program with QEMU.
> +
> +    Parameters:
> +    tool (str):          Tool used for the measurement (perf|callgrind).
> +    qemu_exe_path (str): Path to the QEMU executable of the equivalent target.
> +    command (list):      Program path and arguments.
> +
> +    Returns:
> +    (int):               Number of instructions.
> +    """
> +    if tool == "perf":
> +        run_perf = subprocess.run((["perf",
> +                                    "stat",
> +                                    "-x",
> +                                    " ",
> +                                    "-e",
> +                                    "instructions",
> +                                    qemu_exe_path]
> +                                   + command),
> +                                  stdout=subprocess.DEVNULL,
> +                                  stderr=subprocess.PIPE)
> +        if run_perf.returncode:
> +            sys.exit(run_perf.stderr.decode("utf-8"))
> +        else:
> +            perf_output = run_perf.stderr.decode("utf-8").split(" ")
> +            return int(perf_output[0])
> +
> +    elif tool == "callgrind":
> +        with tempfile.NamedTemporaryFile() as tmpfile:
> +            run_callgrind = subprocess.run((["valgrind",
> +                                             "--tool=callgrind",
> +                                             "--callgrind-out-file={}".format(
> +                                                 tmpfile.name),
> +                                             qemu_exe_path]
> +                                            + command),
> +                                           stdout=subprocess.DEVNULL,
> +                                           stderr=subprocess.PIPE)
> +        if run_callgrind.returncode:
> +            sys.exit(run_callgrind.stderr.decode("utf-8"))
> +        else:
> +            callgrind_output = run_callgrind.stderr.decode("utf-8").split("\n")
> +            return int(callgrind_output[8].split(" ")[-1])
> +
> +
> +def main():
> +    # Parse the command line arguments
> +    parser = argparse.ArgumentParser(
> +        usage="bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] "
> +        "--target TARGET --tool {perf,callgrind} -- "
> +        "<target executable> [<target executable options>]")
> +
> +    parser.add_argument("-s", "--start", dest="start", type=str, required=True,
> +                        help="First commit hash in the search range")
> +    parser.add_argument("-e", "--end", dest="end", type=str, default="master",
> +                        help="Last commit hash in the search range")
> +    parser.add_argument("-q", "--qemu", dest="qemu", type=str, default="",
> +                        help="QEMU path")
> +    parser.add_argument("--target", dest="target", type=str, required=True,
> +                        help="QEMU target")
> +    parser.add_argument("--tool", dest="tool", choices=["perf", "callgrind"],
> +                        required=True, help="Tool used for measurements")
> +
> +    parser.add_argument("command", type=str, nargs="+", help=argparse.SUPPRESS)
> +
> +    args = parser.parse_args()
> +
> +    # Extract the needed variables from the args
> +    start_commit = args.start
> +    end_commit = args.end
> +    qemu = args.qemu
> +    target = args.target
> +    tool = args.tool
> +    command = args.command
> +
> +    # Set QEMU path
> +    if qemu == "":
> +        # Create a temp directory for cloning QEMU
> +        tmpdir = tempfile.TemporaryDirectory()
> +        qemu_path = os.path.join(tmpdir.name, "qemu")
> +
> +        # Clone QEMU into the temporary directory
> +        print("Fetching QEMU: ", end="", flush=True)
> +        git_clone(qemu_path)
> +        print()
> +    else:
> +        qemu_path = qemu
> +
> +    # Create the build directory
> +    qemu_build_path = os.path.join(qemu_path, "tmp-build-gcc")
> +    if not os.path.exists(qemu_build_path):
> +        os.mkdir(qemu_build_path)
> +    else:
> +        sys.exit("A build directory with the same name (tmp-build-gcc) used in "
> +                 "the script is already in the provided QEMU path.")
> +
> +    qemu_exe_path = os.path.join(qemu_build_path,
> +                                 "{}-linux-user".format(target),
> +                                 "qemu-{}".format(target))
> +
> +    # Configure QEMU
> +    configure = subprocess.run(["../configure",
> +                                "--target-list={}-linux-user".format(target)],
> +                               cwd=qemu_build_path,
> +                               stdout=subprocess.DEVNULL,
> +                               stderr=subprocess.PIPE)
> +    if configure.returncode:
> +        sys.exit(configure.stderr.decode("utf-8"))
> +
> +    # Do performance measurements for the start commit
> +    git_checkout(start_commit, qemu_path)
> +    make(qemu_build_path)
> +    start_commit_instructions = measure_instructions(tool,
> +                                                     qemu_exe_path,
> +                                                     command)
> +    print("{:<30} {}".format("Start Commit Instructions:",
> +                             format(start_commit_instructions, ",")))
> +
> +    # Do performance measurements for the end commit
> +    git_checkout(end_commit, qemu_path)
> +    make(qemu_build_path)
> +    end_commit_instructions = measure_instructions(tool,
> +                                                   qemu_exe_path,
> +                                                   command)
> +    print("{:<30} {}".format("End Commit Instructions:",
> +                             format(end_commit_instructions, ",")))
> +
> +    # Calculate performance difference between start and end commits
> +    performance_difference = \
> +        (start_commit_instructions - end_commit_instructions) / \
> +        max(end_commit_instructions, start_commit_instructions) * 100
> +    performance_change = "+" if performance_difference > 0 else "-"
> +    print("{:<30} {}".format("Performance Change:",
> +                             performance_change +
> +                             str(round(abs(performance_difference), 3))+"%"))
> +
> +    # Set the custom terms used for progressing in "git bisect"
> +    term_old = "fast" if performance_difference < 0 else "slow"
> +    term_new = "slow" if term_old == "fast" else "fast"
> +
> +    # Start git bisect
> +    git_bisect(qemu_path, "start", [
> +               "--term-old", term_old, "--term-new", term_new])
> +    # Set start commit state
> +    git_bisect(qemu_path, term_old, [start_commit])
> +    # Set end commit state
> +    bisect_output = git_bisect(qemu_path, term_new, [end_commit])
> +    # Print estimated bisect steps
> +    print("\n{:<30} {}\n".format(
> +        "Estimated Number of Steps:", bisect_output.split()[9]))
> +
> +    # Initialize bisect_count to track the number of performed
> +    bisect_count = 1
> +
> +    while True:
> +        print("**************BISECT STEP {}**************".format(bisect_count))
> +
> +        make(qemu_build_path)
> +
> +        instructions = measure_instructions(tool, qemu_exe_path, command)
> +        # Find the difference between the current instructions and start/end
> +        # instructions.
> +        diff_end = abs(instructions - end_commit_instructions)
> +        diff_start = abs(instructions - start_commit_instructions)
> +
> +        # If current number of insructions is closer to that of start,
> +        # set current commit as term_old.
> +        # Else, set current commit as term_new.
> +        if diff_end > diff_start:
> +            bisect_command = term_old
> +        else:
> +            bisect_command = term_new
> +
> +        print("{:<20} {}".format("Instructions:", format(instructions, ",")))
> +        print("{:<20} {}".format("Status:", "{} commit".format(bisect_command)))
> +
> +        bisect_output = git_bisect(qemu_path, bisect_command)
> +
> +        # Continue if still bisecting,
> +        # else, print result and break.
> +        if not bisect_output.split(" ")[0] == "Bisecting:":
> +            print("\n*****************BISECT RESULT*****************")
> +            commit_message_start = bisect_output.find("commit\n") + 7
> +            commit_message_end = bisect_output.find(":040000") - 1
> +            print(bisect_output[commit_message_start:commit_message_end])
> +            break
> +
> +        bisect_count += 1
> +
> +    # Reset git bisect
> +    git_bisect(qemu_path, "reset")
> +
> +    # Delete temp build directory
> +    shutil.rmtree(qemu_build_path)
> +
> +
> +if __name__ == "__main__":
> +    main()
> 


