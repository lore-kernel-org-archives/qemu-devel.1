Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AFDC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 06:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8472F20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 06:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdPj2uJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8472F20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFAsg-0003yV-Lt
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 02:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFAs8-0003a3-5V
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 02:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFAs7-0005XG-9n
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 02:11:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:37235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jFAs7-0005Pq-0Q
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 02:11:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id d1so5042185wmb.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=wNtM1JpyJxZyN1nnu3nVss1axDTqswD94yxVAimi9lo=;
 b=jdPj2uJTLWyvVMH3SHbWB/ExqNbpAiRjObXht6FsZtHXKoHYh1nexIW+E13JEAGrfO
 Bcb9TrBtGgy/gKz+ewtCHfep/fjR+kltAlWjN96OZx+ww6K69Yv7c5p/01espm6f0BME
 wTnzaYSHCoTw8oUM0Rpjsu2rEYlF5vg1m5HDg0eHlqKJPsZq1cDhM0yiQquGjvcHRvOK
 T/as5phd0uyAtUbzfI82xCWKl//YdYj5tc058t8eFpoBp7YD4uvqb9SWuCEKf2VLOFgY
 BaQyHC8UIaxWnrP5fwRpiuHNv2gxoS8F2o2paRtVS1vMrjAbZf1KSRxE5/W3VFaGjDmO
 aIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=wNtM1JpyJxZyN1nnu3nVss1axDTqswD94yxVAimi9lo=;
 b=KsPNivZVyhCgzzJZjmNpx5kyRQSWPLx8LTGUmsBfVJluuTMCZpbaJ5SeVHXH25BAne
 IqLhMYT5sNE6BWagwPVZ/KfTYYCkCxjSqKU0Yv/uhdUZpDG2A115BcR9YleN2eqI4KkU
 hp4EQvuWHolgOWS34EqYmrWibQoyP/x1hrtj/BfPFPbNGGhtXs9R4NBjuqiQ44P0WEov
 d5oXR7HGtg+0SzZonPCFWEOgNqI8A4Yyy6CaAQiLWM5LdQ0ZJls0wkJ3yTsctPXJu38H
 zKa4t2YlROZ1dEsfjIsrQ1OkPuVXDjhBUQ3xSTNnNUhVluNoA7JJjZ23RF1zfKNDgUj0
 4b9Q==
X-Gm-Message-State: ANhLgQ0u5SewL4hCWDqV32Tk3sMkXz58tgVUBX4maVRjvd+UuVUTLwzU
 yLYN6Kn3j0qQx2RFUtKR8oNL/n3p1EKz5jPLO2iqfA==
X-Google-Smtp-Source: ADFU+vsduQCDWkDYGvu/KC1DvTX3m5BnBriEF9ydrXzslBIyuKTkyjo3oDQkXP92hhb+QT4CGs60Ny/Vw2cleaEtzIo=
X-Received: by 2002:a7b:c770:: with SMTP id x16mr7866991wmk.159.1584684664544; 
 Thu, 19 Mar 2020 23:11:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:600c:2c05:0:0:0:0 with HTTP; Thu, 19 Mar 2020 23:11:03
 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 20 Mar 2020 07:11:03 +0100
Message-ID: <CAHiYmc4BaD+Bz3kchga2UCoernvvfq=Zc_wJyti05En-4QAKSA@mail.gmail.com>
Subject: [QUESTION] Getting configure options for a given QEMU executable?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000082dfd805a14326ee"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

--00000000000082dfd805a14326ee
Content-Type: text/plain; charset="UTF-8"

Hi,

Given a QEMU executable, is there a way to find out the configure options
it was built with?

(context: we frequently get bugs involving QEMU built for a particular
Linux distribution, and knowledge about its configure options would
certainly be helpful while reproducing and debugging)

Thanks,
Aleksandar

--00000000000082dfd805a14326ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>Given a QEMU executable, is there a way to find out =
the configure options it was built with?</div><div><br></div><div>(context:=
 we frequently get bugs involving QEMU built for a particular Linux distrib=
ution, and knowledge about its configure options would certainly be helpful=
 while reproducing and debugging)</div><div><br></div><div>Thanks,</div><di=
v>Aleksandar</div><div><br></div><div><br></div>

--00000000000082dfd805a14326ee--

