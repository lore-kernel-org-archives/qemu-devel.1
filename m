Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA3EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6D22075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYqWhhZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6D22075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNWnZ-0005t6-SS
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 03:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNWmf-0005Ce-MV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNWmb-0004HQ-To
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:44:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601451853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcJLV98ug6/IZPu0Y886Hw1kpnaPyR4hVlS8nsBbipE=;
 b=hYqWhhZg1aJGnGdnaIYLqYJYFVA4+YocFNzYxuuz7flNNCTiPwkqE7p28UG19aoWRNEtwj
 WfxIM5mkhN/kfb7YTDJSKilvwfWcXfwj/1tD9MwQxjzTjffmMFAs0tf2ibxDwKD5eJc2D/
 6Gx/Bvlh3aKPbqxD02XynpaeZyO+dJw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-FtPzzTpFMlWbz7xlOLKb9A-1; Wed, 30 Sep 2020 03:44:04 -0400
X-MC-Unique: FtPzzTpFMlWbz7xlOLKb9A-1
Received: by mail-wr1-f69.google.com with SMTP id o6so290885wrp.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 00:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eZqfsxn94WlYNjG20Qb1EsAzd1mU9ymSCku1MzBhTvA=;
 b=Qu2uLnj/92kEN0gGHcFsVrz+KMEMCeJIpOE1sPozxecwPEaCHchqB3Qx3LaVybsrHY
 /HpNhhWNebJguUOi9/PSvmGdxLa20x0pPYILiL+slqUa4ddLd9UWvhqrvIrzBTEr4aVQ
 SdM+ln2P+BwJS2WFjFR2VN9uUmyVMPcO06NL72egsWFpgkIhmE5jrm8biGe8D44PxURN
 dqVFpeml/+jU1um8+l+6fvi5+KBLON7hRaFltU3CjTxv9c58FEKEbLROd5QJpUblQj9t
 LnwGwUQn6fCNzY0HYQlNEeizs7Iv3N5h+1CpltSpfMZUml40i2PCa1M7eKPtMki6jZUX
 +CXw==
X-Gm-Message-State: AOAM530c3rzcRpv8fJgkwd90zPaSbLZHmH3aOpvz9AjNv3fGS51VAKDS
 vxhdbTNTytVyukdzQ9L6nZSvem4DoHdZ4/E4A54NAmQrOWDoeM3FPcZKecCiprOCpmJ8chf5mP4
 dVc/FkT5fYL1Oplg=
X-Received: by 2002:a1c:7912:: with SMTP id l18mr1492435wme.124.1601451842811; 
 Wed, 30 Sep 2020 00:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQU2DZ4QDu25UiEo25wbpB2VXRO39crPJkhYn0XI7Z38yYAMlXNzGj+ulB1ICKCLAcKvJTsg==
X-Received: by 2002:a1c:7912:: with SMTP id l18mr1492391wme.124.1601451842434; 
 Wed, 30 Sep 2020 00:44:02 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id l8sm1390604wrx.22.2020.09.30.00.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 00:44:01 -0700 (PDT)
Date: Wed, 30 Sep 2020 03:43:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
Message-ID: <20200930034220-mutt-send-email-mst@kernel.org>
References: <20200929063539-mutt-send-email-mst@kernel.org>
 <CAARzgwz6iTsO9Z1ACAHmbSteGYfetDgnSRYc-xnaqjYyJ4yEHA@mail.gmail.com>
 <20200929064858-mutt-send-email-mst@kernel.org>
 <CAARzgwwFeSPd=JGjdk-uj=uuLb+HcfMfGTe1_GmbFRTkP-jZdQ@mail.gmail.com>
 <20200929071412-mutt-send-email-mst@kernel.org>
 <CAARzgwzdYfVn6Kdic+rj7xSxdvP6RAM48wr8Pt_MpDwuYvDSiw@mail.gmail.com>
 <20200929073523-mutt-send-email-mst@kernel.org>
 <CAARzgwyNHnG_dzhD9mZbico2V3-c=XL-fNo7xO=rP2jfVMqtdw@mail.gmail.com>
 <20200930033540-mutt-send-email-mst@kernel.org>
 <CAARzgwyAE1bL5VnkH7dKBeMEtwcsZBhuhtRxx+BUxYsd8ZRi_A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAARzgwyAE1bL5VnkH7dKBeMEtwcsZBhuhtRxx+BUxYsd8ZRi_A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 01:09:09PM +0530, Ani Sinha wrote:
