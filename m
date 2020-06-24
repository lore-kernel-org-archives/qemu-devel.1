Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D79C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 01:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFCB2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 01:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="unHNyM4X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="R+LsAgov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFCB2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnuAe-0005us-1i
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 21:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jnu9z-0005Pi-FQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 21:25:07 -0400
Received: from relay3.mymailcheap.com ([217.182.119.155]:35759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jnu9w-0000cG-24
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 21:25:07 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id C7E233F1CC;
 Wed, 24 Jun 2020 03:24:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 01CD92A3A4;
 Tue, 23 Jun 2020 21:24:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1592961899;
 bh=8WGR70bTqubtGvLXsdS3AXaMjgpq6in5YJRY82W7Uq8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=unHNyM4XLR2EeS9Kxus13omdkzmgAATJVz5eBv/p8ANwQiskYKr17B6RNsbz+8KdF
 ydK+3ugUMVYZeGDFk1KVtEqZdufalwIvBLOVoBnz4L5ethV1Lpffsc2L2f75loOESu
 5eyaTc5oD57ylGrCwy3V62IygFLt9MpDK4HHRBlc=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ey93NRyii1Zj; Tue, 23 Jun 2020 21:24:57 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Tue, 23 Jun 2020 21:24:57 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 9844040855;
 Wed, 24 Jun 2020 01:24:54 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="R+LsAgov"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [194.156.98.201])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id DA22240850;
 Wed, 24 Jun 2020 01:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1592961836;
 bh=8WGR70bTqubtGvLXsdS3AXaMjgpq6in5YJRY82W7Uq8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=R+LsAgovw+Oz7TwM44SuLCd8SjNA5m8uuZ7la5rwmFRin+WrPx3542rverR+RglaN
 7aewl6uZa1SOERoAiWnqi+BgXwLX8IhW7TQ27eVzC8jYuNQnv8aZfR7e8leiC3oyug
 xhMgVwWF6Arvm1p+X2EhYgzWITRVgzSITTDcpyIk=
Subject: Re: [PATCH for-5.1 V5 2/4] hw/intc: Add Loongson liointc support
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <zltjiangshi@gmail.com>
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
 <1592914438-30317-3-git-send-email-chenhc@lemote.com>
 <CAHiYmc7kWNDpb5btfOSmOJT0yAFi31XQ515+f_1avZfwqBdA2A@mail.gmail.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <c83dd877-dd2f-9839-1ce3-f3d05cbebe97@flygoat.com>
Date: Wed, 24 Jun 2020 09:23:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc7kWNDpb5btfOSmOJT0yAFi31XQ515+f_1avZfwqBdA2A@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------F6B78975EC7D198DE8C5FFBA"
X-Rspamd-Queue-Id: 9844040855
X-Spamd-Result: default: False [2.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_SPF_SOFTFAIL(0.00)[~all]; URI_COUNT_ODD(1.00)[3];
 ML_SERVERS(-3.10)[148.251.23.173]; TO_DN_ALL(0.00)[];
 DKIM_TRACE(0.00)[flygoat.com:+]; RCPT_COUNT_SEVEN(0.00)[8];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+,1:+,2:~];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(0.00)[flygoat.com:s=default]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[multipart/alternative,text/plain];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 FREEMAIL_CC(0.00)[amsat.org,aurel32.net,syrmia.com,nongnu.org,gmail.com,lemote.com];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=217.182.119.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay3.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 21:25:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------F6B78975EC7D198DE8C5FFBA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2020/6/23 22:50, Aleksandar Markovic 写道:
>
>
> уто, 23. јун 2020. у 14:13 Huacai Chen <zltjiangshi@gmail.com 
> <mailto:zltjiangshi@gmail.com>> је написао/ла:
>
>     Loongson-3 has an integrated liointc (Local I/O interrupt controller).
>     It is similar to goldfish interrupt controller, but more powerful
>     (e.g.,
>
>
> Any pointers to documentation?

https://wiki.godson.ac.cn/ip_block:liointc

There is a translation.

The original documents can be found at Vol.1 of CPU user's manual

"I/O中断" section.


Btw: I've been very busy recently. But I'll take care of my series later

this week. Sorry for the inconvinence.

I was copy & paste licenses text from another intc driver and forgotten

to double check it.

- Jiaxun


--------------F6B78975EC7D198DE8C5FFBA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">在 2020/6/23 22:50, Aleksandar Markovic
      写道:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAHiYmc7kWNDpb5btfOSmOJT0yAFi31XQ515+f_1avZfwqBdA2A@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr"><br>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">уто, 23. јун 2020. у 14:13
            Huacai Chen &lt;<a href="mailto:zltjiangshi@gmail.com"
              moz-do-not-send="true">zltjiangshi@gmail.com</a>&gt; је
            написао/ла:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Loongson-3 has an
            integrated liointc (Local I/O interrupt controller).<br>
            It is similar to goldfish interrupt controller, but more
            powerful (e.g.,<br>
          </blockquote>
          <div><br>
          </div>
          <div>Any pointers to documentation?</div>
        </div>
      </div>
    </blockquote>
    <p><a class="moz-txt-link-freetext" href="https://wiki.godson.ac.cn/ip_block:liointc">https://wiki.godson.ac.cn/ip_block:liointc</a></p>
    <p>There is a translation.</p>
    <p>The original documents can be found at Vol.1 of CPU user's manual</p>
    <p>"I/O中断" section.</p>
    <p><br>
    </p>
    <p>Btw: I've been very busy recently. But I'll take care of my
      series later</p>
    <p>this week. Sorry for the inconvinence. <br>
    </p>
    <p>I was copy &amp; paste licenses text from another intc driver and
      forgotten</p>
    <p>to double check it.<br>
    </p>
    <p>- Jiaxun<br>
    </p>
  </body>
</html>

--------------F6B78975EC7D198DE8C5FFBA--

