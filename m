Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6C4C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E6523741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vz0d1/XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E6523741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSNu-0005aO-Mg
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kLSLL-0003sV-Re
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:35:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kLSLJ-00052Q-LM
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:35:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEYmkV036717;
 Thu, 24 Sep 2020 14:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ZrDntSVy359csPFeCu/5G0Y/EyX6A5NHDCilk/IjWFs=;
 b=vz0d1/XEO810IieGsqVT7GV+vekKbsQdHoFf5h3KqAEl3C4fANaknXJKvx84JtfMWxWL
 BODg9YvjD2+5A59jElxDLFnZQEnPRHDdlkS8YroGhvOkF/cqmwYKH2ODbaMRJHvyEbeb
 ys8cmAgsxj0dRefu8n/zRC6QMlOKvJdJTpvJTs5VHKvKD0ST61XqOeDA6/SaSj9XneYf
 W66EFtXAq9kpwn6Z5rPthTN+9zDGrotzfRywvvfqN8eZ1dpRVBL6uQSwDy1iBM5hcXHB
 XC3FlM84QqGPLfOQ6V1e5zHTvJNsh/S5i7vQ2vhL0GNrIbiKyU9z32d0z5YG0KVCThbX WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 33ndnurq72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 14:35:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEU8dV057788;
 Thu, 24 Sep 2020 14:33:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 33r28x33jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 14:33:19 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OEXHm6008166;
 Thu, 24 Sep 2020 14:33:17 GMT
Received: from dhcp-10-39-218-110.vpn.oracle.com (/10.39.218.110)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 07:33:16 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v9 11/20] multi-process: introduce proxy object
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200923111006-mutt-send-email-mst@kernel.org>
Date: Thu, 24 Sep 2020 10:33:12 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CBA118C-6292-4267-A6A3-133A979C8804@oracle.com>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-12-elena.ufimtseva@oracle.com>
 <20200923111006-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=4 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=4 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240111
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:35:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, stefanha@redhat.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Sep 23, 2020, at 11:10 AM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>=20
> On Thu, Aug 27, 2020 at 11:12:22AM -0700, elena.ufimtseva@oracle.com =
wrote:
>> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>=20
>> Defines a PCI Device proxy object as a child of TYPE_PCI_DEVICE.
>>=20
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>=20
>=20
> Hmm I think this device needs to block migration. And maybe the pci =
host
> device needs to do it too?

Thanks for the comment Michael. We will add a migration blocker from =
this device.

=E2=80=94
Jag

