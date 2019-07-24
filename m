Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA2C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 00:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CD421734
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 00:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S21qDXtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CD421734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq55W-0004SD-Ew
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 20:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50793)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dongli.zhang@oracle.com>) id 1hq55M-00043n-0L
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 20:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dongli.zhang@oracle.com>) id 1hq55K-0006pg-Rg
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 20:24:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
 id 1hq55K-0006nT-L5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 20:24:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O0NgOa046506;
 Wed, 24 Jul 2019 00:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SCgyFLOCYVBsgiD1kfcC87sKCgseaXkBGU+9O1HCxlc=;
 b=S21qDXtlJmTrel9Rfklm1g5qnviFHDCItefdOUd33zE7NgQgXPP9aUg2gSjQajh0Y8Ok
 oP+M0GxxixIAnDEDr4q7G6HA8qH4c1RBoD5jsWSxzZ9ts2FcCjtKb1/rCpWBp9vhVOIF
 KVvBnVetHjf9KYXj6toNolhBoHkSUhR08Az0VL+1mOcQ6S5cemZslmnziVnxLjhDbU5x
 afZ+aZjdFFZUdwO94oXLoLO9SCh23x+BnoPBGzFrR+OioB0BrgNZbByVakL4a5bNQX2g
 c1zITQbShnabBdXKgSE4UhUUO7e0w9qLTtYc1LNKZcIT2rb2A/HwbIAdN8ujkWk5bOzl zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2tx61bsvxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2019 00:24:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O0Mc8w092950;
 Wed, 24 Jul 2019 00:24:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2tx60xb4u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2019 00:24:42 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6O0OeBi026486;
 Wed, 24 Jul 2019 00:24:41 GMT
Received: from [10.182.69.106] (/10.182.69.106)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 23 Jul 2019 17:24:40 -0700
To: Chris Friesen <chris.friesen@windriver.com>
References: <c6d83f1f-50e2-60e1-38d7-4e622ac71a8c@windriver.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <fb45bccd-cb01-9829-3501-6e37e785146a@oracle.com>
Date: Wed, 24 Jul 2019 08:27:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c6d83f1f-50e2-60e1-38d7-4e622ac71a8c@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240001
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 x6O0NgOa046506
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] high-level view of packet processing for virtio
 NIC?
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Chris,

On 7/24/19 12:18 AM, Chris Friesen wrote:
> Hi,
>=20
> I'm looking for information on what the qemu architecture looks like fo=
r
> processing virtio network packets in a two-vCPU guest.
>=20
> It looks like there's an IO thread doing a decent fraction of the work,=
 separate
> from the vCPU threads--is that correct?=C2=A0 There's no disk involved =
in this case,
> purely network packet processing.
>=20

I suggest use gdb to have a view.

To use gdb, the debug option should be enabled in source code.

# ./configure --target-list=3Dx86_64-softmmu --enable-debug
# make -j8 > /dev/null

# sudo gdb ./x86_64-softmmu/qemu-system-x86_64

(gdb) run -machine pc,accel=3Dkvm -vnc :0 -smp 4 -m 4096M -hda
/path/to/ubuntu1804.qcow2 -device virtio-net-pci,netdev=3Dtapnet,mq=3Dtru=
e,vectors=3D9
-netdev
tap,id=3Dtapnet,ifname=3Dtap0,script=3D/path/to/qemu-ifup,downscript=3Dno=
,queues=3D4,vhost=3Doff

gdb would be able to show which thread is running which function. To have=
 a view
on RX path...

(gdb) b virtio_net_do_receive


Once the break point is hit...

Thread 1 "qemu-system-x86" hit Breakpoint 2, virtio_net_do_receive
(nc=3D0x555557705d40, buf=3D0x55555698b2f4 "", size=3D72) at
/home/zhang/kvm/debug/qemu-4.0.0/hw/net/virtio-net.c:1370
1370	    rcu_read_lock();
(gdb) bt
#0  virtio_net_do_receive (nc=3D0x555557705d40, buf=3D0x55555698b2f4 "", =
size=3D72) at
/home/zhang/kvm/debug/qemu-4.0.0/hw/net/virtio-net.c:1370
#1  0x00005555558f6934 in virtio_net_receive (nc=3D0x555557705d40,
buf=3D0x55555698b2f4 "", size=3D72) at
/home/zhang/kvm/debug/qemu-4.0.0/hw/net/virtio-net.c:1978
#2  0x0000555555c4208b in nc_sendv_compat (nc=3D0x555557705d40,
iov=3D0x7fffffffddb0, iovcnt=3D1, flags=3D0) at net/net.c:706
#3  0x0000555555c4214d in qemu_deliver_packet_iov (sender=3D0x55555698ad0=
0,
flags=3D0, iov=3D0x7fffffffddb0, iovcnt=3D1, opaque=3D0x555557705d40) at =
net/net.c:734
#4  0x0000555555c44bae in qemu_net_queue_deliver (queue=3D0x5555577060d0,
sender=3D0x55555698ad00, flags=3D0, data=3D0x55555698b2f4 "", size=3D72) =
at net/queue.c:164
#5  0x0000555555c44cca in qemu_net_queue_send (queue=3D0x5555577060d0,
sender=3D0x55555698ad00, flags=3D0, data=3D0x55555698b2f4 "", size=3D72,
sent_cb=3D0x555555c56829 <tap_send_completed>) at net/queue.c:199
#6  0x0000555555c41ef3 in qemu_send_packet_async_with_flags
(sender=3D0x55555698ad00, flags=3D0, buf=3D0x55555698b2f4 "", size=3D72,
sent_cb=3D0x555555c56829 <tap_send_completed>) at net/net.c:660
#7  0x0000555555c41f2b in qemu_send_packet_async (sender=3D0x55555698ad00=
,
buf=3D0x55555698b2f4 "", size=3D72, sent_cb=3D0x555555c56829 <tap_send_co=
mpleted>) at
net/net.c:667
#8  0x0000555555c56938 in tap_send (opaque=3D0x55555698ad00) at net/tap.c=
:202
#9  0x0000555555dee376 in aio_dispatch_handlers (ctx=3D0x5555568770d0) at
util/aio-posix.c:430
#10 0x0000555555dee509 in aio_dispatch (ctx=3D0x5555568770d0) at util/aio=
-posix.c:461
#11 0x0000555555de9a20 in aio_ctx_dispatch (source=3D0x5555568770d0, call=
back=3D0x0,
user_data=3D0x0) at util/async.c:261
#12 0x00007ffff7570197 in g_main_context_dispatch () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#13 0x0000555555decdfc in glib_pollfds_poll () at util/main-loop.c:213
#14 0x0000555555dece76 in os_host_main_loop_wait (timeout=3D198847612) at
util/main-loop.c:236
#15 0x0000555555decf7b in main_loop_wait (nonblocking=3D0) at util/main-l=
oop.c:512
#16 0x0000555555a0beeb in main_loop () at vl.c:1970
#17 0x0000555555a13230 in main (argc=3D15, argv=3D0x7fffffffe3a8,
envp=3D0x7fffffffe428) at vl.c:4604

Dongli Zhang

