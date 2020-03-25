Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1098EC54FD2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 02:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77EC20714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 02:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77EC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGvjX-0002Ek-U0
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 22:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1jGviq-0001n8-NB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 22:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1jGvip-00074r-IM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 22:24:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12036
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1jGvip-000713-EV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 22:24:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02P23K2u019056
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 22:24:46 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ywd2sqs80-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 22:24:45 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Wed, 25 Mar 2020 02:24:40 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 25 Mar 2020 02:24:38 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02P2Odfn60162274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 02:24:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE79A52051;
 Wed, 25 Mar 2020 02:24:39 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.2.145])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 86EDA52052;
 Wed, 25 Mar 2020 02:24:39 +0000 (GMT)
Date: Wed, 25 Mar 2020 03:24:28 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v2 1/7] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL
 for EIO
In-Reply-To: <20200324180430.3597ca94.cohuck@redhat.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
 <20200206214509.16434-2-farman@linux.ibm.com>
 <20200324180430.3597ca94.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032502-0020-0000-0000-000003BA80E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032502-0021-0000-0000-00002213042A
Message-Id: <20200325032428.11dd27a2.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-24_10:2020-03-23,
 2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250012
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 18:04:30 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu,  6 Feb 2020 22:45:03 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
> > From: Farhan Ali <alifm@linux.ibm.com>
> > 
> > EIO is returned by vfio-ccw mediated device when the backing
> > host subchannel is not operational anymore. So return cc=3
> > back to the guest, rather than returning a unit check.
> > This way the guest can take appropriate action such as
> > issue an 'stsch'.

I believe this is not the only situation when vfio-ccw returns
EIO, or?

> > 
> > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > Signed-off-by: Eric Farman <farman@linux.ibm.com>
> > ---
> > 
> > Notes:
> >     v1->v2: [EF]
> >      - Add s-o-b
> >      - [Seems the discussion on v1 centered on the return code
> >        set in the kernel, rather than anything that needs to
> >        change here, unless I've missed something.]

Does this need to change here? If the kernel is supposed to return ENODEV
then this does not need to change.

> 
> I've stared at this and at the kernel code for some time again; and I'm
> not sure if "return -EIO == not operational" is even true. That said,
> I'm not sure a unit check is the right response, either. The only thing
> I'm sure about is that the kernel code needs some review of return
> codes and some documentation...

I could not agree more, this is semantically uapi and needs to be
properly documented.

With regards to "linux error codes: vs "ionist cc's" an where
the mapping is different example:

"""
/**                                                                             
 * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt        
 * and clear ordinally if subchannel is valid.                                  
 * @sch: subchannel on which to perform the cancel_halt_clear operation         
 * @iretry: the number of the times remained to retry the next operation        
 *                                                                              
 * This should be called repeatedly since halt/clear are asynchronous           
 * operations. We do one try with cio_cancel, three tries with cio_halt,        
 * 255 tries with cio_clear. The caller should initialize @iretry with          
 * the value 255 for its first call to this, and keep using the same            
 * @iretry in the subsequent calls until it gets a non -EBUSY return.           
 *                                                                              
 * Returns 0 if device now idle, -ENODEV for device not operational,            
 * -EBUSY if an interrupt is expected (either from halt/clear or from a         
 * status pending), and -EIO if out of retries.                                 
 */                                                                             
int cio_cancel_halt_clear(struct subchannel *sch, int *iretry)   

"""
Here -ENODEV is not operational.

Regards,
Halil

> 
> > 
> >  hw/vfio/ccw.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index 50cc2ec75c..19144ecfc7 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -114,6 +114,7 @@ again:
> >          return IOINST_CC_BUSY;
> >      case -ENODEV:
> >      case -EACCES:
> > +    case -EIO:
> >          return IOINST_CC_NOT_OPERATIONAL;
> >      case -EFAULT:
> >      default:
> 
> 


