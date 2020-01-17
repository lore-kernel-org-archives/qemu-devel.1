Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF60C33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7331620661
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="DYEerzUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7331620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMPD-0001ov-Cp
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1isMMw-0008Ab-7d
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1isMMv-0000SB-5W
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:48:38 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:45422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1isMMu-0000RE-O4
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:48:37 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
 by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 00H7l3jR028797; Thu, 16 Jan 2020 23:48:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=rr/TtVwYhoZ8owdNlS4bF/X43o1raE+DR93ymu9Txsg=;
 b=DYEerzUSldyQEhBaIZ/9WdAUI8d44yyO2sEnBfcWwhGsaAxhZe2NRdFW1j7J83mYOL82
 C86em/QgmNQktwPbLNiI+vuHFMbPYA5tuAy8gjOr2uBs1WmwQXF6QcS6QZt8//+2SRyz
 NIQUt0+V3wSCbwadOWKwGoqb16gX8sssC4WCGpDdHckKuuBcSZJYXI7gYIH+KVqyCeXp
 fWxhk5kRK6Ivws0vvE1Pec46M3+5ghta05Y4Zie9WLV4HZgrucO1i44VDrq94Uzvl3bQ
 QgbB0sasgtiBsXYXwqoD3KjhRPIzYDqSdn1Bj/9oNl4BsCQsujQq+VqZrT0+i5uZjRrl yQ== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com
 [17.40.76.7])
 by nwk-aaemail-lapp02.apple.com with ESMTP id 2xfbtpmu12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 16 Jan 2020 23:48:35 -0800
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q48008Y5R0Y8910@ma1-mtap-s03.corp.apple.com>; Thu,
 16 Jan 2020 23:48:34 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q4800100QEKHO00@nwk-mmpp-sz11.apple.com>; Thu,
 16 Jan 2020 23:48:34 -0800 (PST)
X-Va-A: 
X-Va-T-CD: e453fe7e51fd089f43dd72677d71143c
X-Va-E-CD: 96db56e8de44b13642a708958e9da172
X-Va-R-CD: 6d5c2ad239283543a9f2829d6df51a97
X-Va-CD: 0
X-Va-ID: 3847f940-b825-4c99-9b38-81323437719e
X-V-A: 
X-V-T-CD: e453fe7e51fd089f43dd72677d71143c
X-V-E-CD: 96db56e8de44b13642a708958e9da172
X-V-R-CD: 6d5c2ad239283543a9f2829d6df51a97
X-V-CD: 0
X-V-ID: c7d948ba-9b41-46ba-a106-1df623c62da1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2020-01-16_06:,, signatures=0
Received: from [17.234.92.20] (unknown [17.234.92.20])
 by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q4800MRMR0V5J80@nwk-mmpp-sz11.apple.com>; Thu,
 16 Jan 2020 23:48:31 -0800 (PST)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1] vnc: fix VNC artifacts
In-reply-to: <20200117074530.mt2upbm7y5knyj7j@sirius.home.kraxel.org>
Date: Thu, 16 Jan 2020 23:48:30 -0800
Cc: qemu-devel@nongnu.org
Content-transfer-encoding: quoted-printable
Message-id: <DD35EA77-0343-4BA1-8D37-92808BCEF2A5@apple.com>
References: <7cb1f22ef8d575238c84f091f03dee8e7fedb78d.1579232679.git.dirty@apple.com>
 <20200117074530.mt2upbm7y5knyj7j@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2020-01-16_06:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.67
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
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

Yes.  Personally, I'd also take the change to vnc-enc-zrle.c: because =
vs->zrle->zlib is reset at the top of the function, using =
vs->zrle->zlib.offset in determining zstream->next_out and =
zstream->avail_out is useless.

Cameron Esfahani
dirty@apple.com

"All that is necessary for the triumph of evil is that good men do =
nothing."

Edmund Burke



> On Jan 16, 2020, at 11:45 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Thu, Jan 16, 2020 at 07:50:58PM -0800, Cameron Esfahani wrote:
>> Remove VNC optimization to reencode framebuffer update as raw if it's
>> smaller than the default encoding.  QEMU's implementation was naive =
and
>> didn't account for the ZLIB z_stream mutating with each compression.  =
Just
>> saving and restoring the output buffer offset wasn't sufficient to =
"rewind"
>> the previous encoding.  Considering that ZRLE is never larger than =
raw and
>> even though ZLIB can occasionally be fractionally larger than raw, =
the
>> overhead of implementing this optimization correctly isn't worth it.
>=20
> So just revert de3f7de7f4e257 then ...
>=20
>> In my investigation, ZRLE always compresses better than ZLIB so
>> prioritize ZRLE over ZLIB, even if the client hints that ZLIB is
>> preferred.
>=20
> ... and make this a separate patch?
>=20
> cheers,
>  Gerd
>=20


