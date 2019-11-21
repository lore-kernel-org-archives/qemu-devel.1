Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C44BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB96520672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ir0y29R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB96520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXrgG-0005RJ-TK
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXrfT-0004tN-Ch
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXrfS-0001Qc-8O
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:59:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25512
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXrfS-0001Q8-5B
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574362741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVnBXCN/3xd3yFBQ/JitQNjTmDQhaa8qWXg/izJGYGI=;
 b=ir0y29R5/cy5LLvaYjASblvMNE7wg9y3wMIkA/Q7o7XdC5k1wQtAxpPNamJ+f/kKGDZ8P6
 hMzwIjCCUPtpsdoI+bjgi8DkXSoPcv4ktAY9OXuqMgvkglG9ToLhg/+vCAR74KPVtD1Ndy
 bX7MZeAPoJe+CbE6kVY7rNVAC86Oj7Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-LyJboux7PcGKB8zMHzaR2A-1; Thu, 21 Nov 2019 13:58:58 -0500
Received: by mail-wm1-f72.google.com with SMTP id 199so2294745wmb.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DoxUbj1GEYUNvhJw/EScqAg0fyp35HPnwlP7AoZUp5I=;
 b=cNQV1GAzJ7O89zgWxj/Jha/8cRtOREME3Ws3MDbGMddzcHHplGQH/tP5kEZVZyI2nK
 qP+zC9LdsLBzUkGWoTx6OAhbuX2tm6n4+iSlEDHv4XuDv0UrCt2k3JGTWqwoYZrUg/DA
 A/NJ4EAfThqIQhAkPDnc2GXFUVmRlZSIwn8WpqPFb6VT320LxGtBBFZza5NJUOD/PiDV
 7S9t1Lh4dyAz7Crn9nFYv7HUi1vZU9nFasXzFVD53AKLZuqu80xJcGj5jvg8jIsLTPeD
 eVf/BeQI/28hKQri8pLoIQ3NxrrF3ncNUf3ZBrXgxqdjxbHvn6BZf1m/a7ZYmTxTjGvr
 SiwA==
X-Gm-Message-State: APjAAAWV0898N8eStHQw9AehtYew7IQ/bSCJoH1IEsarGedWiLehQMPD
 +PRaWu8BMboF/8AObAQ84WPQwyB3swyXPV/1YDYtcsvX2tqCd0pwt+ldbzJtln7Ebx42h9Ku47L
 y91St7CeVLUqkupg=
X-Received: by 2002:a5d:4142:: with SMTP id c2mr13014870wrq.60.1574362737037; 
 Thu, 21 Nov 2019 10:58:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6eODKBaMCm9/BBCJfW3h2aedJveFmNXOnG0nRpLGgPoK1cPMJI3vsq0aycFTyOhyBZiDe0Q==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr13014844wrq.60.1574362736824; 
 Thu, 21 Nov 2019 10:58:56 -0800 (PST)
Received: from [192.168.43.238] (92.red-95-127-154.staticip.rima-tde.net.
 [95.127.154.92])
 by smtp.gmail.com with ESMTPSA id b17sm4559038wru.36.2019.11.21.10.58.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 10:58:56 -0800 (PST)
Subject: Re: [PATCH-for-4.2?] vmstate-static-checker: Fix for current python
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, ehabkost@redhat.com,
 crosa@redhat.com
References: <20191121185303.51685-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <19b311c5-d4e2-62e2-8597-07e5419c3688@redhat.com>
Date: Thu, 21 Nov 2019 19:58:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121185303.51685-1-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: LyJboux7PcGKB8zMHzaR2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 7:53 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Python 3.7.5 on f31 doesn't seem to like the old type=3Dfile syntax
> on argparse.

Looks 4.2 worth to me.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   scripts/vmstate-static-checker.py | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-c=
hecker.py
> index 21dbdccf3e..9f912dd870 100755
> --- a/scripts/vmstate-static-checker.py
> +++ b/scripts/vmstate-static-checker.py
> @@ -379,9 +379,11 @@ def main():
>       help_text =3D "Parse JSON-formatted vmstate dumps from QEMU in file=
s SRC and DEST.  Checks whether migration from SRC to DEST QEMU versions wo=
uld break based on the VMSTATE information contained within the JSON output=
s.  The JSON output is created from a QEMU invocation with the -dump-vmstat=
e parameter and a filename argument to it.  Other parameters to QEMU do not=
 matter, except the -M (machine type) parameter."
>  =20
>       parser =3D argparse.ArgumentParser(description=3Dhelp_text)
> -    parser.add_argument('-s', '--src', type=3Dfile, required=3DTrue,
> +    parser.add_argument('-s', '--src', type=3Dargparse.FileType('r'),
> +                        required=3DTrue,
>                           help=3D'json dump from src qemu')
> -    parser.add_argument('-d', '--dest', type=3Dfile, required=3DTrue,
> +    parser.add_argument('-d', '--dest', type=3Dargparse.FileType('r'),
> +                        required=3DTrue,
>                           help=3D'json dump from dest qemu')
>       parser.add_argument('--reverse', required=3DFalse, default=3DFalse,
>                           action=3D'store_true',
>=20


