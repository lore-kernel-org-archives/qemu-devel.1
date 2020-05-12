Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1529C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B1420661
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qsq9aiTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B1420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYRXc-0000FH-K5
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYRWS-000861-0r; Tue, 12 May 2020 05:48:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYRWQ-0003cI-W0; Tue, 12 May 2020 05:48:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C9ev5s155850;
 Tue, 12 May 2020 09:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AECQ/f7glkG2PIr+RcUzuWbqfc7fWwtgJbhBluBsSeU=;
 b=qsq9aiTq8cmAJv+3xVVvUk6sjUVAbYe4w4N1r7/fkQRTgNUSqRd1HJdl6ognYcLRvZUT
 myQwaj7Fv8sfQJn/K8bT4F7oGok7udiptybGxlQ+466T9rYXoYLYLgdU1VoqYhkB/ALF
 VqtFxJsqi632yXMkoTlCHC33NEATlwYiR7lTI6oZo3lduO9PnAJbUk37Ed619II9bU5m
 otNNO5DXrDuX1tll+fyEza0hkkkOAeqDaKOh+/ZUFjxZk/9vsoQdwMMAPyHRjHc4ilRt
 XN6I1bo1ZswXL4EzxcAepTX34vKis9wU0l0lSbLV5uyLip03kiJpZLmKbb3Ie1awlPu0 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 30x3gsj05x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 09:48:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C9c990025997;
 Tue, 12 May 2020 09:48:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 30ydsq3y6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 09:48:19 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04C9mIlr021986;
 Tue, 12 May 2020 09:48:18 GMT
Received: from Eyals-MacBook-Pro.local (/185.175.33.128)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 02:48:18 -0700
Subject: Re: [PATCH v2 5/5] qemu-img: Add --start-offset and --max-length to
 map
To: Eric Blake <eblake@redhat.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
 <20200506213459.44743-6-eyal.moscovici@oracle.com>
 <0a3bc115-ea14-4723-2993-6a6c9de12208@redhat.com>
From: Eyal Moscovici <eyal.moscovici@oracle.com>
Message-ID: <582a5db0-1ca8-e464-5e0b-d7de21d19af8@oracle.com>
Date: Tue, 12 May 2020 12:48:13 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0a3bc115-ea14-4723-2993-6a6c9de12208@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120077
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=eyal.moscovici@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 03:59:36
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, liran.alon@oracle.com,
 Yoav Elnekave <yoav.elnekave@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 07/05/2020 1:04, Eric Blake wrote:
> On 5/6/20 4:34 PM, Eyal Moscovici wrote:
>> The mapping operation of large disks especially ones stored over a
>> long chain of QCOW2 files can take a long time to finish.
>> Additionally when mapping fails there was no way recover by
>> restarting the mapping from the failed location.
>>
>> The new options, --start-offset and --max-length allows the user to
>> divide these type of map operations into shorter independent tasks.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> This patch has some changes from v1.  Among others,...
>
>> @@ -3041,6 +3045,18 @@ static int img_map(int argc, char **argv)
>>           case OPTION_OUTPUT:
>>               output = optarg;
>>               break;
>> +        case 's':
>> +            start_offset = cvtnum("start offset", optarg);
>> +            if (start_offset < 0) {
>> +                return 1;
>> +            }
>> +            break;
>
> the new semantics of cvtnum() in this series is enough of a difference 
> that I would have removed R-b to make sure the updated patch gets 
> re-reviewed, if it had been me as author.  But in this case, it does 
> look like the changes are all addressed to comments I suggested in v1, 
> so I'm fine that you left my R-b.
>
Ok, got it.

