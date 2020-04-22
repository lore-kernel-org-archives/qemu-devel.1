Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7B7C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 05:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3F52072D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 05:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hne7ApGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3F52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR84W-0001xB-VZ
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 01:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jR83M-0001Ir-Ve
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 01:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jR83H-0006RY-Vb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 01:36:07 -0400
Received: from mail-eopbgr140117.outbound.protection.outlook.com
 ([40.107.14.117]:11248 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jR83H-0006I6-2I; Wed, 22 Apr 2020 01:36:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0s1TudRlsM9fNDqYBbHxOH1nzBXgvGPUmx64UojHQWfsX6ef8XmUCJE6V2T7ziYUEGm9fVb/i6MoQXansYPwJ/92bI5IGzNtsYM+6A5fIGHdVKt7d29SDJYQ2ZOOHYOVMmQBVvONNknGTTwvQrLM6Kzpsg4hhuFBvU6afnpzVYGP4+RMAIJ49C5l5DXcMN9nqwQJjo1u1gbXlTm6KIBPzGnvqdUNAxxLoacNTFlgs+oddj1Ox9QnGa7eg3NTMBrReqkUUDxCXPVfRC3cyMGILhIeX4jSxP4K+p2wQ+VSLM5dW0uMf7JvPJ2UEekrcscSTYwl/27EMYFE3uK/2NdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlKjiTqo2whtM1YS76PC70XsSDgfcQVI3J/PB1BD8Os=;
 b=IiKxpVpZyADZiNg9dDJJbaSXmsSDWoVv+zFpqXs9mAZZAC63ul50eu5dFvZaRK86vWvLVPUT2qRzp2ICVzr2zPUZ+T2DAB9oLgGzNI7tyzZJAXpskVrC6AXjx+gKRojtjOMSblhWgSPiEAr1eLDkfee1PVEEBz5UW5lLXRIk1VgXGa+dnmC2ECM3FPJ/faLAoiVloot7lsJK9zLrwiWRftp0BHlK3GVh43HREjEYcX637+x5HHFh0e2dH6WHrw90hSyYVywFfciP83UHlQACzuY7okAisooTANiIGY2X28SKNRFVZ7s0Xl4jPRhpcQPCAhhDAF+DTvz8yfQoKpzWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlKjiTqo2whtM1YS76PC70XsSDgfcQVI3J/PB1BD8Os=;
 b=hne7ApGU1RGCc+m73rsIVCJnO68Ts6Kd6ZQK/YeTf687p8N+V5Q+cUbwG2FM2Jf4HWWzSGXv01XR47PWvlK76fmY8WQGatWpYzXLbPf2Y/tSrQxV30IigC3ZaTP4uzEQIIIw7qyycmOVkIn5t7GASHl7EsFdTGI2Z2wO0j6F5dM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5319.eurprd08.prod.outlook.com (2603:10a6:20b:dc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 05:35:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 05:35:59 +0000
Subject: Re: [PATCH v3 06/10] iotests: add testfinder.py
To: Kevin Wolf <kwolf@redhat.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-7-vsementsov@virtuozzo.com>
 <20200421165647.GE22440@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422083557504
Message-ID: <024af11c-180a-2ef6-fbab-fe31107d4438@virtuozzo.com>
Date: Wed, 22 Apr 2020 08:35:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200421165647.GE22440@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0P190CA0025.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 05:35:58 +0000
X-Tagtoolbar-Keys: D20200422083557504
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c823b649-8599-4726-43ec-08d7e67f0950
X-MS-TrafficTypeDiagnostic: AM7PR08MB5319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5319D4FA7F8EEB9DB4514C65C1D20@AM7PR08MB5319.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39830400003)(2616005)(86362001)(956004)(6486002)(2906002)(31696002)(8676002)(30864003)(66946007)(4326008)(66556008)(66476007)(8936002)(31686004)(5660300002)(81156014)(6916009)(16526019)(186003)(52116002)(478600001)(16576012)(36756003)(316002)(26005)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbMEt6NWIHssGSNlFEfHISPjhQE9YKwoYan/xnz+KuMsomVCGGgVAHrYyfzZa3RCU2m0ahldiP1g3u/xHbKkL631FnO82/QPHVZNMUWL4BDZhG03two3Eo6ID2OCEoPe5GTaBU0vqa9iIXwG+6HgkK/ZoPDCLOQAggxv5O2yAKl5Ah3PArrM4Z0OTEbWzEzs5M0reUhS298/Uw2QXRjigiqEzE8eHO6NI7XQT+OzkQiTVmAfRtJ2mVBeHG4iOfuf3kNfnMhsKWu+j9gAi0HKmVCeiucns7M/lq6DNhqqGLX0KL6XXPBJPazTlXqgIN3ew77Z2cRYhU2n91pSgJuCmnxnyV5lTPXcxW9Z9YEwP0gTPBYpIlJ31yVeIjWBfpouVGOJUUGSqImMzlBye51xp1urScDFcHLa/PtoOSVs7ysipIl2Uj2QzohqS2yXQSK78/MaxR3yyiPyXJSi8ifujgj3Ugc75lBaXn3W8l0h288b2kikdFeLWjLufULyXq4+GPXCOXp1q7wcY1egOKPqvuTEfrrIhKG4IHTcZah2ho6CxrKJWWKJSt4mTyVVzOTD
X-MS-Exchange-AntiSpam-MessageData: kov9GJDXiZ+f2Eq9rlj17sHUTCWSBB0W/n3KMDMQc72MJP0R7xf7CkPNRr3WcXqgr1DZrjepq2xfbu06vFkT3NlsDOJ45HhI6Epf1gEaNdWhDehDPgovN+heY/aI7XaWP2VWEBrVMhbtSTg9vkf0Ug==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c823b649-8599-4726-43ec-08d7e67f0950
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 05:35:58.9526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LJdgoHt4RnH3WX4i5/d1oXa4zul2CCu6nbVXaUh0P9HXxRk81nofK/TvK/smG5KIo4aSlIWsVf6H3jqwlwcmSbeCcU9HVBEeBJXSOBY8XE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5319
Received-SPF: pass client-ip=40.107.14.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 01:36:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.14.117
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.04.2020 19:56, Kevin Wolf wrote:
> Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Add python script with new logic of searching for tests:
>>
>> Current ./check behavior:
>>   - tests are named [0-9][0-9][0-9]
>>   - tests must be registered in group file (even if test doesn't belong
>>     to any group, like 142)
>>
>> Behavior of new test:
>>   - group file is dropped
>>   - tests are searched by file-name instead of group file, so it's not
>>     needed more to "register the test", just create it with name
>>     *-test. Old names like [0-9][0-9][0-9] are supported too, but not
>>     recommended for new tests
> 
> I wonder if a tests/ subdirectory instead of the -test suffix would
> organise things a bit better.

No objections.

I also thought about, may be, a tests/ subtree, so we'll have something like

tests/jobs/<mirror, stream, backup tests>
tests/formats/<qcow2 tests and others, or may be one more subdirectory level>
...

> 
>>   - groups are parsed from '# group: ' line inside test files
>>   - optional file group.local may be used to define some additional
>>     groups for downstreams
>>   - 'disabled' group is used to temporary disable tests. So instead of
>>     commenting tests in old 'group' file you now can add them to
>>     disabled group with help of 'group.local' file
>>   - selecting test ranges like 5-15 are not supported more
> 
> Occasionally they were useful when something went wrong during the test
> run and I only wanted to repeat the part after it happened. But it's a
> rare case and we don't have a clear order any more with arbitrary test
> names (which are an improvement otherwise), so we'll live with it.

Yes, I've used it for same thing.

Actually, we still have the order, as I just sort iotests by name. I think,
we could add a parameter for testfinder (may be, as a separate step no in
these series), something like

--start-from TEST : parse all other arguments as usual, make sorted sequence
and than drop tests from the first one to TEST (not inclusive). This may be
used to rerun failed ./check command, starting from the middle of the process.

> 
>> Benefits:
>>   - no rebase conflicts in group file on patch porting from branch to
>>     branch
>>   - no conflicts in upstream, when different series want to occupy same
>>     test number
>>   - meaningful names for test files
>>     For example, with digital number, when some person wants to add some
>>     test about block-stream, he most probably will just create a new
>>     test. But if there would be test-block-stream test already, he will
>>     at first look at it and may be just add a test-case into it.
>>     And anyway meaningful names are better.
>>
>> This commit just adds class, which is unused now, and will be used in
>> further patches, to finally substitute ./check selecting tests logic.
> 
> Maybe mention here that the file can be executed standalone, even if
> it'S not used by check yet.
> 
>> Still, the documentation changed like new behavior is already here.
>> Let's live with this small inconsistency for the following few commits,
>> until final change.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   docs/devel/testing.rst           |  52 +++++++++-
>>   tests/qemu-iotests/testfinder.py | 167 +++++++++++++++++++++++++++++++
> 
> A little bit of bikeshedding: As this can be executed as a standalone
> tool, would a name like findtests.py be better?

Hmm. I named it by class name, considering possibility to execute is just for module testing. So for module users, it's just a module with class TestFinder, and it's called testfinder.. But I don't have strict opinion in it, findtests sound more human-friendly.

> 
>>   2 files changed, 218 insertions(+), 1 deletion(-)
>>   create mode 100755 tests/qemu-iotests/testfinder.py
>>
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index 770a987ea4..6c9d5b126b 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -153,7 +153,7 @@ check-block
>>   -----------
>>   
>>   ``make check-block`` runs a subset of the block layer iotests (the tests that
>> -are in the "auto" group in ``tests/qemu-iotests/group``).
>> +are in the "auto" group).
>>   See the "QEMU iotests" section below for more information.
>>   
>>   GCC gcov support
>> @@ -267,6 +267,56 @@ another application on the host may have locked the file, possibly leading to a
>>   test failure.  If using such devices are explicitly desired, consider adding
>>   ``locking=off`` option to disable image locking.
>>   
>> +Test case groups
>> +----------------
>> +
>> +Test may belong to some groups, you may define it in the comment inside the
>> +test. By convention, test groups are listed in the second line of the test
>> +file, after "#!/..." line, like this:
>> +
>> +.. code::
>> +
>> +  #!/usr/bin/env python3
>> +  # group: auto quick
>> +  #
>> +  ...
>> +
>> +Additional way of defining groups is creating tests/qemu-iotests/group.local
>> +file. This should be used only for downstream (this file should never appear
>> +in upstream). This file may be used for defining some downstream test groups
>> +or for temporary disable tests, like this:
>> +
>> +.. code::
>> +
>> +  # groups for some company downstream process
>> +  #
>> +  # ci - tests to run on build
>> +  # down - our downstream tests, not for upstream
>> +  #
>> +  # Format of each line is:
>> +  # TEST_NAME TEST_GROUP [TEST_GROUP ]...
>> +
>> +  013 ci
>> +  210 disabled
>> +  215 disabled
>> +  our-ugly-workaround-test down ci
>> +
>> +The following groups are defined:
>> +
>> +- quick : Tests in this group should finish within some few seconds.
>> +
>> +- img : Tests in this group can be used to excercise the qemu-img tool.
>> +
>> +- auto : Tests in this group are used during "make check" and should be
>> +  runnable in any case. That means they should run with every QEMU binary
>> +  (also non-x86), with every QEMU configuration (i.e. must not fail if
>> +  an optional feature is not compiled in - but reporting a "skip" is ok),
>> +  work at least with the qcow2 file format, work with all kind of host
>> +  filesystems and users (e.g. "nobody" or "root") and must not take too
>> +  much memory and disk space (since CI pipelines tend to fail otherwise).
>> +
>> +- disabled : Tests in this group are disabled and ignored by check.
> 
> We have more groups than just these. We could either try and document
> all of them here, or we could only keep auto/quick/disabled which have a
> general meaning rather than defining an area of code that they test. If
> we do the latter, I would clarify that this is not an exhaustive list,
> and remove "img" from this section.

