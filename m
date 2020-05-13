Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9A3205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tkYGminI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9A3205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYwRb-0005bx-Bd
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYwQk-0003HY-J9; Wed, 13 May 2020 14:48:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYwQj-0000Fo-9M; Wed, 13 May 2020 14:48:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DImOmE151438;
 Wed, 13 May 2020 18:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=bseVZC0gfhxNuRugPIefHezkwy2bQUdPiKxdUPyR0zg=;
 b=tkYGminIk6qwYhGlxnWsNpp6Oy0q0+xXFg6whfBMhM1SB+MZyiL0zNWCC/Ze1BXRRz1L
 F70k4oPf6AS7JedcCvVPmInwBN0dxqG9qxfBHw0/X+qmglFwm73dHVUBxIisoqlVGM4U
 6jpEeiUTrawdtawgz4XvULfL1hWd8FNFD+zBLj4itT4tC90P4p5Cb12/2ytAvwFVwKOz
 QecMOl8hT2/PxMb35z0UbZ3NpS6S5KkKFgr5b3rHQaQJEIBBejyp78yXRdPXgDyHMDDt
 1Yi0NJgasHpQpkFA0Xui469P74awX0tv1C8/aw8PNG8sx153Ck22HOvyHrjt2QgzEZBA Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 3100yfx1we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 May 2020 18:48:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DIi2Ax129585;
 Wed, 13 May 2020 18:46:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 3100yf4hv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 18:46:30 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04DIkTZr007126;
 Wed, 13 May 2020 18:46:29 GMT
Received: from Eyals-MacBook-Pro.local (/10.74.123.68)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 May 2020 11:46:29 -0700
Subject: Re: [PATCH v3 0/4] Additional parameters for qemu_img map
To: Eric Blake <eblake@redhat.com>
References: <20200513133629.18508-1-eyal.moscovici@oracle.com>
 <3a55d6a6-ce3c-6eb4-fddf-baab00be4f11@redhat.com>
From: Eyal Moscovici <eyal.moscovici@oracle.com>
Message-ID: <9e54171e-961c-66cd-a720-593a7875fb44@oracle.com>
Date: Wed, 13 May 2020 21:46:26 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3a55d6a6-ce3c-6eb4-fddf-baab00be4f11@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130160
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=eyal.moscovici@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 14:48:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 13/05/2020 20:49, Eric Blake wrote:
> On 5/13/20 8:36 AM, Eyal Moscovici wrote:
>> Hi,
>>
>> The following series adds two parameters to qemu-img map:
>> 1. start-offset: mapping starting offset.
>> 2. max-length: the length of the mapping.
>>
>> These parameters proved useful when mapping large disk spread across
>> long store file chains. It allows us to bound the execution time of each
>> qemu-img map execution as well as recover from failed mapping
>> operations. In addition the map operation can divided to
>> multiple independent tasks.
>>
>> V3 changes:
>> 1. Add cvtnum_full and made cvtnum a wrapper function.
>> 2. Keep the original boundaries checks.
>> 3. Tone down error messages.
>
> While this does not directly touch NBD code, I find it quite handy for 
> my tests of incremental backups over NBD (since I frequently use 
> x-dirty-bitmap coupled with qemu-img map to read bitmaps, and 
> subsetting the output is indeed nice), so I'll queue this through my 
> NBD tree.  It may be another week or so before I send a pull request 
> including this and other collected patches.
>
> Congratulations on your first qemu contribution!
Thanks :)
>
>>  qemu-img.c                 | 76 +++++++++++++++++---------------------
>>  tests/qemu-iotests/049.out |  8 ++--
>>  2 files changed, 38 insertions(+), 46 deletions(-)
>
> This series diffstat is off; later in the series, in 4/4, I see:
I had some copy & paste issues with my cover letter, sorry.
>
>>  docs/tools/qemu-img.rst |  2 +-
>>  qemu-img-cmds.hx        |  4 ++--
>>  qemu-img.c              | 22 +++++++++++++++++++++-
>>  3 files changed, 24 insertions(+), 4 deletions(-)
>
> What I don't see is any iotest coverage of the new options, to ensure 
> they don't regress.  Either a new iotest, or an enhancement to an 
> existing iotest.  If you feel up to the task, post a 5/4 patch; if 
> not, I'll probably enhance 223 (my x-dirty-bitmap reading code 
> mentioned above).
>
I will take a look at test 223, and see if I can enhance it.

