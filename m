Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4518AC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155FE206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155FE206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelobjects.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWmx-00044w-0Z
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:55:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ml@kernelobjects.org>) id 1hMWll-0003RK-S0
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ml@kernelobjects.org>) id 1hMWlk-0000HS-SE
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:54:25 -0400
Received: from mail.kernelobjects.org ([5.189.137.180]:28880)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ml@kernelobjects.org>) id 1hMWlk-0000Dr-M7
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:54:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.kernelobjects.org (Postfix) with ESMTP id 7ABAF2A09C0
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 13:47:16 +0200 (CEST)
X-Virus-Scanned: mail.kernelobjects.org - ANTIVIRUS
Received: from mail.kernelobjects.org ([127.0.0.1])
	by localhost (mail.kernelobjects.org [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 5nP4tGviNXgs for <qemu-devel@nongnu.org>;
	Fri,  3 May 2019 13:47:15 +0200 (CEST)
Received: from mlombardo-mac.infra.h26.intra (unknown [89.244.26.92])
	by mail.kernelobjects.org (Postfix) with ESMTPSA id D178F2A02C5
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 13:47:15 +0200 (CEST)
From: Mario <ml@kernelobjects.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Message-Id: <8C02D03E-96CD-414F-BC2C-C59972B26F94@kernelobjects.org>
Date: Fri, 3 May 2019 13:47:15 +0200
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3445.9.1)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.137.180
Subject: [Qemu-devel] Request for comment - dynamic VNC keyboard mapping
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
Message-ID: <20190503114715.mLT14ONBNbQGtap8lsTsUgiRcGcWkZTaf9zUmR-jYig@z>

Hi all,

I have a question related to the VNC server keyboard settings. Currently =
the user of qemu has to decide before VM startup which language is used =
for VNC keyboard mapping. If no keyboard is configured, the en-us =
keyboard will be loaded for keysym to scancode conversion. A later =
reconfiguration of the keyboard is not possible at present.

So here is my idea:

The VNC Display context stores a list of loaded keyboards (like =
vs->vd->kbds). If no keyboard was specified, at least the default will =
be added to the list ("en-us"?). If a client connects, a copy of the =
(latest configured) pointer will be stored within the VncState =
structure. For any keys sent by this client the own keyboard reference =
will be used.

As (in theory) every VNC client may have a differen keyboard layout, in =
my point of view it makes sense to attach the keyboard used for =
keysym2scancode() to the client context rather to the VNC server =
context. However as (most likely) all clients do have the same keyboard =
mapping it would be an overhead to parse and store the mapping list each =
time the client connects.

Now in my idea two mechanisms may change the behavior of the client =
keyboard.

1.) a qmp command was sent, that sets /configures for a =
particular/default keyboard.
2.) within the VNC protocol a =
"VNC_MSG_CLIENT_QEMU/VNC_MSG_CLIENT_QEMU_EXT_KEYBOARD_LAYOUT" message =
arrives

If the new keyboard was not already loaded and stored inside =
vs->vd->kbds , qemu initializes the new mapping. The affected VNC client =
(VncState) again stores the reference only.

This enables switching the keyboard layout during runtime as well as =
using multiple different keyboard layouts at atime.

Together with a corresponding patch I would also add a patch for =
libvncclient to have a reference implmentation for the integrated =
keyboard layout switching.

What are your thoughts about this kind of improvement?

Thanks,
Mario=

