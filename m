Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506DEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 20:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DAF2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 20:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4Oo75OM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DAF2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtzGb-0008Js-BB
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 16:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtzFk-0007kQ-BJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 16:04:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49155
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtzFh-0000tv-GA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 16:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594411448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0nGbAWo9wC+dKZSpY6Lf2dhay+bNtdQUWwsmI+qVqs=;
 b=D4Oo75OMv3Q4jaNjfsKWMz/Ws486cOTpxgLJVJmcJ38pIXqnEP1FNbbLDY4zjOH9mpgaL/
 ZKWw1HsNFcKYZuSAxk/HZCT/3MHCMbyhv0p2w/DRLxfd/DOsIuoLxd15StkVHAFJumW3nM
 vAzWPmoluG3a5alOQzy/MsdhY/yddCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-RlOmAyHHOourAW6q7OeH9Q-1; Fri, 10 Jul 2020 16:04:06 -0400
X-MC-Unique: RlOmAyHHOourAW6q7OeH9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA7BD8015CB
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 20:04:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF2125C1D3;
 Fri, 10 Jul 2020 20:04:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4DA261132FD2; Fri, 10 Jul 2020 22:03:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] tests: improve performance of device-introspect-test
References: <20200709112857.3760116-1-berrange@redhat.com>
Date: Fri, 10 Jul 2020 22:03:56 +0200
In-Reply-To: <20200709112857.3760116-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 9 Jul 2020 12:28:57
 +0100")
Message-ID: <87mu47gms3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 16:04:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Total execution time with "-m slow" and x86_64 QEMU, drops from 3
> minutes 15 seconds, down to 54 seconds.
>
> Individual tests drop from 17-20 seconds, down to 3-4 seconds.

Nice!

A few observations on this test (impatient readers may skip to
"Conclusions"):

* Your testing rig is a fair bit faster than mine.

