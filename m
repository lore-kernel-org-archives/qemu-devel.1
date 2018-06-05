Received: from eggs.gnu.org ([2001:4830:134:3::10]:44740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQBDo-00045q-5L
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQBDl-0005AT-1H
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:37:56 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fQBDk-00059i-OV
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:37:52 -0400
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<CAFEAcA-h7Ef5yfOS3V_kR5_fCmhr-N6okHY9=N87M9Ld+8MVdA@mail.gmail.com>
	<54f54010-ad2d-7df0-8838-b2ddc7668875@vivier.eu>
	<CAFEAcA9b==mGZQUAoPDCt1zbqxT3RmTa0XoQZvuPb17L0NYbMg@mail.gmail.com>
	<18231864-96b1-8f6f-5caa-c3d8613ec20e@vivier.eu>
	<CAFEAcA9e1ymU6aiOi=mQJzyXgZmda+mckhk6uKgR=3E_Po5GVQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d1fb5706-3d69-49ec-b411-8fb6886dac22@vivier.eu>
Date: Tue, 5 Jun 2018 14:37:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9e1ymU6aiOi=mQJzyXgZmda+mckhk6uKgR=3E_Po5GVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/6] linux-user: Use *at functions to
 implement interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Evan Green <evgreen@chromium.org>

Le 05/06/2018 à 14:33, Peter Maydell a écrit :
> On 5 June 2018 at 13:23, Laurent Vivier <laurent@vivier.eu> wrote:
>> They are used by tests/qemu-iotests/socket_scm_helper and
>> qemu-bridge-helper.
>>
>> Perhaps we can disable qemu-iotests with linux-user only and to not
>> build qemu-bridge-helper when tools are disabled?
> 
> Yeah, we shouldn't be building those if you're using --disable-system
> --disable-tools...

So something like that should do the work:

diff --git a/Makefile b/Makefile
....
+ifeq ($(CONFIG_SOFTMMU),y)
 HELPERS-$(CONFIG_LINUX) = qemu-bridge-helper$(EXESUF)
+endif
...
diff --git a/tests/Makefile.include b/tests/Makefile.include
...
+ifeq ($(CONFIG_SOFTMMU),y)
 QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) =
tests/qemu-iotests/socket_scm_helper$(EXESUF)
+endif
...

I prepare a patch...

Thanks,

Laurent
