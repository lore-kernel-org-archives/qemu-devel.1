Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59973C433F8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2444D207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I76M78TF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2444D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHru-0004LD-CI
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyHr9-0003VS-RX
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:44:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyHr6-0000dt-RB
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595436271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNkbKCo7ER/3+EBd9aXnFB6r+pgSvYJhVH4bCdmcnMA=;
 b=I76M78TFquOVGvI/kRMbpDEwYkvI3C48fJoN5UsgKkgPNGlrDAvrgThHnmPHkMRtEfTcfj
 fdxkBj7iEwT2CT+auTs1ULeYwpaAokazogzrMHvLSfwfYR+5EwQrMgM6NLfcGbb7ZVxGSx
 EMT+9N1Xe7LRnSHt19E5ORISdYzJrH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-0yM4LlSfPtSxpf3RBS3Wvg-1; Wed, 22 Jul 2020 12:44:17 -0400
X-MC-Unique: 0yM4LlSfPtSxpf3RBS3Wvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95F6419253C3;
 Wed, 22 Jul 2020 16:44:14 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9FA60C05;
 Wed, 22 Jul 2020 16:44:10 +0000 (UTC)
Date: Wed, 22 Jul 2020 17:44:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 06/12] accel/tcg: better handle memory constrained
 systems
Message-ID: <20200722163722.GS2324845@redhat.com>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-7-alex.bennee@linaro.org>
 <5d26e26f-55f7-5b74-bb9e-b97ea1040c05@linaro.org>
 <87ft9jtsw5.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87ft9jtsw5.fsf@linaro.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: fam@euphon.net, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 f4bug@amsat.org, cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 05:29:46PM +0100, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
> > On 7/21/20 11:28 PM, Alex Bennée wrote:
> >> +        size_t phys_mem = qemu_get_host_physmem();
> >> +        if (phys_mem > 0 && phys_mem < (2 * DEFAULT_CODE_GEN_BUFFER_SIZE)) {
> >> +            tb_size = phys_mem / 8;
> >> +        } else {
> >> +            tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
> >> +        }
> >
> > I don't understand the 2 * DEFAULT part.
> 
> I figured once you had at least twice as much memory you could use the
> full amount but...
> 
> 
> > Does this make more sense as
> >
> >     if (phys_mem == 0) {
> >         tb_size = default;
> >     } else {
> >         tb_size = MIN(default, phys_mem / 8);
> >     }
> 
> This is probably a less aggressive tapering off which still doesn't
> affect my 32gb dev machine ;-)

I still feel like this logic of looking at physmem is doomed, because
it makes the assumption that all of physical RAM is theoretically
available to the user, and this isn't the case if running inside a
container or cgroup with a memory cap set.

I don't really have any good answer here, but assuming we can use
1 GB for a cache just doesn't seem like a good idea, especially if
users are running multiple VMs in parallel.

OpenStack uses TCG in alot of their CI infrastructure for example
and runs multiple VMs. If there's 4 VMs, that's another 4 GB of
RAM usage just silently added on top of the explicit -m value.

I wouldn't be surprised if this pushes CI into OOM, even without
containers or cgroups being involved, as they have plenty of other
services consuming RAM in the CI VMs.

The commit 600e17b261555c56a048781b8dd5ba3985650013 talks about this
minimizing codegen cache flushes, but doesn't mention the real world
performance impact of eliminating those flushes ?

Presumably this makes the guest OS boot faster, but what's the before
and after time ?  And what's the time like for values in between the
original 32mb and the new 1 GB ?  Can we get some value that is
*significantly* smaller than 1 GB but still gives some useful benefit ?
what would 128 MB be like compared to the original 32mb ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


