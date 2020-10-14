Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C438BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 09:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A7B20878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 09:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="frvN1FHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A7B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kScje-000890-KU
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 05:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kSciz-0007g5-Kr
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 05:05:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kScix-0004hc-65
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 05:05:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8wfal028841;
 Wed, 14 Oct 2020 09:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=CuAsrmY0fI+VqRINfjUFFTgbcU9i/SfkclQZ0YzbLzI=;
 b=frvN1FHu/3z6dsseQnR4AtOnojM0wJNQyn3hyY46huJDd4F3JFDMlWt/N2NEiTek1G82
 fbNE3ZlGQL2FYglVG2+r0noPw7lymqHpsCgmBAB3/DRiJosyxjGcVPDqA5+xnYscbSq3
 /6WhwxXFr0V1EpyAgoXYTxAPo+WRBg8P0dJJthkAL1RXm9MHKNmHHt2RxEz+PcGZ7YqZ
 +XjwfCktWKppGzoy9S8Liw0xQw0h8xXpBNct6u+o5uB5HJZOJjbCN+OejelhomOrIKtI
 //iDfv+KYD8eCZbaJHMK9gOjW/obbaHYKvc+47t05SwZ28+1iMNSeUQQc0aCiQ9/mK+C UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 3434wkpd3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Oct 2020 09:05:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E91Y9L099065;
 Wed, 14 Oct 2020 09:03:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 344by3b3cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2020 09:03:26 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09E93PpY010772;
 Wed, 14 Oct 2020 09:03:25 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 14 Oct 2020 02:03:24 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 249D71C0DDC8; Wed, 14 Oct 2020 10:03:18 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Dima Stepanov <dimastep@yandex-team.ru>, Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v1 1/2] fuzz: add virtio-blk fuzz target
In-Reply-To: <20201014073855.GA5872@dimastep-nix>
References: <cover.1602078083.git.dimastep@yandex-team.ru>
 <0b922b854ac4121dd8574c3e9cd36c562f7d0a3c.1602078083.git.dimastep@yandex-team.ru>
 <20201013153052.qzq6dhatcbpx33au@mozz.bu.edu>
 <20201014072931.GA5631@dimastep-nix> <20201014073855.GA5872@dimastep-nix>
Date: Wed, 14 Oct 2020 10:03:18 +0100
Message-ID: <m2o8l5mb6x.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=4 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=4 impostorscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140066
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 05:05:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dima,

On Wednesday, 2020-10-14 at 10:39:01 +03, Dima Stepanov wrote:
> On Wed, Oct 14, 2020 at 10:29:41AM +0300, Dima Stepanov wrote:
>> On Tue, Oct 13, 2020 at 11:30:52AM -0400, Alexander Bulekov wrote:
>> > On 201007 1647, Dima Stepanov wrote:
...

>> > 
>> > I sent a patch to disable QEMU's signal handlers for the fuzzer.
>> > Message-Id: <20201013152920.448335-1-alxndr@bu.edu>
> Sorry, i couldn't find a patch you've pointed out above. Could you share
> some link to it? Also, am i correct that it is a general change for the
> QEMU fuzzing, so all the fuzzing targets will automatically reuse it?
>

The patch Alex is referring to is:

- https://lore.kernel.org/qemu-devel/20201013152920.448335-1-alxndr@bu.edu/

Thanks,

Darren.


