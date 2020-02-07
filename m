Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EC5C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E2320838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/xqdOQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E2320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00d4-0002wO-1Z
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j00bz-0001na-Ir
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j00by-0006Bh-GA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:11:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31307
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j00by-0006BZ-Cs
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581070306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/4gJamhCRHQ3yebOpyuNWtoSMw8s/NkvwyXK/0We7o=;
 b=S/xqdOQs+sCR8f7Hyman8bM9cpldKh3Odpwu4B66Fi4jgLVlSuKWXXSrd3ebUzWNXPohQo
 qBkW+ikw5vp2PZjrk+VReutwNvaqRCz9gTrD5pRsR/acoXvH8r+oKhqrJeSoJF50sZ0JHl
 nz6FFiWpKWvFPEWjHspJgvbyGJbbhhQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-o2Q-xiFhMVyXHY4QlsRu-A-1; Fri, 07 Feb 2020 05:11:44 -0500
Received: by mail-wr1-f72.google.com with SMTP id s13so994745wrb.21
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 02:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bYnhREbb2US+R4d9G7xQLNg490dkufmZ/zrkPG2U2Ls=;
 b=gmj/Tvas17Dp6LoKh5h2gsyloKTbahFqE9anm3XTyz2HWzL0KUZ1zRiOfZQ/yB3oYf
 okVK/PR/TUfR892vk8rEjbkvbTCE2cmqoLeqIrh3UY2Q9/CH2YdO311TRTsKtEOa3kwg
 BkyGRP7NdMdqR4yWQje6ayjfu3oBoI/dCPbmljn9t3P2MWUEi2sVLLRz+UIDDGF32/rM
 iWZ0s9T2o7szVWgs9+/YleV0k2335vRWv0wJGbe1ArmWbMDlbdy8NVPnB5nZUoivM3Vs
 qQmCYF60lO5nM0D0cuRRVqzgRQbfdZu70Y03mieMhlBRdk/pNNqPdQDxx+d6YQN8YSUE
 D5AA==
X-Gm-Message-State: APjAAAV2J32sb98xT0UZkZEQjUrQtCdKdJxWU4yo1QHDKBf4Vp+50PZb
 yRPPlfXnVvoVANyfnm2zeAUKXtFoH0JBQLRurZaC2Bu2tHreLXHAd/d4wrC5TsiryoPOqBAnEtc
 iTraK5BszhBYQ4H4=
X-Received: by 2002:a1c:bdc6:: with SMTP id n189mr3678822wmf.102.1581070302958; 
 Fri, 07 Feb 2020 02:11:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7LBjWDzB86tUKT4VyMCDTuM8ntlKYSPjHkaFSy0Ehh9LBT8ustnzLp/Cg9MQtdvZRiWT9qw==
X-Received: by 2002:a1c:bdc6:: with SMTP id n189mr3678796wmf.102.1581070302650; 
 Fri, 07 Feb 2020 02:11:42 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y185sm2923926wmg.2.2020.02.07.02.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 02:11:42 -0800 (PST)
Subject: Re: [PATCH 17/29] qapi: Add blank lines before bulleted lists
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-18-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <06e540fd-1b3a-6d3d-265d-233fe57d9853@redhat.com>
Date: Fri, 7 Feb 2020 11:11:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206173040.17337-18-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: o2Q-xiFhMVyXHY4QlsRu-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 6:30 PM, Peter Maydell wrote:
> rST insists on a blank line before and after a bulleted list,
> but our texinfo doc generator did not. Add some extra blank
> lines in the doc comments so they're acceptable rST input.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   qapi/block-core.json | 1 +
>   qapi/char.json       | 2 ++
>   qapi/trace.json      | 1 +
>   qapi/ui.json         | 1 +
>   4 files changed, 5 insertions(+)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 9e878e39336..092cd8f13d9 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4757,6 +4757,7 @@
>   #
>   # Once the tray opens, a DEVICE_TRAY_MOVED event is emitted. There are =
cases in
>   # which no such event will be generated, these include:
> +#
>   # - if the guest has locked the tray, @force is false and the guest doe=
s not
>   #   respond to the eject request
>   # - if the BlockBackend denoted by @device does not have a guest device=
 attached
> diff --git a/qapi/char.json b/qapi/char.json
> index 8a9f1e75097..6907b2bfdba 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -133,6 +133,7 @@
>   # @data: data to write
>   #
>   # @format: data encoding (default 'utf8').
> +#
>   #          - base64: data must be base64 encoded text.  Its binary
>   #            decoding gets written.
>   #          - utf8: data's UTF-8 encoding is written
> @@ -167,6 +168,7 @@
>   # @size: how many bytes to read at most
>   #
>   # @format: data encoding (default 'utf8').
> +#
>   #          - base64: the data read is returned in base64 encoding.
>   #          - utf8: the data read is interpreted as UTF-8.
>   #            Bug: can screw up when the buffer contains invalid UTF-8
> diff --git a/qapi/trace.json b/qapi/trace.json
> index 4955e5a7503..47c68f04da7 100644
> --- a/qapi/trace.json
> +++ b/qapi/trace.json
> @@ -53,6 +53,7 @@
>   # Returns: a list of @TraceEventInfo for the matching events
>   #
>   #          An event is returned if:
> +#
>   #          - its name matches the @name pattern, and
>   #          - if @vcpu is given, the event has the "vcpu" property.
>   #
> diff --git a/qapi/ui.json b/qapi/ui.json
> index f527bbdc26e..b368401fd1d 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -935,6 +935,7 @@
>   # Input event union.
>   #
>   # @type: the input type, one of:
> +#
>   #        - 'key': Input event of Keyboard
>   #        - 'btn': Input event of pointer buttons
>   #        - 'rel': Input event of relative pointer motion
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


