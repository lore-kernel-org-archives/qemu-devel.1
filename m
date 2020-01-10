Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DA8C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0D72080D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="aoXxu3LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0D72080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipt1q-0002ij-43
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 07:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ipt1E-0001mx-SH
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ipt1D-0004v8-D6
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:04:00 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:47295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ipt1C-0004mG-S0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=9yD9cuYrn/JPlIAthCBrj95w+fWeDqCuLDxxJdzaGw8=; b=aoXxu3LY2Kcq1ZHgPWLIVgf23E
 Ji3tkPWMkXdvKQQwNR17IMYp6c8ZDDrODxddW0aQ+Ebk1j/dmkf7bibNa0wwS1+08IR7AXs2kCDiN
 SNJ4LzWpDC88+NYqBdSJhTC4aw/LBciEikxYxIEve6p911oy7iZSODv8VGo0Ste1cgCiflaRPaQOR
 prF9MwRPMvArbAtQP1YZSuBJYF/GCAsiE1i89oypHhXk0F4yS9cdzlFPTI4sy8+2Dh/AI5IHFv8rp
 fobL1vLqVdqAJpe48IrHbNXTzezEerxgr1txpnQNxriLuM2fB3VnDFStE35bN1lfY/Fzjhmj5KTLY
 zjX7KpoSEzK2Y1U976FNfCmthBH8vN9r9VUOm5BsiRUYKHUTbTt3oxICTzvxS4Ay56jLEcFN4j68X
 pk1bHCE64aFat9xHDO2vVCf4mZ3LOXBw2SU0R5ckV0xxFmaSuFEt6e8U9ACOE7nLJ+eubtg3qgyXJ
 wQ4W91nHXwQEoq6Z5Npx1GAiNVJIL0agv3uT/KZvJaklb2S27zs0ezWaE/N6V19NoDCyxmMqy8o8k
 n1A2mjVsQuE0AcMchU0Zs4iRdsyAo6qn8DdW+Y2leRxuMQvkxz3ZcIE/kS+DKn583K8wBEZHXeXJj
 jGZgUjdjA+vQuhK+JYQ4gQow4W6bN2Kg+wBcLOORE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 anthony.perard@citrix.com, Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 2/9] 9pfs: validate count sent by client with T_readdir
Date: Fri, 10 Jan 2020 13:03:55 +0100
Message-ID: <1919937.aoWvVaMKoZ@silver>
In-Reply-To: <20200109005335.4b6214a5@bahia.lan>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
 <6289486.8nMSniMWIK@silver> <20200109005335.4b6214a5@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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

On Donnerstag, 9. Januar 2020 00:53:35 CET Greg Kurz wrote:
> > My idea was to "handle it as an error" immediately when server receives a
> > T_version request with a "msize" argument transmitted by client that would
> > be way too small for anything.
> > 
> > Because if client sends T_version with msize < P9_IOHDRSZ then it is
> > obvious that this msize would be way too small for handling any
> > subsequent 9p request at all.
> 
> P9_IOHDRSZ is 24 bytes, it is definitely not enough to accommodate an
> R_getattr message (153 bytes and heavily used by the linux client) for
> example, so we would likely need a higher minimum as you're suggesting
> later in this mail.
[snip]
> > 1. What is the minimum msize to be allowed with T_version?
> > 
> >    P9_IOHDRSZ would be IMO too small, because P9_IOHDRSZ is the size of
> >    the
> >    common header portion of all IO requests. So it would rather make sense
> >    IMO
> >    reviewing the protocol and pick the largest header size among all
> >    possible
> 
> Not the largest header size, rather the size of the largest message,
> otherwise we may still disconnect. Some response messages contain a
> variable size string that the 9p spec forbids to truncate. In the case
> of R_readlink for example, this could go up to the largest target size
> supported by the host filesystem for symbolic links... ie. likely PATH_MAX.

Good point.

> >    requests supported by 9pfs server ATM. The advantage of this approach
> >    would
> >    be that overall code would be easier too maintain, since we don't have
> >    to
> >    add minimum msize checks in any (or even all) individual request type
> >    handlers. T_version handler of server would already enforce a minimum
> >    msize
> >    and prevent the session if msize too small, and that's it.
> 
> Makes sense. Since the linux client already requires msize to be at
> least 4096, this could be a reasonable choice: it doesn't break any
> existing setups and it allows fairly large strings in messages.

4096 as min. msize is fine with me.

In practice people should use a *much* higher msize for performance reasons 
anyway. And I planned to make this circumstance more clear in the docs.

> > 2. How to handle that error with T_version exactly?
> > 
> >    As far as I can see it, it was originally not considered that T_version
> >    might react with an error response at all. The specs are ambiguous
> >    about
> >    this topic. All you can find is that if the transmitted protocol
> >    version
> >    is not supported by server, then server should respond with "unknown"
> >    with
> >    its R_version response, but should not respond with R_error in that
> >    case.
> >    
> >    The specs do not prohibit R_error for T_version in general, but I could
> >    imagine that some clients might not expect if we would send R_error. On
> >    the
> >    other hand responding with R_version "unknown" would not be appropriate
> >    for
> >    this msize error either, because that would mean to the client that the
> >    protocol version was not supported, which is not the case. So it would
> >    leave client uninformed about the actual reason/cause of the error.
> 
> Other 9p implementations have minimal msize checks and return an error
> message. We could go that way too. The only fishy thing I see, and that
> the other implementations seem to ignore, is that the error message format
> depends on the protocol version. It is R_error for older 9p2000 and
> 9p2000.u, while 9p2000.L uses R_lerror.

Ok, noted.

> If the client doesn't understand
> any of these protocols, which is very unlikely, it seems reasonable to
> interrupt the server.

No need. If it is neither 9P2000.u nor 9P2000.L then the appropriate reply of 
server was and still is:

R_version "unknown"

Since the unsupported protocol version still weights higher than the 
unsupported msize. If you are very, very picky, you might want to distinguish 
in this particular case from the case where msize is even too small for 
R_version "unknown", but personally I don't care since the latter would be an 
extreme exotic and broken client.

Best regards,
Christian Schoenebeck



