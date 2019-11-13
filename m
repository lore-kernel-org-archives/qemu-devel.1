Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A1EC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA0D206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gQ4M8aty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA0D206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvhP-0007sh-8c
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iUvcE-0001ZF-L2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iUvcB-00047u-FX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:35:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iUvc8-00047T-Rw
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:35:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGOc9s014590;
 Wed, 13 Nov 2019 16:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=RE+xJpVZGtvS0gxy0/6z/QxURaatPvLmDLPIuO3KOeE=;
 b=gQ4M8atyJPJQiRK+3yjnI27+zbsORkFgDhySNBWFxNfAXJSZ+8LyAOpdtDMYNsLDiVzV
 rtj4ecUiUyug2xn6lpdTNPUnNINfwMZ9dSn2o3gPyrR8iqzvzhsGbz67t/qd4/8CaOQL
 XC9+wLzLqyMYTHcXF9mWgq3L3bV7b/VZAcm6LOkS8R3OLpgeSkbs+6Dn1f4hbfakor4J
 j1jcw4dsRe0xl7qyR0mFh4+mYmOnljydegaSUzO1SfsYyjwaF0DtJ5ynsYpWTCHe18uM
 thX12agdqWgSFrYOnoxS3u1oka3/MVyK2MIEU3m61IRPRL/i8oNTjuHQ17CAsOKLW887 TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2w5mvtwqje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:35:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGQcPW186268;
 Wed, 13 Nov 2019 16:35:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2w7vppj77n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:35:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xADGWBia001111;
 Wed, 13 Nov 2019 16:32:11 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Nov 2019 08:32:10 -0800
Subject: Re: [RFC v4 PATCH 41/49] multi-process/mig: Enable VMSD save in the
 Proxy object
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <8b15ab3d4fe51b792897ffc87e221bfb9317a836.1571905346.git.jag.raman@oracle.com>
 <20191113155019.GH2445240@redhat.com>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <2f2985ea-8449-9cd7-efa9-1eb8d286bbfe@oracle.com>
