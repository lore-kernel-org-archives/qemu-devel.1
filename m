Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31EEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACBF206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhYN0+qQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACBF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJml-0006wH-Hp
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixJmA-0006VA-40
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixJm9-0001Yh-2z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:03:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25605)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixJm8-0001Xp-W1
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580428988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C0lLpkn3BT8naoFppv9fNNj6OuOE0XGJFYmYxGrk5rg=;
 b=HhYN0+qQtzzy3a4Bb9WFHvRZMsODdOo5sddTbtKxx8NtvmLAl5LtvELVWbhUkP6YFEHdgT
 4fBlrxfODytXeDVJupEIBYnUs0iUdqJJsl94aKL7XTjLB1VkBQIj+nQFkq8jUcTa8cyAD3
 w7gAbyJoTDEFaxF6NbocObtH+2Zn+2M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-OvpFkC7dOaGubJicHFE7Kw-1; Thu, 30 Jan 2020 19:03:06 -0500
Received: by mail-wm1-f69.google.com with SMTP id d4so1375879wmd.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P1pkQw5BKitbcECgnzocHMZpFG0gxrYnFX1iWPDZlW8=;
 b=jOwGJWfBOQ6QTZR/fXF6fgjO3HMNXozKkiStFmY3F2r02yzW+hPmXUFIlWZUjVs5e/
 BxKeIjow9eqzMGfuAsL44HNqVhu5yMNF1dB0S/sWY5xBvx/jQQLQCT9S/btpi4gu3DVB
 UOoR4CFcxa7v57NNvjxjoRGDyoEBtvaHLurFJqbtiYyT0bYKU7baT17H3v7kMdivhQKY
 r4DqlWRSHgh6PqkOvME1OcM/NjoTnrs3n+ey+a9lLdZBRcSwK+52p4E93UVkKsbpoaVJ
 Nuq9KxRoVmQ37btazr0Bw6codmeD4qEg2xlgwYBgqjZqybS7KdC2nGF+07sVa765iWXi
 mlyw==
X-Gm-Message-State: APjAAAUcFhnPEeyfDSd8flKpgw1pWV+ixEBttNjgOtfNKhasU4YlO8n0
 Lo5CiIJgOiPLm/E1nODvkVZxVp07klHGJvlNow5G9PrXO42ETPaWz12hH7rTMsUxh3VubIlfmUH
 OxZ8VviJVh64zDCg=
X-Received: by 2002:adf:c54e:: with SMTP id s14mr7875714wrf.385.1580428985007; 
 Thu, 30 Jan 2020 16:03:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUkUPwod8HrBUPRq3zaNK48Q+1CX0h3tgNVVKi26UB4/o9nsFvS1RzDtTojpbQyz18tGysyA==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr7875693wrf.385.1580428984747; 
 Thu, 30 Jan 2020 16:03:04 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id k8sm1979612wrq.67.2020.01.30.16.03.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 16:03:04 -0800 (PST)
Subject: Re: [PATCH 3/6] tests/boot_linux_console: fix extract_from_deb()
 comment
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-4-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <403fd74d-eacf-f130-4d4d-c6bcf18d3e96@redhat.com>
Date: Fri, 31 Jan 2020 01:03:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-4-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-MC-Unique: OvpFkC7dOaGubJicHFE7Kw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wainersm@redhat.com,
 slp@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 5:36 PM, Liam Merwick wrote:
> The second param in extract_from_deb() is 'path' not 'file'
>=20
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>   tests/acceptance/boot_linux_console.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 8daf6461ffac..43bc928b03a2 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -40,7 +40,7 @@ class BootLinuxConsole(Test):
>           Extracts a file from a deb package into the test workdir
>  =20
>           :param deb: path to the deb archive
> -        :param file: path within the deb archive of the file to be extra=
cted
> +        :param path: path within the deb archive of the file to be extra=
cted
>           :returns: path of the extracted file
>           """
>           cwd =3D os.getcwd()
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Also, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


