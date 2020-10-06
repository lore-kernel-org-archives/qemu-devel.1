Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657D5C46466
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA44206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOByN83l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA44206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpiW-0000I6-S5
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPpZ8-0003xt-8l
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPpZ6-0004cZ-05
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602000706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XrGp8Jj6tCsW728c+ZrPtJGronrbJbGec27qByXnjck=;
 b=HOByN83l5sDLnefPJClPw204ZmWH3DUMLEuNGR7zgQ3qwr4cCmIZfDLOWzGWJFntYEDK2J
 Atli7OyooheDPtmP7LXOkqwatQ7LpOBuBYWfIKwR2h7jDPLEsyAshAX91gU+NFvCqDjWFf
 Rjk5gOuN7kPmttuTCwtop5bWRy6mPN4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-7cm8gxRFNCGnfNJ-jZnnWA-1; Tue, 06 Oct 2020 12:11:44 -0400
X-MC-Unique: 7cm8gxRFNCGnfNJ-jZnnWA-1
Received: by mail-wm1-f69.google.com with SMTP id s12so1265819wmj.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XrGp8Jj6tCsW728c+ZrPtJGronrbJbGec27qByXnjck=;
 b=RAE5iQdH7r04wSpJNoLGzzCmBtHx1ojkW/wOd8FsWnrU33cUHaeySsx+9jNhdcFukq
 ZNfDQY0GhN2QYMscw1/Teidb/gz1CihUNIruF/ys82+sMx/dKwGUWTrwTMsgQ7dSIC+N
 xxpSXVh/OPoTz96N4Ydd/YxiP0RZqfFX6Tu3uYKzpyPDtGX2VrlE3qexvsX7NZpD6k2D
 IrTRUpCuzyByGa5uZKGRVZ4M9sohZh1YDZ5P6f6GfTK5rkX2fFOqOHLs+/YX0ZfopdDf
 IhdVj7e1MMtuFDFhd5qgIW7GFSg7ikhiY6cYuBSX8YAckT6m9Q4gTDYkG/PA9eg5fPXe
 iy9Q==
X-Gm-Message-State: AOAM532L9IwKdPXtrPvsR+WAKNfFWUNLheGzQaqVambqIOn2LCmGb6gP
 iIPd2liqo9rW6qbVmJIU/wNqV7mXUiVQ/kgckmNqO40nFZbGNnhQrbVIqh42s2q6ZJgBOuwdrJe
 L8KBpmLef6ydsLQE=
X-Received: by 2002:adf:de11:: with SMTP id b17mr5796921wrm.82.1602000702801; 
 Tue, 06 Oct 2020 09:11:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTmM1LAvnGcbRIUMZexysxxUDlae4bDtI2RmHv47a7tF7nfE8eSlLW0fgf+FKsR/YAdRPFYA==
X-Received: by 2002:adf:de11:: with SMTP id b17mr5796895wrm.82.1602000702550; 
 Tue, 06 Oct 2020 09:11:42 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c4sm5035887wrp.85.2020.10.06.09.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 09:11:41 -0700 (PDT)
Subject: Re: [PATCH] hw/ide/ahci: silence a compiler warning
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201006154256.17392-1-alex.bennee@linaro.org>
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
Message-ID: <fe606f5b-db17-1f5b-9b8b-96b4b4910c0c@redhat.com>
Date: Tue, 6 Oct 2020 18:11:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006154256.17392-1-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 "open list:IDE" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 5:42 PM, Alex Bennée wrote:
> When built with -Og -ggdb with gcc 8.3 the compiler gets confused
> reporting:
> 
>   ../../hw/ide/ahci.c: In function ‘ahci_populate_sglist’:
>   ../../hw/ide/ahci.c:965:58: error: ‘tbl_entry_size’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> As prdtl being > 0 is a prerequisite for running the code which
> guarantees we execute the loop at least once although not necessarily
> resetting off_pos/off_idx which should short-circuit the test anyway.
> 
> To save grey hair initialise the value to zero and move the variable
> to the local block so future changes can't accidentally use it.

Paolo fixed it yesterday but forgot to Cc you:
https://www.mail-archive.com/qemu-block@nongnu.org/msg75131.html

As your patch is also valid (and simpler):
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  hw/ide/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 680304a24c..f5c20c7d55 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -925,7 +925,6 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
>      uint64_t sum = 0;
>      int off_idx = -1;
>      int64_t off_pos = -1;
> -    int tbl_entry_size;
>      IDEBus *bus = &ad->port;
>      BusState *qbus = BUS(bus);
>  
> @@ -952,6 +951,7 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
>      /* Get entries in the PRDT, init a qemu sglist accordingly */
>      if (prdtl > 0) {
>          AHCI_SG *tbl = (AHCI_SG *)prdt;
> +        int tbl_entry_size = 0;
>          sum = 0;
>          for (i = 0; i < prdtl; i++) {
>              tbl_entry_size = prdt_tbl_entry_size(&tbl[i]);
> 


