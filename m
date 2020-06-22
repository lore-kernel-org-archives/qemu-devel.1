Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB1AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8F72071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd84+Wdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8F72071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNgS-0008N5-Oq
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnNYP-0003YT-9R
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:36:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnNYL-0006JZ-DH
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592836564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moaZohW8jViZzq8ht4JalzN6TH7/1foBJAIsOHN/8h0=;
 b=fd84+WdlKbZFmMHObqjTYAYpdMAKDlhHnqE8dmtHRfx7R+6v+JrA5bBiaw6XkaIhdCfoxd
 cnvB/59elQNxC4MVqZszuQ2wLoWHunAEW1RmzbthtOE6OQoIe+yTrIWWHRKSp01LD99QIq
 2bvQ+yROdqtqDpCaRsGD8sR6kOrA9mU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472--PPd0-wtN9aWtoURwRLHjQ-1; Mon, 22 Jun 2020 10:36:02 -0400
X-MC-Unique: -PPd0-wtN9aWtoURwRLHjQ-1
Received: by mail-wm1-f72.google.com with SMTP id t127so7538709wmg.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=moaZohW8jViZzq8ht4JalzN6TH7/1foBJAIsOHN/8h0=;
 b=nwsNHBkekk9L2irKsPYpyhnBRMzBLhU6Iy4AzNc7ke+DrFk/aGyR69lUkfGF5h3fdQ
 zLlmCANIDI6Ch9NMnrX/J/1+Z8JLopfj5mlj4F+SVCPthPfVVwCiq5NBxovXW0WlMeQM
 NkL0r5BC7FEBt1HjZPcTB23P3PKK4pKSxNFhwxOWxpmLmdmzE33Q2Vh+xTPvrePS60WV
 Ox9njQRQXqlqfLAgx7Re3VQIqQpj6KpdF3n201iY0d1XMqT5CD1CWjcXDUVymbfBen+7
 kdZrJUZ0RNMm8YPES92xV/ONTztjKEoyRwXLdnX7UjxT3xCdLDxG28zTseEtVucdxNWs
 XhgA==
X-Gm-Message-State: AOAM533S+avV+/ph3uQoSpRnHunN4oFqnrIVi7VRs8ozm8t+9OMW1CBp
 PBkDOt8B5cUXIcZ2dn6XLyXAuoCHlYaI02IBVLZ0SXmFfRSO83LZn9hac9ehCfx6V5V2RSGY+51
 Tv2gdZe3QVmDLMFc=
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr18782766wmk.35.1592836561113; 
 Mon, 22 Jun 2020 07:36:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDB2qIleRS3NWQTbcqn8YLKq10gVKBFMXicFDO49HFmlimfPLOkN6o0QA87eo8f+JQMyrCpg==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr18782741wmk.35.1592836560839; 
 Mon, 22 Jun 2020 07:36:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1?
 ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
 by smtp.gmail.com with ESMTPSA id y19sm16286906wmi.6.2020.06.22.07.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 07:36:00 -0700 (PDT)
Subject: Re: [PATCH v3 11/19] audio: deprecate -soundhw pcspk
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200622112914.30454-1-kraxel@redhat.com>
 <20200622112914.30454-12-kraxel@redhat.com>
 <47fe0fd8-ab19-b35d-0808-d9a83201c530@redhat.com>
 <4df07eb8-0352-3976-67a2-d49a4fb482da@redhat.com>
 <20200622140354.cin36ds36nwn2khu@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3212b87f-c99e-992f-9d0d-f545cbffbe77@redhat.com>
Date: Mon, 22 Jun 2020 16:35:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200622140354.cin36ds36nwn2khu@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/20 16:03, Gerd Hoffmann wrote:
> 
> The plan is to have audio work simliar to block.  -audiodev creates a
> backend (like -blockdev).  Properties are used to reference them.
> Device properties in most cases, machine properties for builtin devices
> (i.e. pcspk works like pflash then).

Block still has a "-drive" option to configure both frontend and
backend, though.  Audio should have the same (and I modeled my example
on -nic because that's much better than -drive).

Paolo


