Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A874C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5B224677
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c6O6Y7pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5B224677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7kcq-0000Yh-7c
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 13:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j7kcF-00009J-C9
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j7kcD-0006pw-Pt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:44:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1j7kcD-0006oj-Fg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:44:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SIhooW175244;
 Fri, 28 Feb 2020 18:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+2NwSY1NnfWQu7d5e9sHla60MTqCJtUZOP0O87MQn2o=;
 b=c6O6Y7pGzXvht5A3UosDEul4ErSUp0UhhZ3WSMy5q4W8x+tuLpLdv702TQsJ6YLTZtc2
 c2rjlnx/JmmzLZzJlviquRC6GFsxtvvaAU7kdfyygK+uU5eP/wyMrdJqxh9LreAEliXa
 w3fYHu21ZUUE+V1LTc0y7tf4hHN8tRvz4cwlCFNMf+BjUbWeJkTT89uqiFayZ7H+XMtA
 Ec6/qrwVHaVe/ji8FGbYVx+xIZnwENGmoFnoA+Gbszey++AuSXsCOxll2j8v7WS+rB7I
 24v/fmCx8sipg6htrpxVeRta7kZxVV0s3Up1MuAyDTk8bdw3/qcu5kIhmJHwJlQFc4Va Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yf0dmb0cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 18:43:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SIgi3D034799;
 Fri, 28 Feb 2020 18:43:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2ydcsf9tyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 18:43:49 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01SIhkki001315;
 Fri, 28 Feb 2020 18:43:46 GMT
Received: from flaka (/108.236.14.91) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 28 Feb 2020 10:43:45 -0800
Date: Fri, 28 Feb 2020 10:43:44 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 50/50] multi-process: add configure and usage
 information
Message-ID: <20200228184343.GB25838@flaka>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <bbba8cdef9f876ec6d194f3e1974347860eca732.1582576372.git.jag.raman@oracle.com>
 <20200227165804.GE315098@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227165804.GE315098@stefanha-x1.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280137
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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

On Thu, Feb 27, 2020 at 04:58:04PM +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 24, 2020 at 03:55:41PM -0500, Jagannathan Raman wrote:
> > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > 
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > ---
> >  docs/qemu-multiprocess.txt | 86 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 docs/qemu-multiprocess.txt
> > 
> > diff --git a/docs/qemu-multiprocess.txt b/docs/qemu-multiprocess.txt
> > new file mode 100644
> > index 0000000..f156177
> > --- /dev/null
> > +++ b/docs/qemu-multiprocess.txt
> > @@ -0,0 +1,86 @@
> > +Multi-process QEMU
> > +==================
> > +
> > +This document describes how to configure and use multi-process qemu.
> > +For the design document refer to docs/devel/qemu-multiprocess.
> > +
> > +1) Configuration
> > +----------------
> > +
> > +To enable support for multi-process add --enable-mpqemu
> > +to the list of options for the "configure" script.
> > +
> > +
> > +2) Usage
> > +--------
> > +
> > +To start qemu with devices intended to run in a separate emulation
> > +process without libvirtd support, the following should be used on QEMU
> > +command line. As of now, we only support the emulation of lsi53c895a
> > +in a separate process
> > +
> > +* Since parts of the RAM are shared between QEMU & remote process, a
> > +  memory-backend-file is required to facilitate this, as follows:
> > +
> > +  -object memory-backend-file,id=mem,mem-path=/dev/shm/,size=4096M,share=on
> 
> memory-backend-memfd is more convenient.  It doesn't require a mem-path
> and share=on is the default.
>

Will change this. 
> > +
> > +* The devices to be emulated in the separate process are defined as
> > +  before with addition of "rid" suboption that serves as a remote group
> > +  identificator.
> > +
> > +  -device <device options>,rid="remote process id"
> > +
> > +  For example, for non multi-process qemu:
> > +    -device lsi53c895a,id=scsi0 device
> > +    -device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0
> > +    -drive id=drive0,file=data-disk.img
> > +
> > +  and for multi-process qemu and no libvirt
> > +  support (i.e. QEMU forks child processes):
> > +    -device lsi53c895a,id=scsi0,rid=0
> > +    -device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0,rid=0
> 
> This approach is invasive:
>  * lsi53c895a should not need to be modified with a new rid= option.
>  * QEMU should not know about the scsi-hd device or drive0.  Only the
>    device emulation process needs to know about scsi-hd.
> 
> In order to cleanly separate QEMU and the device emulation process
> syntax like this is needed:
> 
>   -object remote-device,id=rid0,...
>   -device remote-pci-device,id=scsi0,remote-device=rid0
> 
> The "remote-device" object could be part of remote-pci-device, but
> keeping it separate may be useful in the future in order to support
> things like reconnection.
> 
> The generic "remote-pci-device" device handles any remote PCI device,
> not just the LSI SCSI controller.
> 
> Do you agree with this approach?
> 

We discussed these changes and they seem to be along the lines with
the future work on vfio over socket approach we will be working on later.

Could we for this experimental version have the changes you propose here
with one modification - instead of having generic remote-pci-device imply that that is LSI
device? And while we work towards vfio over socket this will become any remote
PCI device?

> > +* The command-line options for the remote process are added to the "command"
> > +  suboption of the newly added "-remote" option. 
> > +
> > +   -remote [socket],rid=0,exec="...",command="..."
> 
> QEMU has been using the -object TYPE syntax instead of adding new -TYPE
> command-line options.  This gives you object_add hotplug for free, for
> example.  I suggest using -object remote-device,id=,exec=,command=,
> instead of -remote.
> 

We will add these changes.
> > +
> > +  The drives to be emulated by the remote process are specified as part of
> > +  this command sub-option. The device to be used to connect to the monitor
> > +  is also specified as part of this suboption.
> > +
> > +  For example, the following option adds a drive and monitor to the remote
> > +  process:
> > +  -remote rid=0,exec="qemu-scsi-dev",command="-drive id=drive0,,file=data-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
> > +
> > +  Note: There's an issue with this "command" sub-option which we are in the
> > +  process of fixing. To work around this issue, it requires additional
> > +  "comma" characters as illustrated above, and in the example below.
> 
> command= (which could be called args= for clarity) will be difficult to
> use not just because of comma escaping but also because of double-quote
> escaping.  How do you pass a command-line argument that contains spaces?

Yes, this is not great. And spaces are the problem at the moment.
I am looking if the -object has some properties that can allow for arbitrary
strings. Maybe such as data for "secret" object  would do?


Elena

