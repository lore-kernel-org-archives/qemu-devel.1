Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1241C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD18A20797
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fOH62LzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD18A20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0JZ-0005XO-T1
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1kS0Fo-0000dg-No
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:00:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1kS0Fl-000290-7Y
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:00:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09CFhYQw070607; Mon, 12 Oct 2020 12:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=dlevNp7prWjoPz1wdzKzVm8+WIOdAlEU5ieXCTTS+Es=;
 b=fOH62LzGEekIwVg7c0dUGtDeI8FG3xoAj4fElBXySBkNnJy7V1mh0mVmjm/D1FZu75lJ
 WqylpcqdDdZ9hfNG0AnCGMav5EBMLFptfmg2GEUsLaBNtd9Fcp9pNZCOkrjyyhcj5qsf
 N2WzbUZl02yVQEL74E0FzuiORb7/tRtRuBnYFAaEue53DbfUEl5kxOJdSBVhRU42vus6
 bDhzq4jfdzrpDbs2sikj7jRZGQ6IdlXgAso0deNuxGli5IYP31JBkJSS7uaTK/FnnVhk
 c4VzVYKpkCGNfvyTxW/nQliEbdt5oIuAwJior+QRtnLL1VF1ELx5rj+4PNx7e5JZF2Lh Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 344t1mghpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2020 12:00:43 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09CFkGRQ091376;
 Mon, 12 Oct 2020 12:00:42 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 344t1mghp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2020 12:00:42 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CFllAj028008;
 Mon, 12 Oct 2020 16:00:41 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 3434k8d14q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2020 16:00:41 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09CG0Z9g32702972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2020 16:00:35 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4457578064;
 Mon, 12 Oct 2020 16:00:40 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD2617806D;
 Mon, 12 Oct 2020 16:00:38 +0000 (GMT)
Received: from jarvis (unknown [9.85.148.2])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 12 Oct 2020 16:00:38 +0000 (GMT)
Message-ID: <b6137b4997b0729e576bc6c0c5476960d1992115.camel@linux.ibm.com>
Subject: Re: [PATCH v3] SEV: QMP support for Inject-Launch-Secret
From: James Bottomley <jejb@linux.ibm.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Tobin Feldman-Fitzthum
 <tobin@linux.ibm.com>
Date: Mon, 12 Oct 2020 09:00:37 -0700
In-Reply-To: <20201012155718.GH6677@work-vm>
References: <20200706215451.59179-1-tobin@linux.vnet.ibm.com>
 <20200921190800.GA32491@work-vm>
 <b7faab72e909b709797e6098ec894c72@linux.vnet.ibm.com>
 <20201012155718.GH6677@work-vm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-12_12:2020-10-12,
 2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120124
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jejb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 12:00:45
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
Reply-To: jejb@linux.ibm.com
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, tobin@ibm.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-10-12 at 16:57 +0100, Dr. David Alan Gilbert wrote:
> * Tobin Feldman-Fitzthum (tobin@linux.ibm.com) wrote:
> > On 2020-09-21 15:16, Dr. David Alan Gilbert wrote:
> > > * Tobin Feldman-Fitzthum (tobin@linux.vnet.ibm.com) wrote:
> > > > AMD SEV allows a guest owner to inject a secret blob
> > > > into the memory of a virtual machine. The secret is
> > > > encrypted with the SEV Transport Encryption Key and
> > > > integrity is guaranteed with the Transport Integrity
> > > > Key. Although QEMU faciliates the injection of the
> > > > launch secret, it cannot access the secret.
> > > > 
> > > > Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com
> > > > >
> > > 
> > > Hi Tobin,
> > >   Did the ovmf stuff for agreeing the GUID for automating this
> > > ever happen?
> > > 
> > OVMF patches have not been upstreamed yet. I think we are planning
> > to do that relatively soon.
> 
> So as we're getting to the end of another qemu dev cycle; do we aim
> to get this one in by itself, or to wait for the GUID?

Since they're independent of each other, I'd say get this one in now if
it's acceptable.  The GUID will come as a discoverable way of setting
the GPA, but this patch at least gives people a way to play with SEV
secret injection.  I'm also reworking the OVMF GUID patch to tack on to
the reset vector GUID that just went upstream, so it will be a few more
weeks yet before we have it all integrated with the -ES patch set.

James



