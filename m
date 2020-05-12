Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47598C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55B0206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kns6lTpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55B0206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYRQo-0001hi-Lf
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYRPr-0000zX-CY; Tue, 12 May 2020 05:41:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYRPp-0008GD-7F; Tue, 12 May 2020 05:41:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C9bGVO107876;
 Tue, 12 May 2020 09:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SvtLmUFs13c0BvIFJUmcctSnaAHFt2A7i2QzW/pM3VI=;
 b=kns6lTpiqYQvcRAsJtYd2GD49KLbEdv+qmIVQkFQ4Bgg5ZmMcaQ2nhO7iM3Bp+0k58un
 r/a59yjl4xJZ4hEitKc68Y1V0M1VKVfhyl/4BrfWvEJCMBOAInccP2GahIepCubgbxp/
 RrTuNtcL/luplBc4bN05vbeN23vP7Nhcp+NjNCw2pzDfgk4oyltsmCXPpo4XcQu0eglm
 /R0P9oxhzptVWg7FbSx5uSUZkPDgK43Iu4sXS15Rouhm4Fhmc6B7oOruEEjtFs8Wo7Ya
 K+Af2ZfAwwR/t3fnQkXgVnSEgb/xoHPZaBEIxgZOHIXnyDSPFWiFgQWYkN31ciishtPf qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 30x3mbsy49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 09:41:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C9caOs068993;
 Tue, 12 May 2020 09:39:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 30x69supa7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 09:39:23 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04C9dMnN015432;
 Tue, 12 May 2020 09:39:22 GMT
Received: from Eyals-MacBook-Pro.local (/185.175.33.128)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 02:39:22 -0700
Subject: Re: [PATCH v2 1/5] qemu-img: remove check that cvtnum value > MAX_INT
To: Eric Blake <eblake@redhat.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
 <20200506213459.44743-2-eyal.moscovici@oracle.com>
 <f4131818-f606-2b30-ef69-d9612fb66a80@redhat.com>
From: Eyal Moscovici <eyal.moscovici@oracle.com>
Message-ID: <d136e935-d8af-1710-c1c4-5bc6bc3b9303@oracle.com>
Date: Tue, 12 May 2020 12:39:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f4131818-f606-2b30-ef69-d9612fb66a80@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120077
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=eyal.moscovici@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 05:41:24
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


On 07/05/2020 0:49, Eric Blake wrote:
> On 5/6/20 4:34 PM, Eyal Moscovici wrote:
>> Following commit f46bfdbfc8f95cf65d7818ef68a801e063c40332 
>> (util/cutils: Change
>> qemu_strtosz*() from int64_t to uint64_t) which added a similar check to
>> cvtnum. As a result there is no need to check it separately outside 
>> of cvtnum.
>>
>> Acked-by: Mark Kanda <mark.kanda@oracle.com>
>> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
>> ---
>>   qemu-img.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 6a4327aaba..116a9c6349 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -4307,7 +4307,7 @@ static int img_bench(int argc, char **argv)
>>               int64_t sval;
>>                 sval = cvtnum(optarg);
>> -            if (sval < 0 || sval > INT_MAX) {
>> +            if (sval < 0) {
>>                   error_report("Invalid buffer size specified");
>
> INT_MAX is smaller than cvtnum's check for INT64_MAX.  This code 
> change allows larger buffer sizes, which is probably not a good idea.
I was the most hesitant about this patch because of the size difference. 
I decided to submit it because the type is int64 which pairs better with 
the MAX_INT64 check and I couldn't find a concrete reason to cap the 
variable at MAX_INT. Do you a concrete reason? Because the max size 
should rerally come into effect on very fringe cases and if you are 
asking for a really big buffer you should know the risks.
>
>>                   return 1;
>>               }
>> @@ -4320,7 +4320,7 @@ static int img_bench(int argc, char **argv)
>>               int64_t sval;
>>                 sval = cvtnum(optarg);
>> -            if (sval < 0 || sval > INT_MAX) {
>> +            if (sval < 0) {
>>                   error_report("Invalid step size specified");
>>                   return 1;
>>               }
>> @@ -4493,7 +4493,7 @@ static int img_dd_bs(const char *arg,
>>         res = cvtnum(arg);
>>   -    if (res <= 0 || res > INT_MAX) {
>> +    if (res <= 0) {
>>           error_report("invalid number: '%s'", arg);
>>           return 1;
>>       }
>>
>
> NACK.
>

