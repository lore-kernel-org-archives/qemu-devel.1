Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DF5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDD521973
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hUqU6asc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDD521973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmeS-0004GA-Eo
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kHmdm-0003cE-9z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:27:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kHmdk-0000CE-1Y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:27:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08EBHnSF159220
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Sd9TQ9564NhdT9yQWEkryyky8Hyth+60jLEpD78JT34=;
 b=hUqU6asc7jb2EN0Uyg2rhfBQuFvgNNmfn8seXv/75sUXsymHIG8s8izWpqxFR73/7urS
 nuDBZgAZZo/oUEfWLlgRu/JEHEu2+c9qK8FQeJxrCosK74J2HUkhQXaSUOT7EUXDCNV4
 dpKBNk741uz6B2FI5KlipKeg8Ix8aKbz1aYp22gth0uWsYwAx3pPW6CfJgUO7tq+hDMl
 qK1ODbaqYtA9LdZBbaeMj5nje08Gu51gRM9Qh/43B4T31NXW0/5fRYItppDQrSCjXeGe
 FA0kMpN8mwMnesRoPUexjT6XBg7wLdI9/PVAZa+N8uNuQIDITfpehjsRRv7QkoDmSyN0 sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33j7h3g68n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:27:18 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08EBJ86o162865
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:27:18 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33j7h3g67k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 07:27:17 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08EBN8Bj022791;
 Mon, 14 Sep 2020 11:27:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04fra.de.ibm.com with ESMTP id 33guvm10ax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 11:27:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08EBPdhU17891634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2020 11:25:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3AD04203F;
 Mon, 14 Sep 2020 11:27:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A17F742041;
 Mon, 14 Sep 2020 11:27:10 +0000 (GMT)
Received: from [9.65.222.171] (unknown [9.65.222.171])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2020 11:27:09 +0000 (GMT)
Subject: Re: [PATCH] checkpatch: Detect '%#' or '%0#' in printf-style format
 strings
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200914060109.69583-1-dovmurik@linux.vnet.ibm.com>
 <cc5a95d7-4efd-a3de-c1a2-0c77cb60c63a@redhat.com>
From: Dov Murik <dovmurik@linux.vnet.ibm.com>
Message-ID: <649cd6c5-7825-9373-4da0-7a28c3c97c8b@linux.vnet.ibm.com>
Date: Mon, 14 Sep 2020 14:27:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <cc5a95d7-4efd-a3de-c1a2-0c77cb60c63a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-14_02:2020-09-10,
 2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140086
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dovmurik@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 07:27:18
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 14/09/2020 9:55, Philippe Mathieu-Daudé wrote:
> +qemu-perl team
> 
> On 9/14/20 8:01 AM, Dov Murik wrote:
>> According to the coding style document, we should use literal '0x' prefix
>> instead of printf's '#' flag (which appears as '%#' or '%0#' in the format
>> string).  Add a checkpatch rule to enforce that.
>>
>> Note that checkpatch already had a similar rule for trace-events files.
>>
>> Example usage:
>>
>>    $ scripts/checkpatch.pl --file chardev/baum.c
>>    ...
>>    ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
>>    #366: FILE: chardev/baum.c:366:
>>    +            DPRINTF("Broken packet %#2x, tossing\n", req); \
>>    ...
>>    ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
>>    #472: FILE: chardev/baum.c:472:
>>    +        DPRINTF("unrecognized request %0#2x\n", req);
>>    ...
>>
>> Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
>> ---
>>   scripts/checkpatch.pl | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index bd3faa154c..6ec2a9f6a1 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2891,6 +2891,18 @@ sub process {
>>   			}
>>   		}
>>   
>> +# check for %# or %0# in printf-style format strings
>> +		while ($line =~ /(?:^|")([X\t]*)(?:"|$)/g) {
>> +			my $string = substr($rawline, $-[1], $+[1] - $-[1]);
>> +			$string =~ s/%%/__/g;
>> +			if ($string =~ /(?<!%)%0?#/) {
>> +				ERROR("Don't use '#' flag of printf format " .
>> +				      "('%#') in format strings, use '0x' " .
>> +				      "prefix instead\n" . $herecurr);
>> +				last;
>> +			}
>> +		}
>> +
>>   # QEMU specific tests
>>   		if ($rawline =~ /\b(?:Qemu|QEmu)\b/) {
>>   			ERROR("use QEMU instead of Qemu or QEmu\n" . $herecurr);
>>
> 
> Thank you for this patch!
> 
> What about folding it in the same block?
> 

That makes sense, except that 'last' statement which will escape the 
loop if one of the bad patterns is found.

Maybe we can just drop 'last' from both if-then blocks?  We'll get 
multiple alerts if bad patterns are used more than once in the same 
line, which sounds OK to me.


> -- >8 --
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2880,15 +2880,22 @@ sub process {
>                                  $herecurr);
>                  }
> 
> -# check for %L{u,d,i} in strings
> +# format strings checks
>                  my $string;
>                  while ($line =~ /(?:^|")([X\t]*)(?:"|$)/g) {
>                          $string = substr($rawline, $-[1], $+[1] - $-[1]);
>                          $string =~ s/%%/__/g;
> +                       # check for %L{u,d,i} in strings
>                          if ($string =~ /(?<!%)%L[udi]/) {
>                                  ERROR("\%Ld/%Lu are not-standard C, use
> %lld/%llu\n" . $herecurr);
>                                  last;
>                          }
> +                       if ($string =~ /(?<!%)%0?#/) {
> +                               ERROR("Don't use '#' flag of printf
> format " .
> +                                     "('%#') in format strings, use
> '0x' " .
> +                                     "prefix instead\n" . $herecurr);
> +                               last;
> +                       }
>                  }
> 
>   # QEMU specific tests
> ---
> 

