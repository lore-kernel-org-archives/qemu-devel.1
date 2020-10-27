Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18BDC5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45A52071A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B8o7PhCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45A52071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQMZ-0004FS-Mj
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXPsc-0000PA-Qm; Tue, 27 Oct 2020 10:23:18 -0400
Received: from mail-eopbgr60110.outbound.protection.outlook.com
 ([40.107.6.110]:49316 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXPsZ-0008MB-3o; Tue, 27 Oct 2020 10:23:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjb1c2W4HBWeXmdmTioNp6SWXaPMXzXNMNB+nzDsNhj+diX8aiPlmUVb9RjuFZDy1x1S6oR+qFuF8/0Ki2U9/8+nptvSkUmP52RAIPljMnz2LwkOgbntywxJtq5Xh9Q5xKQVsVhuQizZSps2Q2kZbm04UZtD9pP6M7BfEvZ5KH19cLy8iglwgjxmzVtp26MbvJtfdHZ7zEkNOGg/Kjz/HcITPT15r3a1E5QQapuaEGOan4EzbCICZ9SyKOvPSoDkpmsQVCi+Q/KnCaH/CsLY/op+L9VBe7z8IhldrpjhtInowoacLi56y8fVCANbLz4x4vPv6cGFQILAEHZCSzqAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJbygrjiJ+/tBOtPKcjVFbQEHGFeLv2FLtwx8pO/wvc=;
 b=Hzp/6SYkpi2uL1A6ZAFjHy2jBx6DfC0moKWOHzcjLvqYXKyfsA8+6v3EIQEch9I96a6WJnghOhBC/Fix4GoKUljnFunYch8MxxXxMMIdcpdm7G4Z1ym8kEc7JrnUDWLnUEC8NANgLERvlhUaSGMq9nL0Vt/GWJkI3X4n+jU0fBqIwYU+9kvlInECSRXFb2s98kHZyYna/NKAtfhX5Me1LlSglGYhD5yswko2pvrjWg9JJA5UiL0UA02jBKUp/wTETCur5bQFoVk5ySty7cJoyv/cBQLUK1eag4wLclG7lZvYNyOddqiw3zWnu7l3x+1piqsjstMvR39iXmvRabPu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJbygrjiJ+/tBOtPKcjVFbQEHGFeLv2FLtwx8pO/wvc=;
 b=B8o7PhCh7VcdWmZ11uVIfMqIunYxsa8e5wUeOUVMEWHzy+t5lu1cx8NNdRoksPgdd3RBCoPGLB/qkt58szAnAxeRCRCQ0nakwNtkKG6zJ9+Eyn18Igp8FYpd9j4itkVUew06yfKmI09h5R2fazIEW1Wa8qnv4EVPWjJ++kDAhLs=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VE1PR08MB4813.eurprd08.prod.outlook.com (2603:10a6:802:ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 14:23:11 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 14:23:11 +0000
Subject: Re: [PATCH v12 08/14] iotests: add #310 to test bottom node in COR
 driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-9-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0e568f1b-8462-1c08-8363-ade4352b7408@virtuozzo.com>
Date: Tue, 27 Oct 2020 17:23:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-9-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM4PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:205:1::33) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM4PR07CA0020.eurprd07.prod.outlook.com (2603:10a6:205:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.10 via Frontend Transport; Tue, 27 Oct 2020 14:23:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25267962-91cc-42a5-8810-08d87a83d56b
X-MS-TrafficTypeDiagnostic: VE1PR08MB4813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB4813674375378B046EC61388C1160@VE1PR08MB4813.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HUZ/20iEKh7xphdhNyYBdl2LIBM1DtTNbLYdv/Sne7+QIEnmhvvmEbRt5ii31fsgD4un3v8Bu4DxcyW61d3TgivbxtsOGpuqD1iM8ut/CFbtGQeRX4w5xXEPAUpZWT3y6Z+TNzG5oQ/hqEOqlOcinRkNAt94gR3A7lAbswSo0mnnzI7gyncVA0JU5gniDQyPdmQOPyoDSKNQnW5tsdb5mWbBxPTg2ppnK4I/4t3qgRFoJD2zW79X8QPI0mHhEg/oQdohDVlrnMQZM+JHXKYy59BjR7+kVll6jG9I0KLq/EaHWwpxXs8pllH0FIu5S1qZNwlXuK/e18rZ1MOaDV85ziVwPxpixPObAxzXVISJGEy3vMS053cvbsUaAlU/REPQgg6j2k82jazgiDv/byv7ZylBh0tpXHIeeLLlfdSA2pqD8YYToVhkp6O7kV2HgwbNIgv/BaRWdNDonpnusp2yOkAqMk4z+AKztT+YkaQO5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39850400004)(2906002)(86362001)(186003)(478600001)(36756003)(8676002)(16576012)(6486002)(5660300002)(66556008)(16526019)(66476007)(66946007)(52116002)(316002)(83380400001)(26005)(2616005)(8936002)(4326008)(31696002)(107886003)(31686004)(956004)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HXdqxsfcSFNm6MccVCbjSvHlTZOERI7L0l/tB+WJivSPRUAFxW/r9iWHQ67we4Tsq39LY9OkLiQvAsRWxJ6eR1Rs5Pk/ubl4r33z8kws3+D5TDCVdIRmqnXFAiNO+vAnWsrR1LVfQLQfYUV7GaMmy3hmDgLeXYHWAaXX01+OEX5/Ws/vwA/eTVIFewUzdoefqZS8rN+uml/2fUaRwRLK2q7jei/yW8s60xnZVQTEgrhjqaLgLdlrWE26D6f9PZZj2HgfAx08eJgfgXZRaT9UHZV3nehd07edJ0A2EhoI084Dg/LkxypH1i3e2LehOS9SjAcAtF/0hRqdNaw7O0y1Bqm6EOZ5rP84/S+9xhyvVBMc5bVDiYJ745fEoAEZ9HyEJG5yVQVTUsgjfVwHxXqGYL092aMKT9x+A9MtTQUF6cjLSDcivHRpwhgY++TyamUXGec2Np2+I5CJMS7G8SaevX/ONwRaUrW/QF5wMiAycX5nooyAO1gl9MH18of/hdRZtnxadP1vRvSmT2cY0/9Qp/XxCTvufR5quOQqGeAL7e7g4S1dhqJrnKaMiGGuDUXZJYWhvAZlJ2KwKBzXdkYs9zM2s6FDqpjDeQUMJhDs3p94stM0RTv9x0LjWKfif5Ded1VfGPI6f9B8LyfYL/U35w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25267962-91cc-42a5-8810-08d87a83d56b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 14:23:11.5711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrG4ani5HKlPadeHAZBLjpp7r2noWIp0gIW6HPnUNZvzATtJZduw3+NoUO26bWYmhyFgIK2IjhXNtEPREpcfnk1M3h+Ir/K5TAtgZfXjXxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4813
Received-SPF: pass client-ip=40.107.6.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:23:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

22.10.2020 21:13, Andrey Shinkevich wrote:
> The test case #310 is similar to #216 by Max Reitz. The difference is
> that the test #310 involves a bottom node to the COR filter driver.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/310     | 109 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/310.out |  15 +++++++
>   tests/qemu-iotests/group   |   3 +-
>   3 files changed, 126 insertions(+), 1 deletion(-)
>   create mode 100755 tests/qemu-iotests/310
>   create mode 100644 tests/qemu-iotests/310.out
> 
> diff --git a/tests/qemu-iotests/310 b/tests/qemu-iotests/310
> new file mode 100755
> index 0000000..5ad7ad2
> --- /dev/null
> +++ b/tests/qemu-iotests/310
> @@ -0,0 +1,109 @@
> +#!/usr/bin/env python3
> +#
> +# Copy-on-read tests using a COR filter with a bottom node
> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH

Probably you should keep original copyright too.

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
> +import iotests
> +from iotests import log, qemu_img, qemu_io_silent
> +
> +# Need backing file support
> +iotests.script_initialize(supported_fmts=['qcow2', 'qcow', 'qed', 'vmdk'],
> +                          supported_platforms=['linux'])
> +
> +log('')
> +log('=== Copy-on-read across nodes ===')
> +log('')
> +
> +# This test is similar to the 216 one by Max Reitz <mreitz@redhat.com>
> +# The difference is that this test case involves a bottom node to the
> +# COR filter driver.
> +
> +with iotests.FilePath('base.img') as base_img_path, \
> +     iotests.FilePath('mid.img') as mid_img_path, \
> +     iotests.FilePath('top.img') as top_img_path, \
> +     iotests.VM() as vm:
> +
> +    log('--- Setting up images ---')
> +    log('')
> +
> +    assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M') == 0
> +    assert qemu_io_silent(base_img_path, '-c', 'write -P 1 0M 1M') == 0
> +    assert qemu_io_silent(base_img_path, '-c', 'write -P 1 3M 1M') == 0
> +    assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
> +                    '-F', iotests.imgfmt, mid_img_path) == 0
> +    assert qemu_io_silent(mid_img_path,  '-c', 'write -P 3 2M 1M') == 0
> +    assert qemu_io_silent(mid_img_path,  '-c', 'write -P 3 4M 1M') == 0
> +    assert qemu_img('create', '-f', iotests.imgfmt, '-b', mid_img_path,
> +                    '-F', iotests.imgfmt, top_img_path) == 0
> +    assert qemu_io_silent(top_img_path,  '-c', 'write -P 2 1M 1M') == 0

