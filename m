Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809A8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4402A2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="HtJxT231"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4402A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k590N-0001KZ-Fg
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 10:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k58zR-0000g1-3H; Mon, 10 Aug 2020 10:41:29 -0400
Received: from mail-am6eur05on2109.outbound.protection.outlook.com
 ([40.107.22.109]:3904 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k58zO-0001JX-5u; Mon, 10 Aug 2020 10:41:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHIURqIXEMOmrlHBmS3z+sraJugPvv0beKLDpY19CYDvnbnp+M6beVfo5FpkonLc9UTPGdo8iqd7PEbpolKpJ69kE9FzyhMob4aOEccsU5yEA4ewdVDW1tiDuftm++MSvx7mpkjeGvZ+74ATUZ10fgifoL79B4AQs4o7lFTF9F3GkE4wi4w1jFhqywOidRFKK+YdqrM8n+LXHnDlQyRPptQxn693JqlO04QG35aLhEIY6E/mAWApF4F5Qc60SJJzSghP6Q+y9vKXYcA1v61voRqYX3p/X0KwqJ+b+7nftEKUKqYnzgEykso+qfnOboDHkz2iZ0TAkXXy8KI+SkBWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8+CqCEUoCcxwaMldUzOlOGVqZ1ocufvuDS+6uExWr0=;
 b=L+n6RZmlTGJ3LdvN1Y+i2ooUFoJdsZRV0yNxqMFx/cG5Vec4zYTrGKTXnH6sTfVjXJLgQsIw34qSrFtmJXZAlyaOnGIaDKS5HFZ8G+CLFT0ys9JFt565qUbJAiwPGDH27Cb7IM+J+CQrNLfOUodnN2fDfHRJFjEGzcda6qYgI7cv8iHnQAaBuJ7xGfdLH/T8Y8Q2bduiSvF7HkuLpQpuzpHkfTDtX9ocK/HcEqMZzjQJWhHO1u/JZNSD8UrtbmnuUsko6rsfjswnJEsrDYDipje4HkKaGtpctIK9LQiQE9kbbX3Z3dhyN0M+OOGPyeDunqXlnUvFn+UR2nRNrn61hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8+CqCEUoCcxwaMldUzOlOGVqZ1ocufvuDS+6uExWr0=;
 b=HtJxT231xGn2lim8LytcxNyp/hfUnSUj32sqr64SVJ7T0m6NUWPtR4iTg2TYLP2D6obFzJ9mec+QIWC7bdStO8AW3fhGXV3otIS5Dxb8qse6IZ8dP6JxXeAQsd6TPd8yCK82DMXAYThvDGYe1U8M6bkRF1wmgpY/k+CR19rTIyA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3576.eurprd08.prod.outlook.com (2603:10a6:20b:4a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Mon, 10 Aug
 2020 14:41:23 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3261.022; Mon, 10 Aug 2020
 14:41:23 +0000
Subject: Re: [PATCH for 5.2 1/1] qemu-io: add -V flag for read sub-command
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200810123555.30481-1-den@openvz.org>
 <d87985bc-1f09-dcb7-3ed9-3d54a21c4da9@virtuozzo.com>
 <20200810144000.GE14538@linux.fritz.box>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <fadc1da4-e2e6-7b9f-89e5-c316384529bd@openvz.org>
Date: Mon, 10 Aug 2020 17:41:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200810144000.GE14538@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0401CA0112.eurprd04.prod.outlook.com
 (2603:10a6:7:54::41) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0401CA0112.eurprd04.prod.outlook.com (2603:10a6:7:54::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Mon, 10 Aug 2020 14:41:22 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 227f016f-11c7-4e01-f1b5-08d83d3b73d3
X-MS-TrafficTypeDiagnostic: AM6PR08MB3576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB35761CE9749F8CC90D8DE9C1B6440@AM6PR08MB3576.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p92HLJsg63ZTM2wujTrUbM59Ve8LaXuvzsb/dXO9RhYeAKkndOeGvQSIuvKqWrsvzLwXT8iijaEvyyMwk1PFGTH4OWGB5D8QpXIt1onZeKHlzfZzkhoR5qnaUzB1eOzo0ohZltDJ3TGwutHXbdktiAHEScVxdV/NrZJk1N3MnVuSdEwVam5nFzPbhzHxlLrESHKTyPmddWJuoV24cAtgyGteGWUMG2ZZdZF3VTitXJcPfTtbUjahElFt3VNR/m1W3JeOWGm/3I7m28MqNZiB2UmBI+nCPBv1oLyfQwTUNkcIa7Cy3o13XmOFPnIYfkoaCAJrSi5CaFxpwA18NLqE911xTNk34Qun5GTZOd6WICmk76qZ5a01Jsdqe+DWRvTn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39840400004)(396003)(136003)(53546011)(316002)(16576012)(110136005)(54906003)(5660300002)(52116002)(186003)(16526019)(26005)(6486002)(2906002)(31686004)(66946007)(66556008)(66476007)(36756003)(31696002)(956004)(2616005)(478600001)(42882007)(83380400001)(4326008)(8936002)(83170400001)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 85MwomAGcwXa5/KYEidFU1Wj0tZt8iH0dopI1EmnDDf50ijs50mNIhwQSmMFNyt6Iwpn7d2Ry2KgLYbeERvlH7L5s+/r3GBBuM9n2cyNlPEb7+QnHhSVQAiWSVCnHpo+9Q3udGbCkpv5zQoBlMP7mF9rb5332b10/Dd3IJqvnCtj1rLre++7AkcoVUJWOZaIF1au6Kv4Pe4wVwPHBciR5qyaM6sTn8LNFCHrhpggCD4DDMHomCvjq/wdhdkvhffO0+e0NPJg8KT3Ix8CdQl8/o79fNLl0O220oU4IILhjIVpFoTMft2KdNjDuwUBDH3QtvZKahlr/ICORzdIrDhp7imF8c+UskFuPTRuBQ8jyqyxs0Q0/kKjTSMOL4AOW4kuILxmnbl+UVlTIxYODlV4aivVBq7mAWbYTKV1DLx3fq+85IO8iG6LiYyjhWUO94kfksjqiTudRYQpeRxCgR7vgqukrvU4P5QL41XfW+yy7JOSSNk3ia46EdsR1mKwjJ3olhCEwhdRtnjueLuAg3YVUR6rmbPVT2IuDpkb7P9VINs5yZxnnUgkgRmmMO05zBsMuHNPmucUNDhuN/cNG1RqaH+Xs/9wjHp33rsuJqtQF9ZaObMnaJt6w8lHimGayHQcR44gTwZkGn/9K8o/5mCg+w==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 227f016f-11c7-4e01-f1b5-08d83d3b73d3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 14:41:22.9919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CvP5JAoUDFNiY+7uc80WSn0AykBm7F1kCNxycyPXUBkxyqno+y0LJtZxHtBYavrybT26srJKr+inBnzatAALQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3576
Received-SPF: pass client-ip=40.107.22.109; envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 10:41:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 5:40 PM, Kevin Wolf wrote:
> Am 10.08.2020 um 16:02 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 10.08.2020 15:35, Denis V. Lunev wrote:
>>> The problem this patch is trying to address is libguestfs behavior on the
>>> appliance startup. It starts supporting to use root=UUID definition in
>>> the kernel command line of its root filesystem using
>>>      file --  /usr/lib64/guestfs/appliance/root
>>> This works fine with RAW image, but we are using QCOW2 as a storage to
>>> save a bit of file space and in this case we get
>>>      QEMU QCOW Image (v3), 1610612736 bytes
>>> instead of UUID of the root filesystem.
>>>
>>> The solution is very simple - we should dump first 256k of the image file
>>> like the follows
>>>      qemu-io -c "read -V 0 256k" appliance | file -
>>> which will provide correct result for all possible types of the appliance
>>> storage.
>>>
>>> Unfortunately, additional option for qemu-io is the only and the simplest
>>> solution as '-v' creates very specific output, which requires to be
>>> parsed. 'qemu-img dd of=/dev/stdout' does not work and the fix would be
>>> much more intrusive.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Max Reitz <mreitz@redhat.com>
>>> CC: Richard W.M. Jones <rjones@redhat.com>
>>> ---
>>> P.S. Patch to libguestfs will follow.
>>>
>>>   qemu-io-cmds.c | 17 +++++++++++++----
>>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
>>> index baeae86d8c..7aae9726cd 100644
>>> --- a/qemu-io-cmds.c
>>> +++ b/qemu-io-cmds.c
>>> @@ -718,7 +718,7 @@ static const cmdinfo_t read_cmd = {
>>>       .cfunc      = read_f,
>>>       .argmin     = 2,
>>>       .argmax     = -1,
>>> -    .args       = "[-abCqv] [-P pattern [-s off] [-l len]] off len",
>>> +    .args       = "[-abCqvV] [-P pattern [-s off] [-l len]] off len",
>>>       .oneline    = "reads a number of bytes at a specified offset",
>>>       .help       = read_help,
>>>   };
>>> @@ -728,6 +728,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>>>       struct timespec t1, t2;
>>>       bool Cflag = false, qflag = false, vflag = false;
>>>       bool Pflag = false, sflag = false, lflag = false, bflag = false;
>>> +    bool vrawflag = true;
>>>       int c, cnt, ret;
>>>       char *buf;
>>>       int64_t offset;
>>> @@ -737,7 +738,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>>>       int pattern = 0;
>>>       int64_t pattern_offset = 0, pattern_count = 0;
>>> -    while ((c = getopt(argc, argv, "bCl:pP:qs:v")) != -1) {
>>> +    while ((c = getopt(argc, argv, "bCl:pP:qs:vV")) != -1) {
>>>           switch (c) {
>>>           case 'b':
>>>               bflag = true;
>>> @@ -777,6 +778,9 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>>>           case 'v':
>>>               vflag = true;
>>>               break;
>>> +        case 'V':
>>> +            vrawflag = true;
>>> +            break;
>>>           default:
>>>               qemuio_command_usage(&read_cmd);
>>>               return -EINVAL;
>>> @@ -869,10 +873,15 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>>>       if (vflag) {
>>>           dump_buffer(buf, offset, count);
>>>       }
>>> +    if (vrawflag) {
>>> +        write(STDOUT_FILENO, buf, count);
>>> +    }
>>>       /* Finally, report back -- -C gives a parsable format */
>>> -    t2 = tsub(t2, t1);
>>> -    print_report("read", &t2, offset, count, total, cnt, Cflag);
>>> +    if (!vrawflag) {
>>> +        t2 = tsub(t2, t1);
>>> +        print_report("read", &t2, offset, count, total, cnt, Cflag);
>>> +    }
>>>   out:
>>>       qemu_io_free(buf);
>>>
>> I think -v and -V should be mutually exclusive, as combined output doesn't make real sense.
>> Still, I'm OK with it as is (as well as with -V renamed to -r). I can suggest also -d (aka dump).
> I like -d (maybe with an alias --dump), though in the end the naming is
> secondary. I think having some flag like this is very useful.
>
> How about adding the same thing to write, i.e. get the buffer to write
> from stdin?

no prob, will do :)

Den

