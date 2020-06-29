Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60982C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C311247FA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQ9dn/u3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C311247FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpveL-0006Tc-FX
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jpvdb-0005y5-Qp
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:24:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jpvdZ-0001W0-Up
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593444240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPc58kV1Pj9YacAKDvdBWIdEh8e8hioc6iUctkdEtyw=;
 b=GQ9dn/u3HWzftRA3Pi/b5oX2XG52fx+lBjKXUskZR7PLwnz2pHFyhJ9gXnuxPz9Qam0Zqf
 qZO9Vtg6jwurE8Fu9ORs4gMKsiR3twOPg6Bdad8lW2sNc+5wt9g7XvB1XW0ujMp4u7ldXX
 wfEc4rf5+2xr60MOWQfghY7zn4isKvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-ce2RwS05MHCmQMYOJNd_ww-1; Mon, 29 Jun 2020 11:23:48 -0400
X-MC-Unique: ce2RwS05MHCmQMYOJNd_ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E871018A0726;
 Mon, 29 Jun 2020 15:23:46 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B1245D9E7;
 Mon, 29 Jun 2020 15:23:46 +0000 (UTC)
Subject: Re: [PULL v2 25/31] osdep: Make MIN/MAX evaluate arguments only once
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200626135608.6920-1-pbonzini@redhat.com>
 <20200626135608.6920-3-pbonzini@redhat.com>
 <CAFEAcA9DOyivMUS1gAE_BPcmO7yf6J8d-_YZ8W=Ox8U_O0QcBg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <82b6d089-3270-6bad-1165-33c148b4a375@redhat.com>
Date: Mon, 29 Jun 2020 10:23:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9DOyivMUS1gAE_BPcmO7yf6J8d-_YZ8W=Ox8U_O0QcBg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/20 4:35 PM, Peter Maydell wrote:
> On Fri, 26 Jun 2020 at 14:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Eric Blake <eblake@redhat.com>
>>
>> I'm not aware of any immediate bugs in qemu where a second runtime
>> evaluation of the arguments to MIN() or MAX() causes a problem, but
>> proactively preventing such abuse is easier than falling prey to an
>> unintended case down the road.  At any rate, here's the conversation
>> that sparked the current patch:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05718.html
> 
> Hi; the changes in this patch seem to confuse Coverity.

Oh dear.

> In particular, where MIN_CONST or MAX_CONST are used to
> define values that must be const, eg in qemu-file.c:
>   50    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
> or in hcd-xhci.h:
> 217    USBPort  uports[MAX_CONST(MAXPORTS_2, MAXPORTS_3)];
> 
> Coverity reports:
> 
> CID 1429992 (#1 of 1): Unrecoverable parse warning (PARSE_ERROR)1.
> expr_not_constant: expression must have a constant value
> 
> Can we do something (eg providing fallback less-intelligent
> versions of the macro ifdef __COVERITY__) to help it?

Absolutely; I see we've done similar in include/qemu/thread.h.  I'll 
post something later today.

> 
> (This is the cause of CID 1429992, 1429995, 1429997,
> 1429999. Parse errors are unfortunate because Coverity
> abandons analysis of the affected function entirely,
> and analysis of its callers is also limited.)
> 
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


