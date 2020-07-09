Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB18C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89E82074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLsdNULY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89E82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWWJ-0004UJ-Vt
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtWVW-0003qI-SU
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:22:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32509
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtWVU-00020y-55
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594300951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HOk/PLk+HfHz4svNXprht7tkOnAzgGtikysQLLEG7zM=;
 b=KLsdNULYn0U0IwStHCGXionb2NEWiOC2n741ITQXzp1slA3bUZw/8WCZXJDP74U6LpYjr3
 n0EnBAYabma1nJzI86iFrohEPLTBCTG2b7lcfMUGnC30ehHURNPP5PMIekLELpKqFrcf23
 /V36r0Mn46t3P9aOqQFQTnbmc5JAFyo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-_yL_6eytOf-e4DyUxG1VNA-1; Thu, 09 Jul 2020 09:22:29 -0400
X-MC-Unique: _yL_6eytOf-e4DyUxG1VNA-1
Received: by mail-wr1-f69.google.com with SMTP id s16so1938213wrv.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 06:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HOk/PLk+HfHz4svNXprht7tkOnAzgGtikysQLLEG7zM=;
 b=o95ip8AUM3TcgU3E7/TsP9QSYpyU3E2nr4q2YBi2eLZKWWDyZ72Er4HDmIqJ+Qr+nY
 yg1iKebUAC3V5J35PdBC62Fu5udOG3EgdGhcnCxb8pIhwL4YM4Qajid2tTpR+t9yVYPw
 J9QlZUaWwjz/aUpifAyiSTZLeYYiP8OqNRsWIdb3/la7zhG8uf+vR7UAJdxfUGdQwTrr
 DFJGz/PgEoZee5Cm5a0o2Oj57FRtpj2G6I09npNPMgafmzSNSTW2clizyVQV9AAbDPSr
 Iv/CONvA7Ukp+Fpiu7rcrNQarqkliA6LRacjRbcxFmG4q/kVKwCkLDnv0Hf/Pb3QfmRP
 GM+g==
X-Gm-Message-State: AOAM532E/RNHYrrLOB86Ro25dTbM0Rwmtfa85zLzzBKp91SdwNJNApx+
 IfuACwvErO5Yui/tHVLK01ZCZnFvZ074AhRqmozQgGa1/PSmGqYTeVx8qLn27KxF0LYqkGBzoM0
 jv3IMVGepif8NrBM=
X-Received: by 2002:adf:92c4:: with SMTP id 62mr61654775wrn.290.1594300948296; 
 Thu, 09 Jul 2020 06:22:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdRUne8B5H3/mjfpeO+DyZblGRkvqXGyafgBxDX3A+LyhpikQt6w0ernEU5AigtIbeKUxS5A==
X-Received: by 2002:adf:92c4:: with SMTP id 62mr61654745wrn.290.1594300947987; 
 Thu, 09 Jul 2020 06:22:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id 133sm4909109wme.5.2020.07.09.06.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 06:22:26 -0700 (PDT)
Subject: Re: Delete some Wiki pages (was: Migrating custom qemu.org
 infrastructure to GitLab)
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
 <20200709101602.lc2uipjlxobjvjn3@sirius.home.kraxel.org>
 <3dacddaa-c739-445b-a24a-02f9e51b9b0e@redhat.com>
 <8e1276e2-8957-49db-0409-e85ab2f09739@redhat.com>
 <4e5404a7-20dc-cb5d-6307-b66fae8f77a4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <158ec779-f640-9e76-5ac7-45797a1aa0a4@redhat.com>
Date: Thu, 9 Jul 2020 15:22:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4e5404a7-20dc-cb5d-6307-b66fae8f77a4@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cleber Rosa <cleber@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 15:10, Thomas Huth wrote:
> - https://wiki.qemu.org/Features/40p :
> - https://wiki.qemu.org/Features/PRePCleanup :
> - https://wiki.qemu.org/Features/BeBox
> - https://wiki.qemu.org/Features/DriveRefactoring
> - https://wiki.qemu.org/Features/LegacyRemoval
> - https://wiki.qemu.org/Features/Machines/Edison
> - https://wiki.qemu.org/Features/Tegra2

Can you make them either "Completed feature pages" or "Obsolete feature
pages"?  We can certainly drop the obsolete features if we migrate to
the GitLab wiki.

> - https://wiki.qemu.org/Features/Documentation/interop
>   that has been superseded by:
>   https://www.qemu.org/docs/master/interop/index.html
> 
> - https://wiki.qemu.org/Features/Documentation/specs
>   that has been superseded by:
>   https://www.qemu.org/docs/master/specs/index.html

Need to check if there's anything else left to do for those two manuals.
 Probably the rST conversion of QMP documentation.  I would leave them
around, they are linked from the main Features/Documentation page.

> - https://wiki.qemu.org/Features/LibvirtWiresharkDissector
>   seems to be a libvirt proposal - IMHO should not be in the QEMU wiki

Probably an internship idea.

> - https://wiki.qemu.org/Features/Version3.0
>   Old suggestions for QEMU version 3.0 ... we're close to 5.1 already

This is more like ideas for deprecation.

> - https://wiki.qemu.org/KeySigningParty2013
>   https://wiki.qemu.org/KeySigningParty2014
>   https://wiki.qemu.org/KeySigningParty2015
>   Only some few old information here, useless nowadays?
> 
> - https://wiki.qemu.org/Features/network_reentrant
>   Old ideas from 2013 ... I think vhost-net superseded this?

It's in [[Category:Obsolete feature pages]] for a reason. :)

> - https://wiki.qemu.org/Planning/Relicensing
>   I think this has been completed. The page looks very outdated now.

No, it's not completed and it's probably never going to be.

> - https://wiki.qemu.org/SecurityProcess
>   Should be replaced with a redirect

Done.

Paolo


