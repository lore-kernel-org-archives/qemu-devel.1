Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626A5C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE5420736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex63vPjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE5420736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY32r-0006Ih-Ai
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 03:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jY324-0005YI-8N
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:39:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jY322-0008Dc-LL
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589182760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCRmUFceNBkqKl75VQEPfjiYzPdgMFYrf5aP9QrPcs8=;
 b=ex63vPjAiFoimMwAc/5MbGF5WrL1ElPbYUWRX3xqxUq1L+aoqcDZZRH+i4sVIUGs8MGw+u
 LuMxz+fffEB5HBi8pqqbnxo353fO4hcmu3ZXlTnX/uR/MB2O6W3cINdV9k6POJRgc6j4C5
 U1RxL4aNpP7qzozp1eBgkezbi/kCllw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-oTQxl3XIPl-GrRngXc5VAw-1; Mon, 11 May 2020 03:39:18 -0400
X-MC-Unique: oTQxl3XIPl-GrRngXc5VAw-1
Received: by mail-wr1-f69.google.com with SMTP id w9so962092wrr.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 00:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Y5cvY+t6pfKd2FQG5yx8xgRH7n2qR0wFqkp4wE21Vi8=;
 b=eeq7lT4UG6SPwOS5Kw3JZTUj97aLUACg6huRyypsvqaSGL5uLPTxTEeaAwqDxKbbf/
 GaEnqAGMUcMEhSITNZHeow8zfnT33Py4f8IMi2p1rei3Cx+K0zxJ/VA0z62C/7mi4LZm
 OSrya32HtfAvz0qquPNE5xb+Fa5sAyWdyB8WIAcDZJKPjSrOp3i6ryBUOqzV+UQJNJIR
 Jiv9xFl6/1b/sNf5SkYf3qBSvZBVQfQt4iuwzA3BqSf4zR8d6hidyNLQiTz7ovN9Nxb6
 Hi64DyuC3N3w2gDp7hP6rMk4ljyP6p6mMMDjVNCjXx9CR6b4l/dF9Lp9S0s4AfmfNzBB
 jlGQ==
X-Gm-Message-State: AGi0PuarJxSoWGhA9JC5T3/1Z9dMreV+K8jlBGmO3YaXoBcG6UNzoV2K
 me+KGxEP7BEb5hPaU+jQj4dwANf7fwF4J3vRm/MIQSWZWDKSjSlyvoeuQnswTwcxZQC9iF2CUvf
 2rKifmgsRw9vixhE=
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr16451329wrs.279.1589182756983; 
 Mon, 11 May 2020 00:39:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypLIskl3AsthqqJOAvoWDVz7rUvQoCcVR8uq9929YBCexzLgDjQMDLaiR+E5tLRgZZ0GQu4Mpg==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr16451301wrs.279.1589182756679; 
 Mon, 11 May 2020 00:39:16 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
 by smtp.gmail.com with ESMTPSA id h188sm27771366wme.8.2020.05.11.00.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 00:39:16 -0700 (PDT)
Date: Mon, 11 May 2020 03:39:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Abort in mch_update_pciexbar
Message-ID: <20200511033045-mutt-send-email-mst@kernel.org>
References: <20200511045912.keffhizkobgwqcag@mozz.bu.edu>
 <c6b66f8a-40e4-8ad5-afb4-09bddbcac529@redhat.com>
 <2344dc20-5c7f-75eb-96d2-bef0153550d6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2344dc20-5c7f-75eb-96d2-bef0153550d6@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 09:10:48AM +0200, Philippe Mathieu-Daudé wrote:
> On 5/11/20 8:19 AM, Philippe Mathieu-Daudé wrote:
> > On 5/11/20 6:59 AM, Alexander Bulekov wrote:
> > > Hello,
> > > While fuzzing, I found an input that triggers an assertion failure in
> > > mch_update_pciexbar:
> > > 
> > > #6 0x7f38d387c55a in abort
> > > /build/glibc-GwnBeO/glibc-2.30/stdlib/abort.c:79:7
> > > #7 0x55c27e94ffd0 in mch_update_pciexbar hw/pci-host/q35.c:331:9
> > > #8 0x55c27e94db38 in mch_write_config hw/pci-host/q35.c:487:9
> > > #9 0x55c27e9e3f4c in pci_host_config_write_common hw/pci/pci_host.c:81:5
> > > #10 0x55c27e9e5307 in pci_data_write hw/pci/pci_host.c:118:5
> > > #11 0x55c27e9e6601 in pci_host_data_write hw/pci/pci_host.c:165:9
> > > #12 0x55c27ca3b17b in memory_region_write_accessor memory.c:496:5
> > > #13 0x55c27ca3a5e4 in access_with_adjusted_size memory.c:557:18
> > > #14 0x55c27ca38177 in memory_region_dispatch_write memory.c:1488:16
> > > #15 0x55c27c721325 in flatview_write_continue exec.c:3174:23
> > > #16 0x55c27c70994d in flatview_write exec.c:3214:14
> > > #17 0x55c27c709462 in address_space_write exec.c:3305:18
> > 
> > These lines don't match QEMU v5.0.0.
> > 
> > > 
> > > I can reproduce it in a qemu 5.0 build using:
> > > cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386
> > > -M pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio
> > > outl 0xcf8 0xf2000060
> > > outl 0xcfc 0x8400056e
> > 
> > The guest shouldn't ask for a reserved bar length (grep for
> > MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD). I suppose we should simply report
> > it as GUEST_ERROR and ignore it.
> 
> This patch prevent the crash:
> 
> -- >8 --
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 2bbc90b28f..2b744aca93 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -36,6 +36,7 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
> 
> 
> /****************************************************************************
>   * Q35 host
> @@ -320,6 +321,9 @@ static void mch_update_pciexbar(MCHPCIState *mch)
>          addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid use of reserved
> value\n",
> +                                       __func__);
> +        return;
>      default:
>          abort();
>      }

Maybe report the value too.

> ---
> 
> But the real question is what would the real hardware do in this case.

Spec doesn't say unfortunately. All it says is:
	Designers must not rely on the absence or characteristics of any
	features or instructions marked "reserved" or "undefined." Intel
	reserves these for

	future definition and shall have no responsibility whatsoever
	for conflicts or incompatibilities arising from future changes to them.



> > 
> > > EOF
> > > 
> > > I also uploaded the above trace, in case the formatting is broken:
> > > 
> > > curl https://paste.debian.net/plain/1146095 | qemu-system-i386 -M
> > > pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio
> > > 
> > > Please let me know if I can provide any further info.
> > 
> > It would help the community if you fill your bug reports with Launchpad,
> > so they don't get lost in the high email flow, and we can track/update
> > them. See for example:
> > https://bugs.launchpad.net/qemu/+bug/1835865 and
> > https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06082.html
> > which refers it.


