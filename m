Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CD223D4E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6cw9wuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CD223D4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptQl-0004sj-RC
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jptQ3-0004RS-2t
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:01:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jptQ0-0002nX-SZ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593435711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n5F1lGFpJu3lzkSkwYnxy9ddIuRSithC+ivalFv6U2E=;
 b=a6cw9wuWDPDGOpKVVUbDzTTpMoG9sY5F+xlzGJfl3M7eOv/OEcOOWpNimKKLeUmMRQilDn
 +FSdwuJgFrNemLV1Hh3llxuqmG3UvjTy03FIpIzXCOgaYaLXmN/qc0p0/l0cuWx8Ai1A6Y
 howeKl6y8MAt8eyVtlefcNMX7+KN9lw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-SIUguD9zMHCohNje_p_tnw-1; Mon, 29 Jun 2020 09:01:46 -0400
X-MC-Unique: SIUguD9zMHCohNje_p_tnw-1
Received: by mail-wr1-f72.google.com with SMTP id h28so16448923wrc.18
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 06:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n5F1lGFpJu3lzkSkwYnxy9ddIuRSithC+ivalFv6U2E=;
 b=KUNhLfZvziX/xyKPigtzjoa6Z6fDLZo0NO8+AWPYndqvrbSZivQfXSuY0Dtr9BMVe7
 pe9W4RkN0gmV2NN5V5FVUXWLdO7qtNEOk77ujK5McTCNrdAKtvB6whRQyvwsQI47sZ8r
 7Tvhez2aPo5cZVdih7CfaQcwbfHvN4at5mfiJgzWq6x8AhOyo8IkVoZs6yGuh/ZLvJqH
 9Zgl5LRPQzo8KFKuUlhlv5pLFLbO4WrtUlnjRBz4QcuFGlNceRB/mzSOQ7kjGIXbcF2F
 RPJ0azSAP7yDLyLSBE8MBYTj8rr+MfODJPXFMbiSgZFSaZa0/WFfQYOGSZwOn5YrTyID
 k3tQ==
X-Gm-Message-State: AOAM530lsIuLOKMRVkFzRBoBZlulT6Uf9hUKzDrkiQlIS41uzlyqsf/S
 S0kvxc8srsT0/FvnT4NWvdpH7b7H3s5fLwZNzisL7LMHmcxxpxuSS8uU6u+jl17DssSMODos/PK
 VetqCOSAV1tu9vdg=
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr16609094wml.170.1593435705699; 
 Mon, 29 Jun 2020 06:01:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwbaRZKtKyYY31rqWiJr7HmzQIBC8ejSxBN7MXvLmexITjEZjGiAZ10J7FswJqo8e1qpaudw==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr16609066wml.170.1593435705491; 
 Mon, 29 Jun 2020 06:01:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id x13sm51002511wre.83.2020.06.29.06.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 06:01:44 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] scsi-disk: Add support for the GET LBA STATUS 16
 command
To: Stefan Hajnoczi <stefanha@gmail.com>, Lin Ma <LMa@suse.com>
References: <AM6PR04MB578290CA80CC6000756C4C0EC5920@AM6PR04MB5782.eurprd04.prod.outlook.com>
 <20200629103948.GF31392@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0aaecca-877e-fe51-9248-064dd8855b57@redhat.com>
Date: Mon, 29 Jun 2020 15:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200629103948.GF31392@stefanha-x1.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 12:39, Stefan Hajnoczi wrote:
>> I don't know which one in BDRV_BLOCK_* can be used to represent 'anchored'.
>> It seems that I need to use BDRV_BLOCK_* combination to recognized 'anchored',
>>
>> I'd like to use these combinations to analyze the bdrv_block_status() return value:
>> 'deallocated': BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_ZERO
>> 'anchored':    BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID | ! BDRV_BLOCK_ZERO | ! BDRV_BLOCK_DATA
>> Am I right?
> My understanding is that the SCSI status are mapped to QEMU block status
> as follows:
> 
> allocated: BDRV_BLOCK_DATA | !BDRV_BLOCK_ZERO | BDRV_BLOCK_OFFSET_VALID
> anchored: BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO | BDRV_BLOCK_OFFSET_VALID
> deallocated: !BDRV_BLOCK_DATA

I agree except that I wouldn't test BDRV_BLOCK_OFFSET_VALID.  For
example a compressed cluster would still be reported as allocated even
if BDRV_BLOCK_OFFSET_VALID is cleared.

Paolo


