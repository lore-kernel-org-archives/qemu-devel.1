Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E367FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 01:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8C820675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 01:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B5gCS0sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8C820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k622L-0001G4-TM
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 21:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k6214-0000Ie-1o; Wed, 12 Aug 2020 21:26:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k6211-00079R-K4; Wed, 12 Aug 2020 21:26:49 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07D13Jd3107345; Wed, 12 Aug 2020 21:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=XbBvcv/BXI/xo+sLNGOGnqDhDL7UZmcnZDoZ0JOdoY4=;
 b=B5gCS0sa17EFpNsm8SeOBauANEUe/H+LF0mCRsBEU2wzpH9g6nEHI0+P/kb17xZGv3kQ
 0y7nJ6FDUyNGg1Ko/9PpsDmXoerMg0+N20D/r9/jJzVVTM6XC45PoitwH5IKCxg1z33O
 zh0R35LKkwgPNxtsM6GquN1SdNgSE6bfmczQx9dUN+FxNfckWz6Ouvx8+xE9EG9olkS5
 VxgpXByAfltpUANGNx6s3EamMiEZ6M0IQtVhyIDn5WxS6Ws9MbPCMTPKmQvGNlCRZOfv
 bF4W2pkgg4hj/zqkSrtGxE41GHV3/R1gfnYNpcdMLU0/nlZda4Kn9pgabp4CWLqqnRbs fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32sratccjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2020 21:26:06 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07D13OCG107604;
 Wed, 12 Aug 2020 21:26:04 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32sratccj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2020 21:26:04 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07D1BIqt027671;
 Thu, 13 Aug 2020 01:26:03 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma02dal.us.ibm.com with ESMTP id 32skp9qpvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2020 01:26:03 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07D1PwVT21299708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2020 01:25:58 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 089BDC6061;
 Thu, 13 Aug 2020 01:26:02 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A3ABC6055;
 Thu, 13 Aug 2020 01:25:57 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.41.173])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 13 Aug 2020 01:25:56 +0000 (GMT)
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-9-bauerman@linux.ibm.com>
 <20200727144350.47abd7e7.cohuck@redhat.com>
 <87a6zjuoru.fsf@morokweng.localdomain>
 <20200730114541.4dbdd15e.cohuck@redhat.com>
 <20200811130434.7388cfa2.cohuck@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v3 8/8] target/s390x: Use start-powered-off CPUState
 property
In-reply-to: <20200811130434.7388cfa2.cohuck@redhat.com>
Date: Wed, 12 Aug 2020 22:25:54 -0300
Message-ID: <87a6yzxrod.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-12_19:2020-08-11,
 2020-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130006
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 21:26:43
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?utf-8?Q?Al?= =?utf-8?Q?ex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cornelia Huck <cohuck@redhat.com> writes:

> On Thu, 30 Jul 2020 11:45:41 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Tue, 28 Jul 2020 21:51:33 -0300
>> Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
>> 
>> > Hi,
>> > 
>> > Cornelia Huck <cohuck@redhat.com> writes:
>> >   
>> > > On Wed, 22 Jul 2020 23:56:57 -0300
>> > > Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
>> > >    
>> > >> Instead of setting CPUState::halted to 1 in s390_cpu_initfn(), use the
>> > >> start-powered-off property which makes cpu_common_reset() initialize it
>> > >> to 1 in common code.
>> > >> 
>> > >> Note that this changes behavior by setting cs->halted to 1 on reset, which
>> > >> didn't happen before.    
>> > >
>> > > I think that should be fine, as we change the cpu state to STOPPED in
>> > > the reset function, which sets halted to 1.    
>> > 
>> > Nice, thanks for checking.
>> >   
>> > >> 
>> > >> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> > >> ---
>> > >>  target/s390x/cpu.c | 2 +-
>> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >> 
>> > >> NB: I was only able to test that this patch builds. I wasn't able to
>> > >> run it.    
>> > >
>> > > No noticeable difference under kvm, but running under tcg seems a bit
>> > > more sluggish than usual, and I saw some pausing on reboot (after the
>> > > bios handover to the kernel). Not sure if it were just flukes on my
>> > > laptop, would appreciate if someone else could give it a go.    
>> 
>> Experimented a bit with it again. There's a pause when switching from
>> the bios to the kernel (after the load reset normal has been done, I
>> guess), which is always there, but seems to get more noticeable with
>> this patch (varying wildly, but seems longer on average.) Hard to pin
>> down, and I don't really see a reason why that should happen, as we
>> should end up with halted == 1 in any case. Might still be a fluke,
>> even though I see it both on my laptop and on an LPAR (when running
>> under tcg; not seen under kvm, which is much faster anyway.)
>
> Tried again, the pause now seems comparable to the pause prior to this
> series. Might depend on the phase of the moon.
>
> I ran kvm unit tests on it, and it looks good. So, I'm reasonable
> confident that this is fine, really just seems to be a fluke.
>
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Ah, that's a relief. Thank you very much for looking into this!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

