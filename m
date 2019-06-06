Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF369C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85438206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X51fujIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85438206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ291-0002WA-HD
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 19:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49020)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <randrianasulu@gmail.com>) id 1hZ28Q-000264-M1
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <randrianasulu@gmail.com>) id 1hZ28P-0002dc-8q
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:49:30 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
 id 1hZ28P-0002bd-1S
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:49:29 -0400
Received: by mail-lf1-x141.google.com with SMTP id l26so194375lfh.13
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 16:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:user-agent:cc:references:in-reply-to
 :mime-version:content-transfer-encoding:content-disposition
 :message-id; bh=jZmyIp4exkvmcAv8mKP4Nk1kZaS5My9PdpJWHczsRF0=;
 b=X51fujIzA45a3TUTAyc/kcqyXLd0yNJcE5xQ33gF7RfRPfGyxfuFPB5W55tbeKQV5U
 8HoHJCG7yyNjTkLFbRwWgWUBuG9ymh8k70SJrpEYLT2+V3wyVAlK/kQiwcUa0ClG2TxU
 ChuMCE/agP7ecsEn7SCWB1zjMn2iB9R+TSxm3dLpDrZ0i52GSeWRyebFHe47yOJgWGUt
 +bqrgQEYmYg5EyhH9uXoGdyzLBwbbQ+9LOv0I+zwjnmsOTZuTwCWly6m6NsX6cv93EmK
 VopAcBkY/LfZDUOSFZgjkMhw5RPwB4m5Lw3jOwefmcg6DBmjVBGWgCVVFw4x1WjsT8fs
 o8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:user-agent:cc:references
 :in-reply-to:mime-version:content-transfer-encoding
 :content-disposition:message-id;
 bh=jZmyIp4exkvmcAv8mKP4Nk1kZaS5My9PdpJWHczsRF0=;
 b=JjYBYgm127e85UfamzG2d823VyrcFSNqfrdW5sBkSirn5uliTn8D6CGcFNtkjq5FJj
 tOG1ofvdY2hhr37njYrhYV/YH1beMpld3vgarrTl6v0lpUAWTrOMejNDQZ30PYBxWMHR
 TTX6Vd+FHRpIMVeMCFQL07jiyQTh4vTWLod/Gz8I8QJ6vI3HGySo7uzGc9NAq+5/kWTD
 csAjCMDPmWCafZzuYxVJnt8LsLqgVH4xDm5B0UnQIvLGWfiVDb2V3FG/oSduRPj+Grh3
 mFfjENBNhLjEsv4NCCmSDy4xxKN0F1E2EUEPIa/bVK0LsUHkdUPpTn/BAjgVf/e9BbO1
 PPIA==
X-Gm-Message-State: APjAAAW5k6LHWkGF74Qxk8U3Eqwa3yM4mVGwv/qtf1p0wgJf3ZstdldA
 HrZGTeVEG9QO0cBL9V739CQ=
X-Google-Smtp-Source: APXvYqyGNH5kjNV33zYrhpJo3VoPmORyJ0rhA+0MImAdGeERPzLH6Mas9stIpp7ksrPpfkI5zRmhsg==
X-Received: by 2002:a05:6512:dc:: with SMTP id
 c28mr24545948lfp.105.1559864967361; 
 Thu, 06 Jun 2019 16:49:27 -0700 (PDT)
Received: from [192.168.1.117] ([176.116.252.109])
 by smtp.gmail.com with ESMTPSA id n1sm73438lfl.77.2019.06.06.16.49.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Jun 2019 16:49:26 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 7 Jun 2019 02:41:24 +0300
User-Agent: KMail/1.9.10
References: <20190606154310.15830-1-alex.bennee@linaro.org>
 <201906061857.12470.randrianasulu@gmail.com>
 <87k1dysl14.fsf@zen.linaroharston>
In-Reply-To: <87k1dysl14.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: base64
Content-Disposition: inline
Message-Id: <201906070241.24359.randrianasulu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH] cputlb: cast size_t to target_ulong before
 using for address masks
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

0JIg0YHQvtC+0LHRidC10L3QuNC4INC+0YIgVGh1cnNkYXkgMDYgSnVuZSAyMDE5IDIwOjA0OjA3
IEFsZXggQmVubsOpZSDQvdCw0L/QuNGB0LDQuyjQsCk6Cj4gCj4gQW5kcmV3IFJhbmRyaWFuYXN1
bHUgPHJhbmRyaWFuYXN1bHVAZ21haWwuY29tPiB3cml0ZXM6Cj4gCj4gPiDQkiDRgdC+0L7QsdGJ
0LXQvdC40Lgg0L7RgiBUaHVyc2RheSAwNiBKdW5lIDIwMTkgMTg6NDM6MTAgQWxleCBCZW5uw6ll
INC90LDQv9C40YHQsNC7KNCwKToKPiA+PiBhZGRyMSA9IGFkZHIgJiB+KCh0YXJnZXRfdWxvbmcp
c2l6ZSAtIDEpOwo+ID4KPiA+IHllcywgdGhpcyBmaXhlcyBteSBoYW5nISBUaGFua3MhCj4gCj4g
Q2FuIEkgdGFrZSB0aGF0IGFzIGE6Cj4gCj4gVGVzdGVkLWJ5OiBBbmRyZXcgUmFuZHJpYW5hc3Vs
dSA8cmFuZHJpYW5hc3VsdUBnbWFpbC5jb20+Cj4gCj4gPwoKWWVzLCB3aGlsZSBJIG9ubHkgdGVz
dGVkIDY0LWJpdCB4ODYtNjQga2VybmVsIG9uIDMyLWJpdCB4ODYgaG9zdCwgbm90IG90aGVyIG1h
Y2hpbmVzLgoKPiAKPiAtLQo+IEFsZXggQmVubsOpZQo+IAoKCg==

