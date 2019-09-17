Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C00C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBFB2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBFB2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADmD-00059l-DI
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iADkR-0003zn-35
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iADkN-0008GW-Jy
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:42:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iADkN-0008Fp-E5; Tue, 17 Sep 2019 09:42:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 888F810F2E8C;
 Tue, 17 Sep 2019 13:42:21 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 629BE5D721;
 Tue, 17 Sep 2019 13:42:13 +0000 (UTC)
Date: Tue, 17 Sep 2019 15:42:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190917154212.1fab537f@redhat.com>
In-Reply-To: <20190917084442.GE30562@xz-x1>
References: <20190916132347.30676-1-imammedo@redhat.com>
 <20190916132347.30676-3-imammedo@redhat.com>
 <20190917084442.GE30562@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 17 Sep 2019 13:42:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 2/2] s390: do not call
 memory_region_allocate_system_memory() multiple times
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 16:44:42 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Sep 16, 2019 at 09:23:47AM -0400, Igor Mammedov wrote:
> > PS:
> > I don't have access to a suitable system to test it.  
> 
> Hmm I feel like it would be good to have series like this to be at
> least smoke tested somehow...
> 
> How about manually setup a very small max memslot size and test it on
> x86?  IMHO we'd test with both KVMState.manual_dirty_log_protect to be
> on & off to make sure to cover the log_clear() code path.  And of
> course to trigger those paths we probably need migrations, but I
> believe local migrations would be enough.

I did smoke test it (Fedora boot loop) [*] on s390 host with hacked
1G max section. I guess I could hack x86 and do the same for x86 guest.
Anyways, suggestions how to test it better are welcome.

*) I don't have much faith in tests we have though as it didn't
   explode with broken v5 in my case. Hence CCing ones who is more
   familiar with migration parts.

   I used 2 memslot split config at 1Gb with offline migration like this:

   $ qemu-system-s390x -M s390-ccw-virtio -m 2048 -cpu max -smp 2 -M accel=kvm  \
        --nographic --hda fedora.qcow2 -serial unix:/tmp/s,server,nowait \
        -monitor stdio 
     (monitor) stop
     (monitor) migrate "exec: cat > savefile
     (monitor) q
   $ qemu-system-s390x -M s390-ccw-virtio -m 2048 -cpu max -smp 2 -M accel=kvm  \
        --nographic --hda fedora.qcow2 -serial unix:/tmp/s,server,nowait \
        -incoming "exec: cat savefile"

> 
> And since at it, I'm thinking whether we should start assert() in some
> way in memory_region_allocate_system_memory() to make sure it's not
> called twice from now on on any board.

there is another broken board that misuses it as well,
I intend to clean that up and drop memory_region_allocate_system_memory()
altogether once s390 case is dealt with.

---
*) I don't have much faith in existing tests though as it didn't
   explode with broken v5 in my case. Hence CCing ones who is more
   familiar with migration parts.

   I've used 2 memslot split config at 1Gb with offline migration like this:

   $ qemu-system-s390x -M s390-ccw-virtio -m 2048 -cpu max -smp 2 -M accel=kvm  \
        --nographic --hda fedora.qcow2 -serial unix:/tmp/s,server,nowait \
        -monitor stdio 
     (monitor) stop
     (monitor) migrate "exec: cat > savefile
     (monitor) q
   $ qemu-system-s390x -M s390-ccw-virtio -m 2048 -cpu max -smp 2 -M accel=kvm  \
        --nographic --hda fedora.qcow2 -serial unix:/tmp/s,server,nowait \
        -incoming "exec: cat savefile"
     (monitor) cont


