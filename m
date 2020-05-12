Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6463DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E21420661
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g94IG5/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E21420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYRTZ-00066R-6l
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYRSe-0004l0-Bk; Tue, 12 May 2020 05:44:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYRSd-0000yn-Br; Tue, 12 May 2020 05:44:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C9evlU155753;
 Tue, 12 May 2020 09:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7kLLMvP/AFEUTQhJHL/nU0mgVMsDLJhjp76Fc+5gkC4=;
 b=g94IG5/hObl5CPFDE0uiP2YIie+QrCJA3vllOvc5ZCCItUAT4ocnDzb5EWkIptMJFXWq
 X1AjkLY2uioSKdWGT2xotQNNmK2Ybzw6tBYRxc3xvXgzaSTK90EJntNDTMPcpjc+FaEz
 x1wIIgNbovnJzfIgph8zO3gwVpobEUnkVR3KWG/XOKomEhYYLVYCcMIKUJ6K1ugEaECh
 h8sriWiFeXAVgtwvTwNLffsyCse//rcDjuqIKxkArXQvP1HYBm7V6xmJo9eKv4YoeVjS
 CqNX9XLtX9j/W20Xo7a2k3DLyt7HUcs7zB/9jV3k30LiaAVYWY00eJNKzcCO01s2Eqer yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 30x3gshypm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 09:44:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C9c9wD026007;
 Tue, 12 May 2020 09:44:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 30ydsq3sa2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 09:44:24 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04C9iNTF021893;
 Tue, 12 May 2020 09:44:24 GMT
Received: from Eyals-MacBook-Pro.local (/185.175.33.128)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 02:44:23 -0700
Subject: Re: [PATCH v2 2/5] qemu_img: add error report to cvtnum
To: Eric Blake <eblake@redhat.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
 <20200506213459.44743-3-eyal.moscovici@oracle.com>
 <b9274eb3-1e89-e9f7-d9fd-2f1c8b2e3387@redhat.com>
From: Eyal Moscovici <eyal.moscovici@oracle.com>
Message-ID: <a8ce4904-3c57-e5b0-25a6-857ac8753bed@oracle.com>
Date: Tue, 12 May 2020 12:44:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b9274eb3-1e89-e9f7-d9fd-2f1c8b2e3387@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 07/05/2020 0:59, Eric Blake wrote:
> On 5/6/20 4:34 PM, Eyal Moscovici wrote:
>> All calls to cvtnum check the return value and print the same error 
>> message more
>> or less. And so error reporting moved to cvtnum to reduce duplicate 
>> code and
>> provide a single error message.
>>
>> Acked-by: Mark Kanda <mark.kanda@oracle.com>
>> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
>> ---
>>   qemu-img.c                 | 63 ++++++++++++++++----------------------
>>   tests/qemu-iotests/049.out |  4 +--
>>   2 files changed, 28 insertions(+), 39 deletions(-)
>>
>
>>
>> -    err = qemu_strtosz(s, NULL, &value);
>> -    if (err < 0) {
>> +    err = qemu_strtosz(arg_value, NULL, &value);
>> +    if (err < 0 && err != -ERANGE) {
>> +        error_report("Invalid %s specified! You may use "
>> +                     "k, M, G, T, P or E suffixes for ", arg_name);
>> +        error_report("kilobytes, megabytes, gigabytes, terabytes, "
>> +                     "petabytes and exabytes.");
>>          return err;
>>      }
>> -    if (value > INT64_MAX) {
>> +    if (err == -ERANGE || value > INT64_MAX) {
>> +        error_report("Invalid %s specified! Must be less than 8 EiB!",
>
> Copied from our pre-existing errors, but why are we shouting at our 
> user?  This would be a good time to s/!/./ to tone it down a bit.
Sure, will fix.
>
>> @@ -4491,10 +4488,12 @@ static int img_dd_bs(const char *arg,
>>   {
>>       int64_t res;
>>   -    res = cvtnum(arg);
>> +    res = cvtnum("bs", arg);
>>   -    if (res <= 0) {
>> -        error_report("invalid number: '%s'", arg);
>> +    if (res < 0) {
>> +        return 1;
>> +    } else if (res == 0) {
>> +        error_report("Invalid bs specified! It cannot be 0.");
>
> Maybe it's worth two functions:
>
> int64_t cvtnum_full(const char *name, const char *value, int64_t min, 
> int64_t max)
>
> and then a common helper:
>
> int64_t cvtnum(const char *name, const char *value) {
>     return cvtnum_full(name, value, 0, INT64_MAX);
> }
>
> many existing callers remain with cvtnum(), but callers like this 
> could be cvtnum("bs", arg, 1, INT64_MAX).  You'd still have to 
> special-case other restrictions, such as whether a number must a 
> power-of-2, but that's fewer places.
>
Great idea, I will create two functions.
>> +++ b/tests/qemu-iotests/049.out
>> @@ -92,13 +92,13 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 
>> size=1649267441664 cluster_size=65536 l
>>   == 3. Invalid sizes ==
>>     qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
>> -qemu-img: Image size must be less than 8 EiB!
>> +qemu-img: Invalid image size specified! Must be less than 8 EiB!
>
> Nice that you checked for iotest fallout.  Is this really the only 
> impacted test?
>
Thanks, yes.

