Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE8EC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEE92072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="sCK5bRuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEE92072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioSca-00050d-TE
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 08:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ioSbn-0004SI-HC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ioSbm-0006Ku-3a
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:39:51 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ioSbl-0006KE-M9
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:39:50 -0500
Received: by mail-pf1-x441.google.com with SMTP id x6so25901354pfo.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 05:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4h9nMfiol41vhixVET88rjxNUVMMmEa+T36nR+EWwjQ=;
 b=sCK5bRuKU5rjPFaBpC1SgAzGPkOYTQBEA8PTpNI1IclGpVdYbEfUrROAtt5+msoLE3
 1LoEoyS+pRkRk3atdOdCE7oC+yJJ+J5NkGa5NFTs4tTnnix6NV3A0VxRXnKNrTJijHES
 6sRDZUKHXuDpbwfB4Qatyg5Y5qhsDzjRK5u9UTbe+mIVBsYYO/o/HzfH1ZBhJg6YkEMs
 BpbgC/bA7zMOnwhNGHwq+lCyGlf92fjEpBvYv9sizb3zIiXjf9EeeOKSYjr1E0CByYu8
 ufMQC667C6W/at4W/diIzWiQ2g8g8oB8wqq7qpg+AXkwM3LfJ0ehrKECe7Yscu5qfn84
 RgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4h9nMfiol41vhixVET88rjxNUVMMmEa+T36nR+EWwjQ=;
 b=GyFFZTxvG+a88pawIlLk7Pu6LZtpaYuRi5RkUCVbLENQKEMg2jAjj9kLMdEIp98zh6
 m0s0lipcBDRjHYQnz4XgRSx7abwOauJ8vtrj5B00tVoTBgpY6To0e+1NEIn9kZXioaHc
 r26tlHIEyHZj246F9vS8WVwhnzQ8CyZVU1BxDOXAfBR/DgOhjFgvEb3JhTFl4Lxp9bRZ
 WlUwzAGThgjGk8ht3xLY02RWIf6PCLhgL01Y2SGCRjzvITwHC2me0kV9PA3zhImkZsSB
 teHJwuR8uoVFQMgGkWVqKK+oI7/YPHbahUZAOPyqGUM6e3IlxhFrFkVEZTSOZW3fzNPX
 WKDQ==
X-Gm-Message-State: APjAAAX58VJ0QJTN5M+P3UNKb5ZP6svv8ymlm5aAEAyl6o34UsFiWaJ5
 7buXYS5awMyMAydUS/WOFFjlQLpYcPE=
X-Google-Smtp-Source: APXvYqxIPie8FZltg/ASqOgSxFIBYUWKhFgGo3v92Qa4ZI+ZrKPWvsyHE4H+jXBD3hmI1GH2wFQAGA==
X-Received: by 2002:aa7:9205:: with SMTP id 5mr110718685pfo.213.1578317987941; 
 Mon, 06 Jan 2020 05:39:47 -0800 (PST)
Received: from [192.168.10.152] (124-171-196-88.dyn.iinet.net.au.
 [124.171.196.88])
 by smtp.gmail.com with ESMTPSA id y21sm57276659pfm.136.2020.01.06.05.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 05:39:47 -0800 (PST)
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d8ad377b-3ac1-d190-af5e-342b0e0ba47d@ozlabs.ru>
Date: Tue, 7 Jan 2020 00:39:42 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200106041940.GV2098@umbus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 06/01/2020 15:19, David Gibson wrote:

>> +    const struct fdt_property *prop;
>> +    const char *tmp;
>> +
>> +    readstr(prevaddr, prev);
>> +    for (offset = fdt_first_property_offset(fdt, offset);
>> +         (offset >= 0);
>> +         (offset = fdt_next_property_offset(fdt, offset))) {
>> +
>> +        prop = fdt_get_property_by_offset(fdt, offset, &namelen);
> 
> fdt_getprop_by_offset() also returns the property's name without
> having to dick around with fdt_get_string() manually.


btw I looked quickly:

const void *fdt_getprop_by_offset(const void *fdt, int offset,
                   const char **namep, int *lenp)
{
     const struct fdt_property *prop;

     prop = fdt_get_property_by_offset_(fdt, offset, lenp);
     if (!prop)
         return NULL;
     if (namep) {
         const char *name;
         int namelen;
         name = fdt_get_string(fdt, fdt32_ld(&prop->nameoff),
                       &namelen);
         if (!name) {
             if (lenp)
                 *lenp = namelen;
             return NULL;
         }
         *namep = name;
     }

     /* Handle realignment */
     if (fdt_version(fdt) < 0x10 && (offset + sizeof(*prop)) % 8 &&
         fdt32_ld(&prop->len) >= 8)
         return prop->data + 4;
     return prop->data;
}


and incorrectly assumed *lenp is the name length because of "*lenp = namelen". Huh :)


-- 
Alexey

