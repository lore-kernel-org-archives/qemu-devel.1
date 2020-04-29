Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C63C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A82206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grUDk1+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A82206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTgfr-0008GK-6d
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:58:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTgd9-0005nT-HO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTgad-0008Oq-Kj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:55:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jTgad-0008OP-3x
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588143180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbsnPPVaeuWsySZh2cec7OIhwAiv9oA0Pdr9Ip+jYwc=;
 b=grUDk1+ky2uOZxSrBpyOpGawOVU8l7d7olWMl0lZtkVe+u3HN8/FoZ3rnIGJGElQ1L1504
 pCvv9w63LAbcQ3M01yAThp326PwF33KRWm9Eo1CNbJT9yztLyl3wn2eqY1ydhj9AwMJuWp
 Me1pC37BxuaGWIUdNvy3diDe37W3uiQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-uGyW9MMuOUCGKNIyb7eang-1; Wed, 29 Apr 2020 02:52:59 -0400
X-MC-Unique: uGyW9MMuOUCGKNIyb7eang-1
Received: by mail-wm1-f71.google.com with SMTP id b203so621749wmd.6
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 23:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OJXpO4pda8FVzX/lWmSVg26ncy/eJWQKYmoboqtpzuE=;
 b=uoJZab54+cRrknxm3nMHQaaT4+jAzm5g4xNG6yPL75Z+OuMmENWzDvaRIG1YCoVHlX
 AnOTbmf6Vy3xQXScdTdtKJJgYxCT6cqfSZGPnYsW6vv4DUVYwomw5U++XZKjdtj9Xv3B
 Uq2+q4lndGC04I/0ycNtL1r98yCu0p/vIQbhi/kCOjO9oCNtZ/2M8XqOcqT2p75exTpz
 6J1CiN9dEW57s+tShBzoHtcXlGN5DLHBEBUzR78kIQr5vGqlaeIwcdhIcSV7FUHKkqzW
 c0rlMN09SwSncYc5q+l5L2VipAtetAdWwwvwoHokVa1lT/vaIR2ORNyGgOcqtSxjn35+
 WKUQ==
X-Gm-Message-State: AGi0Pua/rHR8dJ533yLlyVdhjYZA1IGyXl3N8kJIiKr5J7asQQ+JqFh3
 2tb9ndMWtqVcfBjMbpy4LNt/aZ8XP8QNAl7WJspfQgSIk5viPDCEHyz6l6b1SlED02XyNOOoS3a
 6tY7mXlxN5WeC7hw=
X-Received: by 2002:a05:600c:295a:: with SMTP id
 n26mr1665352wmd.16.1588143177725; 
 Tue, 28 Apr 2020 23:52:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypL12FTy8+oeSKgufvJja9BEl/nlbzgRG7tKq60uZ7UZI8ockEX8GFTb1Ge0Gd8HFEpK7uA5DA==
X-Received: by 2002:a05:600c:295a:: with SMTP id
 n26mr1665326wmd.16.1588143177467; 
 Tue, 28 Apr 2020 23:52:57 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 c20sm6711698wmd.36.2020.04.28.23.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 23:52:56 -0700 (PDT)
Date: Wed, 29 Apr 2020 02:52:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200429025200-mutt-send-email-mst@kernel.org>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200428120426-mutt-send-email-mst@kernel.org>
 <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
 <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
 <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

On Wed, Apr 29, 2020 at 06:11:20AM +0000, Ani Sinha wrote:
>=20
>=20
> > On Apr 29, 2020, at 10:58 AM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >=20
> > o if there's a need to disable
> > just one of these, commit log needs to do a better job documenting the
> > usecase.
>=20
> The use case is simple. With this feature admins will be able to do what =
they were forced to do from Windows driver level but now at the bus level. =
Hence,=20
> (a) They need not have access to the guest VM to change or update windows=
 driver registry settings. They can enable the same setting from admin mana=
gement console without any access to VM.
> (b) It is more robust. No need to mess with driver settings. Incorrect se=
ttings can brick guest OS. Also no guest specific knowhow required.
> (c) It is more scalable since a single cluster wide setting can be used f=
or all VM power ons and the management plane can take care of the rest auto=
matically. No need to access individual VMs to enforce this.
> (d) I am told that the driver level solution does not persist across a re=
boot.=20
>=20
> Ani

Looks like disabling both plug and unplug would also address these needs.

--=20
MST


