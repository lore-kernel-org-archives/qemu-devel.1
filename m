Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE51DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 13:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6036E2076A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 13:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="r8ZJZJqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6036E2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juFRj-0008RB-IP
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 09:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juFQk-0007jv-EP; Sat, 11 Jul 2020 09:20:38 -0400
Received: from mail-eopbgr00137.outbound.protection.outlook.com
 ([40.107.0.137]:28149 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juFQd-0004ki-AP; Sat, 11 Jul 2020 09:20:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsaQM8Cqmv2ti9nDegUffoepJwxOgUQWsmWePMTiEhnmD2Bph3+AY7NS0eD1fDt7bR8OBk+khFdJzKJa3DeN9V3O6F1IvduihcOFKVBSIarGBTCHZugxMLX/bvNE0wq3yN8cfg6DuKD3oMm6udTL44lGsVTQvlkFVey5uq+5fhxROKLTE9sJUf4pTpuGIW2/FjX0lU0Yxvr3quLc5YAjPgdq3eTPU+6MijsQ9eclInyhkhQTYsHXRlzGxXA0vBe7MZcxQw0mhippp7G1lldE7X0JfqCnYY4/15l4XlmR+lvUQh6EdfJ6Z3Bh2Es/CZjzuatGsYfQBfy2cJdjwSZkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgHJdnZpzPwbnWn71MwkEJyBKVEzOkQTbpSctuQ0E2s=;
 b=nnGbaYGbxbLOj9kmQBIGbL6Kfa+jMPCQARVMtcL3rlH3ev5T/gweK5DtfqoR5D9SudM9gynq8G0tdqbkze2on5I3sIeLRpmhmowtkbOvPQM56j4iBTVPtOTc+EkqMeh0j9/J+ZnUWG7IgBD6j36d2qDV9KrjgFK98Z0rKHLO6TOIL6swktgIlWyfVVQcphRNbpi81c/lSUQXmocp0Eyx3rNY55G15AioVz3YYs6x2Tp9GWyfQxA/dEA1prQeiQ9SovVlC7E68IMVG3we1agJeU1L4oN97lL100nBCjJYDVUYkamgFA6JhQsWtMe9ocnGMgowinkM9APHLESQ4jBJUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgHJdnZpzPwbnWn71MwkEJyBKVEzOkQTbpSctuQ0E2s=;
 b=r8ZJZJqbzIgrYOIAWWddTqeourSO9W5MIFPyo/MHu/JWU3RB36tHNQHIJxO/e/UztUEFjwf1ga5uU0vI9wOxeks9cdezC5+XJ9m3AkBr1Aqw+PAsIQ4dpRjLdY8aQMnLCWByG/H3n/dDorW2ycECjxdwrJiso2kj6zFRaGSl78M=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3224.eurprd08.prod.outlook.com (2603:10a6:209:47::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Sat, 11 Jul
 2020 13:05:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.024; Sat, 11 Jul 2020
 13:05:25 +0000
Subject: Re: [PATCH v2] scripts/simplebench: compare write request performance
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1593181915-853845-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <73ac42ec-dc28-c4e6-a555-d9cf11cbeed0@virtuozzo.com>
Date: Sat, 11 Jul 2020 16:05:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1593181915-853845-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:205::23)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM4PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:205::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Sat, 11 Jul 2020 13:05:25 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e86719eb-1c9a-436f-07fb-08d8259b13c7
X-MS-TrafficTypeDiagnostic: AM6PR08MB3224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB322402D19EF3B5BCAC2C9276C1620@AM6PR08MB3224.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofuzfEZNrYInlrT7ansZI3YftM+Zig8tvkT7dp81hZB7cZbiYCcKtwoRJ3e8qHSAIOpB78ATzXoq7XFD4wHk7jztX6yCXLJ1wBUWng9g6+vHeYASvqcJZLcz/EI17f0IQy+kyPNJ0YmETXCRWkmNkHTUKDZ9h3o0Vk70LxeoEbsMCl0USZQsPoGzLbG3Ad8oAucI9fI+yNSWka9hUplYM7UKklrzme4btZADgSPjoOC/tjytLsOOnzXXPwx56YCRaBuuOz5jiNS+pmIPJYi4cdHpkA03kn2wM7KeC5AvpaWYZG1cltUhPFu6lCRGTUHUREjF1lmZBAJSgD6lGiz3bc5TjjkcqVXnxVF1WCbWtp3ZJitlcoGdPOxUD+k944/9w/R43ysjo4lV3sxkp6kjdSygVu6RgnNWBaZNu5BBRPWUYO/3W83C1sqfYD1jJJ/WGqRIh0qawS7rS0+Lh3CLgSlVu+BRz5evOqiyN+FUdpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39840400004)(6666004)(83380400001)(956004)(4326008)(66946007)(2616005)(6486002)(8676002)(107886003)(8936002)(31686004)(16576012)(186003)(16526019)(2906002)(26005)(5660300002)(86362001)(316002)(52116002)(31696002)(66556008)(66476007)(478600001)(36756003)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VAZ3TqlScZK+0jujsfhRmbpNKTgmBbnGvPAQlpLa/0IpW5iDLKP20/3RIUgEepB9DCIk9HTnPhlPhHunzaEoRvP7PpnApLc1FEi+eWMBxAbgGbEx+Xe4MKIgSyntYjM6PaUyLDE44xhWvG0k2R9KWpsTs+PI5aFIQyRFhTmkcsfwOr6daaPt0SyVosc3PVInkaehSLKfYrv+3Pv6nrgT7tDxZWszKO+059Lnb+JRKhLnnVtoNxl6nzOW5TkZp5D213nOoA4R7tJvsDTP/8OIEwR/sNzNbgf3ZmJ8Y8nK/TbRgMW4OfNCcg2mEumBaeRyrO+HXHLtqBGngXez3wF+tYspRd8/foJKoodkjSp5YFdjadkpgA+QG6pjUWcsilufXARm04duQByU93KyPclFTeOOl8X2iXbuSS1ruto3ydoohMFrmFoV9YvxtHiw/HIzHndecm+Eam3+UfGQ2cTU5FNBTwfgphpXhFCU48XZKj/3r8Q02wJEOYB6OTlTNvIu
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86719eb-1c9a-436f-07fb-08d8259b13c7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2020 13:05:25.5770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PsXwdUE4tcYNp3UeHfep7PdEqACQ/vkr69Wea7I/3f1U8uYjajuLMe5gDGi1M/oCM9tXpPeQhhGSwIEk7D6cjEqwgCEzCdSYkkQHkH2Zns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3224
Received-SPF: pass client-ip=40.107.0.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 09:20:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

