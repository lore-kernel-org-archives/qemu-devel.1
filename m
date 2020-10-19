Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56A1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 18:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C2E2231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 18:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C2E2231B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUZrD-00048V-5D
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 14:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kUZq8-0003as-No
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 14:25:00 -0400
Received: from mailout04.t-online.de ([194.25.134.18]:54774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kUZq4-0003vZ-Ij
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 14:25:00 -0400
Received: from fwd06.aul.t-online.de (fwd06.aul.t-online.de [172.20.26.150])
 by mailout04.t-online.de (Postfix) with SMTP id 678114194F82;
 Mon, 19 Oct 2020 20:24:48 +0200 (CEST)
Received: from [192.168.211.200]
 (XV3TYYZdZh1d00A3igY2xHfyaR+XeVpjxE7Pc62qwnms+9R35FTjjsV7oDqde8cwHo@[79.208.17.62])
 by fwd06.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kUZpw-0AFl4a0; Mon, 19 Oct 2020 20:24:48 +0200
Subject: Re: [PULL 09/14] qmp: Move dispatcher to a coroutine
To: Kevin Wolf <kwolf@redhat.com>
References: <20201009063432.303441-1-armbru@redhat.com>
 <20201009063432.303441-10-armbru@redhat.com>
 <b4a717b6-a709-f6a7-c992-3dca13fe792e@t-online.de>
 <20201019085706.GA6508@merkur.fritz.box>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Message-ID: <9ba11811-1173-c6bd-1e04-de39503590a9@t-online.de>
Date: Mon, 19 Oct 2020 20:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201019085706.GA6508@merkur.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ID: XV3TYYZdZh1d00A3igY2xHfyaR+XeVpjxE7Pc62qwnms+9R35FTjjsV7oDqde8cwHo
X-TOI-EXPURGATEID: 150726::1603131888-00003102-F6AB7AC5/0/0 CLEAN NORMAL
X-TOI-MSGID: 85157ab4-8b78-4e71-bfe0-e6566638c3d7
Received-SPF: none client-ip=194.25.134.18; envelope-from=vr_qemu@t-online.de;
 helo=mailout04.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 14:24:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>> Hi Kevin,
>>>
>>> since commit 9ce44e2ce2 "qmp: Move dispatcher to a coroutine" I see
>>> the following error on Windows whenever I close the QEMU window or
>>> shut down the guest.
>>>
>>> $ ./qemu-system-x86_64.exe -machine pc,accel=tcg -display gtk
>>> **
>>> ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion failed: (in_aio_context_home_thread(ctx))
>>> Bail out! ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion failed: (in_aio_context_home_thread(ctx))
>>>
>>> I wonder if you forgot to apply the changes to util/aio-posix.c to
>>> util/aio-win32.c too? This solves the problem on my Windows host. But
>>> I have to admit I don't know the code here.
> Hi Volker,
>
> yes, you're right. The assertion in the Windows code was added only in
> commit 5710a3e09f9 after I had posted some versions of the patch series,
> so while I did check this initially, I missed during the rebase for
> later versions of the series that I would have to update the patches for
> Windows.
>
> Would you like to send a patch for this? I could send one myself if you
> prefer, but I can only compile-test Windows patches, so I'd have to rely
> on your testing anyway.
>
> Kevin

Thank you for that information. I'll send a patch.

With best regards,
Volker

