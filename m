Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9CEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA602067D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ub0IqWkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA602067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz11Z-00056c-Uq
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jz110-0004f0-Ep
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:57:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jz10y-0004rx-99
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:57:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OGpRNk131785;
 Fri, 24 Jul 2020 16:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=VxrmYb3RfSEsktzTIyn5FlI+3H1xv9thxHwlbe2aW1U=;
 b=ub0IqWkbGdhUp6b9CQOl47Bk61twTlNTWWYjwpf3VqEkj2hNhs9N0XU8jSiJa/4Sv+nq
 wwPpG1aSm/nbqGAsnBY6ISHjH0LhAj0WcF3RPdT8lS/xXhgkxJBsdZpLkaoXzZ/BxEnE
 zQGt2QL+K/wfDakvMPdycv5gkrg/CZVG2Zt3jsW90j+PoGSNbdExU7ZitxvaLsMkb0wr
 ZTXjVnKx2vFTQVJYYPbKfMk3QDAPR5VX25MntnOEsfWgtLD2/xPWGfMXQB0CMScgROMH
 Stgo7FpiR+MHPwIJkw3bPu0A1OSIGrVY0iJcKYbDCD75SE343u7EQQpb6ofq/7keigAW ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 32bs1n05sp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Jul 2020 16:57:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OGqUVA033420;
 Fri, 24 Jul 2020 16:57:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 32g3hug4em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2020 16:57:31 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06OGvTiN028007;
 Fri, 24 Jul 2020 16:57:29 GMT
Received: from dhcp-10-39-211-58.vpn.oracle.com (/10.39.211.58)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 24 Jul 2020 16:57:28 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v7 12/21] multi-process: Connect Proxy Object with device
 in the remote process
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200701092043.GE126613@stefanha-x1.localdomain>
Date: Fri, 24 Jul 2020 12:57:22 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE91B4AA-7E18-47CE-8747-97152D6462CC@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <20f42fce1b701586a23c9abdb3b53d080845e94a.1593273671.git.elena.ufimtseva@oracle.com>
 <20200701092043.GE126613@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240129
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 12:57:41
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, John G Johnson <john.g.johnson@oracle.com>,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jul 1, 2020, at 5:20 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Sat, Jun 27, 2020 at 10:09:34AM -0700, elena.ufimtseva@oracle.com =
wrote:
>> From: Jagannathan Raman <jag.raman@oracle.com>
>>=20
>> Send a message to the remote process to connect PCI device with the
>> corresponding Proxy object in QEMU
>=20
> I thought the protocol was simplified to a 1:1 device:socket model, =
but
> this patch seems to implement an N:1 model?

Hi Stefan,

Thanks for your feedback on all the patches. We were able to address =
most
of your feedback in this series, and we are looking forward to sending =
the next
version out for review.

We wanted to double check with you regarding this patch alone.

The protocol is still a 1:1 device:socket model. It=E2=80=99s not =
possible for a proxy device
object to send messages to arbitrary devices in the remote.

>=20
> In a 1:1 model the CONNECT_DEV message is not necessary because each
> socket is already associated with a specific remote device (e.g. qemu =
-M
> remote -object mplink,dev=3Dlsi-scsi-1,sockpath=3D/tmp/lsi-scsi-1.sock).=

> Connecting to the socket already indicates which device we are talking
> to.
>=20
> The N:1 model will work but it's more complex. There is a main socket
> that is used for CONNECT_DEV (anything else?) and we need to worry =
about
> the lifecycle of the per-device sockets that are passed over the main
> socket.

The main socket is only used for CONNECT_DEV. The CONNECT_DEV
message sticks a fd to the remote device.

We are using the following command-line in the remote process:
qemu-system-x86_64 -machine remote,fd=3D4 -device lsi53c895a,id=3Dlsi1 =
...

The alternative approach would be to let the orchestrator to assign fds =
for
each remote device. In this approach, we would specify an =E2=80=98fd=E2=80=
=99 for each
device object like below:
qemu-system-x86_64 -machine remote -device lsi53c895a,id=3Dlsi1,fd=3D4 =
=E2=80=A6

The alternative approach would entail changes to the DeviceState struct
and qdev_device_add() function, which we thought is not preferable. =
Could
you please share your thoughts on this?

Thanks!
=E2=80=94
Jag

>=20
>> @@ -50,3 +58,34 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, =
GIOCondition cond,
>>=20
>>     return TRUE;
>> }
>> +
>> +static void process_connect_dev_msg(MPQemuMsg *msg, QIOChannel *com,
>> +                                    Error **errp)
>> +{
>> +    char *devid =3D (char *)msg->data2;
>> +    QIOChannel *dioc =3D NULL;
>> +    DeviceState *dev =3D NULL;
>> +    MPQemuMsg ret =3D { 0 };
>> +    int rc =3D 0;
>> +
>> +    g_assert(devid && (devid[msg->size - 1] =3D=3D '\0'));
>=20
> Asserts are not suitable for external input validation since a failure
> aborts the program and lets the client cause a denial-of-service. When
> there are multiple clients, one misbehaved client shouldn't be able to
> kill the server. Please validate devid using an if statement and set
> errp on failure.
>=20
> Can msg->size be 0? If yes, this code accesses before the beginning of
> the buffer.
>=20
>> +
>> +    dev =3D qdev_find_recursive(sysbus_get_default(), devid);
>> +    if (!dev || !object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) =
{
>> +        rc =3D 0xff;
>> +        goto exit;
>> +    }
>> +
>> +    dioc =3D qio_channel_new_fd(msg->fds[0], errp);
>=20
> Missing error handling if qio_channel_new_fd() fails. We need to
> close(msg->fds[0]) ourselves in this case.
>=20
>> +
>> +    qio_channel_add_watch(dioc, G_IO_IN | G_IO_HUP, =
mpqemu_process_msg,
>> +                          (void *)dev, NULL);
>> +
>> +exit:
>> +    ret.cmd =3D RET_MSG;
>> +    ret.bytestream =3D 0;
>> +    ret.data1.u64 =3D rc;
>> +    ret.size =3D sizeof(ret.data1);
>> +
>> +    mpqemu_msg_send(&ret, com);
>> +}
>> diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
>> index 6d62399c52..16649ed0ec 100644
>> --- a/hw/pci/proxy.c
>> +++ b/hw/pci/proxy.c
>> @@ -15,10 +15,38 @@
>> #include "io/channel-util.h"
>> #include "hw/qdev-properties.h"
>> #include "monitor/monitor.h"
>> +#include "io/mpqemu-link.h"
>>=20
>> static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
>> {
>> +    DeviceState *dev =3D DEVICE(pdev);
>> +    MPQemuMsg msg =3D { 0 };
>> +    int fds[2];
>> +    Error *local_err =3D NULL;
>> +
>>     pdev->com =3D qio_channel_new_fd(fd, errp);
>> +
>> +    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds)) {
>> +        error_setg(errp, "Failed to create proxy channel with fd =
%d", fd);
>> +        return;
>=20
> pdev->com needs to be cleaned up.
>=20
>> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
>> index 5887c8c6c0..54df3b254e 100644
>> --- a/io/mpqemu-link.c
>> +++ b/io/mpqemu-link.c
>> @@ -234,6 +234,14 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
>>             return false;
>>         }
>>         break;
>> +    case CONNECT_DEV:
>> +        if ((msg->num_fds !=3D 1) ||
>> +            (msg->fds[0] =3D=3D -1) ||
>> +            (msg->fds[0] =3D=3D -1) ||
>=20
> This line is duplicated.


