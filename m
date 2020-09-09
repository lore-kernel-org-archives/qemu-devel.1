Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4751C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D2C2065E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S/5B/8ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D2C2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4ck-0001DN-J2
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kG4bh-0000IA-GR; Wed, 09 Sep 2020 14:14:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kG4bc-0003hY-4S; Wed, 09 Sep 2020 14:14:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 089I34FU067244; Wed, 9 Sep 2020 14:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wra71wmueWDeQSVxlGcBU+rZ35hwogg49QKdFEzB+9M=;
 b=S/5B/8ueM0ErCXZ4W48n3L9O+niCFvDgyO4eE9T01M/GMa4InHzO8PqR2DJcd4qEM9iC
 j+F8y3S98qF3oEv9ww1m+wGIqfJ42smcqmVJFTsY4JVs5IuNGbx6WDmr3dR4Wu8MtG/j
 kmX6Aq+QT3mZ217XPwkwhnrzGzsL0FLWp0MMKolTRKERNrL8wYN9rKY9YmCUcHJOemMo
 Mn2JAuPzPcq9DKykWdZnc2wYSVWF0LYDArr2RAb2Mmm0Nt3Ymet5T64txPD/Mos5tILO
 kYpKL0bHSBnhSkPoVCVVLQI0w+hgsl736UjQEmTxO60Ydl3VRrYED+hKRdYmp5DUwfL7 pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33f2x5u3cy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2020 14:14:00 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089I3MsN069057;
 Wed, 9 Sep 2020 14:14:00 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33f2x5u3c4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2020 14:14:00 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089ID9Ct023996;
 Wed, 9 Sep 2020 18:13:59 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03wdc.us.ibm.com with ESMTP id 33cebuws78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2020 18:13:59 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 089IDq8N40239466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2020 18:13:52 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A764B6E052;
 Wed,  9 Sep 2020 18:13:57 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 389A76E04C;
 Wed,  9 Sep 2020 18:13:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.156.134])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed,  9 Sep 2020 18:13:56 +0000 (GMT)
Subject: Re: [PATCH v4 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <b1d68acf-881f-be0f-c1ac-d32b8bfc859d@linux.ibm.com>
 <20200715180409.451d217e.cohuck@redhat.com>
 <d59bd0a5-0660-0c22-09dd-018be6dfe74f@linux.ibm.com>
 <20200716140214.3fdc7590.cohuck@redhat.com>
 <42dde86f-2f12-3b89-0c35-74d69fa3d449@de.ibm.com>
 <20200909104623.57664738.cohuck@redhat.com>
 <20200909114351.1f91f330.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <22005476-9a22-f3b1-4c92-fff9fbb2e11d@linux.ibm.com>
Date: Wed, 9 Sep 2020 14:13:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909114351.1f91f330.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-09_12:2020-09-09,
 2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090160
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:14:01
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, qemu-s390x@nongnu.org,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 5:43 AM, Cornelia Huck wrote:
> On Wed, 9 Sep 2020 10:46:23 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Wed, 9 Sep 2020 09:54:40 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 16.07.20 14:02, Cornelia Huck wrote:  
>>>> On Wed, 15 Jul 2020 12:26:20 -0400
>>>> Collin Walling <walling@linux.ibm.com> wrote:
>>>>     
>>>>> On 7/15/20 12:04 PM, Cornelia Huck wrote:    
>>>>>> On Wed, 15 Jul 2020 11:36:35 -0400
>>>>>> Collin Walling <walling@linux.ibm.com> wrote:
>>>>>>       
>>>>>>> Polite ping. Patches have been sitting on the list for a few weeks now,
>>>>>>> and it doesn't look like any further changes are requested (hopefully I
>>>>>>> didn't miss something).      
>>>>>>
>>>>>> The only thing I had was (I think) the logging of the length you just
>>>>>> replied to. We can still tweak things like that later, of course.
>>>>>>
>>>>>> As these patches depend on a headers sync, I could not yet queue them.
>>>>>> I can keep a preliminary version on a branch. I assume that the header
>>>>>> changes will go in during the next kernel merge window? (If I missed
>>>>>> something, apologies for that.)
>>>>>>       
>>>>>
>>>>> Gotcha. Thanks for the update :)
>>>>>
>>>>> There was an email on the KVM list a couple of days that made one change
>>>>> to the Linux header. Just changed the integer used for the DIAG cap,
>>>>> which should be reflected in QEMU as well.
>>>>>
>>>>> https://www.spinics.net/lists/kvm/msg220548.html
>>>>>
>>>>> Should I respin this patch series to include the new ack's and account
>>>>> for the header sync?    
>>>>
>>>> No need for that, my tooling picks up acks and the headers update needs
>>>> to be replaced with a sync against a proper Linux version anyway.
>>>>
>>>> I've queued the patches on a local branch, and the only patch that did
>>>> not apply cleanly was the headers patch, which will get replaced later
>>>> anyway :) Just ping me when the kernel patches hit upstream, then I'll
>>>> do a header sync against the next -rc and queue the patches on
>>>> s390-next.    
>>>
>>> What is the status of this patchset? The kernel part has been merged in 5.9-rc1.
>>>   
>>
>> Thanks for letting me know, I'll go and process this now. (Had some
>> busy weeks + PTO.)
> 
> There were some minor conflicts, please double check that everything
> looks sane.
> 
> Thanks, applied.
> 
> 

Has this been merged yet? There is one patch that I neglected to include
in this series (I didn't realize it until now) that properly sets the
SCCB size in QEMU based on the length provided by the kernel (right now,
these patches allocate a static 4K size for the SCCB struct, which
causes a segfault).

I can post my set with the fix as v5, or I can wait and post the fix as
a bandaid if the patches are already in.

-- 
Regards,
Collin

Stay safe and stay healthy

