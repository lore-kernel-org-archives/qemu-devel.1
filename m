Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF170C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574E3207F7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvantO0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574E3207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRAB-0000DG-Af
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPR9K-0008AE-O0
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPR9H-000216-PQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601906849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uu5P0a643E+CnAMSnHLByi0BivU7tkuSCL6Tf6hpw5g=;
 b=FvantO0Rxe11aUmIKxG01iVHipwSbsqMAnHVPKX5adLXGaXocrgKBIIs54epAyLlEsmMba
 oLXHEcgFJm2ubvKkTj1eFCYGXpz8MTddlEtb8ggQwOOLCBJI51JE2PcG3E3ocOp4VPFFgN
 6ZiPwsSWOg1HeIQCmimyOHvD7+0NTSM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-qHuYqw2gOeuu3c2L6Jy-xw-1; Mon, 05 Oct 2020 10:07:27 -0400
X-MC-Unique: qHuYqw2gOeuu3c2L6Jy-xw-1
Received: by mail-wr1-f72.google.com with SMTP id f11so1856139wro.15
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 07:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=uu5P0a643E+CnAMSnHLByi0BivU7tkuSCL6Tf6hpw5g=;
 b=hX0oAPGt65mAcu9Sek3eNg7+K+QBaFJBcUGJIADRN8eySkzQH5ddMtjJ5svdvwt6+5
 5mfl5k9wu1ZVH8aRLAmoJeV5pQCFp0SohYyFMyHbJPnytqHb7XBjhoLt3pAw3YMzywWG
 OZmsyu2ST1MhJhJHRLF3fFTKAvlNWH1JrZnDDaGwd4vykQVVcJ7Zrl6EWw4BnIZ1Ri8d
 OWusb+iYbrwPlGhoM9osguiT8bW+FkWuOb9hXGJEZC6IVw71QoQ43n/CZNO9ujRQPfAr
 iicglCODrn5pKFrhhTUdU9cfNWUDGjuxz1lWNsnL4L9ZnVqwwXqVSbyWwujiVfI+t8A4
 X7gQ==
X-Gm-Message-State: AOAM530zGoe1L2cZ5x13G+aRwBbShTG7dzlYxy/7kFlxu8nTKrDZQGoP
 s8H/6GBtwoT9+IG9/WlMkZV/KkTtxVWq6XBCqQU1UG4BgF7za5FSSDSQ4d21MdIHGjffBlCHv4i
 TXd0YaQKMyyoUqIM=
X-Received: by 2002:a1c:417:: with SMTP id 23mr7495124wme.1.1601906846467;
 Mon, 05 Oct 2020 07:07:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy/scG6S083BVI7cl1xVlNNHqPmiOp59pRP6ydUSxthsoDfkkw2k7fPFbtmXPOT27bc5GGFw==
X-Received: by 2002:a1c:417:: with SMTP id 23mr7495087wme.1.1601906846159;
 Mon, 05 Oct 2020 07:07:26 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d9sm12504743wmb.30.2020.10.05.07.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 07:07:25 -0700 (PDT)
Subject: Re: [PATCH] ide: clean up ahci_populate_sglist
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201005125527.429187-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <0de05b34-fbb1-d491-df2f-a49a0146c6d6@redhat.com>
Date: Mon, 5 Oct 2020 16:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005125527.429187-1-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 2:55 PM, Paolo Bonzini wrote:
> Alex reported an uninitialized variable warning in ahci_populate_sglist.
> Even though the warning is bogus and happens only because of -Og, the
> code in the function leaves something to be desired; the condition that
> triggers the warning is easily shown to be entirely redundant.
> 
> In particular, the loop's "if" condition can be rewritten from
> "offset < sum + tbl_entry_size" to "offset - sum < tbl_entry_size";
> this is safe since the LHS cannot underflow.  Because off_pos is
> exactly "offset - sum" it is clear that it can never be less than
> zero or greater than tbl_entry_size.  We can therefore keep the off_idx
> check only and, for documentation purposes, reduce off_pos to an unsigned
> 32-bit integer.
> 
> The tracepoint also is not particularly useful at this point, since
> we know that (if it ever triggers) off_idx will be -1 and off_pos
> uninitialized.  Instead, include the requested offset and the total PRDT
> length, which will be smaller than the offset.
> 

Reported-by: Alex Bennée <alex.bennee@linaro.org>
so we know which 'Alex', and:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ide/ahci.c       | 12 +++++-------
>  hw/ide/trace-events |  2 +-
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 680304a24c..997b67a6fc 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -924,8 +924,7 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
>      int r = 0;
>      uint64_t sum = 0;
>      int off_idx = -1;
> -    int64_t off_pos = -1;
> -    int tbl_entry_size;
> +    uint32_t off_pos = 0;
>      IDEBus *bus = &ad->port;
>      BusState *qbus = BUS(bus);
>  
> @@ -952,19 +951,18 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
>      /* Get entries in the PRDT, init a qemu sglist accordingly */
>      if (prdtl > 0) {
>          AHCI_SG *tbl = (AHCI_SG *)prdt;
> -        sum = 0;
>          for (i = 0; i < prdtl; i++) {
> -            tbl_entry_size = prdt_tbl_entry_size(&tbl[i]);
> -            if (offset < (sum + tbl_entry_size)) {
> +            uint32_t tbl_entry_size = prdt_tbl_entry_size(&tbl[i]);
> +            if (offset - sum < tbl_entry_size) {
>                  off_idx = i;
>                  off_pos = offset - sum;
>                  break;
>              }
>              sum += tbl_entry_size;
>          }
> -        if ((off_idx == -1) || (off_pos < 0) || (off_pos > tbl_entry_size)) {
> +        if (off_idx == -1) {
>              trace_ahci_populate_sglist_bad_offset(ad->hba, ad->port_no,
> -                                                  off_idx, off_pos);
> +                                                  sum, offset);
>              r = -1;
>              goto out;
>          }
> diff --git a/hw/ide/trace-events b/hw/ide/trace-events
> index 6e357685f9..81706efe80 100644
> --- a/hw/ide/trace-events
> +++ b/hw/ide/trace-events
> @@ -88,7 +88,7 @@ ahci_populate_sglist(void *s, int port) "ahci(%p)[%d]"
>  ahci_populate_sglist_no_prdtl(void *s, int port, uint16_t opts) "ahci(%p)[%d]: no sg list given by guest: 0x%04x"
>  ahci_populate_sglist_no_map(void *s, int port) "ahci(%p)[%d]: DMA mapping failed"
>  ahci_populate_sglist_short_map(void *s, int port) "ahci(%p)[%d]: mapped less than expected"
> -ahci_populate_sglist_bad_offset(void *s, int port, int off_idx, int64_t off_pos) "ahci(%p)[%d]: Incorrect offset! off_idx: %d, off_pos: %"PRId64
> +ahci_populate_sglist_bad_offset(void *s, int port, uint64_t sum, uint64_t offset) "ahci(%p)[%d]: Incorrect offset! total PRDT length %"PRIu64", offset: %"PRIu64
>  ncq_finish(void *s, int port, uint8_t tag) "ahci(%p)[%d][tag:%d]: NCQ transfer finished"
>  execute_ncq_command_read(void *s, int port, uint8_t tag, int count, int64_t lba) "ahci(%p)[%d][tag:%d]: NCQ reading %d sectors from LBA %"PRId64
>  execute_ncq_command_unsup(void *s, int port, uint8_t tag, uint8_t cmd) "ahci(%p)[%d][tag:%d]: error: unsupported NCQ command (0x%02x) received"
> 