> 
> 
> On Wed, Sep 30, 2020 at 1:06 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Tue, Sep 29, 2020 at 06:03:00PM +0530, Ani Sinha wrote:
> 
>     > On Tue, Sep 29, 2020 at 5:05 PM Michael S. Tsirkin <mst@redhat.com>
>     wrote:
> 
>     > >
> 
>     > > On Tue, Sep 29, 2020 at 04:58:03PM +0530, Ani Sinha wrote:
> 
>     > > > On Tue, Sep 29, 2020 at 4:45 PM Michael S. Tsirkin <mst@redhat.com>
>     wrote:
> 
>     > > > >
> 
>     > > > > On Tue, Sep 29, 2020 at 04:35:50PM +0530, Ani Sinha wrote:
> 
>     > > > > > On Tue, Sep 29, 2020 at 4:25 PM Michael S. Tsirkin <
>     mst@redhat.com> wrote:
> 
>     > > > > > >
> 
>     > > > > > > On Tue, Sep 29, 2020 at 04:11:45PM +0530, Ani Sinha wrote:
> 
>     > > > > > > > On Tue, Sep 29, 2020 at 4:07 PM Michael S. Tsirkin <
>     mst@redhat.com> wrote:
> 
>     > > > > > > > >
> 
>     > > > > > > > > On Tue, Sep 29, 2020 at 04:02:07PM +0530, Ani Sinha wrote:
> 
>     > > > > > > > > > On Tue, Sep 29, 2020 at 4:00 PM Ani Sinha <
>     ani@anisinha.ca> wrote:
> 
>     > > > > > > > > > >
> 
>     > > > > > > > > > > In your pull request the following patch is completely
>     screwed up:
> 
>     > > > > > > > > > >
> 
>     > > > > > > > > > > commit cda2006eded0ed91974e1d9e7f9f288e65812a3e
> 
>     > > > > > > > > > > Author: Ani Sinha <ani@anisinha.ca>
> 
>     > > > > > > > > > > Date:   Tue Sep 29 03:22:52 2020 -0400
> 
>     > > > > > > > > > >
> 
>     > > > > > > > > > >     tests/acpi: update golden master DSDT binary table
>     blobs for q35
> 
>     > > > > > > > > > >
> 
>     > > > > > > > > > >
> 
>     > > > > > > > > > > This is not my patch. It has all sorts of changes which
>     does not
> 
>     > > > > > > > > > > belong there. Can you please check?
> 
>     > > > > > > > > >
> 
>     > > > > > > > > > See https://patchew.org/QEMU/
>     20200929071948.281157-1-mst@redhat.com/
>     20200929071948.281157-46-mst@redhat.com/
> 
>     > > > > > > > >
> 
>     > > > > > > > >
> 
>     > > > > > > > > I had to regenerate the binary, yes. That's par for the
>     course.
> 
>     > > > > > > > > But it looks like I added disasssembled files. Will fix up
>     and drop,
> 
>     > > > > > > > > thanks for noticing this.
> 
>     > > > > > >
> 
>     > > > > > > OK I pushed out a fixed variant. Pls take a look.
> 
>     > > > > >
> 
>     > > > > > OK I am not used to this workflow. How am I supposed to get it?
>     Which tag?
> 
>     > > > >
> 
>     > > > > New for_upstream tag - I just sent in a pull request.
> 
>     > > >
> 
>     > > > Can you please point me to your tree?
> 
>     > >
> 
>     > >
> 
>     > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
>     >
> 
>     > I have sent the updated patches based on your pull request tag. I just
> 
>     > had to regenrated the blob for tests/data/acpi/pc/DSDT.hpbrroot.
> 
>     >
> 
>     > make && make check-qtest-x86_64 V=1 passes.
> 
>     >
> 
>     > The diff looks good.
> 
>     >
> 
>     > Can you please send a pull request with these two patches ASAP?
> 
> 
> 
> 
> 
>     Thanks, I will queue them and merge in the next pull request.
> 
> 
> I'm willing to get down on my knees begging you to just do one another pull
> request for these two patches. Were so close with my entire work merged.
> 
> Please let's not wait another week or so. 


