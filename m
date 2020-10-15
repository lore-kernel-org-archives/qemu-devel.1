Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FB722254
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHa77RjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FB722254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6qo-00025X-10
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kT6eu-0006vo-8X
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kT6ep-0002pL-RV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602781392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKb8FWFoXb1ixLS2K0bqoORvCy11EZWlJJg3LIzI8uI=;
 b=gHa77RjF5VH0yGfgYXAPssmSAT1liPa4QM/PzrC6PXBVHfeH+PhBSZT91kCyR//C1qMhSu
 O5A5GIcUPcheFncSTCFzTZwhR9NtQ/ItfxMYoH9evJThsStAvbDHke8GpYNzVMj+Rv8zhj
 7wekvxD2OZfCEDZ+9e10iW6Vi9SQtPE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-3DocTtx-Nh6vIUGHbDoldQ-1; Thu, 15 Oct 2020 13:03:10 -0400
X-MC-Unique: 3DocTtx-Nh6vIUGHbDoldQ-1
Received: by mail-io1-f69.google.com with SMTP id z18so2562037ioi.17
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 10:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dKb8FWFoXb1ixLS2K0bqoORvCy11EZWlJJg3LIzI8uI=;
 b=iCMn86Dt5eYXnelnNJyE3L4Gc1LODjI+lmx4AAgz2bM+lhWD05Gs7NKCAHVVm1Nf6x
 nGeb8EksNHURspvFZLcOSdV4J+9we64zaLH7QfdNl76fvhIJtjEuPINo9fFmL3beX1vG
 ulooyUWe9677IlhXztfVo/bHVIecKRGrPiQky7FJ0BvXCO8lsBUDPj4DJ6IKBZPj4hVC
 rokv1kWK3PkQfn6M8mylSps/ZfBTel0iflK4ykhRc+jwa3S4iSTJJtgINdytr4lz6lQo
 JzkISpt5BfM9y1XeOGrCWeZ3rw5LEtNL2jW6jR4G/UrsHppe9ygCuzN30A8zXr+P20hx
 sJow==
X-Gm-Message-State: AOAM531MCNfp9sVnmbpaX0takGMIXo3fOlwBlOcqJWMFrHfPrvlGXXXN
 nrB5ZvyCEcb7GeZd2YV3gqsVcgSGapVdZopFwjRzEw1aaCwZqfLzWtjBhPgc+TQ/7nnwa9zg6mN
 iifAMchVUqMBcNjcdEJbmPPNq0lrnzF0=
X-Received: by 2002:a92:ba1c:: with SMTP id o28mr3632915ili.182.1602781389629; 
 Thu, 15 Oct 2020 10:03:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV/N3BnN3uOte2dnJvYeq5JmfDO35+9W2zQLR+vXPr+uHG7kaHuNjQz5In6x4yv7g3wpRr9bgZW3C8zuxl5/U=
X-Received: by 2002:a92:ba1c:: with SMTP id o28mr3632885ili.182.1602781389248; 
 Thu, 15 Oct 2020 10:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
 <20201015165255.1573897-10-marcandre.lureau@redhat.com>
In-Reply-To: <20201015165255.1573897-10-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Oct 2020 21:02:58 +0400
Message-ID: <CAMxuvay+seL8tHJ+-yS_BWWCukx1ioDp-Bmqy6HRXee=iy+ObA@mail.gmail.com>
Subject: Re: [PATCH 9/9] docs: update the documentation about schema
 configuration
To: qemu-devel <qemu-devel@nongnu.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 8:54 PM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 3d22a7ae21..517bc29507 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -772,26 +772,30 @@ downstream command __com.redhat_drive-mirror.
>  =3D=3D=3D Configuring the schema =3D=3D=3D
>
>  Syntax:
> -    COND =3D STRING
> -         | [ STRING, ... ]
> +    COND =3D CFG-ID
> +         | [ CFG-ID, ... ]
> +         | { 'all: [ CFG-ID, ... ] }
> +         | { 'any: [ CFG-ID, ... ] }
> +         | { 'not': COND }

Btw, I realized while writing that, the doc is actually quite
faithfull with the currently limited supported expressions, but I will
probably improve on that in v2 (unless it's considered a feature :)

>
> -All definitions take an optional 'if' member.  Its value must be a
> -string or a list of strings.  A string is shorthand for a list
> -containing just that string.  The code generated for the definition
> -will then be guarded by #if STRING for each STRING in the COND list.
> +    CFG-ID =3D STRING
> +
> +All definitions take an optional 'if' member. Its value must be a string=
, a list
> +of strings or an object with a single member 'all', 'any' or 'not'. A st=
ring is
> +shorthand for a list containing just that string. A list is a shorthand =
for a
> +'all'-member object. The C code generated for the definition will then b=
e guarded
> +by an #if precessor expression.
>
>  Example: a conditional struct
>
>   { 'struct': 'IfStruct', 'data': { 'foo': 'int' },
> -   'if': ['CONFIG_FOO', 'HAVE_BAR'] }
> +   'if': { 'all': [ 'CONFIG_FOO', 'HAVE_BAR' ] } }
>
>  gets its generated code guarded like this:
>
> - #if defined(CONFIG_FOO)
> - #if defined(HAVE_BAR)
> + #if defined(CONFIG_FOO) && defined(HAVE_BAR)
>   ... generated code ...
> - #endif /* defined(HAVE_BAR) */
> - #endif /* defined(CONFIG_FOO) */
> + #endif /* defined(HAVE_BAR) && defined(CONFIG_FOO) */
>
>  Individual members of complex types, commands arguments, and
>  event-specific data can also be made conditional.  This requires the
> --
> 2.28.0
>