26.06.2020 17:31, Andrey Shinkevich wrote:
> The script 'bench_write_req.py' allows comparing performances of write
> request for two qemu-img binary files.
> An example with (qemu-img binary 1) and without (qemu-img binary 2) the
> applied patch "qcow2: skip writing zero buffers to empty COW areas"
> (git commit ID: c8bb23cbdbe32f5)
> The <unaligned> case does not involve the COW optimization.
> 
> SSD:
> -----------------  -------------------  -------------------
>                     <qemu-img binary 1>  <qemu-img binary 2>
> <simple case>      2.72 +- 0.00         11.67 +- 1.04
> <general case>     0.34 +- 0.00         8.64 +- 1.55
> <cluster middle>   0.33 +- 0.01         8.13 +- 2.05
> <cluster overlap>  8.46 +- 0.06         12.97 +- 1.07
> <unaligned>        9.27 +- 2.04         8.83 +- 0.84
> -----------------  -------------------  -------------------
> HDD:
> -----------------  -------------------  -------------------
>                     <qemu-img binary 1>  <qemu-img binary 2>
> <simple case>      617.86 +- 6.78       608.84 +- 10.72
> <general case>     57.53 +- 3.56        52.99 +- 7.48
> <cluster middle>   60.50 +- 1.92        56.11 +- 5.20
> <cluster overlap>  12.10 +- 1.10        15.16 +- 2.56
> <unaligned>        6.23 +- 0.05         6.40 +- 0.07
> -----------------  -------------------  -------------------
> 