>=20
>> ---
>> MAINTAINERS            |  2 +
>> hw/pci/meson.build     |  1 +
>> hw/pci/proxy.c         | 84 =
++++++++++++++++++++++++++++++++++++++++++
>> include/hw/pci/proxy.h | 34 +++++++++++++++++
>> 4 files changed, 121 insertions(+)
>> create mode 100644 hw/pci/proxy.c
>> create mode 100644 include/hw/pci/proxy.h
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 14b8c005fc..7b2096b300 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3052,6 +3052,8 @@ F: include/hw/i386/remote-obj.h
>> F: hw/i386/remote-obj.c
>> F: include/hw/i386/remote-memory.h
>> F: hw/i386/remote-memory.c
>> +F: hw/pci/proxy.c
>> +F: include/hw/pci/proxy.h
>>=20
>> Build and test automation
>> -------------------------
>> diff --git a/hw/pci/meson.build b/hw/pci/meson.build
>> index 5c4bbac817..0df30172b5 100644
>> --- a/hw/pci/meson.build
>> +++ b/hw/pci/meson.build
>> @@ -12,6 +12,7 @@ pci_ss.add(files(
>> # allow plugging PCIe devices into PCI buses, include them even if
>> # CONFIG_PCI_EXPRESS=3Dn.
>> pci_ss.add(files('pcie.c', 'pcie_aer.c'))
>> +pci_ss.add(when: 'CONFIG_MPQEMU', if_true: files('proxy.c'))
>> softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: =
files('pcie_port.c', 'pcie_host.c'))
>> softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
>>=20
>> diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
>> new file mode 100644
>> index 0000000000..1bff744bd6
>> --- /dev/null
>> +++ b/hw/pci/proxy.c
>> @@ -0,0 +1,84 @@
>> +/*
>> + * Copyright =C3=82=C2=A9 2018, 2020 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +
>> +#include "hw/pci/proxy.h"
>> +#include "hw/pci/pci.h"
>> +#include "qapi/error.h"
>> +#include "io/channel-util.h"
>> +#include "hw/qdev-properties.h"
>> +#include "monitor/monitor.h"
>> +
>> +static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error =
**errp)
>> +{
>> +    pdev->ioc =3D qio_channel_new_fd(fd, errp);
>> +}
>> +
>> +static Property proxy_properties[] =3D {
>> +    DEFINE_PROP_STRING("fd", PCIProxyDev, fd),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
>> +{
>> +    PCIProxyDev *dev =3D PCI_PROXY_DEV(device);
>> +    int fd;
>> +
>> +    if (dev->fd) {
>> +        fd =3D monitor_fd_param(cur_mon, dev->fd, errp);
>> +        if (fd =3D=3D -1) {
>> +            error_prepend(errp, "proxy: unable to parse fd: ");
>> +            return;
>> +        }
>> +        proxy_set_socket(dev, fd, errp);
>> +    } else {
>> +        error_setg(errp, "fd parameter not specified for %s",
>> +                   DEVICE(device)->id);
>> +        return;
>> +    }
>> +
>> +    qemu_mutex_init(&dev->io_mutex);
>> +    qio_channel_set_blocking(dev->ioc, true, NULL);
>> +}
>> +
>> +static void pci_proxy_dev_exit(PCIDevice *pdev)
>> +{
>> +    PCIProxyDev *dev =3D PCI_PROXY_DEV(pdev);
>> +
>> +    qio_channel_close(dev->ioc, NULL);
>> +}
>> +
>> +static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>> +
>> +    k->realize =3D pci_proxy_dev_realize;
>> +    k->exit =3D pci_proxy_dev_exit;
>> +    device_class_set_props(dc, proxy_properties);
>> +}
>> +
>> +static const TypeInfo pci_proxy_dev_type_info =3D {
>> +    .name          =3D TYPE_PCI_PROXY_DEV,
>> +    .parent        =3D TYPE_PCI_DEVICE,
>> +    .instance_size =3D sizeof(PCIProxyDev),
>> +    .class_init    =3D pci_proxy_dev_class_init,
>> +    .interfaces =3D (InterfaceInfo[]) {
>> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>> +        { },
>> +    },
>> +};
>> +
>> +static void pci_proxy_dev_register_types(void)
>> +{
>> +    type_register_static(&pci_proxy_dev_type_info);
>> +}
>> +
>> +type_init(pci_proxy_dev_register_types)
>> diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
>> new file mode 100644
>> index 0000000000..4ae7becf34
>> --- /dev/null
>> +++ b/include/hw/pci/proxy.h
>> @@ -0,0 +1,34 @@
>> +/*
>> + * Copyright =C3=82=C2=A9 2018, 2020 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#ifndef PROXY_H
>> +#define PROXY_H
>> +
>> +#include "hw/pci/pci.h"
>> +#include "io/channel.h"
>> +
>> +#define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
>> +
>> +#define PCI_PROXY_DEV(obj) \
>> +            OBJECT_CHECK(PCIProxyDev, (obj), TYPE_PCI_PROXY_DEV)
>> +
>> +typedef struct PCIProxyDev {
>> +    PCIDevice parent_dev;
>> +    char *fd;
>> +
>> +    /*
>> +     * Mutex used to protect the QIOChannel fd from
>> +     * the concurrent access by the VCPUs since proxy
>> +     * blocks while awaiting for the replies from the
>> +     * process remote.
>> +     */
>> +    QemuMutex io_mutex;
>> +    QIOChannel *ioc;
>> +} PCIProxyDev;
>> +
>> +#endif /* PROXY_H */
>> --=20
>> 2.25.GIT
>=20