An ascii-art of what we have done won't hart, like:

#      0 1 2 3 4
# top    2
# mid      3   3
# base 1     1


> +
> +    log('Done')
> +
> +    log('')
> +    log('--- Doing COR ---')
> +    log('')
> +
> +    vm.launch()
> +
> +    log(vm.qmp('blockdev-add',
> +                    node_name='node0',
> +                    driver='copy-on-read',
> +                    bottom='node2',
> +                    file={
> +                        'driver': iotests.imgfmt,
> +                            'file': {
> +                                'driver': 'file',
> +                                'filename': top_img_path
> +                            },
> +                            'backing': {
> +                                'node-name': 'node2',
> +                                'driver': iotests.imgfmt,
> +                                'file': {
> +                                    'driver': 'file',
> +                                    'filename': mid_img_path
> +                                },
> +                                'backing': {
> +                                    #'node-name': 'node2',
> +                                    'driver': iotests.imgfmt,
> +                                    'file': {
> +                                        'driver': 'file',
> +                                        'filename': base_img_path
> +                                    }
> +                                },
> +                            }
> +                    }))
> +
> +    # Trigger COR
> +    log(vm.qmp('human-monitor-command',
> +               command_line='qemu-io node0 "read 0 5M"'))
> +
> +    vm.shutdown()
> +
> +    log('')
> +    log('--- Checking COR result ---')
> +    log('')
> +
> +    assert qemu_io_silent(base_img_path, '-c', 'discard 0 4M') == 0
> +    assert qemu_io_silent(mid_img_path, '-c', 'discard 0M 5M') == 0
> +    assert qemu_io_silent(top_img_path,  '-c', 'read -P 1 0M 1M') != 0

