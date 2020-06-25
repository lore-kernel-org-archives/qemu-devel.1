Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EEBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E239206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZRd/j0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E239206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPmA-0005vq-Ml
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joPk5-0003WX-EC
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:08:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33128
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joPk3-0006qZ-KJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593083306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBiQGgXgwtK3Lsi5CnReM7TSJvLgOM6zkijEGmQLxR8=;
 b=PZRd/j0SMLEQLF6XRT3NCI5XWiuQMLzFzGGMsMihwhNYAwjH0XQ2uasAL8JUAXlmC1uabM
 jPfcMT/iaoP4n43O3v/68044tJUouYcU5ekX77V0CmL6z35Q7bCHfROvir+SoKigiI41OJ
 /fZetpQimKUQWk7OPQbyJJgGvGx7Oq0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-JOLFlnixPfaCPxHAbdSieA-1; Thu, 25 Jun 2020 07:08:24 -0400
X-MC-Unique: JOLFlnixPfaCPxHAbdSieA-1
Received: by mail-wr1-f69.google.com with SMTP id o25so6510508wro.16
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 04:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JBiQGgXgwtK3Lsi5CnReM7TSJvLgOM6zkijEGmQLxR8=;
 b=QL1cvAlQuO5cMI2xKmWbRLgM6Ajqw99vO/kOTjQMry3c/wGe54sGLbpuwLdwhHxDS1
 0l5AUcry/oAP+cdFQ4M4/zLLWpD3k5avdDEs7MIAW7rfBJYFhfzUvG/K+otxBi1ViKHL
 CrgSwuTlSmomWhJ1owD3i99J+Y0J6Gm1pqUNIZ0Bpbvh6v5VsZqub08s2VFv6njVqMGI
 n7QFEbSXTKsxP7DkZkcwNOI6k7oTbjA6TgKZG4sByGx+0w1JQtW3++aw5N69LLikllZ2
 6AOHDIZW52TYsGKzuDNS2cyGSdRkLxwjM+d4g86UzwxkWT7go4x9+tKh9LtxsihHzmBG
 YLEg==
X-Gm-Message-State: AOAM5307Jr0P6/GWz7ItEQMWqbUjn+Y0tIIBTkoAg+zOSdnofAw5/QED
 dDBSG8ymX0kXM2EommZB4QiYdcmoPZ+w7kv+Z3HGDonQ5e7jAcSvwlkeAXpk2efCU2/jtpiJyqM
 dgwET0mTfHwU13c0=
X-Received: by 2002:a5d:4845:: with SMTP id n5mr19790724wrs.353.1593083303602; 
 Thu, 25 Jun 2020 04:08:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFp2TD6wsRZXz5XKEzAkOLFHRaSpMdSDTEDDB9mOTMb9+PSk6uBAL5JXpRKMYlgJWB2DO2ow==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr19790705wrs.353.1593083303406; 
 Thu, 25 Jun 2020 04:08:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80?
 ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
 by smtp.gmail.com with ESMTPSA id t205sm12101909wmt.8.2020.06.25.04.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 04:08:22 -0700 (PDT)
Subject: Re: [PATCH 0/8] Improve synchronization between QEMU and HVF
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de87b7d0-a788-ef0d-9d9e-5d9fe3b2e119@redhat.com>
Date: Thu, 25 Jun 2020 13:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200624225850.16982-1-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: Claudio Fontana <cfontana@suse.de>, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/20 00:58, Roman Bolshakov wrote:
> The series is a prerequisite to implement gdbstub support for HVF and mostly
> concerns improvements of cpu_synchronize_* functions wrt to HVF and addresses
> old TODO's in the related code.
> 
> Unfortunately live snapshots don't seem to work yet but they don't work with
> tcg (on macOS) either.

Queued, thanks!  Synchronization of special registers is the obvious
next step (hint, hint!).

Cameron perhaps can also guide us with respect to the CPU kick race that
I mentioned in my review of patch 4.  A full fix is not possible without
help from Hypervisor.framework, but using hv_vcpu_run_until will already
tighten the window for the race.

Thanks,

Paolo


