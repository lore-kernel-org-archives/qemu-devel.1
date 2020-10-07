Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725DEC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0BF2076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzEKElRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0BF2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4tD-0002YZ-P7
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQ4rw-0001oZ-7m
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQ4rq-0001Gn-Vk
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602059530;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/SSIEgKRLY/JvxE4I9rdnzB7B6WOGvbll2CcZa2s3RA=;
 b=PzEKElRHwuaIG0ooLgjP89W9Hfwq6BpGKlhjpgTMo1Q0E0QIBL58ANQS3jUu2G/6gWUHcp
 tGrKyAitZy6Zptvigv3uGMpm1J7cTKpI6xX/syjKaCNgLAe1+oFNRxtmnhJxmiGJad44L6
 dF4PgbuAKzxzXk/GbjempiAm9eDcHkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-K2JZt3YANneIgX7Jg6S4kQ-1; Wed, 07 Oct 2020 04:32:08 -0400
X-MC-Unique: K2JZt3YANneIgX7Jg6S4kQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA04B1882FB5;
 Wed,  7 Oct 2020 08:32:06 +0000 (UTC)
Received: from redhat.com (ovpn-114-68.ams2.redhat.com [10.36.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0E0F76644;
 Wed,  7 Oct 2020 08:32:04 +0000 (UTC)
Date: Wed, 7 Oct 2020 09:32:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/3] cirrus: Fixing and speedup the msys2/mingw CI
Message-ID: <20201007083202.GF2505881@redhat.com>
References: <20201007035154.109-1-luoyonggang@gmail.com>
 <20201007035154.109-3-luoyonggang@gmail.com>
 <6b4528dc-918d-ebf4-db27-cbd67fa96c11@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6b4528dc-918d-ebf4-db27-cbd67fa96c11@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 07, 2020 at 10:18:48AM +0200, Paolo Bonzini wrote:
> On 07/10/20 05:51, Yonggang Luo wrote:
> > Using a prepared https://github.com/lygstate/qemu/releases/download/v5.1.0/msys2-x86_64.tar.xz
> > for speed up the msys2/mingw prepare speed on the cirrus CI.
> > This file are generated by the msys2.docker
> 
> The speedup is nice, but we need to be able to regenerate the tarball
> without access to a Windows machine.  Otherwise whoever adds a new
> dependency cannot test it himself with CI.
> 
> Ideally, the tarball would be generated by the containers job in the
> Gitlab CI, but I'm not sure if that's possible.

IMHO any caching should be integrated into the Cirrus CI job itself.
Cirrus has builtin support for caching the contents of a folder, so
the first time the job runs it should populate the cache, and that
can be used thereafter.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


