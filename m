Received: from eggs.gnu.org ([2001:4830:134:3::10]:39460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgsan-0003EZ-V3
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgsan-00078n-6m
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:33:53 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgsan-00077a-11
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:33:53 -0500
Received: by mail-wr0-x22a.google.com with SMTP id 89so20816543wrr.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 04:33:52 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 12:33:31 +0000
Message-ID: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] using fdt_setprop() to set properties to empty values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

What's the right way to use libfdt's fdt_setprop to set a property
to have an empty value? At the moment in QEMU we tend to use
  fdt_setprop(fdt, nodeoffset, "propertyname", NULL, 0);

and git grep 'fdt_setprop.*NULL' produces examples of this usage in
PPC and ARM fdt creation code.

However the fdt_setprop() documentation doesn't document that a NULL
value pointer is OK if the length is 0, and indeed the implementation
unconditionally calls memcpy(prop->data, val, len), which is
undefined behaviour, and warned about by clang sanitizers if you
build libfdt with them:
 dtc/libfdt/fdt_rw.c:288:21: runtime error: null pointer passed
   as argument 2, which is declared to never be null

So what's the best thing to do here? I can't offhand think of a
non-ugly/non-confusing way to pass a valid pointer here...

thanks
-- PMM
