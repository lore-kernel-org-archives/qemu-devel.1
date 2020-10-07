Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DAEC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D691A20797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SY7yr+Ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D691A20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ3Bd-0002AH-MT
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 02:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1kQ3AI-0001E0-VN
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 02:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1kQ3AG-00054A-AB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 02:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602052983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KsoqAOVZT04n5tExLGbwtsPQe6gPuAyzkA+hQQR5CU=;
 b=SY7yr+Arhx5toRp1n0olBPb3H92S2+jO3Oj5CcM+2++rcxv0R3hxS+ClO24PpnwvHga+YB
 zMb0rtQpDTZirSpsmBLEAVha3U+R2vIgQOYjIMf1/xrdq4Q0ym3J3vB8QnkBel3DurOoWD
 12TRsbpmvcqNnyCN8XiM0Izb8m5qHs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-l6jfaZSMNGGWwHvQpcVSYA-1; Wed, 07 Oct 2020 02:41:26 -0400
X-MC-Unique: l6jfaZSMNGGWwHvQpcVSYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 276822FD05;
 Wed,  7 Oct 2020 06:41:25 +0000 (UTC)
Received: from [10.35.206.149] (unknown [10.35.206.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E47C860BEC;
 Wed,  7 Oct 2020 06:41:20 +0000 (UTC)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v3 2/2] hw/virtio-pci Added AER capability.
From: Yan Vugenfirer <yvugenfi@redhat.com>
In-Reply-To: <20201005134406-mutt-send-email-mst@kernel.org>
Date: Wed, 7 Oct 2020 09:41:16 +0300
Message-Id: <F7D5DD54-2FD7-46E0-BD1D-6FAAF6D7B6F1@redhat.com>
References: <20201005115601.103791-1-andrew@daynix.com>
 <20201005115601.103791-3-andrew@daynix.com>
 <20201005134406-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yvugenfi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Melnichenko <andrew@daynix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,



> On 5 Oct 2020, at 8:46 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Mon, Oct 05, 2020 at 02:56:01PM +0300, andrew@daynix.com wrote:
>> From: Andrew <andrew@daynix.com>
>>=20
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1878465
>=20
> That's a private bug - what information can you share about
> the motivation for the patch?

We need AER feature in order to pass MS WHQL tests for the future Windows S=
erver versions.
According to Microsoft driver\device certification requirements for next ve=
rsion of Window Server, PCIe devices must support AER.
The exact quote from Microsoft certification requirements:
"Windows Server PCI Express devices are required to support Advanced Error =
Reporting [AER] as defined in PCI Express Base Specification version 2.1.=
=E2=80=9D


>=20
>> Added AER capability for virtio-pci devices.
>> Also added property for devices, by default AER is disabled.
>>=20
>> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
>> ---
>> hw/virtio/virtio-pci.c | 16 ++++++++++++++++
>> hw/virtio/virtio-pci.h |  4 ++++
>> 2 files changed, 20 insertions(+)
>>=20
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index ae60c1e249..e0a7936f9c 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -1807,6 +1807,12 @@ static void virtio_pci_realize(PCIDevice *pci_dev=
, Error **errp)
>>          */
>>         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
>>=20
>> +        if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
>> +            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
>> +                          PCI_ERR_SIZEOF, NULL);
>> +            last_pcie_cap_offset +=3D PCI_ERR_SIZEOF;
>> +        }
>> +
>>         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
>>             /* Init error enabling flags */
>>             pcie_cap_deverr_init(pci_dev);
>> @@ -1848,7 +1854,15 @@ static void virtio_pci_realize(PCIDevice *pci_dev=
, Error **errp)
>>=20
>> static void virtio_pci_exit(PCIDevice *pci_dev)
>> {
>> +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
>> +    bool pcie_port =3D pci_bus_is_express(pci_get_bus(pci_dev)) &&
>> +                     !pci_bus_is_root(pci_get_bus(pci_dev));
>> +
>>     msix_uninit_exclusive_bar(pci_dev);
>> +    if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
>> +        pci_is_express(pci_dev)) {
>> +        pcie_aer_exit(pci_dev);
>> +    }
>> }
>>=20
>> static void virtio_pci_reset(DeviceState *qdev)
>> @@ -1901,6 +1915,8 @@ static Property virtio_pci_properties[] =3D {
>>                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
>>     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
>>                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
>> +    DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
>> +                    VIRTIO_PCI_FLAG_AER_BIT, false),
>>     DEFINE_PROP_END_OF_LIST(),
>> };
>>=20
>=20
> Does management need ability to enable this capability?
> If yes let's cc them. If no let's rename to x-aer so we don't
> commit to a stable interface ...

QE is using libvirt in order to spawn test setups. So I think it should be =
used by management as well.
Whom should Andrew CC?

Best regards,
Yan.
>=20
>=20
>> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
>> index 91096f0291..3986b4f0e3 100644
>> --- a/hw/virtio/virtio-pci.h
>> +++ b/hw/virtio/virtio-pci.h
>> @@ -45,6 +45,7 @@ enum {
>>     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
>>     VIRTIO_PCI_FLAG_INIT_PM_BIT,
>>     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
>> +    VIRTIO_PCI_FLAG_AER_BIT,
>> };
>>=20
>> /* Need to activate work-arounds for buggy guests at vmstate load. */
>> @@ -84,6 +85,9 @@ enum {
>> /* Init Function Level Reset capability */
>> #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
>>=20
>> +/* Advanced Error Reporting capability */
>> +#define VIRTIO_PCI_FLAG_AER (1 << VIRTIO_PCI_FLAG_AER_BIT)
>> +
>> typedef struct {
>>     MSIMessage msg;
>>     int virq;
>> --=20
>> 2.28.0