Better assert what it should be instead of what it should not:

  assert qemu_io_silent(top_img_path,  '-c', 'read -P 0 0 1M') == 0

> +    assert qemu_io_silent(top_img_path,  '-c', 'read -P 2 1M 1M') == 0
> +    assert qemu_io_silent(top_img_path,  '-c', 'read -P 3 2M 1M') == 0
> +    assert qemu_io_silent(top_img_path,  '-c', 'read -P 1 3M 1M') != 0

  and here

  assert qemu_io_silent(top_img_path,  '-c', 'read -P 0 3M 1M') == 0


> +    assert qemu_io_silent(top_img_path,  '-c', 'read -P 3 4M 1M') == 0
> +
> +    log('Done')
> diff --git a/tests/qemu-iotests/310.out b/tests/qemu-iotests/310.out
> new file mode 100644
> index 0000000..a70aa5c
> --- /dev/null
> +++ b/tests/qemu-iotests/310.out
> @@ -0,0 +1,15 @@
> +
> +=== Copy-on-read across nodes ===
> +
> +--- Setting up images ---
> +
> +Done
> +
> +--- Doing COR ---
> +
> +{"return": {}}
> +{"return": ""}
> +
> +--- Checking COR result ---
> +
> +Done
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 3432989..769029b 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -314,4 +314,5 @@
>   303 rw quick
>   304 rw quick
>   305 rw quick
> -307 rw quick export
> +307 rw quick
> +310 rw quick export
> 

you shouldn't modify 307... line here, and I think "export" is unrelated.

so, with 307 as is, and add 310 without "export" group, and also two my previous suggestions:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

