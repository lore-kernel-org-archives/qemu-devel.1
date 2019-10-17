Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCA0FA3742
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7D0214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7Nh5EfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7D0214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5E0-0007uR-06
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL5D0-0007Au-Sv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL5Cz-0002mF-Lm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:48:50 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL5Cz-0002ld-Fj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:48:49 -0400
Received: by mail-wm1-x341.google.com with SMTP id r17so6965393wme.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lYK+spAgVb0xWweCNgprStw/FyMXPkk5TJh8dSBXh0c=;
 b=o7Nh5EfIU2sakfhRBC7AZHGpbOBlEVoh5G4Ed9uzg0A04+1mLt4d+qPVkLzHmzOmUF
 jSh+seVjqPLqtR4MZsC4rpwalUZVUgrTlaK5LwjWvBJ/rIhvsur4njSvngf9QxOqiH0C
 5fT0rNMjSDaLd5ocIxPSYi3M+vzwtWdw9hnkfd3mOBMXUzN4NIsmKSt9EzuJHmWHOhRr
 f3m5VIRvso4SgER85KONpU30mzBT2RHlYfLM0Ui8rNvHWpJTgjkEWngjl5Fs2eFOJc93
 AvczZ7AWyp4cIRqn3sS1NJis5KBqvKTMk4J/J9KISsqXI48AahqEQghT3pMjroTZSuzt
 gSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lYK+spAgVb0xWweCNgprStw/FyMXPkk5TJh8dSBXh0c=;
 b=sjvr293ohdaTtmePcB3MDF///vWyfbID+jOorWU3pyKGmWaWm+fx9sqMlUaghkdGhl
 K2IpZgQBrwMZZkjV5dzGYLV+ymOBft7V4Mf2rYlM+NYX30S0b2eSBmGXw7P7YEeDNcxY
 PVOLPQGPOlkOCXG5XcusoNiqJ9o6Yoo7/9jaq5US6ImYvrCmJ7BoHsvL+4IFuT3T8qwg
 vxs57fzAz9ttspBY2lfA05+ly+ZWT1DQ/J1/RP3c7EWA6e3A8xNLA3zeiog1dp1Us/7M
 wGdhjLUbs5SAwKPJs5f/iByg32q1YJDmtJlVYZr736Rqemo6s77UFUUtR3MJVfwyhk8t
 g+KQ==
X-Gm-Message-State: APjAAAVvif36DhFPmV87IEoPQqc0WRr1tKYz2Qwj/MNAG6CBFtY/tBTA
 N61HnHsIysAkX+ZEx2eMMzg=
X-Google-Smtp-Source: APXvYqxfj5MLvh1gDMbwND32zy3vKJ2seEgHNBxRhu0+ylQJW13LGGs4lgP4Py6t1Nn38DxyhslGrA==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr2632372wmt.109.1571316527691; 
 Thu, 17 Oct 2019 05:48:47 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id r20sm2770158wrg.61.2019.10.17.05.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 05:48:46 -0700 (PDT)
Subject: Re: [PATCH v7 0/9] linux-user: strace improvements
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
References: <20190915213924.22223-1-f4bug@amsat.org>
 <872209d1-e47c-7385-5581-79c9e243803b@amsat.org>
Message-ID: <a7353ed7-334e-3f36-d234-d50e9dcff0c2@amsat.org>
Date: Thu, 17 Oct 2019 14:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <872209d1-e47c-7385-5581-79c9e243803b@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping ping?

On 9/30/19 5:44 PM, Philippe Mathieu-Daudé wrote:
> On 9/15/19 11:39 PM, Philippe Mathieu-Daudé wrote:
>> Hi Laurent,
>>
>> Few patches I'v been writting while trying to figure out this issue:
>> http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html
>>
>> As usual with linux-user files, this series will trigger some checkpatch
>> benign warnings.
>>
>> Regards,
>>
>> Phil.
>>
>> Since v6:
>> - Use ABI types in sockaddr
>>
>> Since v5:
>> - dropped 'Verify recvfrom(addr)' since failing LTP testsuite (see [1])
>> - also define print_sockfd() for bind() (patches #6 and #7)
>>
>> Since v4:
>> - rebased on master (no change)
>>
>> Since v3:
>> - addressed Laurent comments
>> - added print_sockfd()
>> - removed the print_sockaddr_ptr() patch, also the two
>>    getsockname()/recvfrom() patches for after 3.0.
>>
>> Since v2:
>> - display invalid pointer in print_timeval() and print_timezone()
>> - do not display gettimeofday() arguments
>>
>> Since v1:
>> - addressed Laurent comments
>> - added 'last' argument to print_sockaddr()
>> - reordered series, so patches already correct can get applied directly
>> - dropped "linux-user/syscall: simplify recvfrom()" for now
>>
>> v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05855.html
>> v2: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08216.html
>> v3: http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg00411.html
>> v5: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02067.html
>> v6: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01346.html
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02807.html
> 
> Ping?

