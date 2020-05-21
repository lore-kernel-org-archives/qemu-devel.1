Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D289C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 08:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DB9207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm1IFaOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DB9207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbgpW-0005Dk-DQ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 04:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jbgos-0004E2-Lu
 for qemu-devel@nongnu.org; Thu, 21 May 2020 04:44:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28190
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jbgoq-0000YJ-Fx
 for qemu-devel@nongnu.org; Thu, 21 May 2020 04:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590050685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyGCAUSGtSsgUuEuphAOC9Gk7RmQiR9rCKVt86+TlmY=;
 b=gm1IFaOMD7SSAYQdXMWaabRCPFZST7bCpEk8rn9KanrOVdnJcgtOnTAutwqAeWjPXvBNHg
 qVXnRybsNGkOy4JWnliqeDi1NG3wWhGq5mlHniaio7NjuEC78v9cFXInvd+AnkC00P4Kri
 3pQiH6mWGQ1pxAObNA5CV9Ku8pC/DVc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-oc6UfyY9Nuqg31NbB5Ws6w-1; Thu, 21 May 2020 04:44:43 -0400
X-MC-Unique: oc6UfyY9Nuqg31NbB5Ws6w-1
Received: by mail-wm1-f69.google.com with SMTP id u11so1570939wmc.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 01:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=G0J5X8pKAtRjwCJuqtVneKQFbBBH2tJeOxCjW/tIO3Q=;
 b=sPMiByY7smLvFl+S/85Ch9PjZYbWzAJLY22VEQ8qE9UbCloZQ0A0YbBUbLTvZp/+je
 um1rimyNHuJjnZu2mGYTOFt4L39RFwLoaQkm/KDFBA6rSyL/hAlq1e5H3OLt1seYp1Ry
 iylhMWsr+EKIJU51r7RzVbDFHg9pL0KxulVK23e7LePFFm5G1Pmdz1zuVeUtlqp+bqph
 uz2H0nV7ORhgXw5gAj7ejkoKDgG3r0Xa370YJeCvMRek8Z0FrNX8xLzoecZ42PpFQRWH
 EdOA/NlX1hSROgd9WcRdDmOSCbPuCqH8wMhVcq4dsuG9PG5eHNvO+13uo0d+r2UfyGNO
 nP3A==
X-Gm-Message-State: AOAM530k26EJOlrecni8zqbI19sj2gsDvyGpW6HeZxx5URHIJGA7TwSG
 rDS6ZCiI13kq3P0OfR99NwtTYvbVBJC4pRwdH2rRNo32RBcy2PaKpUvmo2T0oEYx3me3MZiIP+Y
 BCQl76K91B20jiNw=
X-Received: by 2002:a1c:8141:: with SMTP id c62mr7965894wmd.21.1590050682802; 
 Thu, 21 May 2020 01:44:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKS5GxJA+7I2UAFmsSsla9LATPn5NfV5L1ztwroIvFXbMbXdNcv/kfEPHT8Y5fgPS6WT8G3g==
X-Received: by 2002:a1c:8141:: with SMTP id c62mr7965879wmd.21.1590050682585; 
 Thu, 21 May 2020 01:44:42 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6777.dip0.t-ipconnect.de. [91.12.103.119])
 by smtp.gmail.com with ESMTPSA id p7sm5686327wmc.24.2020.05.21.01.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 01:44:41 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 50/55] s390x/event-facility: Simplify creation of SCLP
 event devices
Date: Thu, 21 May 2020 10:44:39 +0200
Message-Id: <03AEEA41-0543-4097-8FFB-9E41038F31EE@redhat.com>
References: <5c6028bd-0bab-6c78-90fe-f00e23ab71b9@redhat.com>
In-Reply-To: <5c6028bd-0bab-6c78-90fe-f00e23ab71b9@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17E262)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


>> +static void realize_event_facility(DeviceState *dev, Error **errp)
>> +{
>> +    SCLPEventFacility *event_facility =3D EVENT_FACILITY(dev);
>> +    Error *local_err =3D NULL;
>> +
>> +    qdev_realize(DEVICE(&event_facility->quiesce),
>> +                 BUS(&event_facility->sbus), &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +    qdev_realize(DEVICE(&event_facility->cpu_hotplug),
>> +                 BUS(&event_facility->sbus), errp);
>=20
> Just wondering, do we have to care about un-realizing quiesce in case
> this fails?

Just remembered that we fail creating the machine and therefore abort. So n=
ot necessary :)

>=20
>> }
>>=20
>> static void reset_event_facility(DeviceState *dev)
>> @@ -479,6 +467,7 @@ static void init_event_facility_class(ObjectClass *k=
lass, void *data)
>>     DeviceClass *dc =3D DEVICE_CLASS(sbdc);
>>     SCLPEventFacilityClass *k =3D EVENT_FACILITY_CLASS(dc);
>>=20
>> +    dc->realize =3D realize_event_facility;
>>     dc->reset =3D reset_event_facility;
>>     dc->vmsd =3D &vmstate_event_facility;
>>     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>=20
>=20
> LGTM
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20
> --=20
> Thanks,
>=20
> David / dhildenb