OK it's not too much work but ... could you please add justification
about why adding this one unit test is needed so urgently?
That motivation would be quite helpful for the pull request.


> 
> 
> 
> 
> 
>     > >
> 
>     > >
> 
>     > >
> 
>     > > > >
> 
>     > > > > >
> 
>     > > > > > >
> 
>     > > > > > > > I think DSDT.hbridge is wrong. The checksum looks weird:
> 
>     > > > > > > >
> 
>     > > > > > > >
> 
>     > > > > > > > + *     Length           0x00000B89 (2953)
> 
>     > > > > > > >   *     Revision         0x01 **** 32-bit table (V1), no
>     64-bit math support
> 
>     > > > > > > > - *     Checksum         0x05
> 
>     > > > > > >
> 
>     > > > > > > What is weird about it?
> 
>     > > > > > >
> 
>     > > > > > > >
> 
>     > > > > > > > This file should be introduced just by one patch. my patch.
> 
>     > > > > > >
> 
>     > > > > > > I just re-run rebuild-expected-aml, no changes.
> 
>     > > > > > >
> 
>     > > > > > > I have this:
> 
>     > > > > > > commit 5e3a486211f02d9ecb18939ca21087515ec81883
> 
>     > > > > > > Author: Ani Sinha <ani@anisinha.ca>
> 
>     > > > > > > Date:   Fri Sep 18 14:11:05 2020 +0530
> 
>     > > > > > >
> 
>     > > > > > >     tests/acpi: unit test for
>     'acpi-pci-hotplug-with-bridge-support' bridge flag
> 
>     > > > > > >
> 
>     > > > > > >     This change adds a new unit test for the global flag
> 
>     > > > > > >     'acpi-pci-hotplug-with-bridge-support' which is available
>     for cold plugged pci
> 
>     > > > > > >     bridges in i440fx. The flag can be used to turn off ACPI
>     based hotplug support
> 
>     > > > > > >     on all pci bridges.
> 
>     > > > > > >
> 
>     > > > > > >
> 
>     > > > > > > Here is the full DSDT header, attached:
> 
>     > > > > > >
> 
>     > > > > > > /*
> 
>     > > > > > >  * Intel ACPI Component Architecture
> 
>     > > > > > >  * AML/ASL+ Disassembler version 20190509 (64-bit version)
> 
>     > > > > > >  * Copyright (c) 2000 - 2019 Intel Corporation
> 
>     > > > > > >  *
> 
>     > > > > > >  * Disassembling to symbolic ASL+ operators
> 
>     > > > > > >  *
> 
>     > > > > > >  * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Tue Sep 29
>     06:51:03 2020
> 
>     > > > > > >  *
> 
>     > > > > > >  * Original Table Header:
> 
>     > > > > > >  *     Signature        "DSDT"
> 
>     > > > > > >  *     Length           0x0000139D (5021)
> 
>     > > > > > >  *     Revision         0x01 **** 32-bit table (V1), no 64-bit
>     math support
> 
>     > > > > > >  *     Checksum         0x05
> 
>     > > > > > >  *     OEM ID           "BOCHS "
> 
>     > > > > > >  *     OEM Table ID     "BXPCDSDT"
> 
>     > > > > > >  *     OEM Revision     0x00000001 (1)
> 
>     > > > > > >  *     Compiler ID      "BXPC"
> 
>     > > > > > >  *     Compiler Version 0x00000001 (1)
> 
>     > > > > > >  */
> 
>     > > > > > > DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT",
>     0x00000001)
> 
>     > > > > > >
> 
>     > > > > > > --
> 
>     > > > > > > MST
> 
>     > > > > > >
> 
>     > > > >
> 
>     > >
> 
> 
> 
> 


