Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E652C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6572720679
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Qv3ZoYfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6572720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZahw-0001qz-83
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kZagf-0000tw-Fi
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:19:57 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:38927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kZagd-0004xE-CR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=srEyC4MpaEK2CCCVGOHDkm7Nnb7hoa0VBuufFMu9xpE=; b=Qv3ZoYflj8G6ip2dc+SplsBuUL
 q0Ffpz1yn7cNYq1Pu8/ELk1OfW3Rm2bx+6QyZmZacqcSJYIDWaNTYUu04Y1L2/pwLG5R2fCYWlevs
 BGI6kcaP9hl6Mi1n4cmXmatYMrnDl7Kb3iRdzGPLyuW8pY4Hhj7fjRqNmttUFjZ/G9cnvqHuK5EHr
 Q43YICLJUHkMXg70DKVTlmNHWGSgI49iSdYz27JU8ZEeLuyWVJ1ASBj+C4D9J5mTjN2bTWfv3XGxf
 gA5wgbhEhMqZjMXR1StVGk17R+9iKrDXF73GJ3P14Kuv23W66cxsNYzm96ndmhQMaYtt+tt2r7jtx
 VVUNxf4Q==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: recent flakiness (intermittent hangs) of migration-test
Date: Mon, 02 Nov 2020 15:19:50 +0100
Message-ID: <2235778.NHLJzTTKgb@silver>
In-Reply-To: <f3a379ca-5c7b-0c19-b0ea-6354c460eff3@redhat.com>
References: <CAFEAcA-EsEZWDbUSy6_AXym5e-wP_B4buZYG0swF946ue41WKg@mail.gmail.com>
 <20201030135350.GA588069@xz-x1>
 <f3a379ca-5c7b-0c19-b0ea-6354c460eff3@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 09:19:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 2. November 2020 14:55:04 CET Philippe Mathieu-Daud=E9 wrote:
> On 10/30/20 2:53 PM, Peter Xu wrote:
> > On Fri, Oct 30, 2020 at 11:48:28AM +0000, Peter Maydell wrote:
> >>> Peter, is it possible that you enable QTEST_LOG=3D1 in your future
> >>> migration-test testcase and try to capture the stderr?  With the help
> >>> of commit a47295014d ("migration-test: Only hide error if !QTEST_LOG",
> >>> 2020-10-26), the test should be able to dump quite some helpful
> >>> information to further identify the issue.>>=20
> >> Here's the result of running just the migration test with
> >> QTEST_LOG=3D1:
> >> https://people.linaro.org/~peter.maydell/migration.log
> >> It's 300MB because when the test hangs one of the processes
> >> is apparently in a polling state and continues to send status
> >> queries.
> >>=20
> >> My impression is that the test is OK on an unloaded machine but
> >> more likely to fail if the box is doing other things at the
> >> same time. Alternatively it might be a 'parallel make check' bug.
> >=20
> > Thanks for collecting that, Peter.
> >=20
> > I'm copy-pasting the important information out here (with some moves and
> > indents to make things even clearer):
> >=20
> > ...
> > {"execute": "migrate-recover", "arguments": {"uri":
> > "unix:/tmp/migration-test-nGzu4q/migsocket-recover"}, "id":
> > "recover-cmd"} {"timestamp": {"seconds": 1604056292, "microseconds":
> > 177955}, "event": "MIGRATION", "data": {"status": "setup"}} {"return":
> > {}, "id": "recover-cmd"}
> > {"execute": "query-migrate"}
> > ...
> > {"execute": "migrate", "arguments": {"resume": true, "uri":
> > "unix:/tmp/migration-test-nGzu4q/migsocket-recover"}} qemu-system-x86_6=
4:
> > ram_save_queue_pages no previous block
> > qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
> > {"return": {}}
> > {"execute": "migrate-set-parameters", "arguments":
> > {"max-postcopy-bandwidth": 0}} ...
> >=20
> > The problem is probably an misuse on last_rb on destination node.  When
> > looking at it, I also found a race.  So I guess I should fix both...
> >=20
> > Peter, would it be easy to try apply the two patches I attached to see
> > whether the test hang would be resolved?  Dave, feel free to give early
> > comments too on the two fixes before I post them on the list.
>=20
> Per this comment:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg756235.html
> You could add:
> Tested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Yes, you can do that.

We've extensively tested with Peter Xu's patches in the last couple days on=
=20
various systems and haven't encountered any further lockup since then.

Best regards,
Christian Schoenebeck



