Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DD5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 05:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C7020723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 05:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ndeoeygk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C7020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrDze-00031r-Q9
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 01:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jrDz5-0002cP-At
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 01:11:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49514
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jrDz3-0001is-4m
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 01:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593753091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iiztc3wKQCYTmK71PLagY4GFv3KpdGGbfH/VF633eF0=;
 b=NdeoeygkBaRMhvEeK3+XVnNLVXn24Y0253om3PvciJxiVRLF+N+u7EhHDoVGS6SGBLZ8BI
 LBbCuYoFw/Srsq2Zq4LL9u8Jml+26iLa1IjMOYb3RK/45TAnU6i4f4X9hgsnTNmu34IIzr
 ujfMVgTplS+uzV3Z7k6gcTqQ/yPxrVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-PnqpfURpM3KS7sxvwggZjQ-1; Fri, 03 Jul 2020 01:11:29 -0400
X-MC-Unique: PnqpfURpM3KS7sxvwggZjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A8B510059A7;
 Fri,  3 Jul 2020 05:11:28 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4725260C81;
 Fri,  3 Jul 2020 05:11:27 +0000 (UTC)
Subject: Re: [PATCH] configure / util: Auto-detect the availability of
 openpty()
To: Michele Denber <denber@mindspring.com>
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
Date: Fri, 3 Jul 2020 07:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5EFE5291.6030300@mindspring.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Tribble <peter.tribble@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/2020 23.33, Michele Denber wrote:
> On 07/02/20 13:34, Thomas Huth wrote:
>>
>> That's just the context, cut at three lines after the last change. 
>> Simply try to apply the patch with "patch -p1 -i ..." or "git am" in a 
>> separate git branch if you're using git. It should hopefully apply 
>> cleanly.
> 
> Looks like it partly worked:
> 
> root@hemlock:~/qemu-5.0.0# gpatch -p1 -i < configpatch.diff
> gpatch: option requires an argument -- 'i'
> gpatch: Try 'gpatch --help' for more information.
> root@hemlock:~/qemu-5.0.0# gpatch -p1 < configpatch.diff
> patching file configure
> Hunk #1 succeeded at 5049 (offset -85 lines).
> Hunk #2 succeeded at 7117 (offset -267 lines).
> patching file util/qemu-openpty.c
> Hunk #1 FAILED at 52.
> Hunk #2 succeeded at 95 with fuzz 2 (offset 2 lines).
> 1 out of 2 hunks FAILED -- saving rejects to file util/qemu-openpty.c.rej
> root@hemlock:~/qemu-5.0.0# cat util/qemu-openpty.c.rej
> --- util/qemu-openpty.c
> +++ util/qemu-openpty.c
> @@ -52,7 +52,8 @@
>   #endif
> 
>   #ifdef __sun__
> -/* Once Solaris has openpty(), this is going to be removed. */
> +
> +#if !defined(HAVE_OPENPTY)
>   static int openpty(int *amaster, int *aslave, char *name,
>                      struct termios *termp, struct winsize *winp)

Did you have a local modification to that file? If so, please revert it 
first before applying the patch (or add the "#if !defined(HAVE_OPENPTY)" 
now manually to see whether it works).

  Thanks,
   Thomas