OK. I'll drop img for now, documenting all the groups may be done in separate.

> 
>>   .. _docker-ref:
>>   
>>   Docker based tests
>> diff --git a/tests/qemu-iotests/testfinder.py b/tests/qemu-iotests/testfinder.py
>> new file mode 100755
>> index 0000000000..1da28564c0
>> --- /dev/null
>> +++ b/tests/qemu-iotests/testfinder.py
> 
> As this is a new code file, would you mind adding type hints from the
> start?

I added it in one-two non-obvious places. Is there any general thought about using type-hints? Should modern coder use them absolutely everywhere?

> 
>> @@ -0,0 +1,167 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Parse command line options to define set of tests to run.
>> +#
>> +# Copyright (c) 2020 Virtuozzo International GmbH
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +#
>> +
>> +import os
>> +import sys
>> +import glob
>> +import argparse
>> +import re
>> +from collections import defaultdict
>> +from contextlib import contextmanager
>> +
>> +
>> +@contextmanager
>> +def chdir(path):
>> +    if path is None:
>> +        yield
>> +        return
>> +
>> +    saved_dir = os.getcwd()
>> +    os.chdir(path)
>> +    try:
>> +        yield
>> +    finally:
>> +        os.chdir(saved_dir)
>> +
>> +
>> +class TestFinder:
>> +    @staticmethod
>> +    def create_argparser():
>> +        p = argparse.ArgumentParser(description="Select set of tests",
> 
> "a set of tests"?
> 
>> +                                    add_help=False, usage=argparse.SUPPRESS)
>> +
>> +        p.add_argument('-g', metavar='group1,...', dest='groups',
>> +                       help='include tests from these groups')
>> +        p.add_argument('-x', metavar='group1,...', dest='exclude_groups',
>> +                       help='exclude tests from these groups')
>> +        p.add_argument('tests', metavar='TEST_FILES', nargs='*',
>> +                       help='tests to run')
>> +
>> +        return p
>> +
>> +    argparser = create_argparser.__func__()
>> +
>> +    def __init__(self, test_dir=None):
>> +        self.groups = defaultdict(set)
>> +
>> +        with chdir(test_dir):
>> +            self.all_tests = glob.glob('[0-9][0-9][0-9]')
>> +            self.all_tests += [f for f in glob.iglob('*-test')]
>> +
>> +            for t in self.all_tests:
>> +                with open(t) as f:
>> +                    for line in f:
>> +                        if line.startswith('# group: '):
>> +                            for g in line.split()[2:]:
>> +                                self.groups[g].add(t)
>> +
>> +    def add_group_file(self, fname):
>> +        with open(fname) as f:
>> +            for line in f:
>> +                line = line.strip()
>> +
>> +                if (not line) or line[0] == '#':
>> +                    continue
>> +
>> +                words = line.split()
>> +                test_file = words[0]
>> +                groups = words[1:]
>> +
>> +                if test_file not in self.all_tests:
>> +                    print('Warning: {}: "{}" test is not found. '
>> +                          'Skip.'.format(fname, test_file))
> 
> You're using f strings in the later patches. Wouldn't it be more
> consistent to use them here, too?

