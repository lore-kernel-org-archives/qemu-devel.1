Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFF3C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 13:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2C42080F
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 13:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bULyPf1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2C42080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBfAB-0001CN-TK
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 09:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arvidjaar@gmail.com>) id 1iBb9c-0006vx-0C
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arvidjaar@gmail.com>) id 1iBb9a-0000Ii-TD
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:54:07 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e]:39018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arvidjaar@gmail.com>) id 1iBb9a-0000E9-9X
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:54:06 -0400
Received: by mail-lj1-x22e.google.com with SMTP id y3so7860692ljj.6
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 01:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=bieKq7AyvjeJPWRkTs6/pJYEcLemLgq4FZ7EpICf4X0=;
 b=bULyPf1GHvXu0hDeCXpSVxiMXBLlJDlfB2YNNCH3ZKiHJKeXUYz1ts9SkaJRqZRgLA
 9/NOZGEPWX+zHVMqt+juWs6Br0J8+KVA4ZGA0nqg30kuD28sFIAQSwHfie3xXOPaPf55
 6QZoEM6W6hCvNObAcLD6JCE2iBwoe1Kled1qWdIYr/cFV9LopmGMYSNwYoS3fPWsgNnW
 kCiXKGd6GqP+KYpGNGwh8VcHWs/SYv7nu1T1/KBQQdHCfcV1XUBGc9JIQFcAa1mXnQna
 +GOJN0Z6jeOWlGjs/hbvhx2k+WDdKTfbRMPNUfOAnK7JSdh1UR8zmSJKHLRLxwk1JJcX
 UMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:content-language
 :content-transfer-encoding;
 bh=bieKq7AyvjeJPWRkTs6/pJYEcLemLgq4FZ7EpICf4X0=;
 b=ixI2lNKddbd7LN7KZD6uoW9sEAA2jX4dV4HIc/CvkKIx+bcQsY20a/71uOy0RUlMyM
 E2x/5AISGF8frveZkTnNHtOLbvqk8zEUgaRG1kv1k1sMum7W4BSjRPEtieh17uWXbal+
 ZqaOg53Rlj6he+iuXsrVm4uWVffSFyfIp8K3CHstAvTuCOKqKlE6GcMbF2lKIXvy2vyO
 bX89+G2seDmGhhxoGeVf4d3KscmR7l+ebAbQgq6bU6nLekk0EaANOSCy+9+fc69Sd2Z+
 QtV/HHVJQNTnXX1hd3sI1on+rHhg5HCZvdOHgp4uUxaQRAn1eCOMh8blcuQ3l4BKG52O
 lQBw==
X-Gm-Message-State: APjAAAVNNr4h+BI8krt9Js6f/zLI/bPHwvHqBnKW//4WZvxHAw2JJB8v
 Nz4d/akAmBzCSckq/WhLYUvmNzzIyGc=
X-Google-Smtp-Source: APXvYqwiC72eWUuG5F+y1uACPyVSpq9/amggeL3tu0NS0ofnFXHomOt6MwDxRFAEZsZiNb0DKqtc7Q==
X-Received: by 2002:a2e:808c:: with SMTP id i12mr11587928ljg.78.1569056043878; 
 Sat, 21 Sep 2019 01:54:03 -0700 (PDT)
Received: from [192.168.1.5] (109-252-54-49.nat.spd-mgts.ru. [109.252.54.49])
 by smtp.gmail.com with ESMTPSA id
 q88sm1019026lje.57.2019.09.21.01.54.02 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 21 Sep 2019 01:54:03 -0700 (PDT)
To: qemu-devel@nongnu.org
From: Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Cannot login into emulated smartcard with OpenSC because it expects
 external PIN pad.
Openpgp: preference=signencrypt
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <f3e43a87-3fb7-68c0-2ed7-8805ae67a372@gmail.com>
Date: Sat, 21 Sep 2019 11:54:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22e
X-Mailman-Approved-At: Sat, 21 Sep 2019 09:09:01 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

USB card reader emulated by QEMU announces presence of PIN pad. OpenSC
will not request PIN from user in this case and assumes PIN is being
entered off-band on external device. Unfortunately QEMU does not seem to
offer PIN entry and access to card always fails.

Changing device to not announce non-existing capability fixes it and
allows to use OpenSC framework with emulated card.

--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -398,7 +398,7 @@ static const uint8_t qemu_ccid_descriptor[] = {
                      * u16 wLcdLayout; XXYY Number of lines (XX) and
chars per
                      * line for LCD display used for PIN entry. 0000 -
no LCD
                      */
-        0x01,       /*
+        0x00,       /*
                      * u8  bPINSupport; 01h PIN Verification,
                      *                  02h PIN Modification
                      */


