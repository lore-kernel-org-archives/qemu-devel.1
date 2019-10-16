Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1526DFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52CC20854
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edNERogC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52CC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKj2Y-0006wJ-Tq
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 09:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1iKj15-0006Eu-Dp
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1iKj13-0005gE-Ve
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:07:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1iKj13-0005fb-Mn
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:07:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id 7so2871662wme.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iMNDiLaMhKwxz3zPgWGlATiJ0caby3EzicnotJEInBI=;
 b=edNERogCPSgcrpngmjGlA0yMTsnysSEMY+mqpQH3SIZwI00830cKRDcuOPViBgLDSD
 raIk1PwBuphY6fk3hwYF0Fdk6S9W7a5bvxRbK51FhDMSJfPXKKWy/yYUj2/ZvMTRACLD
 mkCjnPb9Nf2kIec5DZrAnyVsWhtl2V5kNwYkbyyOcdLvEK3yite6+6cGPv0QlL2WeH6e
 rYQQWxR4S5PN8OLthbnkfxGq9dbPkgCbYTRTb3WwYFBItL7yUlMkst5xsY+hfDAUV7FP
 KHSnt8tpur3GP8sB5Nbt7CGS5EmIu3TqftYttGyz0fq8e6q6wmOObnQ/pceIohi3H5fk
 FZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=iMNDiLaMhKwxz3zPgWGlATiJ0caby3EzicnotJEInBI=;
 b=Cpk0Hi+exTB4rLBZCuR8hK6u48sf77uWcXFl1Dw3DWJZdHUBBdjjLAo1r7pSn9VKAg
 m/+WE8ifc60PpkkUo/u8+9IUr6tIs9JTIgGm+WU8DzMDDcRZf94zuELJ90XARfOYdOx7
 FVi+z6dctCrm5cZC+HKDD5xksN2/T2gj792zVCyPGuniHo7Egyi0NWnc8RiRVRqLdaL0
 XQJRembrcpmJpzNC97NftdYhwZt3uufLIK3AftDZ7AsILJ7cjUFiy3PJHzWcd0g24VRO
 e+spLJN3F3iAzYXpo6mBYEYMukOxKGZR9UQm6JLY9Ek7tjV4g1OAcNgea92X8V5f4aSL
 ATaQ==
X-Gm-Message-State: APjAAAU0tmEvCpqimNN9WlGbk1W8IbiSaNh3JaqRiAkJEH46Gi3Zpp5P
 ug/a8he4iOFGkEocLVSvHrmG7YTW
X-Google-Smtp-Source: APXvYqyW7fggk+w/zcPXVNtFMG/ZT+yCRXHZ7Xi8mgKJsdeTTwOewyHjzKAivdCkp1QeOGBa694FMQ==
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr3553762wmk.28.1571231219944;
 Wed, 16 Oct 2019 06:06:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id t203sm2995757wmf.42.2019.10.16.06.06.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Oct 2019 06:06:59 -0700 (PDT)
Date: Wed, 16 Oct 2019 13:06:58 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] checkpatch: sugguest to use qemu_real_host_page_size
 instead of getpagesize() or sysconf(_SC_PAGESIZE)
Message-ID: <20191016130658.2qlc5fi7mc42cq4g@master>
References: <20191016012432.22731-1-richardw.yang@linux.intel.com>
 <157122155178.13250.10914060468230367742@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157122155178.13250.10914060468230367742@37313f22b938>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: thuth@redhat.com, berrange@redhat.com, richardw.yang@linux.intel.com,
 pbonzini@redhat.com, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 03:25:53AM -0700, no-reply@patchew.org wrote:
>Patchew URL: https://patchew.org/QEMU/20191016012432.22731-1-richardw.yang@linux.intel.com/
>
>
>
>Hi,
>
>This series seems to have some coding style problems. See output below for
>more information:
>
>Subject: [PATCH] checkpatch: sugguest to use qemu_real_host_page_size instead of getpagesize() or sysconf(_SC_PAGESIZE)
>Type: series
>Message-id: 20191016012432.22731-1-richardw.yang@linux.intel.com
>
>=== TEST SCRIPT BEGIN ===
>#!/bin/bash
>git rev-parse base > /dev/null || exit 0
>git config --local diff.renamelimit 0
>git config --local diff.renames True
>git config --local diff.algorithm histogram
>./scripts/checkpatch.pl --mailback base..
>=== TEST SCRIPT END ===
>
>Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>Switched to a new branch 'test'
>6c3e035 checkpatch: sugguest to use qemu_real_host_page_size instead of getpagesize() or sysconf(_SC_PAGESIZE)
>
>=== OUTPUT BEGIN ===
>ERROR: line over 90 characters
>#20: FILE: scripts/checkpatch.pl:2919:
>+                       ERROR("use qemu_real_host_page_size instead of getpagesize()\n" . $herecurr);
>

Since this is an error message and I see other similar code keep it in the
same line, I didn't split it into two lines.

If necessary, I would split it.


-- 
Wei Yang
Help you, Help me

