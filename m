Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A3DECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7982089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MI7rIJJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7982089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL35D-00086E-Ld
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL33v-0007dx-0r
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL33r-0005EY-TB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:31:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL33q-0005DY-Dc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571308273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFvWAIhF5G/log+dilYZg9xTxq+M+pVgVqQz8RVrgtA=;
 b=MI7rIJJR9i9tYpQqCNrAZRv3tH7BkDJqOtkWmT5bpO3DHnwUamffhNW9p52dUffPjnkuIf
 FCAgjVrXcJpZsWjUj41nJ7bu98NsRZCD65Zt5gcYaIyzKMCGT6aoc4WyvhYL6jn9nlGjxB
 nyvoLrZuZPQdsQIHjhAPmT/EASWsAA8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-jMYJ-bFQNVC61w95B10ZFA-1; Thu, 17 Oct 2019 06:31:11 -0400
Received: by mail-wm1-f69.google.com with SMTP id q22so850139wmc.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 03:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NhpoJZokVw1gz3HZCKXMHZSg8vltMYVYwFoLydaJHAA=;
 b=Y1+gTVkEoXNEhXMvQ8hkBnOyjIlz3xxk6iibFIuCjlFo4q5RQTotU/XNY3xuYCdssV
 5u44NnHwqSpsugh+TXwMEU4jGPXxur6Fzwjcd0MzkeI0SArazi702SLGLhGS0N0wC/V1
 Tz0B8+4QYGT3i3iHPTdaGYC+TBdHg/sqD7X9Cui6x9LPmjqljgtoDkfHp67k1xxzPnKo
 KCGNtBBM0S3m5WFONA0qx/5yeOO5MWDSw0CKGc9Uq1qbKU4T3+4NLYcDuipbu5cwRX88
 Q6yljsPH3g3RRIOMJ4UW+dYf/00GRakENynlxC/g0Jpf9r2Am65IsfMxQoHfiM9rB23/
 vJqw==
X-Gm-Message-State: APjAAAW7QCx3lTNwd8PUcnhgJw5ZGBo3KdQZMwvfqYtgXPzUKVARHsEX
 CUcz6HzaDhtTb8On9QeOM3jLVFW0r3tM9jCJfN27KzzktD5ZyJnj2Yj2XxIVg0cTcdd7OwojE+N
 g4Ke28V5pBCWANeI=
X-Received: by 2002:a5d:4588:: with SMTP id p8mr2345178wrq.180.1571308270415; 
 Thu, 17 Oct 2019 03:31:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwE5nahVB2lO/HMpBU3yVf26cjy2B6WWhRVhPCX1CauXVnbxJpOTJ0bmJHRP2oaC/WsQCQcCA==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr2345150wrq.180.1571308270145; 
 Thu, 17 Oct 2019 03:31:10 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id n18sm1850287wmi.20.2019.10.17.03.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 03:31:09 -0700 (PDT)
Subject: Re: [QEMU][PATCH v2] ssi: xilinx_spips: Skip update of cs and fifo
 releated to spips in gqspi
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Alistair Francis <alistair@alistair23.me>
References: <1571307474-16222-1-git-send-email-sai.pavan.boddu@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <20d7bc46-c9fd-dda1-0e8a-2a9b9d5645ef@redhat.com>
Date: Thu, 17 Oct 2019 12:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1571307474-16222-1-git-send-email-sai.pavan.boddu@xilinx.com>
Content-Language: en-US
X-MC-Unique: jMYJ-bFQNVC61w95B10ZFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: edgar.iglesias@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 10/17/19 12:17 PM, Sai Pavan Boddu wrote:
> GQSPI handles chip selects and fifos in a different way compared to
> spips. So skip update of cs and fifos related to spips in gqspi mode.
>=20
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
> Changes for V2:
>      Just skip update of spips cs and fifos
>      Update commit message accordingly
>=20
>   hw/ssi/xilinx_spips.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index a309c71..27154b0 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1022,6 +1022,13 @@ static void xilinx_spips_write(void *opaque, hwadd=
r addr,
>       }
>       s->regs[addr] =3D (s->regs[addr] & ~mask) | (value & mask);
>   no_reg_update:
> +    /* In GQSPI mode skip update of CS and fifo's related to spips */
> +    if (object_dynamic_cast(OBJECT(s), TYPE_XLNX_ZYNQMP_QSPIPS)) {

object_dynamic_cast() is expensive, please add a 'bool is_qpspi' in=20
XilinxQSPIPS and set it in xlnx_zynqmp_qspips_init().

> +        XlnxZynqMPQSPIPS *ss =3D XLNX_ZYNQMP_QSPIPS(s);
> +        if (ARRAY_FIELD_EX32(ss->regs, GQSPI_SELECT, GENERIC_QSPI_EN)) {
> +            return;
> +        }
> +    }
>       xilinx_spips_update_cs_lines(s);
>       xilinx_spips_check_flush(s);
>       xilinx_spips_update_cs_lines(s);
>=20


