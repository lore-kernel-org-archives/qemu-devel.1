Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231FEC606C7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D5A21783
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX483NHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D5A21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkYu0-0006zi-2t
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 15:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58332)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1hkYsU-0006Nn-ML
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1hkYsM-0001EA-Bs
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:00:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1hkYsF-0000Rd-1p
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:00:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id h19so671698wme.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=DOD2sOE6oIZWgXDXDpqSpfiwjLcrMY72srfGQH+LNF8=;
 b=PX483NHiNFKrpeQXYNMyc3GiEu2eItHXw+ygclSGIm+qC9gWDQbknYITOnak8u6CXX
 GLS1jjT1AJPa3gZitH08hArPw8BjvDKFMC5wu0E9tppRnPvdGCw2GZAtaulw1UEm9nff
 2viAwtZ53LE0q7w7EHAr3I5qFcyoACrL/w1IaT9WCspMhYVbvHO2a+Q+4eDxOhSBPRUi
 hnD/zwCpDv7HgeU2web2jMXIl7R1NEUGcNAMg/Z10AOzjMmMQRB7lJrfMY1je6qUfNLQ
 3BEL8LBvuhDTyZ6pJaonkeba/3KFhlT9N4V8SeUZdQwmI1vJzJRgEdnTpzaNMv+zWZ69
 D01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=DOD2sOE6oIZWgXDXDpqSpfiwjLcrMY72srfGQH+LNF8=;
 b=RNAH5XFS3Em27iNpyUB6eNoavFRFRmv5J0BfRP6yEBNU08fPm9lyd+YpBvb5bKug5y
 Rj739rgLf4cmekpmZxiwL21wFxWpUEstBTcZvggxQOsCsyysaHE+UhmRmiATeKeA1bWF
 8RIDh1dEjiP4nb/ZIb2zJX8MRL4BFpDnaEqYKpPucEQTp3MSMdshr5TBshH1GJDiHDWZ
 jVZvZis+rf2juO4ju0DFKZvHcdd9vNbMuSs5WWdDLAE01gXoShycVoU0h5QpM5SpmBEj
 L6AZd56L+oNC1w+tgp2yGA44v32czhnoUMABMp5zhjN2p4ruWmemDxMGamETB+oT0kFM
 H0sw==
X-Gm-Message-State: APjAAAVPREHMrlEOX8cnkpgUCcxRna8k853nE+lW3Gpfxkg6fS/ou61x
 WvorvgIqr7cRifRRIPtuHlouP5BaXpE=
X-Google-Smtp-Source: APXvYqxyxKzqjB3Hx/fLk8Ta5yFG1AhZf/dkrtc6Wu3YFesP1MzkKcUUh+3bGpyRMCJOp8wc8WSjCQ==
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr18506489wma.41.1562612406375; 
 Mon, 08 Jul 2019 12:00:06 -0700 (PDT)
Received: from [192.168.1.29] ([5.102.238.60])
 by smtp.gmail.com with ESMTPSA id a64sm794586wmf.1.2019.07.08.12.00.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jul 2019 12:00:05 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190708160320.GM2746@work-vm>
Date: Mon, 8 Jul 2019 22:00:04 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <742B9D24-E140-48EF-A729-098F811115D7@gmail.com>
References: <20190705010711.23277-1-marcel.apfelbaum@gmail.com>
 <03CB6DEC-3D25-4C09-9C9C-3A5206D1D1F7@gmail.com>
 <CAMzgYoMzLHEpSwLOu4nZAEK_E50xBsaYUfdXeCeHrq+-kaL=4w@mail.gmail.com>
 <49bb8456-a4b1-5a0e-e34d-cf5977e821ae@gmail.com>
 <20190708160320.GM2746@work-vm>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] hw/net: fix vmxnet3 live migration
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
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>,
 Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 8 Jul 2019, at 19:03, Dr. David Alan Gilbert <dgilbert@redhat.com> wrot=
