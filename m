Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C09C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EE920714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8lzbWwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EE920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDDM-0005C4-B2
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jJDCc-0004dj-Jc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jJDCb-0006Eu-7e
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:28:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33396
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jJDCb-0006ER-3k
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585646936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RwaeSbTH01OPN7dwZi5m8Q8O+MzbW80hS561qVP46U=;
 b=E8lzbWwTMMiHzbgJLWi7OFmdFn3f67fg6QF8i9QY/BWV6Vqe+lb88HmQoqWmUACUpw0+iw
 ndEZtajku3UCbn7nJiC1aAOvcKqLVEQi6nEKfhh1s0/zNY59lBabCCHVfO9ucQzH/eSJ6J
 4U6k5ZYHVHDSk9wn1AJSuODNVA1aY5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-kxXudR0GNrGLJOAirxddQA-1; Tue, 31 Mar 2020 05:28:34 -0400
X-MC-Unique: kxXudR0GNrGLJOAirxddQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02A518014D0;
 Tue, 31 Mar 2020 09:28:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 983A460BE0;
 Tue, 31 Mar 2020 09:28:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 50B4E9D1F; Tue, 31 Mar 2020 11:28:31 +0200 (CEST)
Date: Tue, 31 Mar 2020 11:28:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paul Zimmerman <pauldzim@gmail.com>
Subject: Re: [PATCH v2 0/6] dwc-hsotg (aka dwc2) USB host controller emulation
Message-ID: <20200331092831.4s2smc4wtbslzirw@sirius.home.kraxel.org>
References: <20200329001705.15966-1-pauldzim@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200329001705.15966-1-pauldzim@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 28, 2020 at 05:16:59PM -0700, Paul Zimmerman wrote:
> This patch series adds emulation for the dwc-hsotg USB controller,
> which is used on the Raspberry Pi 3 and earlier, as well as a number
> of other development boards. The main benefit for Raspberry Pi is that
> this enables networking on these boards, since the network adapter is
> attached via USB.
>=20
> The emulation is working quite well, I have tested with USB network,
> mass storage, mouse, keyboard, and tablet. I have tested with the dwc2
> driver in the upstream Linux kernel, and with the dwc-otg driver in the
> Raspbian kernel. One remaining issue is that USB redirection does not
> work, I tried connecting to a USB stick on the host, but the device
> generates babble errors and does not work. I will continue to work on
> this issue.
>=20
> The patch series also includes a very basic emulation of the MPHI
> device on the Raspberry Pi SOC, which provides the FIQ interrupt that
> is used by the dwc-otg driver in the Raspbian kernel. But that driver
> still does not work in full FIQ mode, so it is necessary to add a
> parameter to the kernel command line ("dwc_otg.fiq_fsm_enable=3D0") to
> make it work.
>=20
> I have used some on-line sources of information while developing
> this emulation, including:
>=20
> http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
> has a pretty complete description of the controller starting on
> page 370.
>=20
> https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataShee=
ts/RT3050_5x_V2.0_081408_0902.pdf
> has a description of the controller registers starting on page
> 130.
>=20
> Changes from v1:
>   - Fixed checkpatch errors/warnings, except for dwc2-regs.h since
>     that is a direct import from the Linux kernel.
>   - Switched from debug printfs to tracepoints in hcd-dwc2.c, on the
>     advice of Gerd. I just dropped the debug prints in bcm2835_mphi.c,
>     since I didn't consider them very useful.
>   - Updated a couple of the commit messages with more info.
>=20
> Thanks for your time,
> Paul

Looks good to me.  We are in 5.0 freeze now though, so this has to wait
until the tree is open for 5.1 development.

cheers,
  Gerd


