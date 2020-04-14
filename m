Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB150C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DF22076D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Czdc7HHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DF22076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOIq-0007Y8-Pl
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOOFO-0004LX-KR
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOOFI-0004Af-PH
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:17:14 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:35955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jOOFI-0004A8-F6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:17:08 -0400
Received: by mail-pj1-x1033.google.com with SMTP id nu11so5407767pjb.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BlsWyTDQeAM70thCjj+OJjgFcwUACi951RgMZkbrju8=;
 b=Czdc7HHomzkpHFGi6cpmu+GO01i7hGBlk7M0Pld5ybxKIoTSqCb0V05ulY1bAqt2IO
 cfr2Gt8vo5DB0YC/Im1kaPwKuCP0ptSIFf8QioklDLFaMgGfyFzsOMaB4JFlYVgMW88U
 4yQyFKvFZ6RUE0gFqkeOFXeG2VlecE05cLTif+Ie8aJj35rfBWUDFuVXhZ4SIzvslgz+
 V+vV1dRwBQpgeEyDIu1PFh7xWHAtHN1mR+fIuTtcgTAtmAJ9aFlu+7MSBaBz1p2zJ8b2
 2MIXe8vfUP+3xzSfkG6/WNahbPjDVkhDY1yP/msK+NHZXrdV+vBCvQLo9MuV/fNt/4kA
 HOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BlsWyTDQeAM70thCjj+OJjgFcwUACi951RgMZkbrju8=;
 b=AzQxUZYU2939sh2catoLIAT3mcp7nAaGEpy98cobGZ4jfpSrB1Lgwkg3mEdYNAKfPC
 1JUqoBSlF69bKBFf6nTadElAmDTZhavJSvs8uES1JFZWCPo2B5WzrPP9bMzW4JL8PUee
 Yl/tmgeKGfoHarpfC/chsKYUnZn8nYvBBYl2qSXdaSC4GAosG4qmskezIHopg7c1Mbg9
 PReY65UF8CT7yGV9grNF3hL3UKt1TFDdiU1p/zQB0teZOWxvQMfMoxixZTi+kHYQmmwN
 3EEQl7l3pA51sir6vIwsOFh3ocWxS0LwxrJsJZXanJ/VPVs/9JVMg+nw8/ZnR8JmKXCi
 IoIw==
X-Gm-Message-State: AGi0PubS/IDJBivmmEB9//jH7cA1YBBk22m3X7yUV/29/rAe8oekbv8/
 4vuh1SDQWT47Om/FXZZg0IpBBQ==
X-Google-Smtp-Source: APiQypLd7Zpa6wP0q+oTi6r4vjF7H5A28vXBFMh+ARvGoDApRB2qOlTH5F7vlFoQc/XYQbzKwCxpjw==
X-Received: by 2002:a17:902:8509:: with SMTP id
 bj9mr748837plb.64.1586881026951; 
 Tue, 14 Apr 2020 09:17:06 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 6sm10720577pgz.0.2020.04.14.09.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 09:17:06 -0700 (PDT)
Subject: Re: [for-5.0] docs: Require Sphinx 1.6 or better
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200414124114.5363-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <38a41ebb-c923-5b36-94ae-12456c048f25@linaro.org>
Date: Tue, 14 Apr 2020 09:17:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414124114.5363-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1033
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 5:41 AM, Peter Maydell wrote:
> Versions of Sphinx older than 1.6 can't build all of our documentation,
> because they are too picky about the syntax of the argument to the
> option:: directive; see Sphinx bugs #646, #3366:
> 
>   https://github.com/sphinx-doc/sphinx/issues/646
>   https://github.com/sphinx-doc/sphinx/issues/3366
> 
> Trying to build with a 1.4.x Sphinx fails with
>  docs/system/images.rst:4: SEVERE: Duplicate ID: "cmdoption-qcow2-arg-encrypt"
> and a 1.5.x Sphinx fails with
>  docs/system/invocation.rst:544: WARNING: Malformed option description '[enable=]PATTERN', should look like "opt", "-opt
> args", "--opt args", "/opt args" or "+opt args"
> 
> Update our needs_sphinx setting to indicate that we require at least
> 1.6.  This will allow configure to fall back to "don't build the
> docs" rather than causing the build to fail entirely, which is
> probably what most users building on a host old enough to have such
> an old Sphinx would want; if they do want the docs then they'll have
> a useful indication of what they need to do (upgrade Sphinx!) rather
> than a confusing error message.
> 
> In theory our distro support policy would suggest that we should
> support building on the Sphinx shipped in those distros, but:
>  * EPEL7 has Sphinx 1.2.3 (which we've never supported!)
>  * Debian Stretch has Sphinx 1.4.8
> 
> Trying to get our docs to work with Sphinx 1.4 is not tractable
> for the 5.0 release and I'm not sure it's worthwhile effort anyway;
> at least with this change the build as a whole now succeeds.
> 
> Thanks to John Snow for doing the investigation and testing to
> confirm what Sphinx versions fail in what ways and what distros
> shipped what.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/conf.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

