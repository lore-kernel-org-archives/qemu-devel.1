Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8234C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20A1206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSxpBNHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20A1206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyXat-0007ny-Tt
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 05:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyXZm-0006eR-PX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:31:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyXZk-0002vo-2X
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595496698;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVUW+satySmbAs0AlrIiXSB/XLT7Hpj+HVX84vG+Psw=;
 b=GSxpBNHmTcEYNN8Q/kQD+8Wt1iGWR3aIcJvSdxgsDi6dMIdZAqRYQGKa96Rn7t/lJ76PA6
 mLbSyOOmlZbxM5RBQnGPV84HX6Elh7uUvbQVCpTKml8OBUxFJ74wmobJ8zxwlg8A4h6Oab
 7NGKAYZl6LOpz9tUbGRJ2FQoBj/7lNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-CjIN6S1vM4yyZ2nwh-5K7Q-1; Thu, 23 Jul 2020 05:31:16 -0400
X-MC-Unique: CjIN6S1vM4yyZ2nwh-5K7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC02800685;
 Thu, 23 Jul 2020 09:31:14 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C92C22DE68;
 Thu, 23 Jul 2020 09:31:11 +0000 (UTC)
Date: Thu, 23 Jul 2020 10:31:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 06/12] accel/tcg: better handle memory constrained
 systems
Message-ID: <20200723093108.GD2615312@redhat.com>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-7-alex.bennee@linaro.org>
 <5d26e26f-55f7-5b74-bb9e-b97ea1040c05@linaro.org>
 <87ft9jtsw5.fsf@linaro.org> <20200722163722.GS2324845@redhat.com>
 <0efbcac2-d2f4-de96-63a1-ba7cd485a1e6@linaro.org>
 <20200723090027.GB2615312@redhat.com> <87d04mtwku.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87d04mtwku.fsf@linaro.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 23, 2020 at 10:22:25AM +0100, Alex Bennée wrote:
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Jul 22, 2020 at 12:02:59PM -0700, Richard Henderson wrote:
> >> On 7/22/20 9:44 AM, Daniel P. Berrangé wrote:
> >> > OpenStack uses TCG in alot of their CI infrastructure for example
> >> > and runs multiple VMs. If there's 4 VMs, that's another 4 GB of
> >> > RAM usage just silently added on top of the explicit -m value.
> >> > 
> >> > I wouldn't be surprised if this pushes CI into OOM, even without
> >> > containers or cgroups being involved, as they have plenty of other
> >> > services consuming RAM in the CI VMs.
> >> 
> >> I would hope that CI would also supply a -tb_size to go along with that -m
> >> value.  Because we really can't guess on their behalf.
> >
> > I've never even seen mention of -tb_size argument before myself, nor
> > seen anyone else using it and libvirt doesn't set it, so I think
> > this is not a valid assumption.
> >
> >
> >> > The commit 600e17b261555c56a048781b8dd5ba3985650013 talks about this
> >> > minimizing codegen cache flushes, but doesn't mention the real world
> >> > performance impact of eliminating those flushes ?
> >> 
> >> Somewhere on the mailing list was this info.  It was so dreadfully slow it was
> >> *really* noticable.  Timeouts everywhere.
> >> 
> >> > Presumably this makes the guest OS boot faster, but what's the before
> >> > and after time ?  And what's the time like for values in between the
> >> > original 32mb and the new 1 GB ?
> >> 
> >> But it wasn't "the original 32MB".
> >> It was the original "ram_size / 4", until that broke due to argument parsing
> >> ordering.
> >
> > Hmm, 600e17b261555c56a048781b8dd5ba3985650013 says it was 32 MB as the
> > default in its commit message, which seems to match the code doing
> >
> >  #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
> 
> You need to look earlier in the sequence (see the tag pull-tcg-20200228):
> 
>   47a2def4533a2807e48954abd50b32ecb1aaf29a
> 
> so when the argument ordering broke the guest ram_size heuristic we
> started getting reports of performance regressions because we fell back
> to that size. Before then it was always based on guest ram size within
> the min/max bounds set by those defines.

Ah I see. That's a shame, as something based on guest RAM size feels like
a much safer bet for a default heuristic than basing it on host RAM size.

I'd probably say that the original commit which changed the argument
processing is flawed, and could/should be fixed.

The problem that commit was trying to solve was to do validation of the
value passed to -m. In fixing that it also moving the parsing. The key
problem here is that we need to do parsing and validating at different
points in the startup procedure.  IOW, we need to split the logic, not
simply moving the CLI parsing to the place that makes validation work.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


