Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBBFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:25:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1352253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1352253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhA6-0000bj-SM
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iufI0-0001pA-I4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iufHz-0007eU-JE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:25:04 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:39237)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1iufHz-0007dy-DF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:25:03 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 769DF748DC8;
 Thu, 23 Jan 2020 17:25:02 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5BE067482CF; Thu, 23 Jan 2020 17:25:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5AAC67482D2;
 Thu, 23 Jan 2020 17:25:02 +0100 (CET)
Date: Thu, 23 Jan 2020 17:25:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 79/80] tests:numa-test: make top level args
 dynamic and g_autofree(cli) cleanups
In-Reply-To: <1579779525-20065-80-git-send-email-imammedo@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001231723260.72857@zero.eik.bme.hu>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-80-git-send-email-imammedo@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: lvivier@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020, Igor Mammedov wrote:
> Use GString to pass argument to make_cli() so that it would be easy
> to dynamically change test case arguments from main(). The follow up
> patch will use it to change RAM size options depending on target.
>
> While at it cleanup 'cli' freeing, using g_autofree annotation.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v3:
>  * s/strcmp/g_str_equal/
>    (Thomas Huth <thuth@redhat.com>)
>  * use pair make_cli/qtest_init instead of qtest_initf
> PS:
>  made as a separate patch so it won't clutter followup testcase changes.
>
> CC: thuth@redhat.com
> CC: lvivier@redhat.com
> ---
> tests/qtest/numa-test.c | 108 ++++++++++++++++++++++++------------------------
> 1 file changed, 54 insertions(+), 54 deletions(-)

Title of this and next (80/80) patch is probably better written as 
tests/numa-test: to follow usual patch titles but this may not be too 
important.

Regards,
BALATON Zoltan

