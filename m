Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C1BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF1720706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pf//8udK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF1720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAC3b-0002Ka-2e
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 08:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAC33-0001um-Ud
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:58:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34730
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAC30-0006Dz-Kd
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598273881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Hm19DGZEKToSH+wu8a39JIfQ90b+5V2EwzC5slT/Nk=;
 b=Pf//8udK/R+AhPoM5p48u6r0aT7XbWqO6tX7NooBEkl2Q2aceetchPaxPqfvTBBIPthwKt
 zVCrQ+IZ9L3MmIT9r9+a2HoCzWGIt/SdhswJBZ7884tCWi+Zbs2ZN5Bhstlmw38jiRaCGM
 Qxl4+ffcP1WF5LJ03gC6hFd4E8K2uLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-99-cYkngOVqlBUic_KrX_g-1; Mon, 24 Aug 2020 08:57:59 -0400
X-MC-Unique: 99-cYkngOVqlBUic_KrX_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41FE31007467;
 Mon, 24 Aug 2020 12:57:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFC495C1BB;
 Mon, 24 Aug 2020 12:57:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8493D1138648; Mon, 24 Aug 2020 14:57:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: ANNOUNCE: build system conversion to Meson has landed
References: <CAFEAcA-87BcmoPjY9BCodx9+m6QmhfikHv5sLVJ8w20cszDvDA@mail.gmail.com>
 <d9213548-5c05-502e-e660-fbe9b8b1f5ee@redhat.com>
Date: Mon, 24 Aug 2020 14:57:56 +0200
In-Reply-To: <d9213548-5c05-502e-e660-fbe9b8b1f5ee@redhat.com> (Eric Blake's
 message of "Fri, 21 Aug 2020 09:39:20 -0500")
Message-ID: <87lfi4qjzf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 08:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 8/21/20 8:49 AM, Peter Maydell wrote:
>> Hi; we've just merged Paolo's patchset that converts the build system
>> to use Meson. This should mostly be fairly seamless for the average
>> developer (we hope) but there are a few things to be aware of:
>>
>>   * you probably want to do a distclean or otherwise do a clean build
>>     when you first update your git tree to a version of master with Meson
>>     (especially if you do in-tree builds)
>>   * out-of-tree builds should continue to work basically normally
>>   * we have retained compatibility for an "in-tree build" workflow where
>>     you run configure/make in the source tree, but this is now implemented
>>     by having configure create a build tree for you under-the-hood
>>     (but do consider switching to just doing out-of-tree builds)
>
> If you do an in-tree build, do the 'make distclean' _before_ a 'git
> pull' of the new code.  If you don't clean first, the pull attempt is
> likely to complain about various trace.h files, so that is a good
> reminder.  And if you manage to pull anyway, you may need to rewind
> your tree back to v5.1.0 before attempting the in-tree 'make
> distclean', then re-try the pull.

In case you read Eric's advice too late:

    $ (cd your-build-dir && mv -f config.status .config.status && rm -r * && mv .config.status config.status && ./config.status)

It's how I've been blowing away build trees at the slightest sign of
trouble.  Caveat emptor, YMMV, etc. etc.