Yes, thanks. I just wrote this code before learning f-strings)

> 
>> +                    continue
>> +
>> +                for g in groups:
>> +                    self.groups[g].add(test_file)
>> +
>> +    def find_tests(self, groups=None, exclude_groups=None, tests=None):
>> +        """
>> +        1. Take all tests from @groups,
>> +           or just all tests if @groups is None and @tests is None
>> +           or nothing if @groups is None and @tests is not None
>> +        2. Drop tests, which are in at least one of @exclude_groups or in
>> +           'disabled' group (if 'disabled' is not listed in @groups)
>> +        3. Add tests from @tests
>> +        """
>> +        if groups is None:
>> +            groups = []
>> +        if exclude_groups is None:
>> +            exclude_groups = []
>> +        if tests is None:
>> +            tests = []
>> +
>> +        if groups:
>> +            res = set().union(*(self.groups[g] for g in groups))
>> +        elif tests:
>> +            res = set()
>> +        else:
>> +            res = set(self.all_tests)
>> +
>> +        if 'disabled' not in groups and 'disabled' not in exclude_groups:
>> +            exclude_groups.append('disabled')
>> +
>> +        res = res.difference(*(self.groups[g] for g in exclude_groups))
>> +
>> +        # We want to add @tests. But for compatibility with old test names,
>> +        # we should convert any number < 100 to number padded by
>> +        # leading zeroes, like 1 -> 001 and 23 -> 023.
>> +        for t in tests:
>> +            if re.fullmatch(r'\d{1,2}', t):
>> +                res.add('0' * (3 - len(t)) + t)
>> +            else:
>> +                res.add(t)
>> +
>> +        return sorted(res)
>> +
>> +    def find_tests_argv(self, argv):
>> +        args, remaining = self.argparser.parse_known_args(argv)
>> +
>> +        if args.groups is not None:
>> +            args.groups = args.groups.split(',')
>> +
>> +        if args.exclude_groups is not None:
>> +            args.exclude_groups = args.exclude_groups.split(',')
>> +
>> +        return self.find_tests(**vars(args)), remaining
>> +
>> +
>> +def find_tests(argv, test_dir=None):
>> +    tf = TestFinder(test_dir)
>> +
>> +    if test_dir is None:
>> +        group_local = 'group.local'
>> +    else:
>> +        group_local = os.path.join(test_dir, 'group.local')
>> +    if os.path.isfile(group_local):
>> +        tf.add_group_file(group_local)
>> +
>> +    return tf.find_tests_argv(argv)
>> +
>> +
>> +if __name__ == '__main__':
>> +    if len(sys.argv) == 2 and sys.argv[1] in ['-h', '--help']:
>> +        TestFinder.argparser.print_help()
>> +        exit()
>> +
>> +    tests, remaining_argv = find_tests(sys.argv[1:])
>> +    print('\n'.join(tests))
>> +    if remaining_argv:
>> +        print('\nUnhandled options: ', remaining_argv)
> 
> I think unhandled options shouldn't be considered an error and we
> shouldn't even try to find and display any tests then. I'd either print
> the help text or have an error message that refers to --help.
> 

As I considered running this script as executable for testing purposes, it's
good to know, which options are not handled..



-- 
Best regards,
Vladimir

