Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D92C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34DC206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Osu/Wn27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34DC206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtT70-0003cu-5O
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtT6S-0003D8-Hz
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:44:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34296
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtT6Q-0002Tq-PU
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594287865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SnATE0G1PqttW5QnC8ZFkmxQkqAwAlSy2AfyfqCXdOQ=;
 b=Osu/Wn27kXwC1/hs1MFZLEXux2VsYb5BRdSvydvl2T4n8Sx8iV9uz81ylc6d/6acbzDfa6
 Y01K2G2IKQxQCI2vwL7C27+gzhgI2EJ+ioeqAbZCnUMIzEUPSnWxwzOhrE+SytFh9VGbwy
 u/81jIrU28yBaVoIb456jZOZ1iTaI/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-jyELxRd3NJGTnRO3WbQN5A-1; Thu, 09 Jul 2020 05:44:23 -0400
X-MC-Unique: jyELxRd3NJGTnRO3WbQN5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5569A800401;
 Thu,  9 Jul 2020 09:44:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 513AD10640E1;
 Thu,  9 Jul 2020 09:44:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 40F52187; Thu,  9 Jul 2020 11:44:15 +0200 (CEST)
Date: Thu, 9 Jul 2020 11:44:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] x86/cpu: Handle GUEST_MAXPHYADDR < HOST_MAXPHYADDR
 for hosts that don't support it
Message-ID: <20200709094415.yvdh6hsfukqqeadp@sirius.home.kraxel.org>
References: <20200619155344.79579-1-mgamal@redhat.com>
 <20200619155344.79579-3-mgamal@redhat.com>
 <20200708171621.GA780932@habkost.net>
 <20200708172653.GL3229307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708172653.GL3229307@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Guilherme Piccoli <gpiccoli@canonical.com>,
 Pedro Principeza <pedro.principeza@canonical.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 libvir-list@redhat.com, Dann Frazier <dann.frazier@canonical.com>,
 mtosatti@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, Mohammed Gamal <mgamal@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, fw@gpiccoli.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > (CCing libvir-list, and people who were included in the OVMF
> > thread[1])
> > 
> > [1] https://lore.kernel.org/qemu-devel/99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com/

> > Also, it's important that we work with libvirt and management
> > software to ensure they have appropriate APIs to choose what to
> > do when a cluster has hosts with different MAXPHYADDR.
> 
> There's been so many complex discussions that it is hard to have any
> understanding of what we should be doing going forward. There's enough
> problems wrt phys bits, that I think we would benefit from a doc that
> outlines the big picture expectation for how to handle this in the
> virt stack.

Well, the fundamental issue is not that hard actually.  We have three
cases:

(1) GUEST_MAXPHYADDR == HOST_MAXPHYADDR

    Everything is fine ;)

(2) GUEST_MAXPHYADDR < HOST_MAXPHYADDR

    Mostly fine.  Some edge cases, like different page fault errors for
    addresses above GUEST_MAXPHYADDR and below HOST_MAXPHYADDR.  Which I
    think Mohammed fixed in the kernel recently.

(3) GUEST_MAXPHYADDR > HOST_MAXPHYADDR

    Broken.  If the guest uses addresses above HOST_MAXPHYADDR everything
    goes south.

The (2) case isn't much of a problem.  We only need to figure whenever
we want qemu allow this unconditionally (current state) or only in case
the kernel fixes are present (state with this patch applied if I read it
correctly).

The (3) case is the reason why guest firmware never ever uses
GUEST_MAXPHYADDR and goes with very conservative heuristics instead,
which in turn leads to the consequences discussed at length in the
OVMF thread linked above.

Ideally we would simply outlaw (3), but it's hard for backward
compatibility reasons.  Second best solution is a flag somewhere
(msr, cpuid, ...) telling the guest firmware "you can use
GUEST_MAXPHYADDR, we guarantee it is <= HOST_MAXPHYADDR".

> As mentioned in the thread quoted above, using host_phys_bits is a
> obvious thing to do when the user requested "-cpu host".
> 
> The harder issue is how to handle other CPU models. I had suggested
> we should try associating a phys bits value with them, which would
> probably involve creating Client/Server variants for all our CPU
> models which don't currently have it. I still think that's worth
> exploring as a strategy and with versioned CPU models we should
> be ok wrt back compatibility with that approach.

Yep, better defaults for GUEST_MAXPHYADDR would be good too, but that
is a separate (although related) discussion.

take care,
  Gerd


