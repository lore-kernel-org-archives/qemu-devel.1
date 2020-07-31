Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B2EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844E521744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PS7uym5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844E521744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Zrf-0003Jv-Qp
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1Zqq-00022u-JL
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:33:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1Zqo-0006op-9B
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:33:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VILm7M078206;
 Fri, 31 Jul 2020 18:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=mBq1XBdn5dIM7pzboAVesetV/hB9yOlwDfTlUJIKew0=;
 b=PS7uym5+2hBIMAbIQyxaWRzR55YctJeRg8wnw/3nbMQkATb4hlycLSagJxUY+ll+Srr3
 y1OUrNIvbAtqquapa/uL1xoIr0LZTlqezQP63baKNtdZQYWiFYMumFuyPPk2JlKiXFth
 8l4PFBRDEbUVYYm2Ht+azVgRkhNTm/dZLusSNRdUTP2i9B2Al2YAZ6J0J5z2NMT4Ng5v
 7Kax9iM/gxCOZmdElQHC45gR8ZsyHoo3teTQQPtBSoaicQ1c35X/PsApg3hi9OXsl9pE
 oRaJd++kqTMD563azDWq0SwTAEoq0fKiCkL+xvxVULYI83fU6IcM2/NJpHv52XC1E6Eu KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 32mf9g2vm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:33:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIIe51137896;
 Fri, 31 Jul 2020 18:31:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 32hu64rhw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:31:42 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VIVeac030021;
 Fri, 31 Jul 2020 18:31:40 GMT
Received: from dhcp-10-39-209-116.vpn.oracle.com (/10.39.209.116)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:31:40 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v7 12/21] multi-process: Connect Proxy Object with device
 in the remote process
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200727131829.GD386429@stefanha-x1.localdomain>
Date: Fri, 31 Jul 2020 14:31:32 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB0FCC99-E7F6-4F58-BED1-8E7A121E9F56@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <20f42fce1b701586a23c9abdb3b53d080845e94a.1593273671.git.elena.ufimtseva@oracle.com>
 <20200701092043.GE126613@stefanha-x1.localdomain>
 <BE91B4AA-7E18-47CE-8747-97152D6462CC@oracle.com>
 <20200727131829.GD386429@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=3 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 14:20:51
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
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, kanth.ghatraju@oracle.com,
 Felipe Franciosi <felipe@nutanix.com>, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jul 27, 2020, at 9:18 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Fri, Jul 24, 2020 at 12:57:22PM -0400, Jag Raman wrote:
>>> On Jul 1, 2020, at 5:20 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>>> On Sat, Jun 27, 2020 at 10:09:34AM -0700, elena.ufimtseva@oracle.com =
wrote:
>>> In a 1:1 model the CONNECT_DEV message is not necessary because each
>>> socket is already associated with a specific remote device (e.g. =
qemu -M
>>> remote -object mplink,dev=3Dlsi-scsi-1,sockpath=3D/tmp/lsi-scsi-1.sock=
).
>>> Connecting to the socket already indicates which device we are =
talking
>>> to.
>>>=20
>>> The N:1 model will work but it's more complex. There is a main =
socket
>>> that is used for CONNECT_DEV (anything else?) and we need to worry =
about
>>> the lifecycle of the per-device sockets that are passed over the =
main
>>> socket.
>>=20
>> The main socket is only used for CONNECT_DEV. The CONNECT_DEV
>> message sticks a fd to the remote device.
>>=20
>> We are using the following command-line in the remote process:
>> qemu-system-x86_64 -machine remote,fd=3D4 -device lsi53c895a,id=3Dlsi1 =
...
>>=20
>> The alternative approach would be to let the orchestrator to assign =
fds for
>> each remote device. In this approach, we would specify an =E2=80=98fd=E2=
=80=99 for each
>> device object like below:
>> qemu-system-x86_64 -machine remote -device lsi53c895a,id=3Dlsi1,fd=3D4 =
=E2=80=A6
>>=20
>> The alternative approach would entail changes to the DeviceState =
struct
>> and qdev_device_add() function, which we thought is not preferable. =
Could
>> you please share your thoughts on this?
>=20
> I suggest dropping multi-device support for now. It will be =
implemented
> differently with VFIO-over-socket anyway, so it's not worth investing
> much time into.
>=20
> The main socket approach needs authentication support if multiple =
guests
> share a remote device emulation process. Otherwise guest A can access
> guest B's devices.
>=20
> It's simpler if each device has a separate UNIX domain socket. It is =
not
> necessary to modify lsi53c895a in order to do this. Either the socket
> can be associated with the remote PCIe port (although I think the
> current code implements the older PCI Local Bus instead of PCIe) or a
> separate -object mpqlink,device=3Dlsi1,fd=3D4 object can be defined (I =
think
> that's the syntax I've shared in the past).
>=20
> For now though, just using the -machine remote,fd=3D4 approach is fine =
-
> but limited to 1 device.

Hi Stefan,

Thanks for your response.

We didn=E2=80=99t quite get the purpose of the =E2=80=9Cobject=E2=80=9D =
when you proposed the
command-line. But we understand it now.

We also agree to wait for the authentication protocol before enabling
multiple devices in the same remote process. Therefore we have limited
the number of devices to 1.

Even with one device, we still had the problem of attaching the file
descriptor with a device int the remote end. The object idea you =
proposed
seemed to fit well with connecting the fd with device. We have added =
this
object in v8, which we just sent out.

We have dropped the main-socket/control-channel as it=E2=80=99s not =
needed
anymore.

We look forward to your responses to v8.

Thank you very much!

>=20
> Stefan


