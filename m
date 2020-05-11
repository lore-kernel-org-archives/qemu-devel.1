Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B97EC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6046820736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="VoisRkrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6046820736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4ut-0000VN-5A
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1jY4sN-0007S9-Vq
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:37:32 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:59958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1jY4sM-0008P6-HD
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:37:31 -0400
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 1AD1296EF0;
 Mon, 11 May 2020 09:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1589189847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qrp09nn4bKJNi0+huvUws2uTX9fOuj7EqBmFOFnoXRs=;
 b=VoisRkrCMvT6CcVzAUphHW0Gs+4+MdcGteY5Pep2lwmuumYFRb6/Zynz34noBZAosBt1pU
 EkiRwtea15ppEowqGVu4dO1zbNSucs/iCWTRRgdAabcWb0Zj45F0U7lgK2hUx9NgCiipS3
 Roio2YsPm3nX5hLvwv1H4lRNVzAuECc=
Subject: Re: [PATCH v4 08/10] hw/core/resettable: add support for warm reset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-9-damien.hedde@greensocs.com>
 <762b6429-15af-4f6e-2a31-87e3d3313f86@amsat.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <1c84c058-0b8b-7e70-0739-09fe3b65dcc4@greensocs.com>
Date: Mon, 11 May 2020 11:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <762b6429-15af-4f6e-2a31-87e3d3313f86@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1589189847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qrp09nn4bKJNi0+huvUws2uTX9fOuj7EqBmFOFnoXRs=;
 b=bUGDaoPKhNNfD2q2wwpszP+HRgpJwQ2t4YlC7Y8AETvNQATGGgzeCDFcQ/WOPOsHp+Asz4
 xnCkN+vcRHmvI0snwF2IQrcDMpPmhc3srOKoOzLIzcyzYqVo6JbmRZutVpnVr+8vxxVNTk
 UrQoJmGmksVYmPLmr5xtlEHXVuwVV6c=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1589189847; a=rsa-sha256; cv=none;
 b=NdBZmD9cdMnfvoLBNZbfvCVOHGKnF98HrM1yY+C8fPNpnS7ai1257m5qfmsjWZwJjJemDa
 uMd/Hjtao5EaZ+C0BdcJHetL6xLYJcLrBdzKo31W/4U3vrfZRyaR9GOkkq39hd9EFTB9Ft
 SrypVncu6EHMFAr6MJMTyVvdwqXwtko=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=damien.hedde@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 05:37:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, berrange@redhat.com,
 ehabkost@redhat.com, mark.burton@greensocs.com, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Philippe,

On 5/10/20 10:17 PM, Philippe Mathieu-Daudé wrote:
> Hi Damien,
> 
> On 8/21/19 6:33 PM, Damien Hedde wrote:
>> Add the RESET_TYPE_WARM reset type.
>> Expand the actual implementation to support several types.
>>
>>     /**
>>    * ResetType:
>> - * Types of reset.
>> + * Types of reset, values can be OR'ed together.
>>    *
>>    * + Cold: reset resulting from a power cycle of the object.
>> - *
>> - * TODO: Support has to be added to handle more types. In particular,
>> - * ResetState structure needs to be expanded.
>> + * + Warm: reset without power cycling.
>>    */
>>   typedef enum ResetType {
>> -    RESET_TYPE_COLD,
>> +    RESET_TYPE_COLD = 0x1,
>> +    RESET_TYPE_WARM = 0x2,
> 
> I'm a bit lost with the various iterations, what is the plan with warm
> reset, is this blocked due to discussion, API, something else?
> 

I removed it in the last versions of the series because it was adding
complexity. There were unsolved issues and discussions, in particular
regarding the interactions and propagation along trees between the
different types.

Damien