Good, this proves that c8bb23cbdbe32f5 makes sense.

> Suggested-by: Denis V. Lunev <den@openvz.org>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
> v2:
>    01: Three more test cases added to the script:
>        <simple case>
>        <general case>
>        <unaligned>
> 
>   scripts/simplebench/bench_write_req.py | 201 +++++++++++++++++++++++++++++++++
>   1 file changed, 201 insertions(+)
>   create mode 100755 scripts/simplebench/bench_write_req.py
> 
> diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
> new file mode 100755
> index 0000000..fe92d01
> --- /dev/null
> +++ b/scripts/simplebench/bench_write_req.py
> @@ -0,0 +1,201 @@
> +#!/usr/bin/env python3
> +#
> +# Test to compare performance of write requests for two qemu-img binary files.
> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +
> +import sys
> +import os
> +import subprocess
> +import simplebench
> +
> +
> +def bench_func(env, case):
> +    """ Handle one "cell" of benchmarking table. """
> +    return bench_write_req(env['qemu_img'], env['image_name'],
> +                           case['block_size'], case['block_offset'],
> +                           case['requests'], case['empty_image'])
> +
> +
> +def qemu_img_pipe(*args):
> +    '''Run qemu-img and return its output'''
> +    subp = subprocess.Popen(list(args),
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.STDOUT,
> +                            universal_newlines=True)
> +    exitcode = subp.wait()
> +    if exitcode < 0:
> +        sys.stderr.write('qemu-img received signal %i: %s\n'
> +                         % (-exitcode, ' '.join(list(args))))
> +    return subp.communicate()[0]

I understand that it's duplicated from iotests.py.. Hmm, we probably should move most of its functionality into python/ and reuse here, but I don't ask you do it, this patch my keep the copy I think.

> +
> +
> +def bench_write_req(qemu_img, image_name, block_size, block_offset, requests,
> +                    empty_image):
> +    """Benchmark write requests
> +
> +    qemu_img     -- path to qemu_img executable file
> +    image_name   -- QCOW2 image name to create
> +    block_size   -- size of a block to write to clusters
> +    block_offset -- offset of the block in clusters
> +    requests     -- number of write requests per cluster, customize if zero
> +    empty_image  -- if True, fill image with random data
> +

Some comment on the behavior of the function won't hurt.

> +    Returns {'seconds': int} on success and {'error': str} on failure.
> +    Return value is compatible with simplebench lib.
> +    """
> +
> +    if not os.path.isfile(qemu_img):
> +        print('File not found: {}'.format(qemu_img))
> +        sys.exit(1)
> +
> +    image_dir = os.path.dirname(os.path.abspath(image_name))
> +    if not os.path.isdir(image_dir):
> +        print('Path not found: {}'.format(image_name))
> +        sys.exit(1)
> +
> +    cluster_size = 1024 * 1024
> +    image_size = 1024 * cluster_size
> +    seek = 4
> +    dd_count = int(image_size / cluster_size) - seek
> +
> +    args_create = [qemu_img, 'create', '-f', 'qcow2', '-o',
> +                   'cluster_size={}'.format(cluster_size),
> +                   image_name, str(image_size)]
> +
> +    if requests:
> +        count = requests * int(image_size / cluster_size)
> +        step = str(cluster_size)
> +    else:
> +        # Create unaligned write requests
> +        assert block_size
> +        shift = int(block_size * 1.01)
> +        count = int((image_size - block_offset) / shift)
> +        step = str(shift)
> +        depth = ['-d', '2']
> +
> +    offset = str(block_offset)
> +    cnt = str(count)
> +    size = []
> +    if block_size:
> +        size = ['-s', '{}'.format(block_size)]
> +
> +    args_bench = [qemu_img, 'bench', '-w', '-n', '-t', 'none', '-c', cnt,
> +                  '-S', step, '-o', offset, '-f', 'qcow2', image_name]
> +    if block_size:
> +        args_bench.extend(size)
> +    if not requests:
> +        args_bench.extend(depth)
> +
> +    try:
> +        qemu_img_pipe(*args_create)
> +
> +        if not empty_image:
> +            dd = ['dd', 'if=/dev/urandom', 'of={}'.format(image_name),
> +                  'bs={}'.format(cluster_size), 'seek={}'.format(seek),
> +                  'count={}'.format(dd_count), '&&', 'sync']

