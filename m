Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2011C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994F021D40
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcoeFVwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994F021D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbZA-0002Gc-Fg
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZbXA-0000NT-Pv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:14:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZbX8-0006V8-P4
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604330049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sh0GLyfR4gLJ1CYCkkEcHx0/7EmnIGlN9QvtJXfvUYo=;
 b=QcoeFVwxMDzuPLZVLfP2VLyh4gYoGT19YTuy/oTyA/5SeqExhx3cqET4nCcnZQ9qHNpVVv
 2V+rhnVuR5iHhfAsECTabWt/+p0ENTKk2dI/d5aqTUDdUeftZo7hL6J211aQdAkwv0Lzvd
 kkiSIfKpRgqyBeyCQz65Hk1GEZ/s2l0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-TX4rzt_QPeiAK_8er2jDvw-1; Mon, 02 Nov 2020 10:14:05 -0500
X-MC-Unique: TX4rzt_QPeiAK_8er2jDvw-1
Received: by mail-qt1-f200.google.com with SMTP id 7so753783qtw.23
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 07:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Sh0GLyfR4gLJ1CYCkkEcHx0/7EmnIGlN9QvtJXfvUYo=;
 b=Ex620OhfNtsPA0pSsFNaJX3PBMaSmMvUr75ZzpCCi8BRekQUs8Oi1YXy3ckB58ayX+
 S55Vk3GP7dZN34uPh8u2x3MIIw4CtU9fnRRtj3vN/DIBQNxcc34YzMOOZqncUegh9FtG
 5zBmIRFh4N4uBm2sP6BiiVIym4V0nHqBvpvzIa7ygWCySjwMFOERBzJulhE84+OthZoN
 y5FgBLVH6ykGwOdpqW3YQNAGGLm/x55t8waJIrBNMNrPP2C0hSPYmtZhedlV/MTI03aN
 GGZEiESlqEow39pYiH4QOIymfnY3HhwqxZXmOlN+cE74LVvN1x8ysherWiQrlFrw9WvI
 UAUA==
X-Gm-Message-State: AOAM531N5jRCNY6Va9NBCKuowRcraQ7LgebxMKruIta39DIpw6RHlDww
 gGPlkr4EFRPWsxKFLFgygGJQcMkzWQpQMFoFHcw7rSiukds2oy7XE9wnv6sOo2AAnyGrHwsL2wn
 hwTbAR3j6+QGN0Uc=
X-Received: by 2002:ad4:5387:: with SMTP id i7mr21831308qvv.43.1604330044522; 
 Mon, 02 Nov 2020 07:14:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzi2o7YOfDtETibxRyHuMzgLEfBWH2iJyvnEpIqW8RX2bhCu4S4AfFxbswLwj8YNaMZlV7saQ==
X-Received: by 2002:ad4:5387:: with SMTP id i7mr21831280qvv.43.1604330044263; 
 Mon, 02 Nov 2020 07:14:04 -0800 (PST)
Received: from xz-x1
 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
 by smtp.gmail.com with ESMTPSA id n6sm7450009qkk.6.2020.11.02.07.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 07:14:03 -0800 (PST)
Date: Mon, 2 Nov 2020 10:14:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: recent flakiness (intermittent hangs) of migration-test
Message-ID: <20201102151401.GA3641@xz-x1>
References: <CAFEAcA-EsEZWDbUSy6_AXym5e-wP_B4buZYG0swF946ue41WKg@mail.gmail.com>
 <20201030135350.GA588069@xz-x1>
 <f3a379ca-5c7b-0c19-b0ea-6354c460eff3@redhat.com>
 <2235778.NHLJzTTKgb@silver>
MIME-Version: 1.0
In-Reply-To: <2235778.NHLJzTTKgb@silver>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 03:19:50PM +0100, Christian Schoenebeck wrote:
> On Montag, 2. November 2020 14:55:04 CET Philippe Mathieu-Daudé wrote:
> > On 10/30/20 2:53 PM, Peter Xu wrote:
> > > On Fri, Oct 30, 2020 at 11:48:28AM +0000, Peter Maydell wrote:
> > >>> Peter, is it possible that you enable QTEST_LOG=1 in your future
> > >>> migration-test testcase and try to capture the stderr?  With the help
> > >>> of commit a47295014d ("migration-test: Only hide error if !QTEST_LOG",
> > >>> 2020-10-26), the test should be able to dump quite some helpful
> > >>> information to further identify the issue.>> 
> > >> Here's the result of running just the migration test with
> > >> QTEST_LOG=1:
> > >> https://people.linaro.org/~peter.maydell/migration.log
> > >> It's 300MB because when the test hangs one of the processes
> > >> is apparently in a polling state and continues to send status
> > >> queries.
> > >> 
> > >> My impression is that the test is OK on an unloaded machine but
> > >> more likely to fail if the box is doing other things at the
> > >> same time. Alternatively it might be a 'parallel make check' bug.
> > > 
> > > Thanks for collecting that, Peter.
> > > 
> > > I'm copy-pasting the important information out here (with some moves and
> > > indents to make things even clearer):
> > > 
> > > ...
> > > {"execute": "migrate-recover", "arguments": {"uri":
> > > "unix:/tmp/migration-test-nGzu4q/migsocket-recover"}, "id":
> > > "recover-cmd"} {"timestamp": {"seconds": 1604056292, "microseconds":
> > > 177955}, "event": "MIGRATION", "data": {"status": "setup"}} {"return":
> > > {}, "id": "recover-cmd"}
> > > {"execute": "query-migrate"}
> > > ...
> > > {"execute": "migrate", "arguments": {"resume": true, "uri":
> > > "unix:/tmp/migration-test-nGzu4q/migsocket-recover"}} qemu-system-x86_64:
> > > ram_save_queue_pages no previous block
> > > qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
> > > {"return": {}}
> > > {"execute": "migrate-set-parameters", "arguments":
> > > {"max-postcopy-bandwidth": 0}} ...
> > > 
> > > The problem is probably an misuse on last_rb on destination node.  When
> > > looking at it, I also found a race.  So I guess I should fix both...
> > > 
> > > Peter, would it be easy to try apply the two patches I attached to see
> > > whether the test hang would be resolved?  Dave, feel free to give early
> > > comments too on the two fixes before I post them on the list.
> > 
> > Per this comment:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg756235.html
> > You could add:
> > Tested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> 
> Yes, you can do that.
> 
> We've extensively tested with Peter Xu's patches in the last couple days on 
> various systems and haven't encountered any further lockup since then.

Thanks, Christian & all.  I'll post them formally soon with your tags.

-- 
Peter Xu


