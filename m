Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB8BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9DA20774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZvPmg6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9DA20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnLh-0006lp-Mh
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jGmk5-0003ir-1c
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jGmk3-0000Ao-Nj
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:49:28 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jGmk3-0000AT-Iu
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:49:27 -0400
Received: by mail-oi1-x241.google.com with SMTP id k9so6482656oia.8
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=oSfO1qLsq96fdnHxziThSKvm71PA9NH3NBPy8A4Fbao=;
 b=nZvPmg6HxNfgSwE9PhS/6RqsP4Vj+0gK5I9MZVQE91wWsGCeYjdAXKE7x8iayr7DcA
 ofh2M8gq5PxQ1jO7Eewsl0VMpdglIXULnQksYffdSqDUQk0xJLgO6kh1FEX1BPE71gpp
 mNfouKQAoPEr8c3ik+iFuUqdpDnpHONLtmBYUiF3EH5jfSpugIgUecDcFl4jvhpE+ISM
 vtldqGeLJckycZTWZC8n3strbT26qFiru+5J2KjR37QNcd7pFNO5KSGkSoGptmwbcIaA
 hJQt6lr3T9IlTlOyG22YsxIDZHHbtp15LFNKnfV1SZ7/ZxNoPhlxqXSS3LDtPz/jItCg
 iSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=oSfO1qLsq96fdnHxziThSKvm71PA9NH3NBPy8A4Fbao=;
 b=WOahi4oNm0380Qe9EjtaqM/G+QoTc2YkpvcUkwxaPfgZB/QuJ6UNISgpHU/wR/Yp5B
 1gq4w2V2fBkFrYFgZI4hGpYrCXeYilfKH0Sv5GqvapQp55u0jTR8L2fLs9BvHZGd2gym
 iY051vmuJ2qm0lUn9kMFOtMTXQWbJyUrU1wzgIFrY6KFf4nCp3mZC9BaMDu6QqtM08ay
 HeWzK2MQd4n/oeW4RLWFfj/eoBWeaVgJyh7ECzTVDpAKlKD2X9hrhWsbxR3I4AaqIZCs
 PKv9Xe5Hi7/zN36T6TgvY5vC9TMYduWHIE9hqEpOhWr7pBy2bsyFPCFWaQRLqI2U0+fw
 xSCQ==
X-Gm-Message-State: ANhLgQ36AssgCZc9FoV0Tg7gVT0UiqYVj4QcJdbAvDBN8oAGErOeT45I
 SIqBChgMxy5GRoCQC3v1awo=
X-Google-Smtp-Source: ADFU+vskYqIrpw0zhyYJ3U1iNDnDi8W/JImsR5l6Vchp/x3opSVuPjHQ+QhuuYiJIVS+h+NMFFD+Mw==
X-Received: by 2002:aca:b756:: with SMTP id h83mr4203940oif.4.1585068566596;
 Tue, 24 Mar 2020 09:49:26 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id s23sm4311421otd.12.2020.03.24.09.49.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Mar 2020 09:49:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Basil Salman <basil@daynix.com>, qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <75a7f7f7-c0b5-a584-c117-fd1eb6218d6c@redhat.com>
References: <20200311170417.13415-1-basil@daynix.com>
 <20200311170417.13415-4-basil@daynix.com>
 <26fa941f-b578-06e7-947e-34ab426097bc@redhat.com>
 <75a7f7f7-c0b5-a584-c117-fd1eb6218d6c@redhat.com>
Message-ID: <158506856039.3448.7584295753132980505@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] qga-win: prevent crash when executing
 guest-file-read with large count
Date: Tue, 24 Mar 2020 11:49:20 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
X-Mailman-Approved-At: Tue, 24 Mar 2020 13:24:22 -0400
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Philippe Mathieu-Daud=C3=A9 (2020-03-24 08:37:05)
> On 3/24/20 2:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 3/11/20 6:04 PM, Basil Salman wrote:
> >> BZ: #1594054
> > =

> > ^ This is not very helpful as it... (think to ppl with no knowledge of =

> > 'BZ', what to do with this number). Instead ...
> > =

> >> guest-file-read command is currently implemented to read from a
> >> file handle count number of bytes. when executed with a very large =

> >> count number
> >> qemu-ga crashes.
> >> after some digging turns out that qemu-ga crashes after trying to =

> >> allocate
> >> a buffer large enough to save the data read in it, the buffer was =

> >> allocated using
> >> g_malloc0 which is not fail safe, and results a crash in case of failu=
re.
> >> g_malloc0 was replaced with g_try_malloc0() which returns NULL on =

> >> failure,
> >> A check was added for that case in order to prevent qemu-ga from crash=
ing
> >> and to send a response to the qemu-ga client accordingly.
> >>
> > =

> > ... add here (see =

> > https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit=
_message): =

> > =

> > =

> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
> =

> And per the BZ info, please also credit the reporter:
> =

> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>

Since I had these queued for a pull already I went ahead and rolled your
suggestions (minus the posix-side fix) into this patch.

A seperate follow-up patch address the posix counterpart would still be
appreciated though.

> =

> > =

> > Also add:
> > =

> > Cc: qemu-stable@nongnu.org
> > =

> >> Signed-off-by: Basil Salman <basil@daynix.com>
> >> ---
> >> =C2=A0 qga/commands-win32.c | 8 +++++++-
> >> =C2=A0 1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> >> index 9c744d6405..b49920e201 100644
> >> --- a/qga/commands-win32.c
> >> +++ b/qga/commands-win32.c
> >> @@ -343,7 +343,13 @@ GuestFileRead *qmp_guest_file_read(int64_t =

> >> handle, bool has_count,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fh =3D gfh->fh;
> >> -=C2=A0=C2=A0=C2=A0 buf =3D g_malloc0(count+1);
> >> +=C2=A0=C2=A0=C2=A0 buf =3D g_try_malloc0(count + 1);
> >> +=C2=A0=C2=A0=C2=A0 if (!buf) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to allocate sufficient memo=
ry "
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "to complete the requested service"=
);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> >> +=C2=A0=C2=A0=C2=A0 }
> > =

> > Can you fix the equivalent problem in qga/commands-posix.c too please?
> > =

> > Also use "PATCH-for-5.0" in the patch subject so we don't miss it for =

> > the next release.
> > =

> > Thanks!
> > =

> > Phil.
> > =

> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_ok =3D ReadFile(fh, buf, count, &rea=
d_count, NULL);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_ok) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_win3=
2(errp, GetLastError(), "failed to read file");
> >>
>=20

