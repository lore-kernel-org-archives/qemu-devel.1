Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C93C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93EC2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Us37pcQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93EC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irRHs-0003Ka-RM
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 13:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irRGX-000213-Ik
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irRGV-0004VP-5N
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:50:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irRGV-0004Uq-1c
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579027810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+pY1qiXiTsbNkpVTr1ywOWD96muEvHTGJejENDjLJg=;
 b=Us37pcQ/XmL8GsM8jIJXRj49FbdptybPM9SPn7JwvI0niEjaHVANR2cv7tY6saf3N+FYE+
 3AnSyoUedG94guByNErnB08IlHn8e3UzxUHe8Oafba9QBCIVrs9bDvSeNEy7z6xrDbqenV
 Z+eHgPmwJBD4dcsLS6dhr+uZY6j6mzk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-6t02tuvjN8mpbB1BBagAnA-1; Tue, 14 Jan 2020 13:50:08 -0500
Received: by mail-wr1-f70.google.com with SMTP id y7so6900460wrm.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fbbj+rrtStl+0AyWp+AoZbXOT5p9tMx7L1Q7YAxTtC8=;
 b=djNxlpt9t9FLDAHafaczSdUgZNcC6XDdL99jV+igr+ZKjBEqOpXAq+0ZvUqUGBhR3p
 UUXl6KlIfvj7lj73dAL+2Zmo3Fv4Cb/J+hZEyMWQ6h1hGhy6ZvLXcngOorQmWmmbfPuZ
 qNEK33OUqrqj9w9YzjnhUqfhdTwhVnrkE1xwBd12Q2GcGJmtJwgXchVrHkqBGjuphFRS
 erlmyibfLQzYcia9bjAx6Wy/qMA6AhEiUTYz1GQv69e9PMEfu1fPDLVw6iPMXmXj5v1J
 Qpndwneudz9UIJRm/Imhvf7Avw2LGRrPAN2o/w9K+uPvFvDJ+YYX798ZO3Fou6DRlJi/
 KGDw==
X-Gm-Message-State: APjAAAUrPa1ck0b6suA3K3WtNVWlXrBP9mrJx86BzfE7XO9ugFY81oB+
 G5lFyOrE2AOcLn7ZGFdzatfcT+nuulOpoXeslh2y719gbB7cKM3TioJI5Xnvt+6fLKmrhGyX0X9
 M8I13lrvdlKCt6uI=
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr1923790wrr.266.1579027807121; 
 Tue, 14 Jan 2020 10:50:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyktLWFl82h40LZORz+KUcZACsr26vM4yfPglSOx4rAGvsZ7b97zKJF9HJRv7z+EApPywtx+A==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr1923755wrr.266.1579027806824; 
 Tue, 14 Jan 2020 10:50:06 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id e12sm20839211wrn.56.2020.01.14.10.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 10:50:06 -0800 (PST)
Subject: Re: [PATCH] hw/vfio: Move the IGD quirk code to a separate file
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200114161757.28831-1-thuth@redhat.com>
 <c82afcab-8f0b-d6ed-af40-0611b178f910@redhat.com>
 <20200114114741.1eb6bfd8@w520.home>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <72b792b0-5c5c-393e-ffce-528740860076@redhat.com>
Date: Tue, 14 Jan 2020 19:50:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114114741.1eb6bfd8@w520.home>
Content-Language: en-US
X-MC-Unique: 6t02tuvjN8mpbB1BBagAnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 7:47 PM, Alex Williamson wrote:
> On Tue, 14 Jan 2020 18:10:26 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/14/20 5:17 PM, Thomas Huth wrote:
>>> The IGD quirk code defines a separate device, the so-called
>>> "vfio-pci-igd-lpc-bridge" which shows up as a user-creatable
>>> device in all QEMU binaries that include the vfio code. This
>>> is a little bit unfortunate for two reasons: First, this device
>>> is completely useless in binaries like qemu-system-s390x.
>>> Second we also would like to disable it in downstream RHEL
>>> which currently requires some extra patches there since the
>>> device does not have a proper Kconfig-style switch yet.
>>>
>>> So it would be good if the device could be disabled more easily,
>>> thus let's move the code to a separate file instead and introduce
>>> a proper Kconfig switch for it which gets only enabled by default
>>> if we also have CONFIG_PC_PCI enabled.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    hw/vfio/Kconfig       |   5 +
>>>    hw/vfio/Makefile.objs |   1 +
>>>    hw/vfio/igd.c         | 616 ++++++++++++++++++++++++++++++++++++++++=
++
>>>    hw/vfio/pci-quirks.c  | 614 +---------------------------------------=
-
>>>    hw/vfio/pci.h         |  17 ++
>>>    5 files changed, 642 insertions(+), 611 deletions(-)
>>>    create mode 100644 hw/vfio/igd.c
>>>
>>> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
>>> index f0eaa75ce7..7cdba0560a 100644
>>> --- a/hw/vfio/Kconfig
>>> +++ b/hw/vfio/Kconfig
>>> @@ -36,3 +36,8 @@ config VFIO_AP
>>>        default y
>>>        select VFIO
>>>        depends on LINUX && S390_CCW_VIRTIO
>>> +
>>> +config VFIO_IGD
>>> +    bool
>>> +    default y if PC_PCI
>>
>> With the details from Alex here:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg663667.html
>>
>> I'm tempted to use:
>>
>>       default y if XEN
>>       depends on PC_PCI
>=20
> I think you might be confused, there are two separate LPC bridges in
> QEMU for IGD support, one specifically for Xen and this one
> specifically for VFIO.  This one is never used in a Xen environment.

Argh I see, OK!

>> Watch out the Xen Kconfig seems fragile, yesterday using --enable-xen
>> --disable-tcg I hit this build error:
>>
>>     LINK    i386-softmmu/qemu-system-i386
>> /usr/bin/ld: hw/xen/xen_pt.o: in function
>> `xen_igd_passthrough_isa_bridge_create':
>> /home/phil/source/qemu/hw/xen/xen_pt.c:701: undefined reference to
>> `igd_passthrough_isa_bridge_create'
>>
>>> +    depends on VFIO_PCI
>>> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
>>> index abad8b818c..9bb1c09e84 100644
>>> --- a/hw/vfio/Makefile.objs
>>> +++ b/hw/vfio/Makefile.objs
>>> @@ -5,3 +5,4 @@ obj-$(CONFIG_VFIO_PLATFORM) +=3D platform.o
>>>    obj-$(CONFIG_VFIO_XGMAC) +=3D calxeda-xgmac.o
>>>    obj-$(CONFIG_VFIO_AMD_XGBE) +=3D amd-xgbe.o
>>>    obj-$(CONFIG_VFIO_AP) +=3D ap.o
>>> +obj-$(CONFIG_VFIO_IGD) +=3D igd.o
>>
>=20


