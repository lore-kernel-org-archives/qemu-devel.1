Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF6C83008
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EAB206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxIgF3KR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EAB206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTggM-0000Wv-Vt
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:58:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTgf4-0007LV-D8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTgen-0005Y2-5M
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:57:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jTgem-0005Xl-Ov
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588143439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9CCZKahsuW4nGC3laDFTvXBVeJT1++tc6rFlGGrA2XU=;
 b=KxIgF3KRAToyJ5LjMWnQpav+eKgePQgfBn3eYzVrUYq2YdN3mF77aB5ZeIUb3lRIPogfAL
 qVDsatHEKT5HReWnv4BdaP19/mgfPTn/b4ARLFGtIaMYBG1RhhZv2lKh6qpC29090uHydR
 UcG/v112l0emB44jVlVIa1X2FaUGrSI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-eXl2TCPQN2aGXY74IEMjEA-1; Wed, 29 Apr 2020 02:57:18 -0400
X-MC-Unique: eXl2TCPQN2aGXY74IEMjEA-1
Received: by mail-wm1-f70.google.com with SMTP id t62so808257wma.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 23:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tWSoiLw3xQjWDrFZiVEDq5E83eNDt6hXdfsxNe3g6Hk=;
 b=ApZxNyt8/8YFBHGyKiSGcmnKURdWpThcC03NkSUPFNl3NbTPvryB7WRluiQBfyoZVp
 98wbhX48PlTBxQqIx9XhLvqiazWXCSAZLw9UaTeVW+SYsCE6tKc3TYe7Exa/eaotF3Bk
 0Q7LonS7+dDDIsC2ysora9VF7FJmcM2MGuEtwyq+HNeALvbs/PfZ9ixQcmNQ4yw3gGex
 si1LhHAZ9z05C3+qaPyg2MWo0OFjjsHLgVfY/5rbsIiKAi4z7IB5IEH0mp4Of+aOLJvN
 jf92S8GP/URyaqYO8+dPnTlegt2MuEckIok2c10yRphh8z55zmxWnWF22qr/0hfY5Hvi
 ZKtg==
X-Gm-Message-State: AGi0PuYEBzqDpEVMkAJxpRlRD+ts7zhGq6YS4rcU8l+plJSsu5eb5dPG
 CfSRYze8dEbyucErROxybYWV38FTNxajdSyvalTFbgkZnxvXhdDNPAo7/piyqusYEWt9aUMaVMd
 Wqf+foXZVVYMh6BY=
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr30486634wro.361.1588143435361; 
 Tue, 28 Apr 2020 23:57:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJihlExA9iqRaOfQ3zvN+uJiHY/qhWyX6G8WMin5mIgX9MpyX16gdPUeJzL30tn3WtwkVHi/w==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr30486610wro.361.1588143435148; 
 Tue, 28 Apr 2020 23:57:15 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 62sm19655562wro.65.2020.04.28.23.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 23:57:14 -0700 (PDT)
Date: Wed, 29 Apr 2020 02:57:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200429025535-mutt-send-email-mst@kernel.org>
References: <20200428120426-mutt-send-email-mst@kernel.org>
 <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
 <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
 <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
 <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 06:54:52AM +0000, Ani Sinha wrote:
>=20
>=20
> > On Apr 29, 2020, at 12:22 PM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >=20
> > On Wed, Apr 29, 2020 at 06:11:20AM +0000, Ani Sinha wrote:
> >>=20
> >>=20
> >>> On Apr 29, 2020, at 10:58 AM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >>>=20
> >>> o if there's a need to disable
> >>> just one of these, commit log needs to do a better job documenting th=
e
> >>> usecase.
> >>=20
> >> The use case is simple. With this feature admins will be able to do wh=
at they were forced to do from Windows driver level but now at the bus leve=
l. Hence,=20
> >> (a) They need not have access to the guest VM to change or update wind=
ows driver registry settings. They can enable the same setting from admin m=
anagement console without any access to VM.
> >> (b) It is more robust. No need to mess with driver settings. Incorrect=
 settings can brick guest OS. Also no guest specific knowhow required.
> >> (c) It is more scalable since a single cluster wide setting can be use=
d for all VM power ons and the management plane can take care of the rest a=
utomatically. No need to access individual VMs to enforce this.
> >> (d) I am told that the driver level solution does not persist across a=
 reboot.=20
> >>=20
> >> Ani
> >=20
> > Looks like disabling both plug and unplug would also address these need=
s.
>=20
> No the driver level solution does not prevent hot plugging of devices but=
 blocks just hot unplugging. The solution I am proposing tries to do the sa=
me but from the bus/hypervisor level.

Why does the driver level solution need to prevent just hot unplugging?


>=20
> > --=20
> > MST
> >=20


