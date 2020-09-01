Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2BBC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 00:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47FA2083E
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 00:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P8WUTC8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47FA2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCuXG-0006fM-4Q
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 20:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1kCuW9-0005g6-Ju; Mon, 31 Aug 2020 20:51:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1kCuW7-0008Qt-Cp; Mon, 31 Aug 2020 20:51:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0810VivY162760; Mon, 31 Aug 2020 20:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=cCK3AmjVHxv98ABWp7KgHUgig3wbAYFOJan3OpjBB0U=;
 b=P8WUTC8qYbdBTvXSaXGTs2cud4Kt6dDc0IvjWnL4WRjsnGqrIq4KXuPyDGbdlOa4thsp
 n8D+vOIOBxbuxh8as9bLce6mS5ffCCDlr4nUJFMYc43YpuztnSzRTqGeXEKrVgFwUFV3
 AwXxrErWhena17JS40Yo0lU/tp1k4h+grZ53RV2JLssP1PADCLQpN+nptfMrRQ/FjMoG
 EMKOYPqme7Sqmz3DPOq69Xa7mq3f77Q/Sbklms3oz7aQ1Ja9wA2iFomOtkNsH7D10y78
 Wq56k5nW550LxdOW0X0EdE9wcj4o/1DPy5Bz8wh8Oi98m6JSCAGo5CG2ItyDC8P75i4U ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 339bkkrpwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 20:50:38 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0810WPoe165466;
 Mon, 31 Aug 2020 20:50:38 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 339bkkrpw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 20:50:37 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0810m7ZF019490;
 Tue, 1 Sep 2020 00:50:37 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02dal.us.ibm.com with ESMTP id 337en9h5nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2020 00:50:37 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0810oa9O47776010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2020 00:50:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46E1DAE060;
 Tue,  1 Sep 2020 00:50:36 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A75CAE05C;
 Tue,  1 Sep 2020 00:50:29 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.56.43])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue,  1 Sep 2020 00:50:28 +0000 (GMT)
References: <20200826055535.951207-1-bauerman@linux.ibm.com>
 <20200831065010.GB36360@yekko.fritz.box>
User-agent: mu4e 1.4.10; emacs 27.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v7 0/8] Generalize start-powered-off property from ARM
In-reply-to: <20200831065010.GB36360@yekko.fritz.box>
Date: Mon, 31 Aug 2020 21:50:25 -0300
Message-ID: <87mu2a2ucu.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-31_10:2020-08-31,
 2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310145
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 20:51:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9d?= =?utf-8?Q?ric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Gibson <david@gibson.dropbear.id.au> writes:

> On Wed, Aug 26, 2020 at 02:55:27AM -0300, Thiago Jung Bauermann wrote:
>> This version fixes `make check` failures in ppc/e500.c, mips/cps.c and
>> sparc/sun4m.c. This was done by moving the qdev_realize_and_unref() call as
>> close as possible to the object_new() call, in order to keep the CPU object
>> construction as similar as possible to the earlier version which used
>> cpu_create().
>> 
>> I also had to change the patch which removed the main_cpu_reset() function
>> from sparc/sun4m.c. It was causing a `make check` failure but I can't
>> really explain why. See this message for a few more details:
>> 
>> https://lists.nongnu.org/archive/html/qemu-ppc/2020-08/msg00419.html
>> 
>> I dropped the Reviewed-by's on the changed patches because of these
>> changes.
>> 
>> Original cover letter below, followed by changelog:
>> 
>> The ARM code has a start-powered-off property in ARMCPU, which is a
>> subclass of CPUState. This property causes arm_cpu_reset() to set
>> CPUState::halted to 1, signalling that the CPU should start in a halted
>> state. Other architectures also have code which aim to achieve the same
>> effect, but without using a property.
>> 
>> The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vcpu
>> before cs->halted is set to 1, causing the vcpu to run while it's still in
>> an unitialized state (more details in patch 3).
>> 
>> Peter Maydell mentioned the ARM start-powered-off property and
>> Eduardo Habkost suggested making it generic, so this patch series does
>> that, for all cases which I was able to find via grep in the code.
>> 
>> The only problem is that I was only able to test these changes on a ppc64le
>> pseries KVM guest, so except for patches 2 and 3, all others are only
>> build-tested. Also, my grasp of QOM lifecycle is basically non-existant so
>> please be aware of that when reviewing this series.
>> 
>> The last patch may be wrong, as pointed out by Eduardo, so I marked it as
>> RFC. It may make sense to drop it.
>
> Applied to ppc-for-5.2, thanks.

Thank you!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