consider using new python f-strings, like f'bs={cluster_size}'

> +            devnull = open('/dev/null', 'w')
> +            subprocess.call(dd, stderr=devnull, stdout=devnull)

subprocess.call is outdated API, use .run()

And, I really doubt that "'&&", 'sync'" would work without shell=True. Probably better to call run() twice: for dd and for sync.

Next, I don't understand, are you trying to fill qcow2 image by dd directly? This is strange. Even if you don't break metadata, you don't change it, so all cluster will remain empty.

> +
> +    except OSError as e:
> +        return {'error': 'qemu_img create failed: ' + str(e)}
so, here, you don't care to remove image_name


> +
> +    try:
> +        ret = qemu_img_pipe(*args_bench)
> +    except OSError as e:
> +        return {'error': 'qemu_img bench failed: ' + str(e)}
> +    finally:
> +        os.remove(image_name)
> +        if not ret:
> +            return {'error': 'qemu_img bench failed'}
> +        if 'seconds' in ret:
> +            ret = ret.split()

Note, that such thing (reassigning another type to variable)

> +            index = ret.index('seconds.')
> +            return {'seconds': float(ret[index-1])}
> +        else:
> +            return {'error': 'qemu_img bench failed: ' + ret}

return both in except and in finally doesn't seem good thing to do: note that "finally is executed even if you try to return from except, so your return in except doesn't make sence at all

> +
> +
> +if __name__ == '__main__':
> +
> +    if len(sys.argv) < 4:
> +        print('USAGE: {} <path to qemu-img binary file> '
> +              '<path to another qemu-img to compare performance with> '
> +              '<full or relative name for QCOW2 image to create>'
> +              ''.format(os.path.basename(sys.argv[0])))
> +        exit(1)
> +
> +    # Test-cases are "rows" in benchmark resulting table, 'id' is a caption
> +    # for the row, other fields are handled by bench_func.
> +    test_cases = [
> +        {
> +            'id': '<simple case>',
> +            'block_size': 0,
> +            'block_offset': 0,
> +            'requests': 10,
> +            'empty_image': False
> +        },
> +        {
> +            'id': '<general case>',
> +            'block_size': 4096,
> +            'block_offset': 0,
> +            'requests': 10,
> +            'empty_image': False
> +        },
> +        {
> +            'id': '<cluster middle>',
> +            'block_size': 4096,
> +            'block_offset': 524288,
> +            'requests': 10,
> +            'empty_image': False
> +        },
> +        {
> +            'id': '<cluster overlap>',
> +            'block_size': 524288,
> +            'block_offset': 4096,
> +            'requests': 2,
> +            'empty_image': False
> +        },
> +        {
> +            'id': '<unaligned>',
> +            'block_size': 104857600,
> +            'block_offset': 524288,
> +            'requests': 0,
> +            'empty_image': False
> +        },
> +    ]
> +
> +    # Test-envs are "columns" in benchmark resulting table, 'id is a caption
> +    # for the column, other fields are handled by bench_func.
> +    # Set the paths below to desired values
> +    test_envs = [
> +        {
> +            'id': '<qemu-img binary 1>',
> +            'qemu_img': '{}'.format(sys.argv[1]),
> +            'image_name': '{}'.format(sys.argv[3])
> +        },
> +        {
> +            'id': '<qemu-img binary 2>',
> +            'qemu_img': '{}'.format(sys.argv[2]),
> +            'image_name': '{}'.format(sys.argv[3])
> +        },
> +    ]
> +
> +    result = simplebench.bench(bench_func, test_envs, test_cases, count=3,
> +                               initial_run=False)
> +    print(simplebench.ascii(result))
> 


-- 
Best regards,
Vladimir

