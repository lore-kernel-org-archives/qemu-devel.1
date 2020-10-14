Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4066CC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10B720BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AY/48IKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10B720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kScA5-0002Fs-MK
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSc8E-0008Va-Fk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSc8C-0008D5-4Z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602664049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4g3JzaJkXiHhjCbtynOGjqdUPHPFvNBFEwUL+601iw=;
 b=AY/48IKRiaXy3A7Dl0VGUfVmjEqHyoNkzIprAxTivL0XM79A3SfUkZF8g5b/sn+dd6W7Uy
 LCM5rvr517FE0UceSgPTKkAj2u+WfrZ0aSbEXX2KiVLI+qpn+nisYL8LSdpZc2scCyIs0X
 VhtYptorvRNmEmcD8nklUsTkmEB13bg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-N3dedZKhNKegASeZgsqyRA-1; Wed, 14 Oct 2020 04:27:25 -0400
X-MC-Unique: N3dedZKhNKegASeZgsqyRA-1
Received: by mail-ed1-f70.google.com with SMTP id m10so909367edj.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 01:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x4g3JzaJkXiHhjCbtynOGjqdUPHPFvNBFEwUL+601iw=;
 b=HaQ7WPbKyjkSmqplepqk8Ci7J1kFzOl1PV6vh5QMnGdgETnADkIlt9NFk7rAkCaIKx
 HxMH497V6kvAcOgCTJTgijnkEaIIluejXRKyAZSr75kzeExHv6We378HTywkOzl0+BfX
 5MBrbrdSpZTNXUZkt0ERgA6s/5dTArMBRxUyRUJz6aolyZMVGMHWCTDjsyvU7Th4GLyc
 iayQD6j6ae2gJlaJ/omBrzdcFsXlxxjYw0prRKTIm/6W/WpnZ4ARdqv64cfWe/EPJ3Mv
 o5LjLprZR37dxZd8ye4MMbpNUVOp0OAJWWYnKUeNpMmrQZZ0KVxpKpVDwNA+yhWEMulA
 hjxQ==
X-Gm-Message-State: AOAM531/z0/wKt7UnaA1HqACuX7I9+OZCkqNFwksffgE79AKxwcMxYaD
 6iJSJd9HTNvDMHVdJ6LyVyZ5N6R/bPfJMYHHIH3BSZuwHN8IRMqlL6lVVm85Eunc2s+Kq27rA4l
 Neqa0NAOEHPXKWow=
X-Received: by 2002:aa7:de06:: with SMTP id h6mr3908473edv.31.1602664044093;
 Wed, 14 Oct 2020 01:27:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0qpIx7WA12LFk5RAxsrrUKAYr738RykIwdqdF0x1Sm/2twJVXzbmig9JdADFGNPyRu/33GA==
X-Received: by 2002:aa7:de06:: with SMTP id h6mr3908439edv.31.1602664043555;
 Wed, 14 Oct 2020 01:27:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e5f7:db3b:55ea:7337?
 ([2001:b07:6468:f312:e5f7:db3b:55ea:7337])
 by smtp.gmail.com with ESMTPSA id cw15sm1245419ejb.47.2020.10.14.01.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 01:27:22 -0700 (PDT)
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
To: harry harry <hiharryharryharry@gmail.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
 <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
 <20201013045245.GA11344@linux.intel.com>
 <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
 <CA+-xGqMMa-DB1SND5MRugusDafjNA9CVw-=OBK7q=CK1impmTQ@mail.gmail.com>
 <a163c2d8-d8a1-dc03-6230-a2e104e3b039@redhat.com>
 <CA+-xGqOMKRh+_5vYXeLOiGnTMw4L_gUccqdQ+HGSOzuTosp6tw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24cdf8f2-7dc7-1232-8d78-86f9b4b8eda3@redhat.com>
Date: Wed, 14 Oct 2020 10:27:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+-xGqOMKRh+_5vYXeLOiGnTMw4L_gUccqdQ+HGSOzuTosp6tw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, PLING_QUERY=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, mathieu.tarral@protonmail.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/20 22:36, harry harry wrote:
> Hi Paolo and Sean,
> 
> Thanks much for your prompt replies and clear explanations.
> 
> On Tue, Oct 13, 2020 at 2:43 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> No, the logic to find the HPA with a given HVA is the same as the
>> hardware logic to translate HVA -> HPA.  That is it uses the host
>> "regular" page tables, not the nested page tables.
>>
>> In order to translate GPA to HPA, instead, KVM does not use the nested
>> page tables.
> 
> I am curious why KVM does not directly use GPAs as HVAs and leverage
> nested page tables to translate HVAs (i.e., GPAs) to HPAs?

GPAs and HVAs are different things.  In fact I'm not aware of any
hypervisor that uses HVA==GPA.  On 32-bit x86 systems HVAs are 32-bit
(obviously) but GPAs are 36-bit.

In the case of KVM, HVAs are controlled by the rest of Linux; for
example, when you do "mmap" to allocate guest memory you cannot ask the
OS to return the guest memory at the exact HVA that is needed by the
guest.  There could be something else at that HVA (or you don't want
anything at that HVA: GPA 0 is valid, but HVA 0 is the NULL pointer!).
There's also cases where the same memory appears in multiple places in
the guest memory map (aliasing).

Paolo