Date: Wed, 13 Nov 2019 11:32:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191113155019.GH2445240@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130146
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 xADGOc9s014590
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 ross.lagerwall@citrix.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 kraxel@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 liran.alon@oracle.com, marcandre.lureau@gmail.com, kwolf@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/13/2019 10:50 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Oct 24, 2019 at 05:09:22AM -0400, Jagannathan Raman wrote:
>> Collect the VMSD from remote process on the source and save
>> it to the channel leading to the destination
>>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> ---
>>   New patch in v4
>>
>>   hw/proxy/qemu-proxy.c         | 132 ++++++++++++++++++++++++++++++++=
++++++++++
>>   include/hw/proxy/qemu-proxy.h |   2 +
>>   include/io/mpqemu-link.h      |   1 +
>>   3 files changed, 135 insertions(+)
>>
>> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
>> index 623a6c5..ce72e6a 100644
>> --- a/hw/proxy/qemu-proxy.c
>> +++ b/hw/proxy/qemu-proxy.c
>> @@ -52,6 +52,14 @@
>>   #include "util/event_notifier-posix.c"
>>   #include "hw/boards.h"
>>   #include "include/qemu/log.h"
>> +#include "io/channel.h"
>> +#include "migration/qemu-file-types.h"
>> +#include "qapi/error.h"
>> +#include "io/channel-util.h"
>> +#include "migration/qemu-file-channel.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/migration.h"
>> +#include "migration/vmstate.h"
>>  =20
>>   QEMUTimer *hb_timer;
>>   static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
>> @@ -62,6 +70,9 @@ static void stop_heartbeat_timer(void);
>>   static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)=
;
>>   static void broadcast_msg(MPQemuMsg *msg, bool need_reply);
>>  =20
>> +#define PAGE_SIZE getpagesize()
>> +uint8_t *mig_data;
>> +
>>   static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
>>   {
>>       /* TODO: Add proper handler. */
>> @@ -357,14 +368,135 @@ static void pci_proxy_dev_inst_init(Object *obj=
)
>>       dev->mem_init =3D false;
>>   }
>>  =20
>> +typedef struct {
>> +    QEMUFile *rem;
>> +    PCIProxyDev *dev;
>> +} proxy_mig_data;
>> +
>> +static void *proxy_mig_out(void *opaque)
>> +{
>> +    proxy_mig_data *data =3D opaque;
>> +    PCIProxyDev *dev =3D data->dev;
>> +    uint8_t byte;
>> +    uint64_t data_size =3D PAGE_SIZE;
>> +
>> +    mig_data =3D g_malloc(data_size);
>> +
>> +    while (true) {
>> +        byte =3D qemu_get_byte(data->rem);
>=20
> There is a pretty large set of APIs hiding behind the qemu_get_byte
> call, which does not give me confidence that...
>=20
>> +        mig_data[dev->migsize++] =3D byte;
>> +        if (dev->migsize =3D=3D data_size) {
>> +            data_size +=3D PAGE_SIZE;
>> +            mig_data =3D g_realloc(mig_data, data_size);
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static int proxy_pre_save(void *opaque)
>> +{
>> +    PCIProxyDev *pdev =3D opaque;
>> +    proxy_mig_data *mig_data;
>> +    QEMUFile *f_remote;
>> +    MPQemuMsg msg =3D {0};
>> +    QemuThread thread;
>> +    Error *err =3D NULL;
>> +    QIOChannel *ioc;
>> +    uint64_t size;
>> +    int fd[2];
>> +
>> +    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
>> +        return -1;
>> +    }
>> +
>> +    ioc =3D qio_channel_new_fd(fd[0], &err);
>> +    if (err) {
>> +        error_report_err(err);
>> +        return -1;
>> +    }
>> +
>> +    qio_channel_set_name(QIO_CHANNEL(ioc), "PCIProxyDevice-mig");
>> +
>> +    f_remote =3D qemu_fopen_channel_input(ioc);
>> +
>> +    pdev->migsize =3D 0;
>> +
>> +    mig_data =3D g_malloc0(sizeof(proxy_mig_data));
>> +    mig_data->rem =3D f_remote;
>> +    mig_data->dev =3D pdev;
>> +
>> +    qemu_thread_create(&thread, "Proxy MIG_OUT", proxy_mig_out, mig_d=
ata,
>> +                       QEMU_THREAD_DETACHED);
>> +
>> +    msg.cmd =3D START_MIG_OUT;
>> +    msg.bytestream =3D 0;
>> +    msg.num_fds =3D 2;
>> +    msg.fds[0] =3D fd[1];
>> +    msg.fds[1] =3D GET_REMOTE_WAIT;
>> +
>> +    mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->com);
>> +    size =3D wait_for_remote(msg.fds[1]);
>> +    PUT_REMOTE_WAIT(msg.fds[1]);
>> +
>> +    assert(size !=3D ULLONG_MAX);
>> +
>> +    /*
>> +     * migsize is being update by a separate thread. Using volatile t=
o
>> +     * instruct the compiler to fetch the value of this variable from
>> +     * memory during every read
>> +     */
>> +    while (*((volatile uint64_t *)&pdev->migsize) < size) {
>> +    }
>> +
>> +    qemu_thread_cancel(&thread);
>=20
> ....this is a safe way to stop the thread executing without
> resulting in memory being leaked.
>=20
> In addition thread cancellation is asynchronous, so the thread
> may still be using the QEMUFile object while....
>=20
>> +    qemu_fclose(f_remote);

The above "wait_for_remote()" call waits for the remote process to
finish with Migration, and return the size of the VMSD.

It should be safe to cancel the thread and close the file, once the
remote process is done sending the VMSD and we have read "size" bytes
from it, is it not?

Thank you very much!
--
Jag

>=20
> ..this is closing it. This feels like it is a crash danger.
>=20
>=20
>> +    close(fd[1]);
>> +
>> +    return 0;
>> +}
>=20
> Regards,
> Daniel
>=20

