Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD4C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8F92072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3MxYmdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8F92072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfK4-0005Z7-64
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 01:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTfIw-0004fY-5T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTfGY-00070g-0F
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:30:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27184
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jTfGX-0006ra-DL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588138091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yW7KzLKyeditHW+0TJT609XgzRfoJVQ9r7eV3EZ/Qag=;
 b=N3MxYmdjPe4oX87ny9DsUT9luYHBZKmmJ2Wqp2Kd7W6YryiOjsSkxo16kA4nfl7ku9e3cW
 ES+5QlL0+dDNd3ach8tYEpZrwvczScX6CnCixuDiy1LHUyhoR/03et1UAjilUnP28WA0CC
 o9Im63IPqogwmhkyYFDEYdLhepw9dzs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-HohvkL3BP5SoiEcUD56ocA-1; Wed, 29 Apr 2020 01:28:10 -0400
X-MC-Unique: HohvkL3BP5SoiEcUD56ocA-1
Received: by mail-wm1-f71.google.com with SMTP id l21so716490wmh.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 22:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eeH9sWDoim/rHWkeLwiGH53msb9ctC1mifN6wvyxmns=;
 b=Zc1ZdzVG8B/a9v5b3hLcn97HbS5PAZtoNGM+2zuPaDuHjxm0Sd6znkb+gD+rxsADQb
 dg4fV+ATpczvodKcjrroNDcLHnxlCwEZ5IMzTjBIoCO3OI/w2vY+Zb3QKJLi+qP/YpF9
 LjT5DlvPK9h6jubQurtA+sGb+D8dZz21ezQi4dt3t6oXZMjQZABYLHxgCpeaFpfWdpp7
 xh2TMwgB/Iyv8GpDNMeVndLDqiWZbRdTrDVTM6P7oMIOm5GZM6ZsqptmyhhJiMUixWkK
 Eyieo/t/ktlwN+JqUL1u6TNvqt3url8YziXAAmTTmeoccQrsGHhhaiOYFxmJUOqvj9bV
 bsKg==
X-Gm-Message-State: AGi0PuY8CBP4gGF6GzlzsfItpL4iMIpVCHG7qrOQFqpWmJtRpJMC9k4/
 J6mBLbGH/nLlL/pQywRAU0fAg/MlVII6UZVTjKRdL/2uzg8NJyKNMHZn+6LPmooZRsDEIOA7jDY
 bsux8sSXCJFtrxRY=
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr1055320wmf.166.1588138088917; 
 Tue, 28 Apr 2020 22:28:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypLLwC5cnx7b4FxFY9M2GyTqzO8dShhp8JmpXBW0/oTGLEwqweFdgJcr+sJKpeH7aUy64iTlbg==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr1055294wmf.166.1588138088701; 
 Tue, 28 Apr 2020 22:28:08 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 a67sm6375336wmc.30.2020.04.28.22.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 22:28:08 -0700 (PDT)
Date: Wed, 29 Apr 2020 01:28:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200429011228-mutt-send-email-mst@kernel.org>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200428120426-mutt-send-email-mst@kernel.org>
 <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
 <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
 <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 06:28:46AM +0530, Ani Sinha wrote:
> Well there were several discussions in the other thread around how PCIE b=
ehaves
> and how we can't change the slot features without a HW reset. Those were =
useful
> inputs.

OK so I'd expect these to be addressed in some way. If we commit to
support a feature which has no chance to work on real hardware, we paint
ourselves into a tight corner. This kind of thing tends to create
maintainance problems down the road. Disabling both hotplug and unplug
sounds like a reasonable thing to do, so if there's a need to disable
just one of these, commit log needs to do a better job documenting the
usecase.

Alternatively, we need to be more creative with achieving what you are
trying to do in ways that can work on real hardware.

For example, how about hot-plugging a bridge which doesn't
support hotplug itself? Would that happen to make windows
do what you want, for both PCI and PCIE? We don't support
hotplugging bridges with devices behind them ATM, but
that sounds like a useful option.


Also, pcie root ports recently gained ability to disable hotplug, see
=09commit 530a0963184e57e71a5b538e9161f115df533e96
=09Author: Julia Suvorova <jusual@redhat.com>
=09Date:   Wed Feb 26 18:46:07 2020 +0100

=09    pcie_root_port: Add hotplug disabling option

adding this to pci and pcie bridges sounds very reasonable.

--=20
MST


