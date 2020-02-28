Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA3FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCF724677
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rk+jBbgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCF724677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7kdo-00025s-Hh
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 13:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j7kck-0000bu-MT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j7kcj-0007XH-Jk
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:44:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1j7kcj-0007Td-Aa
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:44:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SIgmFq134056;
 Fri, 28 Feb 2020 18:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=1CooSqxG8VqB2eEcRvUmmyjg9XI7Djeca1W76Buy2+4=;
 b=Rk+jBbgY8IMsHiUCRCrSDUW/qKEmgYl74l5e0gu8ljuhczEtc9Mqgh+T4zoa2FrmQMMh
 16ttP0tVRZxFzO4wHuaa8qKk0LLsmhAVfa8WtodjC/LsbQ1z2SzrKPVHx5HZIn0z82us
 Mf/expntZEtFT6EN7y0Ez2k1Cv0Vg2D+ebzxxyq4psUvCwZUqwHPp40dpdYfcUgm+S4j
 Szj8RSi1qUM800iNYdw5RjySHANqPH7UooYV4mgn9AdfmYTopfGtbzLHqvw3OUfJOkSp
 bH2o71FyvEwGNmBIY61elEs5smcQmCy0E050IFKGEOBGKm+okRXojwlQgauAhVGoJDxo Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2ydct3mn9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 18:44:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SIiMJ2177721;
 Fri, 28 Feb 2020 18:44:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2ydj4rfu36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 18:44:23 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01SIiKgv029483;
 Fri, 28 Feb 2020 18:44:20 GMT
Received: from flaka (/108.236.14.91) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 28 Feb 2020 10:44:18 -0800
Date: Fri, 28 Feb 2020 10:44:11 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 49/50] multi-process: add the concept description to
 docs/devel/qemu-multiprocess
Message-ID: <20200228184411.GC25838@flaka>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <b6a030f0a81a1129b853c30a4c10def606a53089.1582576372.git.jag.raman@oracle.com>
 <20200227171140.GF315098@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227171140.GF315098@stefanha-x1.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280137
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 05:11:40PM +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 24, 2020 at 03:55:40PM -0500, Jagannathan Raman wrote:
> > From: John G Johnson <john.g.johnson@oracle.com>
> > 
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > ---
> >  docs/devel/index.rst             |    1 +
> >  docs/devel/qemu-multiprocess.rst | 1102 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 1103 insertions(+)
> >  create mode 100644 docs/devel/qemu-multiprocess.rst
> > 
> > diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> > index 4dc2ca8..1a95871 100644
> > --- a/docs/devel/index.rst
> > +++ b/docs/devel/index.rst
> > @@ -25,3 +25,4 @@ Contents:
> >     tcg-plugins
> >     bitops
> >     reset
> > +   multi-process
> > diff --git a/docs/devel/qemu-multiprocess.rst b/docs/devel/qemu-multiprocess.rst
> > new file mode 100644
> > index 0000000..477e246
> > --- /dev/null
> > +++ b/docs/devel/qemu-multiprocess.rst
> > @@ -0,0 +1,1102 @@
> > +Disaggregating QEMU
> 
> Please revise this document and the patch series to use consistent
> terminology.  At least "qemu-multiprocess.rst", "--enable-mpqemu", and
> "disaggregated QEMU" are used to describe this feature (there are
> probably more, I have only looked at 2 patches so far).
> 
> It's confusing for someone who stumbles across one of these terms and
> then has to figure out that we're talking about the same thing when
> encountering other terms later on.
> 
> Please use a single name and use it consistently.
>


Thanks Stefan, will work on this. 
> > +===================
> > +
> > +QEMU is often used as the hypervisor for virtual machines running in the
> > +Oracle cloud. Since one of the advantages of cloud computing is the
> > +ability to run many VMs from different tenants in the same cloud
> > +infrastructure, a guest that compromised its hypervisor could
> > +potentially use the hypervisor's access privileges to access data it is
> > +not authorized for.
> > +
> > +QEMU can be susceptible to security attack because it is a large,
> 
> s/attack/attacks/
> 
> > +monolithic program that provides many features to the VMs it services.
> > +Many of these feature can be configured out of QEMU, but even a reduced
> 
> s/feature/features/



