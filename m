Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9EEC3B1B7
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDD522314
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFOUXoGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDD522314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fTE-00033u-CP
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2fSZ-0002XM-Cz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2fSX-0006JK-8p
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:13:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2fSX-0006Is-4s
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581703980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmFIz5TKVSPNTaiM1HXJfIpF0BfVZxsWWORnFsR1XG0=;
 b=CFOUXoGxrppC2Ol7wA7xYItBVM2l4pSpfM3yV0q/qymFdr4X4ASdrZO3LapfmZWdNk/+gH
 CyUpiejS18HTigtQ1vQ+21eV9+0mXhYYkxlML4/G5xv908ededv4butDUq/SdGx+464Zen
 aNwLCkp83FbE1vahVhdo3IUAVRF4xF0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-BIJpGvsmNROoBxdSZ8_htA-1; Fri, 14 Feb 2020 13:12:53 -0500
Received: by mail-wm1-f70.google.com with SMTP id d4so4302129wmd.7
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pmFIz5TKVSPNTaiM1HXJfIpF0BfVZxsWWORnFsR1XG0=;
 b=FETaTUUgcEoSoYXBSfcTtVUsNQdcudO+HuY8VtvdB/JtAD7nsY6lUmrwdKfk6LJ5oI
 /LADBGpqRnv67WlJjeYXuFB1lV4kn6AlN2kkKF8R3fQPVdUCSdCoBO/lbj12LLdygnLt
 5bKURQ1L5NDzaUW0CGNoAzd17mBJY77fuoZVY5fu260KoRqYz0RI3v1Mc9I5MdI7rm7m
 vt6YND8ilj4jyEW9fXsi6uqsn63ZiIuQ9Orwws5LmWhbJ5axYLCErazbCDRlPit+CT2w
 IVbKjkDHZFhMtQssX4AxvZndwUbS248Exn3Pp8/6mJMmi/ZudpMwhWIY29czE6eq7VEO
 4LHA==
X-Gm-Message-State: APjAAAW88XorsG5jN0rq6He9cf6dYT3eykEU3j3eZLR5KUVSpSTzcNe/
 /eMOUe6DuoS0dlD/ilCKOFlk8kUE6LQ/Ttr6s6idc8hKqOi89zJFVUYVSOQqz/mZP0mn50b7muB
 ZOvF0M5NP+6cvLeU=
X-Received: by 2002:a7b:c759:: with SMTP id w25mr5801250wmk.15.1581703972618; 
 Fri, 14 Feb 2020 10:12:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEeXP41wMgomMHENPaHG/3BCqLyFIvsHvzYlIYlZ6Tre8VIR5LKJLUjFro7V0pIlxH8tQUKA==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr5801237wmk.15.1581703972408; 
 Fri, 14 Feb 2020 10:12:52 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y12sm8162291wmj.6.2020.02.14.10.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 10:12:51 -0800 (PST)
Subject: Re: How do UEFI on Windows host
To: Jerry Geis <jerry.geis@gmail.com>, Laszlo Ersek <lersek@redhat.com>
References: <CABr8-B4_mEkOkodKVVe=U_eiMemWictNSQj4T5R6nEynVXCEGw@mail.gmail.com>
 <58491266-962f-4c4f-9a51-829ec30f008b@redhat.com>
 <CABr8-B6xARb1iuD7M_i9Pgs7OXF+EQQBxKDDC-o_imbiEDbMJw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6aad5b16-53c5-4485-381c-1cb990c8b766@redhat.com>
Date: Fri, 14 Feb 2020 19:12:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABr8-B6xARb1iuD7M_i9Pgs7OXF+EQQBxKDDC-o_imbiEDbMJw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: BIJpGvsmNROoBxdSZ8_htA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 5:37 PM, Jerry Geis wrote:
> I dont know how to get all files listing on windows. But, I cd \program 
> files\qemu
> dir *.fd
> edk2-x86_64-code.fd
> edk2-x86_64-secure-code.fd
> 
> It seems like from other posts these might be the files - but still not 
> sure how to do "boot" a command line for UEFI.

I tested/added these files in commit e54ecc70c34:

     NSIS: Add missing firmware blobs

     Various firmwares has been added in the pc-bios/ directory:

     - CCW     (since commit 0c1fecdd523)
     - skiboot (since commit bcad45de6a0)
     - EDK2    (since commit f7fa38b74c3)

Stefan can you describe how you generate the binaries in 
https://qemu.weilnetz.de/w64/ ? Maybe the bunzip2 step is not called?


