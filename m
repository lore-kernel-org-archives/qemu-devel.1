Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A35C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC4120652
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qoz9IG7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC4120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfM8e-0004K9-AF
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 06:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hfM51-00029b-Td
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hfM4w-0001Lb-T7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:20:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hfM4w-0001JD-JL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:20:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id u8so12774736wmm.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1ObYhkY4AFQtKGtE6wxOzY6hNIXkfB8b9EcmTCPa1Vg=;
 b=Qoz9IG7EOmJHtn4csJ4w3BCBRECU1FOp1PyuJcw+WT5X7dI5FzD4nmzc3qkpL+lj9M
 /qyBRgrio6UKn0sv0TVbADfuLfrDzUAuNRz9/1pYpWY3h9S0LTxCoDMYMKz5Vhy54yFA
 I8n+Tp2aNjIUW3m+6SEK3q+ocF0YRJ1qkDT+pdLMRwS9ZikkIFFlxuZYPX4YqaL74oGh
 hsVpgGApp5baokvIdh5U9rIcgBN6fCAXXtiSLiEH61B5Xhi20OlgcqPJFdZknCIhkaoG
 cG6pTegMgswhILGk95ogNZeoObU8Jnooiuz4Fmy7ggb7jHk8//XosCKmWBjcER1TRxos
 QPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1ObYhkY4AFQtKGtE6wxOzY6hNIXkfB8b9EcmTCPa1Vg=;
 b=tzBbkbiyAv4XnREy47WwcIJmfkPhShCvg0QWvKxma1MTCAro8CXdH8yN4rU8+6j+lK
 8tEs0JHR7GohgI92EaRRfE4JBm4T27CIto0hjVEKjEfFsojVRagRh4L1vAqI/n9TiK/F
 J6Y4Xrb4UvIVBdFr0iTKKsf64qPJSccOn9swFx+z7LP2Bym41I24qEV1/68rh/Vl1dRg
 cZy3y0cd4imJse28Bl5TZIACC9QPZJ7Q7AXk1OOFQtoHKBnoxce4fF6vUjsN5M6eLay4
 plyG/CU/22anq0OdCJDJjIMSy8KpotTmEQW8r6hZOZSrgAWdu8X7p8hnQuCPKxeJpUtX
 mNIw==
X-Gm-Message-State: APjAAAXOvRb2cUw4rwozqyM1VeQ5teuEERRmGrqhO5sEmVhbOnwLFoQw
 36m05mqWpia9mupZqbHH1Z1voKpABOd0ZSsZzhQ=
X-Google-Smtp-Source: APXvYqzFF2D5NiyxgdER9Qq8VW0WJA9Y9R9Ay/y1yxCp1DiXvR7vapjTlI1tusxlNLzQw4yOWFEozHJIc5Bmi/U/1Hw=
X-Received: by 2002:a1c:b782:: with SMTP id h124mr15299279wmf.20.1561371600719; 
 Mon, 24 Jun 2019 03:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190624091304.666-1-stefanha@redhat.com>
In-Reply-To: <20190624091304.666-1-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Jun 2019 12:19:49 +0200
Message-ID: <CAJ+F1CKC2Sr4DVrsK7RO6Zz9F5e5Fu_899u+Yj+aKBzzbsCVbw@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] docs: clarify multiqueue vs multiple
 virtqueues
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
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Cathy Zhang <cathy.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Jun 24, 2019 at 11:13 AM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>
> The vhost-user specification does not explain when
> VHOST_USER_PROTOCOL_F_MQ must be implemented.  This may lead
> implementors of vhost-user masters to believe that this protocol feature
> is required for any device that has multiple virtqueues.  That would be
> a mistake since existing vhost-user slaves offer multiple virtqueues but
> do not advertise VHOST_USER_PROTOCOL_F_MQ.
>
> For example, a vhost-net device with one rx/tx queue pair is not
> multiqueue.  The slave does not need to advertise
> VHOST_USER_PROTOCOL_F_MQ.  Therefore the master must assume it has these
> virtqueues and cannot rely on askingt the slave how many virtqueues
> exist.
>
> Extend the specification to explain the different between true
> multiqueue and regular devices with a fixed virtqueue layout.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Based-on: <20190621094005.4134-1-stefanha@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5750668aba..7827b710aa 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -324,6 +324,15 @@ must support changing some configuration aspects on =
the fly.
>  Multiple queue support
>  ----------------------
>
> +Many devices have a fixed number of virtqueues.  In this case the master
> +already knows the number of available virtqueues without communicating w=
ith the
> +slave.
> +
> +Some devices do not have a fixed number of virtqueues.  Instead the maxi=
mum
> +number of virtqueues is chosen by the slave.  The number can depend on h=
ost
> +resource availability or slave implementation details.  Such devices are=
 called
> +multiple queue devices.
> +
>  Multiple queue support allows the slave to advertise the maximum number =
of
>  queues.  This is treated as a protocol extension, hence the slave has to
>  implement protocol features first. The multiple queues feature is suppor=
ted
> @@ -339,6 +348,14 @@ queue in the sent message to identify a specified qu=
eue.
>  The master enables queues by sending message ``VHOST_USER_SET_VRING_ENAB=
LE``.
>  vhost-user-net has historically automatically enabled the first queue pa=
ir.
>
> +Slaves should always implement the ``VHOST_USER_PROTOCOL_F_MQ`` protocol
> +feature, even for devices with a fixed number of virtqueues, since it is=
 simple
> +to implement and offers a degree of introspection.
> +
> +Masters must not rely on the ``VHOST_USER_PROTOCOL_F_MQ`` protocol featu=
re for
> +devices with a fixed number of virtqueues.  Only true multiqueue devices
> +require this protocol feature.
> +
>  Migration
>  ---------
>
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

