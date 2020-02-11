Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76868C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1EB206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNe6ofDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1EB206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1QJJ-0002r1-Cg
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1QIh-0002Qx-Kk
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1QIg-0006WJ-EM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:49:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59806
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1QIg-0006UF-9m
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581407381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoikqihwCHIkVxh9hDsJV++5c5vgWu676lD58dy1XSs=;
 b=CNe6ofDrHIH5m2E31EHPQG37VXP2r+pqcf1Hk98Q6BXR5oCcqluFkogreyRbMgy/40dM3P
 mnVcF/ccdX42XLcENnTYhShUPRmP1YKqCFQTG47XUMTZgoWp+9uHTTaRaEoo5sulk//8xO
 q8OerT89c+3ei5WoVN6DZzxkt928g98=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-cH7TKijrPFyybZDMKviRdA-1; Tue, 11 Feb 2020 02:49:32 -0500
Received: by mail-wr1-f69.google.com with SMTP id 50so6483292wrc.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zoikqihwCHIkVxh9hDsJV++5c5vgWu676lD58dy1XSs=;
 b=IrJIcISTtVmY4JJlhLYqSx5I+jiifsxjHxNAPqq+006IsS3/32jxwkSLgx7EPB6Mt5
 doaBbuoPBxSnQswaMtoZorH7HLTcVUebPxyuv+Qvvzu1byOyZC6SyF4bfr5PDNLisebm
 p/5u1yZeZ5tGbu/H4//cZnz95cY4lZCe9bm+HBL6Ceqaav7EA0+AHm9grxGiDeWC1Ufq
 2vVBKMc3GF4Mv7dx1tnPtgrvG55Fn+oKMobAwuHyL/ERq6dzYFSmc5rj6wVmwXVMtMDb
 GCsZLX2djsskaWHQdUG+IbmqcuKYE70xTB0tMVHdAJDEmW6nSbB78+ZQ5qtseiai0AND
 oCFA==
X-Gm-Message-State: APjAAAUg/oiN0w7bGdnvVFQPEpr6YzeykbwHYjPpPtPEEEt9SWcG8k3Z
 t9bAeCjeCVNQdAhpQiBeGpalEnQWYFEjKJq9IxxyGFu+CRY8CWF/XXqaysGFwpFZ3iSULuyCaiP
 lmHl/XY7/3a2YHo0=
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr4217226wml.83.1581407371139; 
 Mon, 10 Feb 2020 23:49:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7TDqeB2LK31QoQg8M+ZocG5/YkgYmb2myxlFoMIhdeqFkVirfLz46PnrLufijYoEeEWMcBA==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr4217201wml.83.1581407370909; 
 Mon, 10 Feb 2020 23:49:30 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id j5sm4154960wrb.33.2020.02.10.23.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:49:30 -0800 (PST)
Subject: Re: [RFC PATCH 00/66] Hexagon patch series
To: qemu-devel@nongnu.org, tsimpson@quicinc.com
References: <158138469249.2844.2481028228458255882@a1bbccc8075a>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <69406057-7a25-5c58-51e2-8d3d45795d29@redhat.com>
Date: Tue, 11 Feb 2020 08:49:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158138469249.2844.2481028228458255882@a1bbccc8075a>
Content-Language: en-US
X-MC-Unique: cH7TKijrPFyybZDMKviRdA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 2:31 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1581381644-13678-1-git-send-email-tsimpson@quicinc.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
[...]> ERROR: please use python3 interpreter
> #21: FILE: target/hexagon/do_qemu.py:1:
> +#!/usr/bin/env python

Yay my Perl fu worked \o/

> 
> total: 1 errors, 1 warnings, 773 lines checked
> 
> Patch 21/66 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 22/66 Checking commit 38aac214033b (Hexagon generator phase 2 - qemu_wrap_generated.h)
> 23/66 Checking commit 55b2d7ee57f9 (Hexagon generator phase 2 - opcodes_def_generated.h)
> 24/66 Checking commit c200b920adee (Hexagon generator phase 2 - op_attribs_generated.h)
> 25/66 Checking commit f0262c416b0e (Hexagon generator phase 2 - op_regs_generated.h)
> 26/66 Checking commit a25a1a5fb267 (Hexagon generator phase 2 - printinsn-generated.h)
> 27/66 Checking commit 3d4364b80632 (Hexagon generator phase 3 - C preprocessor for decode tree)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #15:
> new file mode 100644
> 
> ERROR: Macros with complex values should be enclosed in parenthesis
> #82: FILE: target/hexagon/gen_dectree_import.c:63:
> +#define REGINFO(TAG, REGINFO, RREGS, WREGS) RREGS,
> 
> ERROR: Macros with complex values should be enclosed in parenthesis
> #91: FILE: target/hexagon/gen_dectree_import.c:72:
> +#define REGINFO(TAG, REGINFO, RREGS, WREGS) WREGS,
> 
> ERROR: suspicious ; after while (0)
> #196: FILE: target/hexagon/gen_dectree_import.c:177:
> +    } while (0);
> 
> total: 3 errors, 1 warnings, 205 lines checked
> 
> Patch 27/66 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 28/66 Checking commit 38f354878e1b (Hexagon generater phase 4 - Decode tree)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #13:
> new file mode 100755
> 
> ERROR: please use python3 interpreter
> #18: FILE: target/hexagon/dectree.py:1:
> +#!/usr/bin/env python
> 
> total: 1 errors, 1 warnings, 354 lines checked
> 
[...]


