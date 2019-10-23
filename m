Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8BECA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6602121928
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sfw7v7NI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6602121928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNMPC-0005KK-7A
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 15:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNMLM-0001lM-Nj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNMLK-0000aS-Ee
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:30:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNMLK-0000a8-9x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571859049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnujnO/KuApV2nCDBo9KNNikQGgcgXCIzUPXYlDL3Gc=;
 b=Sfw7v7NIMKx+bV0U1Jw+RXzCtbytK6+EkRqen0TuvYewBwjTWwtF4KQhqn4np9SHg3tO2G
 s6FJfRgHiiV5nej7YOVdnhwwi/K+XUFA7vlCKP9EiA0v5eKxAGNr3GcDGtTeRql2cW78s6
 YtIZRQ/NNEL/DZ5sdClaV/04fL/KGXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-7dxen6axPvSobGNO5FcdQw-1; Wed, 23 Oct 2019 15:30:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0E80107AD31;
 Wed, 23 Oct 2019 19:30:44 +0000 (UTC)
Received: from localhost (ovpn-116-38.ams2.redhat.com [10.36.116.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E14AB60872;
 Wed, 23 Oct 2019 19:30:37 +0000 (UTC)
Date: Wed, 23 Oct 2019 21:30:35 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191023193035.tlcumzmgjw242hgw@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <20191023120648.57e50ae1@x1.home>
MIME-Version: 1.0
In-Reply-To: <20191023120648.57e50ae1@x1.home>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7dxen6axPvSobGNO5FcdQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 laine@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 12:06:48PM -0600, Alex Williamson wrote:
>On Wed, 23 Oct 2019 10:27:02 +0200
>Jens Freimann <jfreimann@redhat.com> wrote:
>
>> This patch adds a net_failover_pair_id property to PCIDev which is
>> used to link the primary device in a failover pair (the PCI dev) to
>> a standby (a virtio-net-pci) device.
>>
>> It only supports ethernet devices. Also currently it only supports
>> PCIe devices. QEMU will exit with an error message otherwise.
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> ---
>>  hw/pci/pci.c         | 17 +++++++++++++++++
>>  include/hw/pci/pci.h |  3 +++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index aa05c2b9b2..fa9b5219f8 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -75,6 +75,8 @@ static Property pci_props[] =3D {
>>                      QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
>>      DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
>>                      QEMU_PCIE_EXTCAP_INIT_BITNR, true),
>> +    DEFINE_PROP_STRING("net_failover_pair_id", PCIDevice,
>> +            net_failover_pair_id),
>
>Nit, white space appears broken here.

I'll fix it.

>>      DEFINE_PROP_END_OF_LIST()
>>  };
>>
>> @@ -2077,6 +2079,7 @@ static void pci_qdev_realize(DeviceState *qdev, Er=
ror **errp)
>>      ObjectClass *klass =3D OBJECT_CLASS(pc);
>>      Error *local_err =3D NULL;
>>      bool is_default_rom;
>> +    uint16_t class_id;
>>
>>      /* initialize cap_present for pci_is_express() and pci_config_size(=
),
>>       * Note that hybrid PCIs are not set automatically and need to mana=
ge
>> @@ -2101,6 +2104,20 @@ static void pci_qdev_realize(DeviceState *qdev, E=
rror **errp)
>>          }
>>      }
>>
>> +    if (pci_dev->net_failover_pair_id) {
>> +        if (!pci_is_express(pci_dev)) {
>> +            error_setg(errp, "failover device is not a PCIExpress devic=
e");
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>
>Did we decide we don't need to test that the device is also in a
>hotpluggable slot? =20

Hmm, my reply to you was never sent. I thought the check for
qdev_device_add() was sufficient but you said that works only
after qdev_hotplug is set (after machine creation). I modified
the check to this:

    hide =3D should_hide_device(opts);                                     =
                                =20
                                                                           =
                              =20
    if ((hide || qdev_hotplug) && bus && !qbus_is_hotpluggable(bus)) {     =
                              =20
        error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);                  =
                              =20
        return NULL;                                                       =
                              =20
    }                                                                      =
                              =20
                                                                           =
                              =20
    if (hide) {                                                            =
                              =20
        return NULL;                                                       =
                              =20
    }

This will make qemu fail when we have the device in the initial
configuration or when we hotplug it to a bus that doesn't support it.
I tested both with a device on pcie.0. Am I missing something?=20

>Are there also multi-function considerations that
>should be prevented or documented?  For example, if a user tries to
>configure both the primary and failover NICs in the same slot, I assume
>bad things will happen.

  I would have expected that this is already checked in pci code, but
it is not. I tried it and when I put both devices into the same slot
they are both unplugged from the guest during boot but nothing else
happens. I don't know what triggers that unplug of the devices.

I'm not aware of any other problems regarding multi-function, which
doesn't mean there aren't any.=20

>
>> +        class_id =3D pci_get_word(pci_dev->config + PCI_CLASS_DEVICE);
>> +        if (class_id !=3D PCI_CLASS_NETWORK_ETHERNET) {
>> +            error_setg(errp, "failover device is not an Ethernet device=
");
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>> +    }
>
>Looks like cleanup is missing both both error cases, the option rom
>error path below this does a pci_qdev_unrealize() before returning so
>I'd assume we want the same here.  Thanks,

Thanks, I'll fix this too.

regards,
Jens=20


