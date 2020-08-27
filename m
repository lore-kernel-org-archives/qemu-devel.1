Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD71BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75FB22B4E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikLRy5Hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75FB22B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBBr0-0002Cs-Ub
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 02:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kBBqE-0001eO-H3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:56:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39479
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kBBq9-0002G9-Jo
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598511412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rPJ5+y1fY3rbEC4eXpcba4ftNw0KTE3K0N9tI7jMnxk=;
 b=ikLRy5HflvgaMDAaTDYXq8ialOkfXt5oppNRwyzZcIqyoE8DbOHaeXS3gPNDSe7tA182cn
 5F1+0Dzg0tFyxplmQXd7qHwZA/NQTuIpj4gsaWlJ4xmOmplOv21+/k32YT1PrkyRvKGdS4
 768uUnshTrbuZhih4B3UmbgMReKLeJE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-ASVLqu2IPByhbBnoEuqzbg-1; Thu, 27 Aug 2020 02:56:50 -0400
X-MC-Unique: ASVLqu2IPByhbBnoEuqzbg-1
Received: by mail-qk1-f199.google.com with SMTP id 1so3904558qki.22
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 23:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rPJ5+y1fY3rbEC4eXpcba4ftNw0KTE3K0N9tI7jMnxk=;
 b=ZPbOrcV5JJfh4moHA7OqlMUUMp3NwRTYWyAMKgrPdWY06OEoanPmQ+sncr4Eata2r7
 TJrrFRVzrhki8SUtaldXGVENTo42XkXzBaKfk8o9QSB7HUyCtQUOUC7/kBvoAdGNf/v2
 Ha828vU5kyreRZ3NEk5+3dVbyxDhTOYleurcxGEq65UANB94jb6mD3F90iwTM90ouBoZ
 GwrDmKi49LcJ12UPl53dGq0cHn+N4UBzvJnoE6eezjoRiHH1XI2aj+S62ts3BgVBrvwH
 EkhQz1LeJx79npZrmifuln1qoxXxdf5lJq70b2OzhcOhPxUEZjKQxJRU1PBd1666qSLt
 r5Jw==
X-Gm-Message-State: AOAM531sEHecYkVdsdOTcL/ScRdL6Ael818GSKjrwy3Z5Qe7qt3enJ0y
 HsBShBJu/FgjxPANwdlcsSWLDBORRP6+itAf/hP31FcI18cZ1iWCqlI6SHlNTtNXSBCUIdUvfxk
 MF4QqY09lm6nbatvklp7IVfv3d80CTcc=
X-Received: by 2002:ad4:4dc5:: with SMTP id cw5mr17529773qvb.238.1598511410287; 
 Wed, 26 Aug 2020 23:56:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhfGICCROP5tIO8I+7hBk1ClW7mqG/ldbOpvgXCIGMXnYdOO94Kjxmjgg+k5at1c/g/nxTGvyY0FIXwRZDMEI=
X-Received: by 2002:ad4:4dc5:: with SMTP id cw5mr17529758qvb.238.1598511410063; 
 Wed, 26 Aug 2020 23:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200826143651.7915-1-eperezma@redhat.com>
 <20200826143651.7915-13-eperezma@redhat.com>
 <CAE2XoE9kFuavzHzTWvCony77iHk1_+kjrYj-budDVTdgKfTeaQ@mail.gmail.com>
In-Reply-To: <CAE2XoE9kFuavzHzTWvCony77iHk1_+kjrYj-budDVTdgKfTeaQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 27 Aug 2020 08:56:14 +0200
Message-ID: <CAJaqyWf-v8rx1V5WenepqYVWbN+z7CxWyr=vYe+H=T6DgQJDUQ@mail.gmail.com>
Subject: Re: [RFC v6 12/13] intel_iommu: Do not notify regular iotlb to
 device-iotlb notifiers
To: luoyonggang@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eperezma@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 6:52 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <=
luoyonggang@gmail.com> wrote:
>
>
>
> On Wed, Aug 26, 2020 at 10:42 PM Eugenio P=C3=A9rez <eperezma@redhat.com>=
 wrote:
>>
>> This improves performance in case of netperf with vhost-net:
>> * TCP_STREAM: From 9049.59Mbit/s to 9049.59Mbit/s (13%)
>
> What's improvement ? they are the same
>

Ouch, it was from 1923.6 Mbit/s to 2175.13 Mbit/s. Thanks for notify
it, will fix in next revision!

>>
>> * TCP_RR: From 8464.73 trans/s to 8932.703333 trans/s (5.5%)
>> * UDP_RR: From 8562.08 trans/s to 9005.62/s (5.1%)
>> * UDP_STREAM: No change observed (insignificant 0.1% improvement)
>>
>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>> ---
>>  hw/i386/intel_iommu.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index ddb828da1f..7620a1abbf 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -1960,6 +1960,12 @@ static void vtd_iotlb_domain_invalidate(IntelIOMM=
UState *s, uint16_t domain_id)
>>      vtd_iommu_unlock(s);
>>
>>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
>> +        if (vtd_as->iommu.iommu_notify_flags & IOMMU_NOTIFIER_DEVIOTLB)=
 {
>> +            /* If IOMMU memory region is DEVICE IOTLB type, it does not=
 make
>> +             * sense to send regular IOMMU notifications. */
>> +            continue;
>> +        }
>> +
>>          if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>>                                        vtd_as->devfn, &ce) &&
>>              domain_id =3D=3D vtd_get_domain_id(s, &ce)) {
>> --
>> 2.18.1
>>
>>
>
>
> --
>          =E6=AD=A4=E8=87=B4
> =E7=A4=BC
> =E7=BD=97=E5=8B=87=E5=88=9A
> Yours
>     sincerely,
> Yonggang Luo


