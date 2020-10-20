Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BD1C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 21:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A1522244
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 21:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fh4jiw1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A1522244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUzMA-0002re-52
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 17:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.ibm.com>)
 id 1kUzKk-0002QX-Id
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 17:38:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.ibm.com>)
 id 1kUzKi-0007TZ-0M
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 17:38:18 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09KLWwXY054802; Tue, 20 Oct 2020 17:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version :
 content-type : content-transfer-encoding : date : from : to : cc : subject
 : in-reply-to : references : message-id; s=pp1;
 bh=i0PnR+F0kwJanYLavo+Y6fZ1vWPX4WFyyqb/awbHcLc=;
 b=Fh4jiw1TEE1pZ2046IhfsJusz5gYA7+cLIWDAldNDuml1lEqUj2COTr8k24CwTFyNMup
 8Gechi4BCf0NNLI3GHfD4goZc1ewhrpmRxdsSgaeClWbgGAZIf6zDXmapujXh0y5Far3
 Mphu9f/Ufh62xpZLV4Y/ou8osrCHTin1RtEWKXmdD2iBCLHZcc3xA/9MW50uLPey8kyU
 hMbGL+vICcTDM3qEnmj/03ot+zpBx/EV6jKIQg9BNa2NxRzVUw6tofDV5vX7BmNSvT/p
 +oLDEUtZjQS/XkOKEHbFnLFEfU0j/65adzViAsPnAM05qLxgTmABR1VoXuI+9aENpETI VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34a79y94hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2020 17:38:09 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09KLXkCv056925;
 Tue, 20 Oct 2020 17:38:08 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34a79y94he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2020 17:38:08 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09KLW2LX009148;
 Tue, 20 Oct 2020 21:33:07 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 347r899uuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2020 21:33:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09KLX1nm29295298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Oct 2020 21:33:01 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1453F7805E;
 Tue, 20 Oct 2020 21:33:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 980E678060;
 Tue, 20 Oct 2020 21:33:05 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 20 Oct 2020 21:33:05 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Oct 2020 17:33:05 -0400
From: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5] sev: add sev-inject-launch-secret
In-Reply-To: <e4bc6348-cda5-e7f5-3753-61f4d3ba0116@redhat.com>
References: <20201015143713.14682-1-tobin@linux.ibm.com>
 <2f1be055-58c8-dcf8-debc-8956636d8ef8@redhat.com>
 <20201020135444.GR5733@habkost.net>
 <e4bc6348-cda5-e7f5-3753-61f4d3ba0116@redhat.com>
Message-ID: <dd1b07f9d596432ee5d4ebd740a98c5d@linux.vnet.ibm.com>
X-Sender: tobin@linux.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-20_12:2020-10-20,
 2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010200146
Received-SPF: pass client-ip=148.163.156.1; envelope-from=tobin@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 17:38:11
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com,
 Eduardo Habkost <ehabkost@redhat.com>, jejb@linux.ibm.com, tobin@ibm.com,
 dgilbert@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-10-20 11:56, Paolo Bonzini wrote:
> On 20/10/20 15:54, Eduardo Habkost wrote:
>> On Tue, Oct 20, 2020 at 11:03:51AM +0200, Paolo Bonzini wrote:
>>> On 15/10/20 16:37, tobin@linux.ibm.com wrote:
>>>> -static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error 
>>>> **errp)
>>>> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, 
>>>> Error **errp)
>>>>  {
>>>>      MemoryRegionSection mrs = 
>>>> memory_region_find(get_system_memory(),
>>>> -                                                 addr, 1);
>>>> +                                                 addr, size);
>>> 
>>> You need to check size against mrs.size and fail if mrs.size is 
>>> smaller.
>>>  Otherwise, the ioctl can access memory out of range.
>> 
>> Good catch!  I'm dequeuing it.
>> 
>> Is there a reason memory_region_find() doesn't ensure that by
>> default?
> 
> IIRC memory_region_find() was used to do DMA in the very first versions
> of "virtio-blk dataplane" so you would call it multiple times in a 
> loop.
>  So it's like that because it maps the way address_space_map() works.
> 
>> The call at virtio_balloon_handle_output() looks suspicious,
>> though, because it looks for a BALLOON_PAGE_SIZE range, but
>> there's no check for the returned section size.
> 
> I think it's not a bug because ultimately it's checked in
> ram_block_discard_range, but it's not pretty.
> 
> Paolo

Ok, it seems like the best solution is, as Paolo suggested, to add a
simple check at the end of gpa2hva that makes sure mr.size is equal
to size. gpa2hva is used one other place where the size is hard-coded
as 1, so adding the check isn't going to break anything.

Would you like me to resubmit with this tweak?

-Tobin

