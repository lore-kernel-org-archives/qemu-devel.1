Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C6AC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CCD20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGEv8vj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CCD20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j16rs-0005j7-Vl
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j16rG-0005HJ-L4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j16rE-0002lW-5U
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:04:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31621
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j16rD-0002jw-TQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581332642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1j36Kr7f8ruJR53L8vdnKSUiHdoyGLZJvtelba2nxF0=;
 b=UGEv8vj8k61eItXVRERHXj3sHRpJgk6c4d0lyXzBHu4uAu2xC/fZzGyI1CxRxUVA2YAxbj
 r8LejyiwQgDtNbNecKusvteCFD+8x8Wl0jKm8z8CCRXghdVjwBDPkja01z3HnOh/CtpuPU
 daO1dU8KZKZUfg+k6FiPymxtdQzMdw8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-ewUTV4DqNIm7jhm5uHfu6g-1; Mon, 10 Feb 2020 06:04:01 -0500
Received: by mail-wr1-f70.google.com with SMTP id z15so4857281wrw.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 03:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1j36Kr7f8ruJR53L8vdnKSUiHdoyGLZJvtelba2nxF0=;
 b=FU2S5KxSgniECF8yeRDc9hPpoJPt4qxaIyUenonB4iGsiwlRokx8nqqXkLxyqpT6Wf
 EXWp846t1YUs0jYqUqMoQ5CjvYaJmhUbq+tH9tRVSc2LxYFsUUvZM2rYQkjV3SqLCeOc
 OnF/UNQZ1xpj/aBsHQOJXvAOkiFoWCgSCKYu2444Tx3qSOTHLpnyzYYkJrE/Qt4WOGxo
 sIVuhZ3zonkt7aV3LVslqJTT6m240/pIGopcXeE2RnDIfdSgyERYwzCMwQmXLsOAXiV0
 BvA2eaMMIRDqi/Ax1qCF+s9hJimQy/mqU0zQcWo8iFoMkmh3TbGikKkgfeflzRnKDxsv
 zMXg==
X-Gm-Message-State: APjAAAUz+S6ktfJ6bXCTotvrmdqNgRvFuXb7y903Mj8me9RNznegsSLo
 YktKIneiX0Ru6m00V4/WVjgCr+I49ZQ3ZKnPCpOob4PfZRggbxdgFMax5Af1aX2xPCPO465yp49
 NWYrk5Kb63W72jpY=
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr14643898wmc.158.1581332640261; 
 Mon, 10 Feb 2020 03:04:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkeADIUMzgvIOA34bEUbrKb5UB3JDUj40ubgXYWBdBjq5p1RsfSpNhyiGf9fTf+2eZxHJJoA==
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr14643873wmc.158.1581332640020; 
 Mon, 10 Feb 2020 03:04:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56?
 ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
 by smtp.gmail.com with ESMTPSA id y139sm129678wmd.24.2020.02.10.03.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 03:03:59 -0800 (PST)
Subject: Re: Summary of Re: Making QEMU easier for management tools and
 applications
To: Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <875zgm2vqv.fsf@dusky.pond.sub.org>
 <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a504c681-2c1c-9b1d-c7fb-09e42abb7b9b@redhat.com>
Date: Mon, 10 Feb 2020 12:04:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: ewUTV4DqNIm7jhm5uHfu6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/02/20 11:56, Stefan Hajnoczi wrote:
> On Tue, Feb 4, 2020 at 3:54 PM Markus Armbruster <armbru@redhat.com> wrote:
>> = Ways to provide machine-friendly initial configuration =
>>
>> Two ways to provide machine-friendly initial configuration on par with
>> QMP have been proposed:
>>
>> 1. Extend QMP
>>
>>    Machines use the CLI only to configure a QMP socket.  The remainder
>>    of the CLI becomes human-only, with much relaxed compatibility rules.
>>
>> 2. QAPIfy the CLI
>>
>>    Provide a machine-friendly CLI based on QAPI and JSON.  The current
>>    CLI becomes human-only, with much relaxed compatibility rules.
> 
> Do we keep the existing CLI around in both cases?  I'm concerned that
> we're still following the HMP/QMP approach, which has left QEMU with
> the legacy HMP monitor that we still haven't removed.
> 
> I'm in favor of simplifying QEMU at the expense of an incompatible CLI
> change in QEMU 6.0.
> 
> A project like this could prototype incompatible CLI changes in a
> separate git tree.  If it achieves the desired unification (CLI, QMP,
> configuration file) and simplification (less code, legacy removal)
> then it can be merged for an upcoming QEMU major release.

I think Daniel had a good point in suggesting a (possibly) throwaway
fork for either (1) or (2).  Let's see what kind of change is needed to
do 100% QMP-based configuration of guests (or at least to QMP-ify
configuration of devices and backends---things that can already have an
*-add command now); then we can figure out which subset of the current
CLI can be mapped to it.

Paolo


