Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304A2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 01:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE18720738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 01:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="n6HmCwmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE18720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=apple.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgf5j-0007nS-9f
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 21:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dirty@apple.com>) id 1jgf50-0007Od-LE
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 21:54:02 -0400
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:51946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dirty@apple.com>) id 1jgf4z-0004vO-6w
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 21:54:02 -0400
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
 by nwk-aaemail-lapp01.apple.com (8.16.0.42/8.16.0.42) with SMTP id
 0541qouu018625; Wed, 3 Jun 2020 18:53:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=67WU8PDEJ+mUSTs6NaMIr+chfbaqD8+8IVixeRUDC8k=;
 b=n6HmCwmbt4V5MQIE2WEFTnyl/VRoG8pYtyLvqNFnLGEGvUmFRVr4FA1THnXYVASWm9rX
 jwA0pYz9d072154ktKuJb4kfRZwvDA2zswX6UXiyb4Ube89mNGu9eGFCfX9dxdpkyOgt
 y1FUsP6PIfVKg7ktQCmmJOAgRynk4n4UfevxBEVtyBu0CBgYG4cVEofjMlOIQb31gtl0
 b7vRviPLNGOeFmp5+wSlb+dXU6XCc9a3YIJD20+6cUYdBhvIACi2WqsRRgzk2GJiJZtk
 70hgIGfO3UzaAbAurp6ADVoIFrg8vBBFRhbpQKhlFoTavG2Zp1+TQbQ0Hd+pkwDN3pys Hg== 
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by nwk-aaemail-lapp01.apple.com with ESMTP id 31bpe153v3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 03 Jun 2020 18:53:59 -0700
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0QBD00ZWFP9ZIU10@rn-mailsvcp-mta-lapp02.rno.apple.com>; 
 Wed, 03 Jun 2020 18:53:59 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0QBD00C00P4SHY00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Wed,
 03 Jun 2020 18:53:59 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 99f89d79671c95ffdbff058802d4710e
X-Va-E-CD: f2f4c490b283e0999592aef402d17e40
X-Va-R-CD: 38c3c07246e21531e94ba00813ded620
X-Va-CD: 0
X-Va-ID: 8750a291-0b96-4813-8aed-8c6d5f6c13d6
X-V-A: 
X-V-T-CD: 99f89d79671c95ffdbff058802d4710e
X-V-E-CD: f2f4c490b283e0999592aef402d17e40
X-V-R-CD: 38c3c07246e21531e94ba00813ded620
X-V-CD: 0
X-V-ID: 7dbb60df-57f5-412f-93b5-2c578903003b
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-03_13:2020-06-02,
 2020-06-03 signatures=0
Received: from [17.234.60.254] (unknown [17.234.60.254])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0QBD00D4JP9ZNN00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Wed,
 03 Jun 2020 18:53:59 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 00/13] i386: hvf: Remove HVFX86EmulatorState
From: Cameron Esfahani <dirty@apple.com>
In-reply-to: <20200528193758.51454-1-r.bolshakov@yadro.com>
Date: Wed, 03 Jun 2020 18:53:58 -0700
Cc: qemu-devel@nongnu.org
Content-transfer-encoding: quoted-printable
Message-id: <71C3D499-BFE4-402B-9720-5F2246F94B4F@apple.com>
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-03_13:2020-06-02,
 2020-06-03 signatures=0
Received-SPF: pass client-ip=17.151.62.66; envelope-from=dirty@apple.com;
 helo=nwk-aaemail-lapp01.apple.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 21:54:00
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Reviewed-by: Cameron Esfahani <dirty@apple.com>=20

Cameron Esfahani
dirty@apple.com

"The cake is a lie."

Common wisdom



> On May 28, 2020, at 12:37 PM, Roman Bolshakov <r.bolshakov@yadro.com> =
wrote:
>=20
> Hi,
>=20
> This is a cleanup series for HVF accel.
>=20
> HVF is using two emulator states CPUX86State and HVFX86EmulatorState
> simultaneously. HVFX86EmulatorState is used for instruction emulation.
> CPUX86State is used in all other places. Sometimes the states are in
> sync, sometimes they're not. It complicates reasoning about emulator
> behaviour given that there's a third state - VMCS.
>=20
> The series tries to leverage CPUX86State for instruction decoding and
> removes HVFX86EmulatorState. I had to add two new hvf-specific fields =
to
> CPUX86State: lazy_flags and mmio_buf. It's likely that cc_op, cc_dst,
> etc could be reused for lazy_flags but it'd require major rework of =
flag
> processing during instruction emulation. Hopefully that'll happen too =
in
> the future.
>=20
> I tried to include sysemu/hvf.h into target/i386/cpu.h to add =
definition
> of hvf lazy flags but couldn't do that at first it because it =
introduced
> circular dependency between existing sysemu/hvf.h and cpu.h. The first
> three patches untangle and prune sysemu/hvf.h to the bare minimum to
> allow inclusion of sysemu/hvf.h into target/i386/cpu.h.
>=20
> This might conflict with [1], but merge/rebase should be trivial.
>=20
> 1. https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg07449.html
>=20
> Thanks,
> Roman
>=20
> Roman Bolshakov (13):
>  i386: hvf: Move HVFState definition into hvf
>  i386: hvf: Drop useless declarations in sysemu
>  i386: hvf: Clean stray includes in sysemu
>  i386: hvf: Drop unused variable
>  i386: hvf: Use ins_len to advance IP
>  i386: hvf: Use IP from CPUX86State
>  i386: hvf: Drop fetch_rip from HVFX86EmulatorState
>  i386: hvf: Drop rflags from HVFX86EmulatorState
>  i386: hvf: Drop copy of RFLAGS defines
>  i386: hvf: Drop regs in HVFX86EmulatorState
>  i386: hvf: Move lazy_flags into CPUX86State
>  i386: hvf: Move mmio_buf into CPUX86State
>  i386: hvf: Drop HVFX86EmulatorState
>=20
> include/qemu/typedefs.h      |   1 -
> include/sysemu/hvf.h         |  73 ++-------------------
> target/i386/cpu.h            |   4 +-
> target/i386/hvf/hvf-i386.h   |  35 ++++++++++
> target/i386/hvf/hvf.c        |  30 ++++-----
> target/i386/hvf/x86.c        |   2 +-
> target/i386/hvf/x86.h        |  89 ++-----------------------
> target/i386/hvf/x86_decode.c |  25 ++++---
> target/i386/hvf/x86_emu.c    | 122 +++++++++++++++++------------------
> target/i386/hvf/x86_flags.c  |  81 ++++++++++++-----------
> target/i386/hvf/x86_task.c   |  10 +--
> target/i386/hvf/x86hvf.c     |   6 +-
> 12 files changed, 186 insertions(+), 292 deletions(-)
>=20
> --=20
> 2.26.1
>=20
>=20


