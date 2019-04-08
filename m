Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0CEC282DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335AB20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQVKtTI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335AB20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50187 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQm4-0002JA-5l
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:41:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hDQl9-0001t4-5P
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hDQl8-0005lU-AB
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:40:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hDQl6-0005kK-RR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:40:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id y7so15473686wrn.11
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=r5BMkOuVnSJRjRnzpUDwtGjzp8Irr7hpDVQ+2U2Dvbg=;
	b=YQVKtTI5iG3RcNjrrufnr5ZgephJLI5w1wSiEJn61P39EPpigQug8bKFAnOb2NEbZx
	0IYDBtgzpkfM/srCEuXvN9cFFYOx94ww3PoFxC990udz3Sx6jfIBfpiF0buMn2e5CwoD
	gVrZoSTULwAFSzH1wdv+tUf/vtIk0NZBpSn5zeB1pTUn/9hohQAHn/vVhjV5zX2lds/Y
	xBrPOXycxL/GWf2dClQSqh9OyPPwDmfvTgEaTO3/Ch/UCnbrE5dJBU3GhPZnmk4ySxNy
	cAqExT66fyRwQtrKM9RLNP4GsVM5XwSLjQOjpSy21EFucrPj5vktRL444NRozQCxzwxt
	loRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=r5BMkOuVnSJRjRnzpUDwtGjzp8Irr7hpDVQ+2U2Dvbg=;
	b=ijfy0eGM/GUrL/a+2X2yGO3CstuQ+rl9fay+7YKz90lzN+6JPHjQeZEi3F20Nx91GF
	Q/cQEdkCXdbqxLapij3XNGle8mxv3ezavE2RcJqJVfdTNmfYaaB6WYEwXtbOD+pOzla+
	zgoAigIcCaQrNIP5xWP8urcG3/uQrLNVD+pvUIpTiF5apEaWZZJ8zwD/9nFYj2wSNw/W
	hr27rsEpOnFwWN0gPG/DbNUROf7SGuKyNUiofV8aOCJhpfqRDrwK5dJn/7ywQQZG8CBj
	szueQDBNYy8wJ9Y9ER/BZMJ/7vKnMVuxtMZeWrUqCb3A7TXT7q2TTssHo8TZxtEZK8gv
	M6OQ==
X-Gm-Message-State: APjAAAVezKtv+jZ+R3WPBZQhFFBlYRgRLyXIbcbMC6ZCzx01Bcqlzmlh
	fi0uCOvBuq0kaes1danjlQI=
X-Google-Smtp-Source: APXvYqzBwoAarP8g5I80gwCglPANLdHxZlCG4fXVv+0ruMGtDmlRwNzX4ymGcPFkmQN9FViUw8QRcg==
X-Received: by 2002:a05:6000:1286:: with SMTP id
	f6mr12543738wrx.93.1554716406889; 
	Mon, 08 Apr 2019 02:40:06 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id
	r30sm94266294wrr.46.2019.04.08.02.40.05
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 02:40:06 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-7-armbru@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <0e6fed9f-a8c6-6dad-b27f-4eb62db8dd7e@gmail.com>
Date: Mon, 8 Apr 2019 11:41:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-7-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 06/15] pci: Report fatal errors with
 error_report(), not error_printf()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408084107.XzPiK0DfSLZP7MMxr3rC3VXB592abZHYuqD2LZ__7LU@z>



On 4/8/19 11:36 AM, Markus Armbruster wrote:
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/pci/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 35451c1e99..a74995b596 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -927,7 +927,7 @@ static uint16_t pci_req_id_cache_extract(PCIReqIDCache *cache)
>           result = PCI_BUILD_BDF(bus_n, 0);
>           break;
>       default:
> -        error_printf("Invalid PCI requester ID cache type: %d\n",
> +        error_report("Invalid PCI requester ID cache type: %d",
>                        cache->type);
>           exit(1);
>           break;

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel

