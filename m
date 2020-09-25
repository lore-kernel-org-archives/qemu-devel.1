Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B7C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31BD20936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kk5tHftR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31BD20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpq1-0002Hr-5R
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1kLphx-0003fc-8z; Fri, 25 Sep 2020 11:32:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1kLphs-0006dq-AV; Fri, 25 Sep 2020 11:32:24 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08PF2eqa160889; Fri, 25 Sep 2020 11:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=J48lAXbHx6sb22bQTk8g6r+Rb2iXuaXblEe1RyP/woA=;
 b=kk5tHftRC6Px3wtcDWvGMKVQpYNM++p95mEfJVh++7w7LwZvL97HU+XuBwaJnVmEzqfB
 QaifWu2uRoMXQF5gxzyynZLv7vL7S7C3u82sFeTKH6AjX1Xyau+f+pw5vRwjsKwo0Xju
 WPw3hVnP+Uvto4aLkaN760cEv9u4g06IlIBqbNKbE4iyfxPQzqJ37u1rrmeBiyyTu2Wm
 urjsLgtji0LhMfMPba/PnX+fNYqnNSdsElYbVK4N6K3cPnH7zJ5QfsuPwLvelmNHBHBg
 2t0KlmyeCRTFrE/Sw3LagEvtKVKN2px1pvXahSeKECDqJyMHtgYRag1ieIypFQ5oQwky Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33sfwy70ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 11:32:13 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08PF3BVv163020;
 Fri, 25 Sep 2020 11:32:13 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33sfwy70ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 11:32:13 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08PFJjuE018892;
 Fri, 25 Sep 2020 15:32:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma01fra.de.ibm.com with ESMTP id 33n9m7ubcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 15:32:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08PFW7wf31195448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2020 15:32:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD5A811C04C;
 Fri, 25 Sep 2020 15:32:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19E9011C050;
 Fri, 25 Sep 2020 15:32:07 +0000 (GMT)
Received: from ibm-vm (unknown [9.145.11.83])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2020 15:32:07 +0000 (GMT)
Date: Fri, 25 Sep 2020 17:32:05 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Message-ID: <20200925173205.288d877b@ibm-vm>
In-Reply-To: <20200925171855.670bd93a.cohuck@redhat.com>
References: <20200915194416.107460-1-walling@linux.ibm.com>
 <20200916175300.5c2b6bbb.cohuck@redhat.com>
 <3f4c28d6-fe5f-2e52-2e51-3190621ea63d@linux.ibm.com>
 <82f7c31c-16f6-8450-d241-ca8257db6469@linux.ibm.com>
 <20200925171855.670bd93a.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-25_12:2020-09-24,
 2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250108
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 10:10:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: Collin Walling <walling@linux.ibm.com>, frankja@linux.ibm.com,
 mst@redhat.com, david@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, thuth@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Sep 2020 17:18:55 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 25 Sep 2020 11:13:49 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
> > On 9/16/20 1:15 PM, Collin Walling wrote:  
> > > On 9/16/20 11:53 AM, Cornelia Huck wrote:
> > > 
> > > [...]
> > >     
> > >>>    
> > >>
> > >> Thanks, applied.
> > >>
> > >>    
> > > 
> > > Thanks Conny.
> > > 
> > > Much appreciated for everyone's patience and review. The only
> > > thing I'd like to hold out on for now is for someone to take a
> > > peek at patch #3 with respect to the protected virtualization
> > > stuff. I don't know too much about it, honestly, and I want to
> > > ensure that dynamically allocating memory for the SCCB makes
> > > sense there. The alternative would be to allocate a static 4K for
> > > the work_sccb. 
> > 
> > I had someone take a look at the patch for PV and was told
> > everything looks sane. Since the patches have already been applied,
> > it seems like it's too late to add a reviewed-by from someone?  
> 
> Have the reviewer reply with their R-b, and I'll happily add it, as I
> rebase s390-next before doing a pull req anyway :)

well it was me :)

you can add a 

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

for the first 6 patches, and an

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

for the last one


thanks!