e:
>=20
> * Marcel Apfelbaum (marcel.apfelbaum@gmail.com) wrote:
>>=20
>>=20
>>> On 7/5/19 2:14 PM, Sukrit Bhatnagar wrote:
>>>> On Fri, 5 Jul 2019 at 16:29, Dmitry Fleytman <dmitry.fleytman@gmail.com=
> wrote:
>>>>=20
>>>>> On 5 Jul 2019, at 4:07, Marcel Apfelbaum <marcel.apfelbaum@gmail.com> w=
rote:
>>>>>=20
>>>>> At some point vmxnet3 live migration stopped working and git-bisect
>>>>> didn't help finding a working version.
>>>>> The issue is the PCI configuration space is not being migrated
>>>>> successfully and MSIX remains masked at destination.
>>>>>=20
>>>>> Remove the migration differentiation between PCI and PCIe since
>>>>> the logic resides now inside VMSTATE_PCI_DEVICE.
>>>>> Remove also the VMXNET3_COMPAT_FLAG_DISABLE_PCIE based differentiation=

>>>>> since at 'realize' time is decided if the device is PCI or PCIe,
>>>>> then the above macro is enough.
>>>>>=20
>>>>> Use the opportunity to move to the standard VMSTATE_MSIX
>>>>> instead of the deprecated SaveVMHandlers.
>>>>>=20
>>>>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>>=20
>>>> Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
>>>>=20
>>> Tested-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
>>=20
>> Thanks for the fast testing and review!
>>=20
>> David, since the live migration was broken long before this patch,
>> I don't need  to add any compatibility code, right?
>=20
> Right, although we should probably bump the version_id field, that way
> you'll get a nice clean error if you try and migrate from the old<->new.
>=20
> (It's nice to get rid of the old msix oddity).
>=20
>> If so, can you merge it using your migration tree?
>=20
> I could do; or since it's entirely in vmxnet3 Dmitry can take it.

Dave, please take it to your migration tree.
Thanks, Dmitry.

>=20
> Dave
>=20
>> Thanks,
>> Marcel
>>=20
>>=20
>>>>> ---
>>>>> hw/net/vmxnet3.c | 52 ++----------------------------------------------=

>>>>> 1 file changed, 2 insertions(+), 50 deletions(-)
>>>>>=20
>>>>> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
>>>>> index 10d01d0058..8b17548b02 100644
>>>>> --- a/hw/net/vmxnet3.c
>>>>> +++ b/hw/net/vmxnet3.c
>>>>> @@ -2141,21 +2141,6 @@ vmxnet3_cleanup_msi(VMXNET3State *s)
>>>>>     msi_uninit(d);
>>>>> }
>>>>>=20
>>>>> -static void
>>>>> -vmxnet3_msix_save(QEMUFile *f, void *opaque)
>>>>> -{
>>>>> -    PCIDevice *d =3D PCI_DEVICE(opaque);
>>>>> -    msix_save(d, f);
>>>>> -}
>>>>> -
>>>>> -static int
>>>>> -vmxnet3_msix_load(QEMUFile *f, void *opaque, int version_id)
>>>>> -{
>>>>> -    PCIDevice *d =3D PCI_DEVICE(opaque);
>>>>> -    msix_load(d, f);
>>>>> -    return 0;
>>>>> -}
>>>>> -
>>>>> static const MemoryRegionOps b0_ops =3D {
>>>>>     .read =3D vmxnet3_io_bar0_read,
>>>>>     .write =3D vmxnet3_io_bar0_write,
>>>>> @@ -2176,11 +2161,6 @@ static const MemoryRegionOps b1_ops =3D {
>>>>>     },
>>>>> };
>>>>>=20
>>>>> -static SaveVMHandlers savevm_vmxnet3_msix =3D {
>>>>> -    .save_state =3D vmxnet3_msix_save,
>>>>> -    .load_state =3D vmxnet3_msix_load,
>>>>> -};
>>>>> -
>>>>> static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
>>>>> {
>>>>>     uint64_t dsn_payload;
>>>>> @@ -2203,7 +2183,6 @@ static uint64_t vmxnet3_device_serial_num(VMXNET=
3State *s)
>>>>>=20
>>>>> static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
>>>>> {
>>>>> -    DeviceState *dev =3D DEVICE(pci_dev);
>>>>>     VMXNET3State *s =3D VMXNET3(pci_dev);
>>>>>     int ret;
>>>>>=20
>>>>> @@ -2249,8 +2228,6 @@ static void vmxnet3_pci_realize(PCIDevice *pci_d=
ev, Error **errp)
>>>>>         pcie_dev_ser_num_init(pci_dev, VMXNET3_DSN_OFFSET,
>>>>>                               vmxnet3_device_serial_num(s));
>>>>>     }
>>>>> -
>>>>> -    register_savevm_live(dev, "vmxnet3-msix", -1, 1, &savevm_vmxnet3_=
msix, s);
>>>>> }
>>>>>=20
>>>>> static void vmxnet3_instance_init(Object *obj)
>>>>> @@ -2440,29 +2417,6 @@ static const VMStateDescription vmstate_vmxnet3=
_int_state =3D {
>>>>>     }
>>>>> };
>>>>>=20
>>>>> -static bool vmxnet3_vmstate_need_pcie_device(void *opaque)
>>>>> -{
>>>>> -    VMXNET3State *s =3D VMXNET3(opaque);
>>>>> -
>>>>> -    return !(s->compat_flags & VMXNET3_COMPAT_FLAG_DISABLE_PCIE);
>>>>> -}
>>>>> -
>>>>> -static bool vmxnet3_vmstate_test_pci_device(void *opaque, int version=
_id)
>>>>> -{
>>>>> -    return !vmxnet3_vmstate_need_pcie_device(opaque);
>>>>> -}
>>>>> -
>>>>> -static const VMStateDescription vmstate_vmxnet3_pcie_device =3D {
>>>>> -    .name =3D "vmxnet3/pcie",
>>>>> -    .version_id =3D 1,
>>>>> -    .minimum_version_id =3D 1,
>>>>> -    .needed =3D vmxnet3_vmstate_need_pcie_device,
>>>>> -    .fields =3D (VMStateField[]) {
>>>>> -        VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
>>>>> -        VMSTATE_END_OF_LIST()
>>>>> -    }
>>>>> -};
>>>>> -
>>>>> static const VMStateDescription vmstate_vmxnet3 =3D {
>>>>>     .name =3D "vmxnet3",
>>>>>     .version_id =3D 1,
>>>>> @@ -2470,9 +2424,8 @@ static const VMStateDescription vmstate_vmxnet3 =3D=
 {
>>>>>     .pre_save =3D vmxnet3_pre_save,
>>>>>     .post_load =3D vmxnet3_post_load,
>>>>>     .fields =3D (VMStateField[]) {
>>>>> -            VMSTATE_STRUCT_TEST(parent_obj, VMXNET3State,
>>>>> -                                vmxnet3_vmstate_test_pci_device, 0,
>>>>> -                                vmstate_pci_device, PCIDevice),
>>>>> +            VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
>>>>> +            VMSTATE_MSIX(parent_obj, VMXNET3State),
>>>>>             VMSTATE_BOOL(rx_packets_compound, VMXNET3State),
>>>>>             VMSTATE_BOOL(rx_vlan_stripping, VMXNET3State),
>>>>>             VMSTATE_BOOL(lro_supported, VMXNET3State),
>>>>> @@ -2508,7 +2461,6 @@ static const VMStateDescription vmstate_vmxnet3 =3D=
 {
>>>>>     },
>>>>>     .subsections =3D (const VMStateDescription*[]) {
>>>>>         &vmxstate_vmxnet3_mcast_list,
>>>>> -        &vmstate_vmxnet3_pcie_device,
>>>>>         NULL
>>>>>     }
>>>>> };
>>>>> --
>>>>> 2.17.1
>>>>>=20
>>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

