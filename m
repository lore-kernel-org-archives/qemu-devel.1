Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76481C35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4001A20658
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="li12p+Xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4001A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Tx4-0005tH-5r
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 12:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@web.de>) id 1j0TtY-0003fP-Hv
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 12:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1j0TtX-0007X3-EQ
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 12:27:52 -0500
Received: from mout.web.de ([212.227.17.12]:47977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1j0TtW-0007WO-5t
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 12:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581182863;
 bh=JumUw+gArUHorGvI4sUVP/YGhPCioeC4AxkJDT+0lco=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=li12p+XiGuBxO3GQqffAdAm0wLh/oTepr9QvxE30J9aUquwuh8HduyPG+20rnzSeB
 Q2cp5tqU8ZHksVzhgTN3pSg20rK4egFQF+fJ3Wa0/N5kGwAUDSa0JpzhYFL79NESIo
 YvgjX7bez0Z5HauV2X9QEwash6J9ltFBSnaJ9e8M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLWc-1j0vkv33hW-00Yhkt; Sat, 08
 Feb 2020 18:27:43 +0100
Subject: Re: [PATCH v2 0/2] ui/gtk: Fix gd_refresh_rate_millihz() when widget
 window is not realized
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200208161048.11311-1-f4bug@amsat.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <9a755d19-5eef-3acf-011e-4b985d0cf20a@web.de>
Date: Sat, 8 Feb 2020 18:27:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200208161048.11311-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xdRkQM2gllCatPx8FEAYeLyp2+4T7i7ZCBWdmG7OMWuZ+OI3puB
 RWfS2ISsIh3LaMZ7tHt+zPmQzPdq9+QYf1L1GEJMaJJ7zswVkB40dSx8o6zj61PYs5lHT1O
 KirVxifSujdqweXUonx8OGPYKcoaBuvWn7UJOL/yXfikHPsQfgRdow1JMVErZ9tZnFhsmWH
 vR7yjXWAExbk2qYmGml/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H+PceyxPKr0=:v29k3fo7XpHpNjk4r9eR5x
 LNy29nbv+gi6bfAyvxIOvdfcTIn1Dqd32z/fSG+D6hgaISfHAfY2eGBOm3xZRDxn6/1WIExGv
 7x3aHz1JbKgtQYzITlEDQSEbcQ7DVGqR4RFJUmcdiQvq3t4rtBkzMj57plzDhUnLTic9B2lID
 84fr1G2dyyFOSO3leIOc9aNvmEwssAwWtZyhydqeINQNJ0Uem8+W3ONw1f62mo/Melz7IKrNx
 M7i5Zpo7ls3iVkX8/mqmRrudd0pG/y7Xkv4K2tNKS/YAVIfJ8TvXwk80U4iegidKA6wAMz+cA
 9YJcGcNc+giCh/K5PmLyB2Azv/ng1Oyi2CZMrwh+r5IsESIusErl1l4ex61sPIVj1dVga+JfM
 cSB6Zm3ryVyx/JUK/KwIixQwtnnw5UPPDs2GSr/mW0j+wnK1pP7WlgstXP5ECeeLtPFXGd2Er
 4edZ+EvZGMH2RcPcXsFc0APve5EXRXR+Y/FTnILxivf6kJi0xCHhZZ5oQKrzkD1Tidz7Rq2C1
 2ih5jU0PDi1aw8MTkH7miXmnZ4C0oKNQXuM/BTuk2O4XMz0FXKjUnTfTGgFhJrHqGULJe11Pn
 ja9EC1konP92Ek0Tmzesd8I4fm5/W/qBQroHhf3fuQ/PWgilfEL/1WZNYn7VICdnYg3esI0VD
 dGSuQg+Wc2m3zM2/cX+knvJGMt5+EjL/s2TxkSnfwvzKBSlvhBK9WqCvPnVzMwn9UwP+wT1rp
 oPb63vrzyBzwXg0r8oRGt7qpYkmsppd85dGGWRlBjS3XEyO4xK05uHGWL/v/f+gT4bV3bUIf/
 EJ+hYV3oJkn85U96No+wDHTA5gkRZKqBRuAfVT2j7YYJovRMeQqUYSM5qgCkZ7LzVd5nTZVNs
 O18oQB0+3WDq52UTRBVXH9s9rz/Ts3kLVRTQQ8hbeJ/zEvy54SKv7O/nUTaXL7lZnbNlv3q6b
 HEZkZzpTdzx7qkqEVYKB4XN6p+siJuFv/NMEzaQcRdewTa+AEGdRXHv1Ghf7zL3C75WOGYM6k
 08jMm29PY2S+6yK7G6WmHJvDVangLom66UMU4fSfgZ3O7FOgWAl9zoI3yv+T0Fxkn0YSUAZ2/
 BuMDBjzR+6JiaX7cd9V2PHZzQm/DMmaQXfPbWwQsOcFWKd+azLkSqrV3FtLYVHqB6qNY38zNi
 r4buJ5aXDlB4GqfDdxTp4dKp4CmocP8PhVTocrNYjzE78+zbbUXPURU/4YjE09WfVHsMiawtl
 jtbkgXGR1K/p9QBCU
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.02.20 17:10, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix bug report from Jan Kiszka:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg678130.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02260.html
>
> Supersedes: <20200208143008.6157-1-f4bug@amsat.org>
>
> Philippe Mathieu-Daud=C3=A9 (2):
>    ui/gtk: Update gd_refresh_rate_millihz() to handle VirtualConsole
>    ui/gtk: Fix gd_refresh_rate_millihz() when widget window is not
>      realized
>
>   ui/gtk.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>

Yep.

Tested-by: Jan Kiszka <jan.kiszka@web.de>

