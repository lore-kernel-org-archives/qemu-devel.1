Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A6FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA7123101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7uUeIRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA7123101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xln-0002Ef-2g
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1k6xi3-0005v8-EC
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:03:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1k6xi0-0006W5-E2
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:03:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07EN22nv117937;
 Fri, 14 Aug 2020 23:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=iCTOPTyCxQuSsnShu15UWZMp70JSvBdI6hNECcCF4HY=;
 b=i7uUeIRXB/K4OTcej+TImZzSYuAr6UdzP25eEgGAGQurkHjh2OkDLwd0nGD60KcGOQnW
 WIxDc1PBB4CJs7340VBR3j093j7RAQ4ugYYOaG1jmaDJzNJrXfX/1JBXmB+F70YH32TH
 El0k1f0p5KiswDAUPB2DE5OlVknY5QK2M9PV7i7HKw1Z/Qdq4H4QG5rBV3zGWQ3TH3Mj
 SO9sWN0OEjZMIj0t/eXCcR0NBNUg24ZCetD2lX4zDSfF7fVbXDx5ApyTQESNyAt1uPtC
 sQnQ6kRe8aiOAKzGHTQMLHD7XCejwPLsFA/skCXwZweH6Xck0kC1B4jRXxNlq/0+ntPC 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 32t2ye79mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Aug 2020 23:02:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07EMrjwC044201;
 Fri, 14 Aug 2020 23:01:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 32u3hbutyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Aug 2020 23:01:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07EN1p02020234;
 Fri, 14 Aug 2020 23:01:51 GMT
Received: from heatpipe (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 14 Aug 2020 23:01:51 +0000
Date: Fri, 14 Aug 2020 16:01:47 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v8 17/20] multi-process: heartbeat messages to remote
Message-ID: <20200814230147.GA177362@heatpipe>
References: <cover.1596217462.git.jag.raman@oracle.com>
 <93b7566e5d565b9e5d8127849bb5be65057e25cc.1596217462.git.jag.raman@oracle.com>
 <20200811144130.GC18223@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811144130.GC18223@stefanha-x1.localdomain>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9713
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=1 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008140167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9713
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=1 phishscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008140168
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 21:28:09
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, alex.williamson@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 03:41:30PM +0100, Stefan Hajnoczi wrote:
> On Fri, Jul 31, 2020 at 02:20:24PM -0400, Jagannathan Raman wrote:
> > @@ -343,3 +349,49 @@ static void probe_pci_info(PCIDevice *dev, Error **errp)
> >          }
> >      }
> >  }
> > +
> > +static void hb_msg(PCIProxyDev *dev)
> > +{
> > +    DeviceState *ds = DEVICE(dev);
> > +    Error *local_err = NULL;
> > +    MPQemuMsg msg = { 0 };
> > +
> > +    msg.cmd = PROXY_PING;
> > +    msg.bytestream = 0;
> > +    msg.size = 0;
> > +
> > +    (void)mpqemu_msg_send_and_await_reply(&msg, dev->ioc, &local_err);
> > +    if (local_err) {
> > +        error_report_err(local_err);
> > +        qio_channel_close(dev->ioc, &local_err);
> > +        error_setg(&error_fatal, "Lost contact with device %s", ds->id);
> > +    }
> > +}
> 
> Here is my feedback from the last revision. Was this addressed?
>

Hi Stefan,

Thank you for reviewing the patchset. In this version we decided to 
shutdown the guest when the heartbeat did not get a reply from the
remote by setting the error_fatal.
Should we approach it differently or you prefer us to get rid of the
heartbeat in this form?

Thank you,
Elena

>   This patch seems incomplete since no action is taken when the device
>   fails to respond. vCPU threads that access the device will still get
>   stuck.
> 
>   The simplest way to make this useful is to close the connection when a
>   timeout occurs. Then the G_IO_HUP handler for the UNIX domain socket
>   should perform connection cleanup. At that point there are a few
>   choices:
> 
>   1. Stop guest execution and wait for the host admin to restore the
>      mplink so execution can resume. This is similar to how -drive
>      rerror=stop pauses the guest when a disk I/O error is encountered.
> 
>   2. Stop guest execution but defer it until this stale device is actually
>      accessed. This maximizes guest uptime. Guests that rarely access the
>      device may not notice at all.
> 
>   3. Return 0 from MemoryRegion read operations and ignore writes. The
>      guest continues executing but the device is broken. This is risky
>      because device drivers inside the guest may not be ready to deal with
>      this. The result could be data loss or corruption.
> 
>   4. Raise a bus-level event. Maybe PCI error reporting can be used to
>      offline the device.
> 
>   5. Terminate the guest with an error message.
> 
>   6. ?
> 
>   Until the heartbeat is fully implemented and tested I suggest dropping
>   it from this patch series. Remember the G_IO_HUP will happen anyway if
>   the remote device process terminates.



