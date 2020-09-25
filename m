Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C316C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1C121D42
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwVVh7Aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1C121D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLumD-0002Ks-S8
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 16:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLulQ-0001Se-VL
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLulO-0007Zm-Az
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:56:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601067376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRi8rtYjDoe5nzdlnFKw+DrFD4QS35QEvyohLPA5+BI=;
 b=MwVVh7Aak4bGcIDw64aZzjudlF9TgaQypgd8tJIQ6FUiOOigFNflmj9eBwJfX6uwWWYStb
 QJ2e5id8JWlNFeWA+b940pxEpb4MjPawJbTyLsflh2dOIglbiZ7kaK5BfPnoq/ykCC1z58
 g8DLzBRWS60EoaJDRGtIM6F5BUlbk50=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-TBWBgRT2NECn5Lxy4tYAUg-1; Fri, 25 Sep 2020 16:56:13 -0400
X-MC-Unique: TBWBgRT2NECn5Lxy4tYAUg-1
Received: by mail-wr1-f72.google.com with SMTP id o6so1551832wrp.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 13:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bRi8rtYjDoe5nzdlnFKw+DrFD4QS35QEvyohLPA5+BI=;
 b=b0z4j4423Q7P+OgGth/o86/7CZ1m/1XroeJotuhTJM5AE/Htbe0E8gYQAPMoTQAKEZ
 QiZVRYECnklU/B6T2pGZq40QklTjVAKlSl6YdBVWvt9dU+43PVeOrTHZrNBmCZJFlyx+
 hKYi7+WcNLFficPx1s+CKbC3fnv/R+glUMOpjfRPTYwdzT/UZrhs8HQePWf4nWRszw9r
 u1vhGev0FrVeNPv6ZJSwLnVxgVtsTsngoK/OUj537OhlctbO6yQ7bkYmc7ehCEz/cOdO
 RZAE4C37sTS2rEhGPL6oXNYJE6sPGIJrsRS6qAg/gwJ8tcC8ZaVxtRd52qqR95tD1Fog
 4d4g==
X-Gm-Message-State: AOAM531rEOixnKXi+HHxwzeR2yGu3KQ0nGN6BvZHhv9FqgtSAzmrYU/J
 eG82EiVB81h47WzUGEPSBgJYfNX7irqPVUpI2/ZKUpN8/pJ5/xb/yTN8G6M6rKHhLtrIKErS9RE
 FwVTfXlLJqICSVZA=
X-Received: by 2002:a5d:540a:: with SMTP id g10mr6085021wrv.138.1601067372541; 
 Fri, 25 Sep 2020 13:56:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFWHG6wBCaDjpxz6qgam7/k96M8pymXMLLaNofo5RQePVZcb3+eYsGuzAN6oeI9ysxuZNTJQ==
X-Received: by 2002:a5d:540a:: with SMTP id g10mr6085008wrv.138.1601067372334; 
 Fri, 25 Sep 2020 13:56:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id j26sm4239894wrc.79.2020.09.25.13.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 13:56:11 -0700 (PDT)
Subject: Re: SEV guest debugging support for Qemu
To: Ashish Kalra <ashish.kalra@amd.com>
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
 <5a58509c-5838-f0aa-d9ab-4f85ca0ac35f@redhat.com>
 <20200925204607.GA10964@ashkalra_ubuntu_server>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9b09c9b-4d4c-c6de-4cce-807effc38836@redhat.com>
Date: Fri, 25 Sep 2020 22:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925204607.GA10964@ashkalra_ubuntu_server>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: thomas.lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 22:46, Ashish Kalra wrote:
> I was also considering abstracting this vendor/SEV specific debug
> interface via the CPUClass object, the CPUClass object aleady has cpu
> specific methods for doing things like guest VA to GPA translations like the
> get_phys_page_attrs_debug() method and it will be a simple and clean
> approach to override this method with a SEV specific
> get_phys_page_attrs_debug() if SEV guest is active and SEV debug policy
> is allowed. [...]
> 
> I can probably add new interfaces/methods to this CPUClass object for
> guest memory read/writes for debugging purpose and then invoke the same
> from the generic cpu_memory_rw_debug() interface. 
> 
> Let me know your thougts on abstracting this debug interface via the
> CPUClass object ? 
> 
> Or the other option is to introduce the new MemoryDebugOps you described
> above and additionally apply SEV/SEV-ES considerations in CPUClass
> methods such as gdb_read_register, gdb_write_register, etc.

Yes, this makes the most sense, however you're right that you don't need
translate in MemoryDebugOps.  I don't think read/write should be moved
to CPUClass, however, since you can use a MemTxAttr to tell the
read/write MemoryDebugOps whether the page is encrypted or not.

Paolo


