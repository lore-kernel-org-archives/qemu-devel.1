Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCCAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC4C2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OLmGL0WQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC4C2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pag-0007YQ-Jq
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1j8pWs-00059y-Se
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1j8pWr-0003dG-Uh
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:10:58 -0500
Received: from mout.gmx.net ([212.227.15.15]:44663)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1j8pWr-0003bM-Lg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1583172642;
 bh=1W7dCF8F/x6R0jk9UZ5JqII6an+t+s1OOlq0XvPtzJI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=OLmGL0WQ+lb8qgL8vwOveAAsmcdzlE+tRh53g3P9Ltw8fgW/+6FHk+gPppd/rEJ3w
 d965wGhan0oGXDKnHD9rYKhjs4dHDTZeMCpciFVwfP7nxZKH1/MZ9MhpDrvTsu4XAX
 5CVpZpky4of+pXLsHpvdnG8psQgRy/J4mZhVE1r4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLQxN-1irROj13Y3-00IQVu; Mon, 02
 Mar 2020 19:10:42 +0100
Subject: Re: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com,
 peter.maydell@linaro.org, max@m00nbsd.net
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-3-n54@gmx.com>
 <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
 <55d6ace5-3cf1-de24-53be-700982a9f834@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <1da8f8c9-7924-44c2-d397-706c6a7435fd@gmx.com>
Date: Mon, 2 Mar 2020 19:09:44 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <55d6ace5-3cf1-de24-53be-700982a9f834@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xtz4Is0AZwwy5aZw1OLdIXHql+L190W6q4YQ+5LMXZr+aOPib8k
 H4Wk0sM4z6J9BcP9P2/n29l8WSyFHuI4o2qNhoxIlnzA8MwSImmKn++oKJarhSTeOCUg3q8
 30P2j4hyNFZUVNYEOFBDAZTc1Mu/2xsw1tijs6Bhaaaz04/+Py2sH/OIt1ck0o4lQad7Suc
 0ekA0YjRIXdbj9JVyK5cQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0kvh3yhFdX4=:/W/8GMvp877QiY/oYNttHx
 jSWMvjwscGtKRfBolTDQiKQn3KciXTV5yyFklVWU3teatYThq9ZPqHlwkeklfGYIRFY2li1Nh
 A4bVYrZVPogmysRhj2sIyQ8fItoG5T1gEgg86AU+E43pwwOI+Xf4ohQNOnfWGihocQYjAHAHB
 Tm7nQzO4FY6NB0akma9l2bCH43CDCLsxZrFAnb6opvoJphFngenhocgVqbrZnOyvQFQQSa6DL
 aIdYrOWAy3EY3rWfOL7prukCAsbr3SE08hEcMQrtLVoE9GVou4hZHVZeNJDXY439bfHVL7pke
 Ut5+Pcb9CfaMx3+wU5QDiVoJdGTqlTRPm7Yg2g8klbRhBWUkQf406zYGCkB6KzcguUJiKOVRV
 crtdan7hjeCkrf5bcO7LnXsRpsVgH3jWAe9ztOgdCqPHnp78wBcyOHGcPc8aHOkSIgLk5PhLT
 5aMAPUeGRGrTvEXLKXJ5J449fU1KQX+0Jh5hmL58p497DVIexbTReor2693sACFdJo9uz/LAd
 3TJD9UoLVvJ8t/gAt+MUvif6hGJppxwsb7RHFG4ayTx5HDB/Lp8hF4N0DyQgpw82YYYRamq2J
 1cyjxb7wkBvWUQfjApmlJ9FUNLo8d3Csalab9+/fbMm39OrN2oJ5SguZ3TcikTXosOD7nZiQ3
 Cioq+PlXEz27Lju9QWyeYZpKh0VXC6ImiG1HT7gyYEUrftU5S198W+nLFFoxBkYBJTtTSPDkH
 pqnyu3yXZSj1QpgAQvwwxJSW107Xl8eGSmDMqAi5gPiCxVTYg+TH/benu1LJWsqDCmoXzVl18
 9aEMz2j3YrqgL9SZVJGrQqNP3YEdLlrBhAZUR/QvDUsZ4hXHsX//yzkNZYbnf/kmoZK4+pf08
 i/LMy6uzavhCz6W2bip0wKmf0xfiqbD59WedRIs69JKeXLP2DeO+hdTou7xSMoiQnKHJJQcSR
 lhnraXGG45hHqehF4sEMmVqZJOeOX4RCTzSGySs4EtVBBo7FzaXyuPPtvTgPwsGbgswU32tMX
 pLP8rKxIWrWRmoG7uWqyV6hwxqq3KUrRw8rkGF+f7/BIEU71JW0NeyEfAXetZR78KyiR9PQrV
 LYynd1vKFp9pFoF58ZJSNcO+eJTE69ajXQjRRpI5BZWIDT+sWOkohqQL7jJyhaaGrlSkb/zcr
 UfwhU5P5mcCpLapTI18yqXBmDzCH6fCCPhd5pzfrVU7tgNR4an1k+LF3xaNhy6qh5pj+I=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.03.2020 18:11, Paolo Bonzini wrote:
> On 03/02/20 12:41, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> Maybe you can add something like:
>>
>> if test "$targetos" =3D "NetBSD"; then
>> =C2=A0=C2=A0=C2=A0 nvmm=3D"check"
>> fi
>
> You could do just nvmm=3D"" and, below,
>
> if test "$nvmm" !=3D "no" && test "$targetos" =3D "NetBSD"
>
> But maybe even testing NetBSD is not needed since nvmm.h will likely not
> be there.
>
> Paolo
>

I have got no opinion here.

I can just change on request nvmm=3D"yes" to nvmm=3D"check" and be done.

>> to build by default with NVMM if available.
>>
>>> +##########################################
>>> +# NetBSD Virtual Machine Monitor (NVMM) accelerator check
>>> +if test "$nvmm" !=3D "no" ; then
>>> +=C2=A0=C2=A0=C2=A0 if check_include "nvmm.h" ; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvmm=3D"yes"
>>> +=C2=A0=C2=A0=C2=A0 LIBS=3D"-lnvmm $LIBS"
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if test "$nvmm" =3D "yes";=
 then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fe=
ature_not_found "NVMM" "NVMM is not available"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvmm=3D"no"
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +fi
>


