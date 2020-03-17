Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F2EC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D82F2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGQC02LS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D82F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIan-0006B9-Aq
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEIZG-00057T-Rr
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEIZF-000601-Fu
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:12:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEIZF-0005xK-Bp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584475920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ch6MFyjX0VPp0Y9DHKRGyPIJ148lX5GCC4QkkcQzBXA=;
 b=SGQC02LSj1HfYAukbIRA780ERAxzLR9rJsZqgttVDIU56s8QFFSGxXJxTAjiiuvnrinM4V
 Hg6VKIEjw28OsdDPcbuKMxGHhNR9mH8CSNOiJbS7JhoDzVWHZwixsOXIKGRei6aNRpJT8X
 puL6ZH58qmdClVeVmXvPLOt3sRP3Kbs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-Qs7gbSBdOCiuMoOVvo9rjA-1; Tue, 17 Mar 2020 16:11:59 -0400
X-MC-Unique: Qs7gbSBdOCiuMoOVvo9rjA-1
Received: by mail-wr1-f70.google.com with SMTP id h17so1533686wru.16
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 13:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rTI5XjHvGl9p4i0aDDhF0wj7jPpyHkuu7P1chixtGmI=;
 b=iU3cdv25c5tvQT+qnt27bN+8TuUIUWA2No5ptgIEcF6GoOakIqfvlrfWj+NEM27e/9
 qKR9Wlmci4KwWOUodH9gUq8LJvQugfSDl3I6/m8nWSHWqNczJEsxDSh2J8rQ56NCIEXO
 /Vslqto1Y21pdRXy/H55kaf/s7zEyPms1LxV2BD2Yk2PqbxKcAatmCC6XHli9rVd7oCt
 kV3L5tNo2RQ6RvVSBcfaPfsr+2I7mR8GSl6k74gi42LgCgHuxigB6ZuNnY0EzkG/TBOl
 3IPYEND3WeW66gbQnFtc9VvjAD2twSUoOkNmEz9izh9rECcm02f3zpKdXuBJgioUJS8G
 LtkA==
X-Gm-Message-State: ANhLgQ1JQLUd3TPefzTdj0VqKWnvA26GxnjS8BO919oqSiwpU+cmMXc9
 8/vdZreWThzRaDiq5999QtBOw/QrjzTAxWWLz8nPeYus/9YX3z9kfJeSgZ5UPeUuVn+0ZD1jw/r
 Ew8OXVQEOiAwo8KE=
X-Received: by 2002:adf:cf04:: with SMTP id o4mr769390wrj.347.1584475918121;
 Tue, 17 Mar 2020 13:11:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtjllUzPjABWuBX10YdXH38Jui4ZmPL2NVJuWV88ZxbDi/Nn6mgNpIM06xocj8G7Hu0+EaDOg==
X-Received: by 2002:adf:cf04:: with SMTP id o4mr769370wrj.347.1584475917931;
 Tue, 17 Mar 2020 13:11:57 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id w19sm638655wmi.0.2020.03.17.13.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 13:11:57 -0700 (PDT)
Date: Tue, 17 Mar 2020 16:11:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
Message-ID: <20200317201153.GB233068@xz-x1>
References: <20200317195908.283800-1-peterx@redhat.com>
 <6beb4b5d-91c6-2536-64ab-18217be71134@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6beb4b5d-91c6-2536-64ab-18217be71134@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 03:02:57PM -0500, Eric Blake wrote:
> On 3/17/20 2:59 PM, Peter Xu wrote:
> > Sometimes it would be good to be able to read the pin number along
> > with the IRQ number allocated.  Since we'll dump the IRQ number, no
> > reason to not dump the pin information.  For example, the vfio-pci
> > device will overwrite the pin with the hardware pin number.  It would
> > be nice to know the pin number of one assigned device from QMP/HMP.
> >=20
> > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > CC: Alex Williamson <alex.williamson@redhat.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > CC: Julia Suvorova <jusual@redhat.com>
> > CC: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >=20
> > This helped me to debug an IRQ sharing issue, so may good to have it
> > in master too.
>=20
> We're right at soft freeze.
>=20
>=20
> > +++ b/qapi/misc.json
> > @@ -403,6 +403,8 @@
> >   #
> >   # @irq: if an IRQ is assigned to the device, the IRQ number
> >   #
> > +# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
> > +#
>=20
> But if we really do want it in 5.0, this needs a tweak.  Does the delay
> hurt?

No it won't; it's something good to have only.  I'll let the
maintainers to decide...

>=20
> Naming convention: We prefer 'irq-pin' unless there is a consistency
> issue....
>=20
> >   # @qdev_id: the device name of the PCI device
> >   #
> >   # @pci_bridge: if the device is a PCI bridge, the bridge information
> > @@ -417,8 +419,8 @@
> >   { 'struct': 'PciDeviceInfo',
> >     'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
> >              'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
> > -           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeI=
nfo',
> > -           'regions': ['PciMemoryRegion']} }
> > +           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
> > +           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegio=
n'] }}
>=20
> and the pre-existing pci_bridge is indeed the consistency issue.

Yeh, actually every key in this struct. :)

Thanks,

--=20
Peter Xu


