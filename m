Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF191C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E5A24686
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqoZfzwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E5A24686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdrV-0003iL-15
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBdqW-0002pO-38
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBdqU-00067H-LV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:18:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBdqU-0005zR-D9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:18:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id p2so14783077wrw.7
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=E4yvEs46Oefqmfs2RdFm8irR9Pfwko3RhlbyZlNc5nU=;
 b=WqoZfzwgeaqsg41MetPPDdKHB0+VUZaJz0RLn/a2htPw0ITPULE67Vd2Gk2WsB0ou3
 Cx9mn0sTakaJhBBusUbnI/Jg3QkVapUQAg1K3uL2a45kfNG3skJ/kYFM1NQb6cIrk2te
 BWhgn2AodGhEIq/DH2skbH8xRBekw7oaOX3KpDM3eI5zi1ZwvIEh/vNzskzfU5+BeO/l
 EczUEC9g4wPPX/grkOEgNTyfcyD3tuPtQwIBapCsOS0Us/Uo8Ntv1BuBS3t02gy+oLIc
 dnNTnC5R6ZPGnHWuCCoby0pHFpsuZa8UrMcxoFAEyCAUk8uRK+q2YULz2L9BIqco7Nvy
 5yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=E4yvEs46Oefqmfs2RdFm8irR9Pfwko3RhlbyZlNc5nU=;
 b=i8+FkcD6X6zsROKGEBgCs8aW1r9JhcLq0tcQp6HSnH5eVVRwyQmHIc7pTPL8oHi2bN
 a7EbC6syGSdQrPtlvUPCq5Fd2J9+eouxL6pk6xllBh+kQbVHaKFGwBbG5trtCLtPUlZS
 wZ2w/KM5rg0mLdMI3Sn5oqN4kqNJEOKwl/UlzPx5pBtkqYzDE3wRgtcAYRo5w7Sr81Kf
 IrIJ7ocGe9NnR2lndZi8d1LkTZ4CYxfVLhjw8s8HsJj37S4421aIC9xrzzGCpg4idXYq
 iRNT+cCvu6cJH5ZL1nu9Xvq3uoCUTO0IcFyuXU/wc8Q2YMBCS7rTpNFjuIe/lH7gnMxb
 ga2w==
X-Gm-Message-State: ANhLgQ0eAlgxFtI/6yBhcpxUw1J1WBcinQ+URMmcZsc4KXb/Y5RvguPX
 rupOspYoT+5GDjXqfl0mV8SAHQ==
X-Google-Smtp-Source: ADFU+vuYIp5PN8/u/Fz9S2uacYAQSYWynxfllv369KBsR8be/CxxEM6xxFKwOXG5Qyf2s40W1mqnMQ==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr14169719wrn.105.1583842729182; 
 Tue, 10 Mar 2020 05:18:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q13sm14563600wrs.91.2020.03.10.05.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 05:18:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 224071FF7E;
 Tue, 10 Mar 2020 12:18:47 +0000 (GMT)
References: <20200310083218.26355-1-kraxel@redhat.com>
 <20200310083218.26355-4-kraxel@redhat.com> <87lfo8ijfg.fsf@linaro.org>
 <20200310120232.6lor5opu7iykqgcr@sirius.home.kraxel.org>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/4] tests/vm: update FreeBSD to 12.1
In-reply-to: <20200310120232.6lor5opu7iykqgcr@sirius.home.kraxel.org>
Date: Tue, 10 Mar 2020 12:18:47 +0000
Message-ID: <87imjcies8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

>> > -    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12=
.0/FreeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
>> > -    csum =3D "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954fb=
485fb99db"
>> > +    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12=
.1/FreeBSD-12.1-RELEASE-amd64-disc1.iso.xz"
>> > +    csum =3D "7394c3f60a1e236e7bd3a05809cf43ae39a3b8e5d42d782004cf2f2=
6b1cfcd88"
>
>> Warning: Permanently added '[127.0.0.1]:39533' (ECDSA) to the list of kn=
own hosts.
>> Bootstrapping pkg from
>> pkg+http://pkg.FreeBSD.org/FreeBSD:12:amd64/quarterly, please wait...
>> Verifying signature with trusted certificate
>> pkg.freebsd.org.2013102301... done
>> Installing pkg-1.12.0_1...
>> Newer FreeBSD version for package pkg:
>> To ignore this error set IGNORE_OSVERSION=3Dyes
>> - package: 1201000
>              ^^^^
> 12.1 package
>
>> - running kernel: 1200086
>                     ^^^^
> 12.0 running
>
> I saw that too, but only *without* the patch.  The upgrade to 12.1 fixes
> that.

Hmm I wonder if the cached assets got confused? It certainly re-ran the
install rather than skipping straight to running the test.

> We might consider setting IGNORE_OSVERSION=3Dyes, so this doesn't happen
> again after FreeBSD 12.2 release.  Not sure whenever that can have
> unwanted side effects though, like packages not working properly.
>
> Any advise from the bsd guys?
>
> cheers,
>   Gerd


--=20
Alex Benn=C3=A9e

