Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387E2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B05A2065E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B05A2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0W8G-0001pL-Ag
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 16:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1k0W7E-0000kU-3Z; Tue, 28 Jul 2020 16:22:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1k0W7B-00040C-TY; Tue, 28 Jul 2020 16:22:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06SK1wNA128987; Tue, 28 Jul 2020 16:22:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32jqs95r1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 16:22:18 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06SK91AR158876;
 Tue, 28 Jul 2020 16:22:18 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32jqs95r0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 16:22:18 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SKMFCX010188;
 Tue, 28 Jul 2020 20:22:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06fra.de.ibm.com with ESMTP id 32jgvprjye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 20:22:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 06SKKmoI52887840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2020 20:20:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62CE6A4057;
 Tue, 28 Jul 2020 20:22:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06E66A4040;
 Tue, 28 Jul 2020 20:22:13 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.179.56])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jul 2020 20:22:12 +0000 (GMT)
Date: Tue, 28 Jul 2020 22:22:11 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 2/2] s390x/s390-virtio-ccw: fix loadparm property getter
Message-ID: <20200728222211.518e8fdb.pasic@linux.ibm.com>
In-Reply-To: <20200728171438.2c3eb4fb.cohuck@redhat.com>
References: <20200727140522.251815-1-cohuck@redhat.com>
 <20200727140522.251815-3-cohuck@redhat.com>
 <CAFEAcA_1xECE+ESWoioHFSF_mwDG11NrR2=J3NWx2X+OGg3SZw@mail.gmail.com>
 <20200728171438.2c3eb4fb.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-28_16:2020-07-28,
 2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280139
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 16:22:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 17:14:38 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 28 Jul 2020 14:52:36 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On Mon, 27 Jul 2020 at 15:05, Cornelia Huck <cohuck@redhat.com> wrote:
> > >
> > > From: Halil Pasic <pasic@linux.ibm.com>
> > >
> > > The function machine_get_loadparm() is supposed to produce a C-string,
> > > that is a NUL-terminated one, but it does not. ElectricFence can detect
> > > this problem if the loadparm machine property is used.
> > >
> > > Let us make the returned string a NUL-terminated one.
> > >
> > > Fixes: 7104bae9de ("hw/s390x: provide loadparm property for the machine")
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > > Message-Id: <20200723162717.88485-1-pasic@linux.ibm.com>
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > >  hw/s390x/s390-virtio-ccw.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > > index 8cc2f25d8a6a..403d30e13bca 100644
> > > --- a/hw/s390x/s390-virtio-ccw.c
> > > +++ b/hw/s390x/s390-virtio-ccw.c
> > > @@ -701,8 +701,12 @@ bool hpage_1m_allowed(void)
> > >  static char *machine_get_loadparm(Object *obj, Error **errp)
> > >  {
> > >      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> > > +    char *loadparm_str;
> > >
> > > -    return g_memdup(ms->loadparm, sizeof(ms->loadparm));
> > > +    /* make a NUL-terminated string */
> > > +    loadparm_str = g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1);
> > > +    loadparm_str[sizeof(ms->loadparm)] = 0;
> > > +    return loadparm_str;  
> > 
> > Hi. Coverity points out (CID 1431058) that this code now
> > reads off the end of the ms->loadparm buffer, because
> > g_memdup() is going to read and copy 9 bytes (size + 1)
> > and the array itself is only 8 bytes.
> > 
> > I don't think you can use g_memdup() here -- you need to
> > allocate the memory with g_malloc() and then fill it with
> > memcpy(), something like:
> > 
> >     loadparm_str = g_malloc(sizeof(ms->loadparm) + 1);
> >     memcpy(loadparm_str, ms->loadparm, sizeof(ms->loadparm));
> >     loadparm_str[sizeof(ms->loadparm)] = 0;
> 
> Sigh.
> 
> Halil, do you have time to cook up a patch?
> 
> 

Will do!

Halil


