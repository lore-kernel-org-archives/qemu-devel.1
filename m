Received: from eggs.gnu.org ([2001:4830:134:3::10]:59817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLAz7-0000LW-Nx
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLAz6-00023t-RF
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:22:05 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:43915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLAz6-00023g-Lu
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:22:04 -0400
Received: by mail-ot0-x22f.google.com with SMTP id y10-v6so21882891otg.10
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 10:22:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <707c783c-0c82-4916-c8b9-0a4d93364386@kaod.org>
References: <20180423101433.17759-1-clg@kaod.org>
	<CAFEAcA_1q4+kKunX6_d9N3+6tUFGJRRc5biqn5TqDDmh09-kiw@mail.gmail.com>
	<e2d6b0b9-2402-4c34-305e-ae61ebe10df4@kaod.org>
	<707c783c-0c82-4916-c8b9-0a4d93364386@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 18:21:42 +0100
Message-ID: <CAFEAcA9wr9dXJcqiz83LSPhta19yE-cAukKJ0ztagntyp=Bc=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

On 2 May 2018 at 14:56, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> There seems to be an issue while reading the CPACR reg.
>
> With a brutal setting of CPACR in cpu_reset, the romulus-bmc machine
> migrates. What would be a more appropriate approach ?

Ah, yes, the bug here is that we made the cpacr_write() function
insist that certain bits are RAO/WI, but we didn't also change
the reset code to match. So (a) the guest initially reads a
value which doesn't have ones in the RAO bits and (b) when we
migrate we get a mismatch between what we had on the source
end and what we get when we write that to the destination end.

I think we can fix the reset value without having to duplicate
the logic from cpacr_write() using a resetfn. I'll cook up a patch...

thanks
-- PMM
