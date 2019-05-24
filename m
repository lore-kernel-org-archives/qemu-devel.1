Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4344C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AC02175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XblAIfN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AC02175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUDeT-0002et-0z
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:06:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hUDcO-00017y-K8
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hUDWb-0001vJ-0t
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:58:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hUDWa-0001uP-Qr
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:58:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id 198so10087554wme.3
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to
	:content-transfer-encoding;
	bh=YlZwrraF9eMdORn3xQAkQSXHzOtu3FK9WsAHM1lYXas=;
	b=XblAIfN+K6CpD1f2ep7MY+8TKxcAT7+R8/GNQDo0NcbIS8gQl+qCIqzFBqwH9LL9RN
	3d7o9yB4Gek5qGq0fPwq/+KQpEc2AZWzml5tT0R2I/8mR6dEFPyJj/WqmbGqAJ21udlR
	bYH8NXlT+PMBJwfkNexKenjMYwoRIH86SeD66aIwWoeadeFtNAvNem9NrlPuVjHdiWTL
	ML1oMY2cYHbtqjotyY8PmfaDMT9fwTLXY7zd8+XbNQ61rUnazU2AwA5d6OoKsLWB+mno
	hAU/dkOg2vMutFfIZAAFf3S/riX/jIE3gVVnV3ftNY/4M0OBch4sjgdxnoXbOkYYxAQO
	JHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to
	:content-transfer-encoding;
	bh=YlZwrraF9eMdORn3xQAkQSXHzOtu3FK9WsAHM1lYXas=;
	b=r99LnaYvz5CITFR0IOE/zn4Bb1Tq4qzBzYpLlIuUHe32H11p1BzY7GWA3wHWouiciW
	F/6LCVlFZtsjQp/HlbNLLYKmfrBJyrrrsIkwVUHq02qP1efE3btcfvVuw3k+l384wKGk
	HzfW7qVn3RETv9IAD5A9xWx3a/XPQMEKF0uRDZi9JAdRsrWzhe3VStm+reAcdQx8F1WG
	EhZ+wbzYBmcy4ZvimteJxemrD2MUzQgCWhMRC7guwFnfKU44pisG6sOoMu8b7HcQ/S63
	o2mJfP8kCVbOES8bAgYiqg5Hz65OsxvuwIlh/qxW5U9fmI1bOb53uGWnawd0ygIOrZpG
	pRfw==
X-Gm-Message-State: APjAAAVhmppxxN8+ETq/b0XS/jz888eW1KGS0Bs1MqxjXq5qyfgvGAfw
	2TGbIUwpBSsm1AHIiwtiUDCA1xG8voiKXyAnid0=
X-Google-Smtp-Source: APXvYqxEEZaPZKCBrUGIcecwmq+6xkhJJ2cl7uCboFIaaAxQL9dLh1uPiElF6Jj5aT2PAjqTJ2y59qOLKS6dyynoFJc=
X-Received: by 2002:a7b:c549:: with SMTP id j9mr16530336wmk.114.1558717110377; 
	Fri, 24 May 2019 09:58:30 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 May 2019 18:58:18 +0200
Message-ID: <CAJ+F1CKg0a4G6mK7Hi1Z5dByGT2_YzK3S4pKWNtAvp1CRoA8LA@mail.gmail.com>
To: slirp@lists.freedesktop.org, QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [ANNOUNCE] libslirp 4.0.0 is now available
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

We would like to announce the availability of the libslirp 4.0.0
release. This is the initial release since the project was split off
from QEMU.

You can grab the tarball from the gitlab release page here:

    https://gitlab.freedesktop.org/slirp/libslirp/releases

Highlights include:

 * standalone project, removing any QEMU dependency
 * license clarifications
 * installable as a shared library
 * meson build system
   (& make build system for in-tree QEMU integration)

Once the library installed, you may compile QEMU >=3D 4.0 with
--enable-slirp=3Dsystem to link against it.

Thank you to everyone involved!

--=20
Marc-Andr=C3=A9 Lureau

