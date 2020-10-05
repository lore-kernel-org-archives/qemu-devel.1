Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC6C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFBF2064C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SV8EkKfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFBF2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMAE-0001AT-7O
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPM8G-0007iH-1h
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPM8D-00022F-UR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601887565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=okCrQkGxtnHZPZ8SiAzTpzb/xJBxhBwvy+wvdWPVABI=;
 b=SV8EkKfnwHtY20jF1GctejVTRViEJOV6mSVtox/hjUVx016OzAYoGpOWpIVmPxbXWweM0u
 0Wryh62Qr2rElOLl1vs+/1kjalg1xzI7j/cnLd388JTwRw3UJfn1MF3YpPqC1E5yf7xmkT
 uMxQckoegipYoTIPQw+/d/3H3f/YA+c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-YNmQ6IXyN6GYKUDDSjGLdg-1; Mon, 05 Oct 2020 04:46:03 -0400
X-MC-Unique: YNmQ6IXyN6GYKUDDSjGLdg-1
Received: by mail-wr1-f72.google.com with SMTP id w7so3746338wrp.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=okCrQkGxtnHZPZ8SiAzTpzb/xJBxhBwvy+wvdWPVABI=;
 b=KYNkdWVD02eE2maEzHFZ+ExbNvChHVMaQo1qqBeHXl52O+I03HTZJVbH6lDmqNO0Dq
 vx77q5DfYKj5vVm8A79XrjJkwUYjYzPqwPBYVVM8TC07zD3z/VaR+MUbNE2fo6ZmQMIa
 fxZT9IUmacIiCOKoLD+9IZ9mPlLdu4ZcEbRLV1Dx8XDgMhBbSdZsiUzYms4Jk0tRUCBD
 rQgV9NRxufACsaIz2ChVhMqyek9eLaLBfrH5xV6EeWJIRIa0HeQXW+yjGhmSgsn7hkMV
 FSD4I7fkK4vo2OCXfR3R0/8XfIBCVUG+crWsPEYKlu/JArZKRCgKZ9CK+VwgDt8RDfn3
 5nRw==
X-Gm-Message-State: AOAM532OI+Dwnk9u44qpGaJIKShK8urD81jAXrj/s0ofMmwGcVDK6+Pw
 OD2Cnyw0qf78w+JOIBCBlyILG4tP+Bk0BCB6eC6JR9ma/iIjuDQPgFgczsDLVRzwAPyW/j3SOuP
 jDnwzNxJKPCWEEyE=
X-Received: by 2002:adf:e407:: with SMTP id g7mr10330887wrm.349.1601887562083; 
 Mon, 05 Oct 2020 01:46:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL7iy8SyjTNcssIenIDbDU3EPy6FirqSaU/6oIe+Yp0UOc3VHOKrxtGPaaIZvrooguFHlONw==
X-Received: by 2002:adf:e407:: with SMTP id g7mr10330871wrm.349.1601887561841; 
 Mon, 05 Oct 2020 01:46:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2e86:3d8b:8b70:920c?
 ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id h17sm13109068wro.27.2020.10.05.01.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 01:46:00 -0700 (PDT)
Subject: Re: [PATCH 0/5] qapi: Restrict machine (and migration) specific
 commands
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20201002133923.1716645-1-philmd@redhat.com>
 <87wo05aypg.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c54aa06-372c-ab81-0974-34340adb7b55@redhat.com>
Date: Mon, 5 Oct 2020 10:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87wo05aypg.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 10:01, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Reduce the machine code pulled into qemu-storage-daemon.
> I'm leaving review to Eduardo and Marcel for PATCH 1-4, and to David and
> Juan for PATCH 5.  David already ACKed.
> 
> Can do the pull request.
> 

If it counts, :) for patch 1-4:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Generally these patches to remove code from user-mode emulators
fall into the "if it builds it's fine" bucket, since I assume
we want the "misc" subschema to be as small as possible.

Paolo


