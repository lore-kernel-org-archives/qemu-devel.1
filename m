Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF27C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C4020767
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6w8TYlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C4020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXaQ-0007lF-KI
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1joXZ5-0006QK-T9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 15:29:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37678
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1joXYy-0007LH-CH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 15:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593113370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QSrB5CRaOgo3UajSlh+j0cHfOY/JURYq6xnockrJxw=;
 b=A6w8TYlYN2Mv+9YuKBo19BtP9tEuKvUk74z6ZzhMZEwVl5j1Bz1LiJpE+nX6JNDuYH3/4N
 UMzr2wDiyuRAqukRYyqLrREe0M3/hr9t2G5wR/ULjW/nyTiGeC8vuW98HjQmMkPUjCKs6z
 I8rW9RpXuJTBfrlbsCbOCloZ2A0QVEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-sKjnVftkM3-LkujrK2vbkw-1; Thu, 25 Jun 2020 15:29:28 -0400
X-MC-Unique: sKjnVftkM3-LkujrK2vbkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FB86EC1A0;
 Thu, 25 Jun 2020 19:29:27 +0000 (UTC)
Received: from localhost (unknown [10.40.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F33710013C4;
 Thu, 25 Jun 2020 19:29:24 +0000 (UTC)
Date: Thu, 25 Jun 2020 21:29:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 20/25] x86: Fix x86_cpu_new() error API violations
Message-ID: <20200625212920.620b25b8@redhat.com>
In-Reply-To: <1d6e83fa-04c2-2d3e-3695-bf85f6647bfc@redhat.com>
References: <20200624083737.3086768-1-armbru@redhat.com>
 <20200624083737.3086768-21-armbru@redhat.com>
 <20200624161703.153c7905@redhat.com>
 <1d6e83fa-04c2-2d3e-3695-bf85f6647bfc@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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
Cc: Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 16:20:16 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 24/06/20 16:17, Igor Mammedov wrote:
> >> -    cpu = object_new(MACHINE(x86ms)->cpu_type);
> >> -
> >> -    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
> >> -    qdev_realize(DEVICE(cpu), NULL, &local_err);
> >> -
> >> -    object_unref(cpu);
> >> -    error_propagate(errp, local_err);
> >> +    object_property_set_uint(cpu, apic_id, "apic-id", &error_abort);  
> > it may fail here if user specified wrong cpu flags, but there is nothing we can do to fix it.
> > perhaps error_fatal would suit this case better?  
> 
> No, we need to add the error_propagate dance instead.

yep, it cam be used by legacy cpu-add, so just dying isn't an option.

we need deprecate cpu-add since device-add is supported buy all interested
boards for quite a bit and once it's gone, we can use error_fatal here.


> 
> Paolo
> 


