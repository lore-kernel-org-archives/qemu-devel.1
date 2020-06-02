Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC812C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 05:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99668206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 05:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JACo2aeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99668206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfzdX-0006Ie-Tu
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 01:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfzck-0005qS-D0
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 01:38:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49977
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfzcj-0000xj-9I
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 01:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591076284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M0i5nHedoNlzGV9Oz7QbwtsZG+EUs8MYI4v/6kKkqLU=;
 b=JACo2aehkgfeqfzolFNS67E0GdsYDWErCujC2yymoRO8K7+x/+83UVuIVCENoVpfqjGd3l
 /eFtRF085bU328V6po0JQ/P65mmq9rw3vm1+QZOhmayiLoNeYp2yFuve8dTKl/7Bpz+aw5
 lmfbFDL/f2hvdVxnsZjiRPPw43rDLoM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-vt4zqiL1N6SfL7TnHFFtEw-1; Tue, 02 Jun 2020 01:37:57 -0400
X-MC-Unique: vt4zqiL1N6SfL7TnHFFtEw-1
Received: by mail-wm1-f70.google.com with SMTP id x6so493400wmj.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 22:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M0i5nHedoNlzGV9Oz7QbwtsZG+EUs8MYI4v/6kKkqLU=;
 b=TMu5AHAD13EVZW3Eb+mOUGQ2hEam0VFFo+WoJQAHVgBmyBds6eRNkfmaJ2aFLZeSKG
 MYt/8u2PJeAwcBzLHamFxt9DYHz61RRmDkiHXQjJAlGVsIIRwQqCdGyghZgIxQz+PMwl
 tOdDAuG6NpS+1tj+CuzkoDDS34HWZ+jJJdTG1sIw5C8iZnDCeEjkPUPciPLy7nyaaJbJ
 Rrl9DTFtKkrHPTNx6ZnKVamOLGJytCH8t4c4BeRFYBS6BuawQwZGElFVfEwsHP2mcXcb
 y3YjHGgAf2shJ+btSAHdX5zVtfx6c7mzGM1uEo98RaoOR7/ZOz+jWHcrEu6KbKTTS9Bk
 iADw==
X-Gm-Message-State: AOAM531M8LEcDppoxYlx7vBMy/WwXNLqvutHdcQC9ssewYyGjgjdtTUX
 THMje1RPzkOnnWZJt8D3P6MZBnrXRQAxiZiPZraRvxO0d8a7zXje3Wqgn398YpNbMdxlmUnpYiG
 8Q/FfAs70o42ZrZs=
X-Received: by 2002:a1c:8048:: with SMTP id b69mr2332078wmd.169.1591076276121; 
 Mon, 01 Jun 2020 22:37:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsbDzDRNl0xy7uczTa23VtI3Yxh74rVPWefpa0JCnFYwTh+o4fj94mQ/KPoJKC/y6A0ODXAw==
X-Received: by 2002:a1c:8048:: with SMTP id b69mr2332048wmd.169.1591076275891; 
 Mon, 01 Jun 2020 22:37:55 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 s132sm1993894wmf.12.2020.06.01.22.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 22:37:55 -0700 (PDT)
Date: Tue, 2 Jun 2020 01:37:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/3] account for NVDIMM nodes during SRAT generation
Message-ID: <20200602013735-mutt-send-email-mst@kernel.org>
References: <20200528162011.16258-1-vishal.l.verma@intel.com>
 <159070702972.20666.6607729006861632036@45ef0f9c86ae>
MIME-Version: 1.0
In-Reply-To: <159070702972.20666.6607729006861632036@45ef0f9c86ae>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 01:38:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: lvivier@redhat.com, thuth@redhat.com, xiaoguangrong.eric@gmail.com,
 imammedo@redhat.com, vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
 jingqi.liu@intel.com, pbonzini@redhat.com, dan.j.williams@intel.com,
 rth@twiddle.net, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 28, 2020 at 04:03:51PM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200528162011.16258-1-vishal.l.verma@intel.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20200528162011.16258-1-vishal.l.verma@intel.com
> Subject: [PATCH v3 0/3] account for NVDIMM nodes during SRAT generation
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Switched to a new branch 'test'
> 7e9fa62 tests/acpi: update expected SRAT files
> e8c3427 hw/acpi-build: account for NVDIMM numa nodes in SRAT
> 7598dc9 diffs-allowed: add the SRAT AML to diffs-allowed
> 
> === OUTPUT BEGIN ===
> 1/3 Checking commit 7598dc9bc984 (diffs-allowed: add the SRAT AML to diffs-allowed)
> 2/3 Checking commit e8c342740610 (hw/acpi-build: account for NVDIMM numa nodes in SRAT)
> 3/3 Checking commit 7e9fa62e9d26 (tests/acpi: update expected SRAT files)
> ERROR: Do not add expected files together with tests, follow instructions in tests/qtest/bios-tables-test.c: both tests/data/acpi/q35/SRAT.dimmpxm and tests/qtest/bios-tables-test-allowed-diff.h found
> 
> ERROR: Do not add expected files together with tests, follow instructions in tests/qtest/bios-tables-test.c: both tests/data/acpi/q35/SRAT.dimmpxm and tests/qtest/bios-tables-test-allowed-diff.h found
> 
> total: 2 errors, 0 warnings, 1 lines checked
> 
> Patch 3/3 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

This is a bug I introduced in checkpatch, pls ignore.


> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20200528162011.16258-1-vishal.l.verma@intel.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


