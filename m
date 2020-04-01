Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9D7C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 13:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7170B2073B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 13:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="r42fvqrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7170B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJdGW-0005aq-IS
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 09:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJdFe-000568-5g
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJdFc-0008CP-6p
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:17:50 -0400
Received: from mail-vi1eur05on20706.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::706]:64800
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJdFU-0007yb-Mr; Wed, 01 Apr 2020 09:17:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b83vK8e+FJULEzdg6dr2YNfo8lQviM/9sYIw5Gs7zmMIK4hVQlyyqchvCR2KDPtLP3lbX//Ux8u/ISws0pfPE7BeHPp9srZ9IOSEnq6oL7TBbxT7AS4YtKr9xV1w7fDaY+kKWrwW3MyvEkJdBHKSHIF23wra1C2pky8YFGR2sF/PqKJRRUHC0YvWLEWK9GGZoOfCV/u76ViLhi1ZEMdBrb+2cRbK8KLCOl+gpPti1ZuJiPgSL+3b5dV/+EgI5w1LLXP9rVlwBK/r8jxLRF7JmoQKgAbjl5QmHVIAWlGpK4K27HMyWWaBVYUncoc+sd8zyAus6E7R5cZmonLEWJhSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRQXkfQkKnKs6Lh8rAmoRpt37l125tnUxD7aO+FLXqE=;
 b=huQ6gB5pVEMu2KmlXMgLvuSSkBH5LP6TJugSJ24z7gdAGW1ZS9d+TbEUsF6pgHruQwaoV7TS/flixUXlAVMIaH9k9uBAenLYkuOjWHwhML+Myp5NS5qKAj4zVyDwlnyYg9msAa7ruw8ZqsaOmkP90G3USX5dlZtS82lkWuE4VQE58LNQyO6VAlMeTMmOZAedE75WiyWH5m0Ue3FN0hRotqRswdaRv8rm2n23Z/ae7xECEWyZ71lfdid0aYZldadkR7uNKWPPeJDup4KyhhikRLDU+niXQ6+owPZTt4ttqTYpmpqeNip6TnDaZ8mU6NEkBc/QUKlPvjYaSqafD/rPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRQXkfQkKnKs6Lh8rAmoRpt37l125tnUxD7aO+FLXqE=;
 b=r42fvqrdIJOhXZmQGT8HcgENNAth/OlEBxiuNpwndCDelfb71c2Kq6uBDJ0Dh2HrdV8rFjMWLkfKRnVYJmyCWzGqahlTmJn6+tZRbKE61YfYuGoeRvuUSbdUdmN9KfPjtbJvEaZ6sXguP2747ZAuk2t+3xzNW/WEVozf75P9xsU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5527.eurprd08.prod.outlook.com (10.141.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 13:17:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 13:17:37 +0000
Subject: Re: [PATCH v15 4/4] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200401101213.24505-1-dplotnikov@virtuozzo.com>
 <20200401101213.24505-5-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401161735299
Message-ID: <e77968ec-cba7-1078-d4f6-b91298403906@virtuozzo.com>
Date: Wed, 1 Apr 2020 16:17:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200401101213.24505-5-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0077.eurprd02.prod.outlook.com
 (2603:10a6:208:154::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR02CA0077.eurprd02.prod.outlook.com (2603:10a6:208:154::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 13:17:36 +0000
X-Tagtoolbar-Keys: D20200401161735299
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 441b5e7b-c543-4e52-b547-08d7d63f0c06
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5527CA748FDEB8D7DD8E1376C1C90@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(39840400004)(346002)(396003)(136003)(366004)(16576012)(36756003)(8676002)(6486002)(2906002)(52116002)(4326008)(8936002)(81166006)(81156014)(186003)(86362001)(66946007)(5660300002)(316002)(478600001)(26005)(16526019)(2616005)(31686004)(66556008)(66476007)(956004)(31696002)(2004002)(21314003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUpmU7xDOmeFCB5Bc13J/2OCUHEK+nMGCLuS+fo0qPmJ0B+oRHXYk0hi2l0pc7EuKVT7zS+PwRU1URK4scare3ZIU4sThYjr58mWvtSzkV9lmkfpyC5062aNHsd1qD8vR3yH+mLUop3E0FqVWoK6BUA7h/Lixf5eoVRtYF+QtLZsRrRGCcMglL3eTRlpelJG633Vt2YzOKap57PapRVAXUiB3sCvYbmUoxkbc7froZH2U2R39ApIkt5gdCKqKU+oEB6RiQmiLq/wDL+L5yEwDqmN4kE8WQAJovSWN22HYmPnGHoVBE+ygPgB2okNDAzeXr+inUVeVymMMqE2SfpQBpY4PSnPte3Kdcfm+ZJywnZxbNHYMwtD3AdUuRhXNgA6GR64fC43QjzC53ZTMxcqBCrVHZYOZOZEpyAcQ2zSL1EXeY70N051vG2fg5N+4PIa1MCrdrJzG57WNUDh0TbOn59NbZ5a2XwA9aToCG4CRrZjMkWTvzBk3QoUbxhl+zAqnRYMVkNkr9OsPnhdwYjX5j5HxXzt4IP3dYfx2EVL6lXVOn74sWvY/L7k33gvuEjSpMxllG/c3Kk8AZv2b1ShOw==
X-MS-Exchange-AntiSpam-MessageData: cbsUxCqERyM3sN4tvma5pZmUG2gQZd5uX3Gc/CJXZ3AG14tn+PA+BGjyLnPONS47bxM8orih2D2iNjheF2B8KBfT9GKIUcWXZLGDF+/A7qmSjofjrQ/ybjHK3tuzlxbmU9PG8G2EiscQKvjWS7+GRA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441b5e7b-c543-4e52-b547-08d7d63f0c06
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 13:17:37.0817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOyiWdQiMeNutv0QiOPAfbQ+dopnendVWuHFWVKYR6KVtU0nasgtqzs107/+qMRSphYOZyMrodKqHFEFjbM2gEgi5/8NxbZHpRVmFSjjPeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7d00::706
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.04.2020 13:12, Denis Plotnikov wrote:
> The test checks fulfilling qcow2 requiriements for the compression
> type feature and zstd compression type operability.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   tests/qemu-iotests/287     | 159 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/287.out |  70 ++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 230 insertions(+)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out
> 
> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
> new file mode 100755
> index 0000000000..9925a2a14f
> --- /dev/null
> +++ b/tests/qemu-iotests/287
> @@ -0,0 +1,159 @@
> +#!/usr/bin/env bash
> +#
> +# Test case for an image using zstd compression
> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH
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
> +# creator
> +owner=dplotnikov@virtuozzo.com
> +
> +seq="$(basename $0)"
> +echo "QA output created by $seq"
> +
> +status=1	# failure is the default!
> +
> +_cleanup()
> +{
> +	_cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# standard environment
> +. ./common.rc
> +. ./common.filter
> +
> +# This tests qocw2-specific low-level functionality
> +_supported_fmt qcow2
> +_supported_proto file
> +_supported_os Linux
> +
> +# for all the cases
> +CLUSTER_SIZE=65536
> +
> +# Check if we can run this test.
> +if IMGOPTS='compression_type=zstd' _make_test_img 64M |
> +    grep "Invalid parameter 'zstd'"; then
> +    _notrun "ZSTD is disabled"
> +fi
> +
> +# Test: when compression is zlib the incompatible bit is unset
> +echo
> +echo "=== Testing compression type incompatible bit setting for zlib ==="
> +echo
> +
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +
> +# Test: when compression differs from zlib the incompatible bit is set
> +echo
> +echo "=== Testing compression type incompatible bit setting for zstd ==="
> +echo
> +
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +
> +# Test: an image can't be opened if compression type is zlib and
> +#       incompatible feature compression type is set
> +echo
> +echo "=== Testing zlib with incompatible bit set ==="
> +echo
> +
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
> +# to make sure the bit was actually set
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
> +if (($?==0)); then
> +    echo "Error: The image opened successfully. The image must not be opened"
> +fi
> +
> +# Test: an image can't be opened if compression type is NOT zlib and
> +#       incompatible feature compression type is UNSET
> +echo
> +echo "=== Testing zstd with incompatible bit unset ==="
> +echo
> +
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
> +# to make sure the bit was actually unset
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
> +if (($?==0)); then
> +    echo "Error: The image opened successfully. The image must not be opened"
> +fi
> +# Test: check compression type values
> +echo
> +echo "=== Testing compression type values ==="
> +echo
> +# zlib=0
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +od -j104 -N1 -An -vtu1 "$TEST_IMG"
> +
> +# zstd=1
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +od -j104 -N1 -An -vtu1 "$TEST_IMG"
> +
> +# Test: using zstd compression, write to and read from an image
> +echo
> +echo "=== Testing simple reading and writing with zstd ==="
> +echo
> +
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$QEMU_IO -c "write -c -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io
> +# read on the cluster boundaries
> +$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
> +
> +# Test: using zstd compression, write and verify three adjacent
> +#       compressed clusters
> +echo
> +echo "=== Testing adjacent clusters reading and writing with zstd ==="
> +echo
> +
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$QEMU_IO -c "write -c -P 0xAB 0 64k " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "write -c -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io

you may use "64k" notation both for offset and length

> +$QEMU_IO -c "write -c -P 0xAD 131072 64k " "$TEST_IMG" | _filter_qemu_io
> +
> +$QEMU_IO -c "read -P 0xAB 0 64k " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0xAD 131072 64k " "$TEST_IMG" | _filter_qemu_io
> +
> +# Test: create an image, write 1M likely uncompressible data from urandom,
> +#       write 1M of compressible data, convert the image with zstd
> +#       and compare these two images - their data should be identical
> +echo
> +echo "=== Testing incompressible cluster processing with zstd ==="
> +echo
> +
> +RAND_FILE="./287_rand_data"

you should use something like "$TEST_DIR/rand_data"


> +dd if=/dev/urandom of=$RAND_FILE bs=1M count=1

of="$RAND_FILE"

> +
> +IMGOPTS='' _make_test_img 64M

You don't need to clean IMGOPTS, it was not changed globally when you pass
it to previous commands.

> +# fill the image with likely incompressible and compressible clusters
> +$QEMU_IO -c "write -c -s $RAND_FILE 0 1M " "$TEST_IMG" | _filter_qemu_io

Hmm, I'm afraid -s is broken if RAND_FILE contains spaces. Should be fixed separately somehow.

> +$QEMU_IO -c "write -c -P 0xFA 1M 1M " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IMG convert -O $IMGFMT -c -o compression_type=zstd \
> +                  "$TEST_IMG" "$TEST_IMG".orig

Strange that target is called "$TEST_IMG".orig... Could we call it "$TEST_IMG".compressed ?

> +$QEMU_IMG compare "$TEST_IMG" "$TEST_IMG".orig
> +
> +rm -f $RAND_FILE
> +# success, all done
> +echo "*** done"
> +rm -f $seq.full
> +status=0
> diff --git a/tests/qemu-iotests/287.out b/tests/qemu-iotests/287.out
> new file mode 100644
> index 0000000000..3f47528b20
> --- /dev/null
> +++ b/tests/qemu-iotests/287.out
> @@ -0,0 +1,70 @@
> +QA output created by 287
> +
> +=== Testing compression type incompatible bit setting for zlib ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +incompatible_features     []
> +
> +=== Testing compression type incompatible bit setting for zstd ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +incompatible_features     [3]
> +
> +=== Testing zlib with incompatible bit set  ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +incompatible_features     [3]
> +
> +=== Testing zstd with incompatible bit unset  ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +incompatible_features     []
> +
> +=== Testing compression type values  ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +   0
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +   1
> +
> +=== Testing simple reading and writing with zstd ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +wrote 65536/65536 bytes at offset 65536
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 65536/65536 bytes at offset 65536
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +0001fffe:  ac ac 00 00 00 00 00 00  ........
> +read 8/8 bytes at offset 131070
> +8 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +0000fffe:  00 00 ac ac ac ac ac ac  ........
> +read 8/8 bytes at offset 65534
> +8 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=== Testing adjacent clusters reading and writing with zstd ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +wrote 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 65536
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 131072
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 65536/65536 bytes at offset 65536
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 65536/65536 bytes at offset 131072
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=== Testing incompressible cluster processing with zstd ===
> +
> +1+0 records in
> +1+0 records out
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +wrote 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Images are identical.
> +*** done
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 79c6dfc85d..dacbcfc12d 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -294,5 +294,6 @@
>   283 auto quick
>   284 rw
>   286 rw quick
> +287 auto quick
>   288 quick
>   289 rw quick
> 


-- 
Best regards,
Vladimir