* Run time is almost completely spent in the
  /TARGET/device/introspect/concrete/*/* cases.

  Each such case iterates over all known device types.  Each iteration
  introspects one device.

  Cases concrete/*/M use machine type M.  The test ignores "old"
  versioned machine types; see qtest_is_old_versioned_machine().

  Cases concrete/nodefaults/* use -nodefaults, cases concrete/defaults/*
  don't.

* The number of known device types varies between targets from 33
  (tricore) to several hundreds (x86_64+i386: 421, ppc 593, arm 667,
  aarch64 680, ppc64 689).  Median is 215, sum is 7485.

  Aside: why on earth do we need 334 ppc64 CPUs?

* The number of tested machine types varies between targets from two to
  over 60 (arm 62, aarch64 66).  Median is 4, sum is 286.

* Without -m slow, only /TARGET/device/introspect/concrete/defaults/none
  is run.

  This tests #devices introspections, i.e. between 33 and 689 depending
  on target, 7485 for all targets together.

  Run times for master (commit eb2c66b10e) vary for me from well under
  one second to almost 6 seconds, with x86_64 and i386 the slowest,
  followed by aarch64, arm, ppc64, pcc. s390x.  This is what "make
  check" runs.  Total run time for all 32 targets is ~72s.  That's
  roughly 100 introspections per second.

  Note I measured manual runs, like so:

  $ QEMU_AUDIO_DRV=3Dnone QTEST_QEMU_BINARY=3D"$TARGET-softmmu/qemu-system-=
$TARGET" QTEST_QEMU_IMG=3Dqemu-img time tests/qtest/device-introspect-test

* With -m slow, we run all cases.  This is relatively recent: commit
  410573aa2c 'tests/device-introspect: Test with all machines, not only
  with "none"'.  The commit message explains:

    Certain device introspection crashes used to only happen if you were
    using a certain machine, e.g. if the machine was using serial_hd() or
    nd_table[], and a device was trying to use these in its instance_init
    function, too.

  Aside: these are things an instance_init() should not do.  But
  catching things that should not be done is one reason for having
  tests.  This one is an awfully expensive catcher, but until someone
  has better ideas...

  With -m slow, we test 2 * #machines * #devices introspections,
  i.e. from 132 (tricore) to over 10k (ppc 13046, ppc64 23426, arm
  82708, aarch64 89760).  Median is ~1600, sum is ~260k.

  Except we actually test just 89k now, because the test *fails* for arm
  and aarch64 after some 500 introspections: introspecting device
  msf2-soc with machine ast2600-evb makes QEMU terminate unsuccessfully
  with "Unsupported NIC model: ftgmac100".  Cause: m2sxxx_soc_initfn()
  calls qemu_check_nic_model().  Goes back to commit 05b7374a58 "msf2:
  Add EMAC block to SmartFusion2 SoC", merged some ten weeks ago.  This
  is exactly the kind of mistake the test is designed to catch.  How
  come it wasn't?  Possibly due to unlucky combination with the slowdown
  discussed in the next item (but that was less than four weeks ago).
  I'll post a patch to fix the bug.

  Run time increases even more than the number of introspections.  Total
  run time for all targets is around one hour, which is less than 25
  introspections per second.  ppc64 is the worst by far: 26 *minutes*
  for 23k tests, less than 15 introspections per second.  sparc and rx
  achieve a paltry 5 introspections per second.

* Recent commit e8c9e65816 'qom: Make "info qom-tree" show children
  sorted' made things worse.  Reverting it cuts run time without -m slow
  from 72s to 43s (100 and 170 introspections per second, respectively),
  and with -m slow from one hour to 6 minutes (24 and 250 introspections
  per second, respectively).

  The speedup with -m slow varies much between targets: from less than 2
  (cris, moxie, nios2, or1k, s390x, tricore, unicore32) to more than 20
  (ppc64, rx, sparc).  The most sluggish introspections profit the most.

  Paolo pointed out that the sorting is n^2.  True.  I did not expect n
  to be large enough for that to matter.  What's being sorted is the
  children of each node in the QOM composition tree.  The number of
  children is almost always small.  The performance difference proves
  enough of them are large enough for the sorting to matter.  The
  variance between machine types suggests some machines have nodes with
  a particularly large number of children.

* I found a memory leak in the same commit.  Plugging it makes the test
  slightly slower for me.  I'll post the fix.

* Since some of the n appear to be large enough for n^2 to matter, I
  tried sorting more efficiently.

  With g_queue_insert_sorted() replaced by g_queue_push_head() &
  g_queue_sort(), the test without -m slow is *slower* : 80s instead of
  72s.  Same for g_slist_prepend() & g_slist_sort().  I believe that's
  because the n are indeed small for the none machine.

  -m slow gets faster: 34 minutes instead of one hour (44 introspections
  per second).  Better, I wouldn't call it good.

* These modest time savings are dwarved many times over by Daniel's
  patch.  With his patch and my leak fix, the test takes 51s without -m
  slow (down from 72s), and 7:29 minutes with -m slow (down from 1h).
  The test is still a pig, but anything that tests a hundred thousand
  QMP commands is bound to be one.

  My "info qom-tree" improvements don't matter anymore then, at least
  for this test: 50s vs. 51s, and 449s vs. 456s.

* Fixing the msf2-soc bug more than *doubles* the run time with -m slow:
  from 7.5 to 18 minutes.

* Measurements in tabular form:

                                without -m slow     with -m slow
  master                        72s  (100 / s)      ~1h  ( 24 / s)
  sort reverted                 43s  (170 / s)      362s (250 / s)
  sort redone, leak plugged     80s  ( 90 / s)      ~34m ( 44 / s)
  Daniels' patch, leak plugged  51s  (170 / s)      456s (200 / s)
  & sort redone                 50s  (150 / s)      449s (200 / s)
  & msf2-soc fixed              no change           ~18m (240 / s)

Conclusions:

* The test matrix is *expensive*.  Testing even a simple QMP query is
  when you do it a quarter million times.  ARM is the greediest pig by
  far (170k introspections, almost two thirds of the total!), followed
  by ppc (36k), x86 (12k) and mips (11k).  Ideas on trimming excess are
  welcome.  I'm not even sure anymore this should be a qtest.

* Running "info qom-tree" and "info qtree" in the order of a hundred
  thousand times is a bad idea.  Daniel's patch makes sense.

* Making info qom-tree build unsorted lists, then sorting them
  efficiently only matters when you run "info qom-tree" way more than
  you should.  It helps more with machines where longer lists exist than
  it hurts with machines where the lists are all short.

> The cost of this change is that any QOM bugs resulting in the test
> failure will not be directly associated with the device that caused
> the failure. The test case is not frequently identifying such bugs
> though,

Most likely because it identifies them long before the patches hit the
list :)

>         and the cause is likely easily visible in the patch series
> that causes the failure. So overall the shorter running time is
> considered the more important factor.

The time savings are simply too large to be left on the table.

I agree with the idea that most of the time the offending device should
be fairly obvious.  But when it isn't, having a way to let the test do
the work of pinpointing the device would be sooo nice.  Can we keep the
slow & thorough checking as a run-time option?

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks!


